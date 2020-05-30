Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AF32074B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590844559;
	bh=VceDSw21CiOfGJeqHBr1CP4d0xYCY00d31XuwrH77Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CIxfcqmmyv/aMONDGV7CGPjYZVDoBPF+RrmSjyAfIEC6rxp8n2cNrSfF7OC+9FRfN
	 FLyGwfxZSBfSdTm92vg4iLh0y/tsvVAFQNvTJyC6rqn+0UDEgghcCXBhJcmOPNEuu+
	 1P6RncxdlPewMv8q1LO6XC9m1gKCwXIxaTxqwedo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgE3NP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3NP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:15:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFBA2074A;
        Sat, 30 May 2020 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590844557;
        bh=VceDSw21CiOfGJeqHBr1CP4d0xYCY00d31XuwrH77Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVFSSCom4H9LHoxhuFn21pSETGkaKylK0YvCvLucRPX0jI6hztPTZnbP7mvnCxy4l
         oA+AGKd0ckZc3i0+ubbQrSZm01+ROfuZeNR0pGFvQomCNspGw9SscgzpO6h2dS5r5E
         z1k18Ix4rl6KA3vuYsaD/PcAHZOHHaKWMEJPDUBk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jf1L9-00GXrc-Uf; Sat, 30 May 2020 14:15:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH 0/2] irqchip: loongson-*: Two small fixes
Date:   Sat, 30 May 2020 14:15:35 +0100
Message-Id: <159084442227.135078.812738924633130027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530121113.1797678-1-jiaxun.yang@flygoat.com>
References: <20200530121113.1797678-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jiaxun.yang@flygoat.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, tglx@linutronix.de, chenhc@lemote.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 20:11:11 +0800, Jiaxun Yang wrote:
> 
> Jiaxun Yang (2):
>   irqchip: loongson-pci-msi: Fix a typo in Kconfig
>   irqchip: loongson-*: Fix COMPILE_TEST
> 
>  drivers/irqchip/Kconfig                | 2 +-
>  drivers/irqchip/irq-loongson-htpic.c   | 4 ++++
>  drivers/irqchip/irq-loongson-htvec.c   | 4 ++++
>  drivers/irqchip/irq-loongson-liointc.c | 4 ++++
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> [...]

Applied to irqchip-next, thanks!

[1/2] irqchip/loongson-pci-msi: Fix a typo in Kconfig
      commit: 8abfb9b77d8707873088356cfee5bcbb842212af

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.

