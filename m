Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A6E21548
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593256109;
	bh=3PFr6kqNhAL9gthVmY3YY05Bhk6vYRM7Jm7OnV0DMmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UNSUji2iMmtrYUkOCpLtzjW6lYCkz/LVaIGMJ/TJCwl2SUoPoQgn/YGt0no8JtpBF
	 13wJc94SVC57KG+OwtQlt9CEQBuWEU+RTd8cMeDYMiBJ3KzVT6H+ssJuuyiXYRXvWM
	 XAuHZ4My9ib43AngYP8rAX/BVBbYnMfhRHZouF5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgF0LI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgF0LIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:08:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6B721527;
        Sat, 27 Jun 2020 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593256104;
        bh=3PFr6kqNhAL9gthVmY3YY05Bhk6vYRM7Jm7OnV0DMmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXZtyK61U7cju4rOd9T9Qdqm8TBx8Y+c3/IlfwcPGGbGdbtGBj3ZJ5i0+HBWNaicj
         7Ny9giwZGGQTrEKzdXMGEPtdHNESxBER96tqudGEZj0mVR/JWcXWFWkAXeg+jUOuHB
         Ug17ksTT6bTtM5SCS7wxq4uqM5hgs92DlTVjtHUI=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jp8h4-006s0z-ED; Sat, 27 Jun 2020 12:08:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Perepech <andrew.perepech@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip: vic: Drop cascaded intialization call
Date:   Sat, 27 Jun 2020 12:08:04 +0100
Message-Id: <159325548742.93134.737037488044346140.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607215124.48638-1-linus.walleij@linaro.org>
References: <20200607215124.48638-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, matthias.bgg@gmail.com, brgl@bgdev.pl, tglx@linutronix.de, linus.walleij@linaro.org, andrew.perepech@mediatek.com, linux-mediatek@lists.infradead.org, stephane.leprovost@mediatek.com, linux-arm-kernel@lists.infradead.org, pedro.tsai@mediatek.com, bgolaszewski@baylibre.com, fparent@baylibre.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jun 2020 23:51:23 +0200, Linus Walleij wrote:
> We got rid of the last user of the cascaded intialization
> from board files so drop this API.

Applied to irq/irqchip-5.9:

[1/2] irqchip/vic: Drop cascaded intialization call
      commit: adf4f9d49c74a812757c5c67879ece0e54b75417
[2/2] irqchip/vic: Cut down the external API
      commit: b0b92ab6a86e59779c2b17c5f611b04120fdfbb6

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

