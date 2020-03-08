Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF74EC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D912084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583676279;
	bh=Xc4sRcrrcFV4JWGHKn2Ox+OfEVzERdOZP6tAvwZ/TPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cqVjn8QVqwrg8yKwspC9n1g3kZg0Lai/XdIXi6yG5ak/9AswSYQPR3jv2sKdUt+tv
	 qCTKINFcV9KrDR/haniMMgSMsmKcdoiNk4JTg4KZn9GSHQyH1VRxs52KKpGfeAFc0P
	 Jvo4zO0Gn+yF5SjXmnOsFzMOBK+Eok9lAeSUjhGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCHOEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgCHOEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:04:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EC8206D7;
        Sun,  8 Mar 2020 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583676277;
        bh=Xc4sRcrrcFV4JWGHKn2Ox+OfEVzERdOZP6tAvwZ/TPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZITbiWlV7TGSYqCWEV5ICRVwodCKEkyymuyR8iGYXzfbBZzL9wierMXzBnNgpybbs
         fhs3YzubSS4U7WHrUdplBPzd38NoJqHKAUiT/FLNAvADfchgjQK5rvGBMjjk9BEg7V
         u8OYLiIs4zxK+zWworBkezQWq6kPWi7OPHxUzETc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwXk-00B2n3-1M; Sun, 08 Mar 2020 14:04:36 +0000
Date:   Sun, 8 Mar 2020 14:04:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] irqchip/mmp: A pair of robustness fixed
Message-ID: <20200308140434.18b0f947@why>
In-Reply-To: <20200219080024.4002-1-lkundrak@v3.sk>
References: <20200219080024.4002-1-lkundrak@v3.sk>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lkundrak@v3.sk, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 09:00:22 +0100
Lubomir Rintel <lkundrak@v3.sk> wrote:

[+RobH]

Lubomir,

> Hi,
> 
> please consider applying these two patches. Thery are not strictly
> necessary, but improve diagnostics in case the DT is faulty.

Can't we instead make sure our DT infrastructure checks for these? I'm
very reluctant to add more "DT validation" to the kernel, as it feels
like the wrong place to do this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
