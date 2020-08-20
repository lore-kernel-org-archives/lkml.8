Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1208FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FF62080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597910938;
	bh=SaSN7/f0bbXOStkF+otn1zt3UQ5bPw5JBNpwMHhvnr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yoj/sjxZHSYdjzd52GnGb1JRwChmjHUeFMWXJzQFtHC+JnhuotebnyPOnH0dPhDFW
	 qG2kBU0tkGoBSCaR7oEeRd1lYpojOKkREzHp3UvTbCcr403mryNC/kE+TXs+o9FIgT
	 iTOAm7wDmbtnLm3w3cxQHJEGSj0wgR6JkX7BWDGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHTIIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgHTIIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:08:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1495C2080C;
        Thu, 20 Aug 2020 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597910910;
        bh=SaSN7/f0bbXOStkF+otn1zt3UQ5bPw5JBNpwMHhvnr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vRw+eWi1aTA+FCOcukYGo6P8y8JEENTHKYvP/kqVJRmsvLKbn589IRJB5Cfh8M/QL
         NoVx3aDqDoVvsYgIiFs+bNRnS07DIw8+Ru101tC01D7JRpu5uM9CrnyoTMF7wpMSrd
         bo+tzwOtLmPhggFtah7A2ybCMDu3MlXqUO47OfH0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8fca-004SFh-Is; Thu, 20 Aug 2020 09:08:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 09:08:28 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, od@zcrc.me,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: ingenic: Leave parent IRQ unmasked on suspend
In-Reply-To: <20200819180602.136969-1-paul@crapouillou.net>
References: <20200819180602.136969-1-paul@crapouillou.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <b7b89ed757b6731198c14f8561696b20@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: paul@crapouillou.net, tglx@linutronix.de, jason@lakedaemon.net, od@zcrc.me, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 19:06, Paul Cercueil wrote:
> All the wakeup sources we possibly want will go through the interrupt
> controller, so the parent IRQ must not be masked during suspend, or
> there won't be any way to wake up the system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Do you have a Fixes: tag? Does it need to be Cc: to stable?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
