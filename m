Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC0C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C732072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHYPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:53:24 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33821 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHYPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:53:18 -0400
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A5FDE100002;
        Tue, 25 Aug 2020 15:53:14 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org,
        Reto Schneider <code@reto-schneider.ch>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: at91: Add GARDENA smart Gateway (Art. 19000) board
Date:   Tue, 25 Aug 2020 17:53:14 +0200
Message-Id: <159837068692.2863543.14754905231256837957.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200822151023.31629-1-code@reto-schneider.ch>
References: <20200810171921.8679-1-code@reto-schneider.ch> <20200822151023.31629-1-code@reto-schneider.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 17:10:20 +0200, Reto Schneider wrote:
> Document devicetree's bindings for the GARDENA smart Gateway with
> article number 19000, based on the SAM9G25 Atmel SoC.

Applied, thanks!

I did join back the long line in the device tree documention as I found that
clearer.

[1/2] dt-bindings: arm: at91: Add GARDENA smart Gateway (Art. 19000) board
      commit: c05a4bff5c509afda0ee60009d62b5abc0e08311
[2/2] ARM: at91: Add GARDENA smart Gateway (Art. 19000) support
      commit: 25ffa0dde53c14cd6ddc938e39f70db4f8837591

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
