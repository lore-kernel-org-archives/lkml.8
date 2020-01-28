Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFE924698
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221753;
	bh=IsbXFGWERoVF4z0Lvb9M0YfgBy8HjSeZ2bGvR2Jhedc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Spe+6rUxmrnLAYqQi83W+4aiJCpATjI3Uf1NC3PG9f6b/ekXDcBUoqLZO7AOi6UIi
	 NfH3ivGikGg9qPgiMsVksMcXyq5KWLUZ6M1YiANvXIeMj0OnmRd+ZWo8QLEWEmd1iu
	 CAdSAp8DKX73Eh7qGPFF5/VJZjScZryYxU2n6NNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgA1O3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387601AbgA1O3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:29:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF6E2468F;
        Tue, 28 Jan 2020 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221742;
        bh=IsbXFGWERoVF4z0Lvb9M0YfgBy8HjSeZ2bGvR2Jhedc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3xzrODhimWEJypTQNnRlj009Sq+LabgrJqAJmg+3UQfVSoUciA1zgQEK5wGK+UCE
         dUO4FV7D4Ao3NI9Ny+FTVGSSe3lcItXspGcwSZkmunGkBe8241t274XtCdLTmQLyue
         vxEJITfOT/martZv8iF8cFcOQbjGFfg+iN89LGCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 56/92] tracing: Use hist triggers var_ref array to destroy var_refs
Date:   Tue, 28 Jan 2020 15:08:24 +0100
Message-Id: <20200128135816.390761744@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

commit 656fe2ba85e81d00e4447bf77b8da2be3c47acb2 upstream.

Since every var ref for a trigger has an entry in the var_ref[] array,
use that to destroy the var_refs, instead of piecemeal via the field
expressions.

This allows us to avoid having to keep and treat differently separate
lists for the action-related references, which future patches will
remove.

Link: http://lkml.kernel.org/r/fad1a164f0e257c158e70d6eadbf6c586e04b2a2.1545161087.git.tom.zanussi@linux.intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2175,6 +2175,15 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
+static void __destroy_hist_field(struct hist_field *hist_field)
+{
+	kfree(hist_field->var.name);
+	kfree(hist_field->name);
+	kfree(hist_field->type);
+
+	kfree(hist_field);
+}
+
 static void destroy_hist_field(struct hist_field *hist_field,
 			       unsigned int level)
 {
@@ -2186,14 +2195,13 @@ static void destroy_hist_field(struct hi
 	if (!hist_field)
 		return;
 
+	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
+		return; /* var refs will be destroyed separately */
+
 	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
 		destroy_hist_field(hist_field->operands[i], level + 1);
 
-	kfree(hist_field->var.name);
-	kfree(hist_field->name);
-	kfree(hist_field->type);
-
-	kfree(hist_field);
+	__destroy_hist_field(hist_field);
 }
 
 static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
@@ -2320,6 +2328,12 @@ static void destroy_hist_fields(struct h
 			hist_data->fields[i] = NULL;
 		}
 	}
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		WARN_ON(!(hist_data->var_refs[i]->flags & HIST_FIELD_FL_VAR_REF));
+		__destroy_hist_field(hist_data->var_refs[i]);
+		hist_data->var_refs[i] = NULL;
+	}
 }
 
 static int init_var_ref(struct hist_field *ref_field,


