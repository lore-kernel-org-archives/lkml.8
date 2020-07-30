Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94505204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgG3IhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:40460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3IhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:37:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5730CAE38;
        Thu, 30 Jul 2020 08:37:31 +0000 (UTC)
Date:   Thu, 30 Jul 2020 10:37:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace : use kvmalloc instead of kmalloc
Message-ID: <20200730083717.GB18727@dhcp22.suse.cz>
References: <1596023309-14403-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596023309-14403-1-git-send-email-zhaoyang.huang@unisoc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-07-20 19:48:29, Zhaoyang Huang wrote:
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ca1ee65..d4eb7ea 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6891,7 +6891,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  	if (trace_array_get(tr) < 0)
>  		return -ENODEV;
>  
> -	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	info = kvmalloc(sizeof(*info), GFP_KERNEL);

I am not familiar with the code but it is quite clear that the patch is
incomplete without matching kvfree call in the release path. You cannot
simply change k.malloc to kvmalloc without the pairing kvfree.

>  	if (!info) {
>  		trace_array_put(tr);
>  		return -ENOMEM;
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
