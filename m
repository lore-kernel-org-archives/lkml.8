Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F260C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E152A2084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583675101;
	bh=RBjZPGsUiQKMAYuCVc9l3M8rUSO+5QKpF3FnNFmV69Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XRsA8MkrawIaX91lkFFi19zDc0Ch+a11mm1u3nM1X99wZ4LUmQVvAZ0lpsW6ejrei
	 5k73u4OZ3cfZF2a9GTd4S3oVV+HytnWjqr0NAd3FrZ7wLVwTH9PynQ/q1gQD69CmCT
	 L3Q+KID97CcxitT6F2TCETaOODJdK+HBe2QoesUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHNpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCHNpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:45:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6DD20848;
        Sun,  8 Mar 2020 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583675099;
        bh=RBjZPGsUiQKMAYuCVc9l3M8rUSO+5QKpF3FnNFmV69Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMD8MttDVLiX3hA3MfRHVv5qnHIj82BuiW9zyDU0N9kIUBn18YRIocVffjTyk6jSL
         xA7TmOVqT+smgBO85YN9LCnqi2NNZXEdF47yhMLofmVP08yRmQzTXEKMeZf+BaMSzD
         gWRoj81zeFl4LGOZBCp084DMWmas1tbLxMZOVd/0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwEj-00B2cM-AM; Sun, 08 Mar 2020 13:44:57 +0000
Date:   Sun, 8 Mar 2020 13:44:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3] irqchip: Replace setup_irq() by request_irq()
Message-ID: <20200308134453.32ab0fea@why>
In-Reply-To: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
References: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: afzal.mohd.ma@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, paul@crapouillou.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Mar 2020 06:18:38 +0530
afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

I've queued this for 5.7.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
