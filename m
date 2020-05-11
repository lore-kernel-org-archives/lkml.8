Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B0C206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgEKUkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbgEKUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:40:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F77B20661;
        Mon, 11 May 2020 20:40:21 +0000 (UTC)
Date:   Mon, 11 May 2020 16:40:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <mingo@redhat.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangle6@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] trace: Remove duplicate semicolons at the end of line
Message-ID: <20200511164019.354a6d60@gandalf.local.home>
In-Reply-To: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
References: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 19:21:02 +0800
Xiaoming Ni <nixiaoming@huawei.com> wrote:

> Remove duplicate semicolons at the end of line in
> include/trace/events/iocost.h

This looks like it should go through Jens's tree.

-- Steve

> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  include/trace/events/iocost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
> index 7ecaa65b..91297eb 100644
> --- a/include/trace/events/iocost.h
> +++ b/include/trace/events/iocost.h
> @@ -152,7 +152,7 @@
>  
>  	TP_fast_assign(
>  		__assign_str(devname, ioc_name(ioc));
> -		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
> +		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
>  		__entry->new_vrate = new_vrate;
>  		__entry->busy_level = ioc->busy_level;
>  		__entry->read_missed_ppm = (*missed_ppm)[READ];

