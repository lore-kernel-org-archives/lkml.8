Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D17C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0B820675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFZUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:48:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55411 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:48:19 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6049D20002;
        Fri, 26 Jun 2020 20:48:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        robh+dt@kernel.org, ludovic.desroches@microchip.com
Subject: Re: [PATCH v2] ARM: dts: at91: sama5d2_xplained: Remove pdmic node
Date:   Fri, 26 Jun 2020 22:48:16 +0200
Message-Id: <159320449048.1519242.4348779875317362688.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618152845.682723-1-codrin.ciubotariu@microchip.com>
References: <20200618152845.682723-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 18:28:45 +0300, Codrin Ciubotariu wrote:
> The PDMIC needs PDM microphones to work. sama5d2 xplained doesn't have
> such microphones, so there is no reason to enable PDMIC and take the
> pins since there is no-one using them.

Applied, thanks!

[1/1] ARM: dts: at91: sama5d2_xplained: Remove pdmic node
      commit: 51139cc82c8d6edec034a6c2401090070195fa13

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
