Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2777E2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 02:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbgAYCZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 21:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387564AbgAYCZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 21:25:34 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8AE20718;
        Sat, 25 Jan 2020 02:25:33 +0000 (UTC)
Date:   Fri, 24 Jan 2020 21:25:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH] tracing: Decrement trace_array when bootconfig creates
 an instance
Message-ID: <20200124212531.4dc23b8c@rorschach.local.home>
In-Reply-To: <20200125112300.220f1728f6e47f45717ec564@kernel.org>
References: <20200124205927.76128804@rorschach.local.home>
        <20200125112300.220f1728f6e47f45717ec564@kernel.org>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2020 11:23:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 24 Jan 2020 20:59:27 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The trace_array_get_by_name() creates a ftrace instance and
> > trace_array_put() is used to remove the reference. Even though the
> > trace_array_get_by_name() creates the instance, it also adds a reference
> > count to it, that prevents user space from removing it.
> > 
> > As the bootconfig just creates the instance on boot up, it should still be
> > used where it can be deleted by user space after boot. A trace_array_put()
> > is required to let that happen. Otherwise, the created instance can not
> > be removed.
> > 
> > Also, change the documentation on trace_array_get_by_name() to make this not
> > be so confusing.  
> 
> Good catch! I misunderstood trace_array_put() would remove the instance.

I figured as much, which is why I included the documentation update.

> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

-- Steve


