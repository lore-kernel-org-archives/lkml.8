Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBDAC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41157206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgELOlR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgELOlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:41:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FEBE206A3;
        Tue, 12 May 2020 14:41:16 +0000 (UTC)
Date:   Tue, 12 May 2020 10:41:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-linus][PATCH 3/3] bootconfig: Fix to prevent warning
 message if no bootconfig option
Message-ID: <20200512104114.5f70803a@gandalf.local.home>
In-Reply-To: <0686d98b-5eba-b761-6d84-f93edfbbb5a6@molgen.mpg.de>
References: <20200512132317.343672858@goodmis.org>
        <20200512132348.029291894@goodmis.org>
        <0686d98b-5eba-b761-6d84-f93edfbbb5a6@molgen.mpg.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:36:53 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Steven,
> 
> 
> Am 12.05.20 um 15:23 schrieb Steven Rostedt:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Commit de462e5f1071 ("bootconfig: Fix to remove bootconfig
> > data from initrd while boot") causes a cosmetic regression
> > on dmesg, which warns "no bootconfig data" message without
> > bootconfig cmdline option.
> > 
> > Fix setup_boot_config() by moving no bootconfig check after
> > commandline option check.
> > 
> > Link: http://lkml.kernel.org/r/9b1ba335-071d-c983-89a4-2677b522dcc8@molgen.mpg.de
> > Link: http://lkml.kernel.org/r/158916116468.21787.14558782332170588206.stgit@devnote2  
> 
> It’d be great if you could update your script to include HTTPS URLs. 
> That would save one redirect.

Never thought of that as an issue, but sure, it's easy enough to fix.

> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks,

-- Steve
