Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D48C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B352078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgFOBuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 21:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgFOBuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:50:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E382053B;
        Mon, 15 Jun 2020 01:50:43 +0000 (UTC)
Date:   Sun, 14 Jun 2020 21:50:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] [traceevent] add_new_comm(): Fix memory leak
Message-ID: <20200614215041.024f818f@gandalf.local.home>
In-Reply-To: <20200614181517.30187-1-gaurav1086@gmail.com>
References: <20200614181517.30187-1-gaurav1086@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 14:14:53 -0400
Gaurav Singh <gaurav1086@gmail.com> wrote:

> The pointer cmdlines need to be explicity freed in case the
> realloc() fails. Fix it by adding a free() if realloc()
> returns a NULL pointer.
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  tools/lib/traceevent/event-parse.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index e1bd2a93c6db..7f0133420931 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -284,12 +284,13 @@ static int add_new_comm(struct tep_handle *tep,
>  		return 0;
>  	}
>  
> -	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (tep->cmdline_count + 1));
> -	if (!cmdlines) {
> +	struct tep_cmdline *new_cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (tep->cmdline_count + 1));
> +	if (!new_cmdlines) {
> +		free(cmdlines);
>  		errno = ENOMEM;

NAK! This was fine as is.

What you just did was make tep->cmdline point to freed data, which will
crash later on when tep is freed, and we free tep->cmdline.

If we fail to realloc, then the caller of add_new_comm will get the report
that it failed, and then can determine what to do next. We don't want to
touch tep->cmdline on failure.

-- Steve


>  		return -1;
>  	}
> -	tep->cmdlines = cmdlines;
> +	tep->cmdlines = new_cmdlines;
>  
>  	key.comm = strdup(comm);
>  	if (!key.comm) {

