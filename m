Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7E920767
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592749236;
	bh=1JJUUYXnXHvputWDk56tJc3YEIIePEn96bUELiZMnH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jzViaU9YVTlT3RzdYMFr5YTj69d/L4ixw/rmOrFeU7NYX108MDi4j3F23eGFiSOSD
	 HbMFgrZddV0ncLYXVeRpuBiLs8vYrNtKqC921ZVgt2ZKCrM7wnrhu3F3CDaklVS+Ol
	 mFABAWC9VHtiqyxkQ6jBmaUzNt71faZOzDL3A7I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgFUOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgFUOUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:20:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2831B20708;
        Sun, 21 Jun 2020 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592749234;
        bh=1JJUUYXnXHvputWDk56tJc3YEIIePEn96bUELiZMnH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCgWRlMVCXkFbI1LfKZ7Wdr/f9DPq9hHxgA8kdzxDcbp5aFzcAgyhjh6PzkHWmgKM
         POPjfjjB3vuNV6OPPtcCq2xlBpu8SrLbdfwekISZQ3VJrszJfd8lhP1j+/ak1VjEAd
         zyD/+5vyy54XjTwF/0UiPeOQekIUtDEt8xMVESBc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jn0pk-0056cj-8r; Sun, 21 Jun 2020 15:20:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>
Cc:     jason@lakedaemon.net, tglx@linutronix.de,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv@lists.infradead.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
Subject: Re: [PATCH] irqchip: riscv-intc: Fix a typo in a pr_warn()
Date:   Sun, 21 Jun 2020 15:20:25 +0100
Message-Id: <159274906987.783748.5482676001777469001.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611175302.253540-1-palmer@dabbelt.com>
References: <20200611175302.253540-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: palmer@dabbelt.com, Anup.Patel@wdc.com, jason@lakedaemon.net, tglx@linutronix.de, palmerdabbelt@google.com, linux-riscv@lists.infradead.org, kernel-team@android.com, linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 10:53:02 -0700, Palmer Dabbelt wrote:
> Anup originally re-spun his patch set to include this fix, but it was a bit too
> late for my PR so I've split it out.

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/riscv-intc: Fix a typo in a pr_warn()
      commit: 559fe74ba6b0c8283e923a64f19fc0398fb64d04

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.
