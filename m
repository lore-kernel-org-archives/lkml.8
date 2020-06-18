Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932FF20773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgFROxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgFROxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:53:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751EEC06174E;
        Thu, 18 Jun 2020 07:53:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F05FA120ED481;
        Thu, 18 Jun 2020 07:53:33 -0700 (PDT)
Date:   Thu, 18 Jun 2020 07:53:30 -0700 (PDT)
Message-Id: <20200618.075330.1927214829648104806.davem@davemloft.net>
To:     gaurav1086@gmail.com
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net/sched]: Remove redundant condition in qdisc_graft
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200618040056.30792-1-gaurav1086@gmail.com>
References: <20200618012308.28153-1-gaurav1086@gmail.com>
        <20200618040056.30792-1-gaurav1086@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jun 2020 07:53:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Singh <gaurav1086@gmail.com>
Date: Thu, 18 Jun 2020 00:00:56 -0400

> parent cannot be NULL here since its in the else part
> of the if (parent == NULL) condition. Remove the extra
> check on parent pointer.
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  net/sched/sch_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 9a3449b56bd6..be93ebcdb18d 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1094,7 +1094,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>  
>  		/* Only support running class lockless if parent is lockless */
>  		if (new && (new->flags & TCQ_F_NOLOCK) &&
> -		    parent && !(parent->flags & TCQ_F_NOLOCK))
> +			!(parent->flags & TCQ_F_NOLOCK))

You've broken the indentation of this line, it was correctly indented
before your change.
