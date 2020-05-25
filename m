Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30578C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0ADB20899
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590401311;
	bh=J6set5wG6yYzEZqJStlskj0Qhfj8D7QFCDFSbGIGd/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A8Ghcqspts5nzMyTlqcGbX+p69eBRPZ+vlwasYBACFLO5G752N6exjzZMDyqxuu60
	 XCJ8QYx3Wdy60pi1DXLHGmw0Pvvm4UN+QZITBAF8CY+8m1FcHSGVFk+lTmFTHKPSck
	 9d5UBYG4F0QP3qXalTodZuy/PRuZi73JJlPzi7wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbgEYKIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389337AbgEYKI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:08:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14163206D5;
        Mon, 25 May 2020 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590401309;
        bh=J6set5wG6yYzEZqJStlskj0Qhfj8D7QFCDFSbGIGd/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hIaZZg9rgTUjy0zKc8HquIfWBmWIniT3wWGWP4sqdOXUS5HD0iWvDkCFB+Uoxflf
         4vwo6Aw7lKGr0zvf08ixEj2YjX2torC0cej5UuMG9zyX2AVAaxrEggq3Vpa1sfRgJv
         ke+G54WgvzycCpksvRGtmhxjjG/jnnKeHe/BdNMM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdA1z-00F7tY-Dv; Mon, 25 May 2020 11:08:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Anup Patel <anup@brainfault.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v2 0/3] More improvements for multiple PLICs
Date:   Mon, 25 May 2020 11:08:02 +0100
Message-Id: <159040126938.385862.7378207521947822453.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518091441.94843-1-anup.patel@wdc.com>
References: <20200518091441.94843-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: paul.walmsley@sifive.com, anup.patel@wdc.com, tglx@linutronix.de, palmer@dabbelt.com, jason@lakedaemon.net, anup@brainfault.org, Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, atish.patra@wdc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 14:44:38 +0530, Anup Patel wrote:
> This series does more improvements for supporting multiple PLIC
> instances.
> 
> PATCH1 and PATCH2 are fixes whereas PATCH3 helps users distinguish
> multiple PLIC instances in boot prints.
> 
> These patches are based up Linux-5.7-rc5 and can be found at
> plic_imp_v2 branch at: https://github.com/avpatel/linux.git
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/3] irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()
      commit: 2458ed31e9b9ab40d78a452ab2650a0857556e85
[2/3] irqchip/sifive-plic: Setup cpuhp once after boot CPU handler is present
      commit: 2234ae846ccb9ebdf4c391824cb79e73674dceda
[3/3] irqchip/sifive-plic: Improve boot prints for multiple PLIC instances
      commit: 0e375f51017bcc86c23979118b10445c424ef5ad

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


