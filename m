Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE27C204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597239057;
	bh=qONd+uebxuHxqWaUJyHKSu5dged4G+IxGWG78tjLPcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ejUg+iMPa4I2PKim79yR/iJMTIxY6+j2Q2a0g/YamqG1SrJ2t/RjSXx1LGNQ8ccr1
	 tiOTGNq2GB3fEZ36a1jDsRbk+okSnHw9iB2+/yNwi2N5yZvF3tul9Ngwt78s63ioCA
	 HgEZs9MlNqGZ9A1r0BE1UkaIneZNPWchKSGYSvkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHLNaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgHLNas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:30:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BAC8207F7;
        Wed, 12 Aug 2020 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597239048;
        bh=qONd+uebxuHxqWaUJyHKSu5dged4G+IxGWG78tjLPcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYB7dZLHVZ6TZh/+w9McXu9gV8/m4bTlrJ/NIEwTCZW44NkpnA/167w84fBx/RVUX
         ZXN7VctIATKR+floFs+XHZlRAUN0eNW/3EQi8WTVB7h+6jrGMMip+aqXsPMUYJwcI2
         vW10Q56VWGZ2NWGM7Cw1D00tu9jMf0gseOQP1uZ8=
Date:   Wed, 12 Aug 2020 14:30:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Gaurav Kohli <gkohli@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        neeraju@codeaurora.org
Subject: Re: [PATCH] arm64: Skip apply SSBS call for non SSBS system
Message-ID: <20200812133043.GA8924@willie-the-truck>
References: <1596550484-11029-1-git-send-email-gkohli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596550484-11029-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:44:42PM +0530, Gaurav Kohli wrote:
> In a system where no cpu's implement SSBS, for
> them no need to set pstate. This might help to save
> few cpu cycles during context switch.
> 
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6089638..79f80f1 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -477,6 +477,13 @@ static void ssbs_thread_switch(struct task_struct *next)
>  	struct pt_regs *regs = task_pt_regs(next);
>  
>  	/*
> +	 * For Targets which don't have SSBS support, they
> +	 * can return from here.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARM64_SSBD))
> +		return;

Does this actually make a measurable difference?

Will
