Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3401CC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099B620738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598780509;
	bh=k08ME3JDK4Gf72G0743+68FC+Jt7TdUfF3cIxI3Mtlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PbjFxM9cyhCQZB5mHxicvRKT198iYx41guA0N0IdWoX584k9u4t4skRPRdD2ajtcy
	 slDPNhjykQNANkld///1F1EXpdK1lEJVC+guDgWnY3KFIlTzmP/wsoJyvWvcrvJA1r
	 0bp72QjCFg2Vc5ra5t4TA/D6F7J3GMO8oeRdNVQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgH3Jlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgH3Jlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:41:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E6F20738;
        Sun, 30 Aug 2020 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598780504;
        bh=k08ME3JDK4Gf72G0743+68FC+Jt7TdUfF3cIxI3Mtlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVHPqylinVz5Fur63sAf0ZDd7st/OEgSM9ButsjdNl6wPRFq8iCAH6ZlpzuyB8yR/
         HYsHjbFrf4VGcxviO2E6IWrqGZpTyIVY0v3msj3H6E3QmGT9bXtvnP70VYfbJth3ih
         ynO45M9ZgssnohZj4nT40d03nU3bMBW35cHn6dFY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kCJqI-007mQ2-MD; Sun, 30 Aug 2020 10:41:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 30 Aug 2020 10:41:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure on gru-scarlet-inx with 5.9-rc2
In-Reply-To: <20200829164920.7d28e01a@DUFFMAN>
References: <20200829164920.7d28e01a@DUFFMAN>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <65d88bdd0888a69849327501a2aad186@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@dionne-riel.com, devicetree@vger.kernel.org, frowand.list@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 2020-08-29 21:54, Samuel Dionne-Riel wrote:
> Hi,
> 
> The patch "of: address: Work around missing device_type property in
> pcie nodes" by Marc Zyngier, d1ac0002dd297069bb8448c2764c9c31c4668441,
> causes the "DUMO" variant of the gru-scarlet-inx, at the very least,
> to not boot. A gru-kevin reportedly had no issues booting (further),
> though it most likely had a different kernel configuration.

Do you have a pointer to the device-tree for this system? I couldn't
spot anything amiss in the scarlet-inx DT, but I'm not sure the
system you have is that exact one. Even a DTB would help.

The fact that Kevin still boots is a good indication that the issue
could be with with the board-specific changes layered on top of the
GRU base. My own rk3399 systems are running with this patch.

> Using a SuzyQ cable, there is absolutely no serial output at boot,
> while reverting the commit (and this commit alone) on top of v5.9-rc2
> works just as it did with v5.9-rc1.

Do you have "earlycon" on the kernel command-line?

> From this point on, I don't know what's the usual process, so bear with
> me if I forgot to provide relevant information, or made a faux-pas by
> CC-ing too many people or not enough.

No need to worry, and thank you for reporting the issue.

Could you try replacing the problematic patch with [1], and let me
know whether this changes anything on your end? This patch probably
isn't the right approach, but it would certainly help pointing me
in the right direction.

Thanks,

         M.

[1] https://lore.kernel.org/lkml/20200815125112.462652-2-maz@kernel.org/
-- 
Jazz is not dead. It just smells funny...
