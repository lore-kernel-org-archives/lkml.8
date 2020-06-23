Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039B42072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FPBrUaqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbgFWPmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbgFWPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:42:16 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79155C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:42:16 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m9so3403172qvx.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k9npaZkB/RX+A77Mjxy8tZOLesXDgVyirFfZLx7RsY8=;
        b=FPBrUaqD+INXJNZq97GAZ8wt0va9XMksIvOQgUMsCLh5PhfHnsz+Efu5Na78VXWJDy
         1XGzChK2G0CNZjY7N2MBk7hQmzSCtWqq7r6C/3RhPhMC7Ezb5WuUmKtWAZG5o1xssGYG
         JfuM2ZMrklYBBVcoZO2EY1qioMp/UBzxm+s4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9npaZkB/RX+A77Mjxy8tZOLesXDgVyirFfZLx7RsY8=;
        b=YchcdYorqgZGysL/U6qLsvHTHTQeXYfsSloirDPNpFRwMec41g1gh1aih2hnqHwVEB
         BDSLSECPWqq8VpsQNGSGP2wWVAhKSNL/Rtsjn7qVdOde6Y7PMa20MxL/Z9mbs4EwpOnw
         RhJcmLy34wZOQe7rgcmzsVm539o+ah98AlH23dvURBFbw3ea/Vttfs6VRgKJ8qgwB388
         QOm99OAa0f3Uhdoo/sm3af9gre5fARG+EkZAO/oyofn1UX8yxwhX3MSlcDNmI9/FWiXN
         Er3rovuFByTHDpdrZeISGDCr8viw+lH6kvp/7bgEXVz1dbltEiVw/gagGGgfNz3K0vWe
         xu3Q==
X-Gm-Message-State: AOAM533qHWEJTrHzdXsdfmRkU5axZdBatAcGIcQCnkWT3bgiKaBs1H0v
        Jmcor0p5xpciFbHX8Wb58egCpCzADTo=
X-Google-Smtp-Source: ABdhPJzCnBPX85hWbeFdqNNPtt+wSv9RuuKhMXclYBSr+NMQYCtrb2esRWUO8PeTG4ifuFQWlIHL7g==
X-Received: by 2002:ad4:4f23:: with SMTP id fc3mr27529525qvb.25.1592926935691;
        Tue, 23 Jun 2020 08:42:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g4sm843079qka.97.2020.06.23.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:42:14 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:42:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
Message-ID: <20200623154214.GE9005@google.com>
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
> On callback overload, we want to force quiescent state immediately,
> for the first and second fqs. Enforce the same, by including
> RCU_GP_FLAG_OVLD flag, in fqsstart check.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And I think needs fixes tag:
Fixes: 1fca4d12f4637 ("rcu: Expedite first two FQS scans under callback-overload conditions")

thanks,

 - Joel


>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d0988a1..6226bfb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
>  			break;
>  		/* If time for quiescent-state forcing, do it. */
>  		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> -		    (gf & RCU_GP_FLAG_FQS)) {
> +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  					       TPS("fqsstart"));
>  			rcu_gp_fqs(first_gp_fqs);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
