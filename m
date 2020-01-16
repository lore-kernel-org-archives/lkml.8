Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0342F20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgAPV5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgAPV5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:57:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5121920728;
        Thu, 16 Jan 2020 21:57:00 +0000 (UTC)
Date:   Thu, 16 Jan 2020 16:56:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved reference for histogram variable
Message-ID: <20200116165658.4e8d15fb@gandalf.local.home>
In-Reply-To: <20200116154216.58ca08eb@gandalf.local.home>
References: <20200116154216.58ca08eb@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 15:42:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> in parse_expr():
> 
> 	operand1->read_once = true;
> 	operand2->read_once = true;
> 
> Why is that?
> 
> This means that any variable used in an expression can not be use later
> on.
> 
> Or should the variable be detected that it is used multiple times in
> the expression, and have the parser detect this, and just reuse the
> same variable multiple times?

This patch seems to fix the problem, and lets us reuse the same
variable multiple times.

-- Steve

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 117a1202a6b9..b7f944735a4a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -116,6 +116,7 @@ struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
 	hist_field_fn_t			fn;
+	unsigned int			ref;
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
@@ -2432,8 +2433,16 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
+static void get_hist_field(struct hist_field *hist_field)
+{
+	hist_field->ref++;
+}
+
 static void __destroy_hist_field(struct hist_field *hist_field)
 {
+	if (--hist_field->ref > 1)
+		return;
+
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 	kfree(hist_field->type);
@@ -2475,6 +2484,8 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (!hist_field)
 		return NULL;
 
+	hist_field->ref = 1;
+
 	hist_field->hist_data = hist_data;
 
 	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
@@ -2670,6 +2681,19 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 {
 	unsigned long flags = HIST_FIELD_FL_VAR_REF;
 	struct hist_field *ref_field;
+	int i;
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		ref_field = hist_data->var_refs[i];
+		/* Maybe this is overkill? */
+		if (ref_field->var.idx == var_field->var.idx &&
+		    ref_field->var.hist_data == var_field->hist_data &&
+		    ref_field->size == var_field->size &&
+		    ref_field->is_signed == var_field->is_signed) {
+			get_hist_field(ref_field);
+			return ref_field;
+		}
+	}
 
 	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
 	if (ref_field) {
