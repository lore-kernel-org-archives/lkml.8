Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE9EC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0E20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="e8A/1clU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZRUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:20:16 -0400
Received: from gateway33.websitewelcome.com ([192.185.147.108]:36127 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgDZRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:20:15 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id EA53219D9401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:47 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id SkcBjKDvVAGTXSkcBjdGy0; Sun, 26 Apr 2020 11:58:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3afp7XxE1GlxY/Ju1j3y2JMSguq9JL32ykPeH5k4AAE=; b=e8A/1clUau5xhwJsVZL/XinyHG
        K+NKJwhcDIzLEepjZNEnvkt07zus5UaGa8Gwvkv24REMgFQapaFmx4O0A2Ptmi96gDizht5r/Dh00
        g5/TTyU3Z6QYEdDaf2snZ1eAmeqjL8IPFdrySd3U6YiXmnZPRJi3w597ivbbSaBIjitrcXpqK4mZx
        DbQ27XappymmQ2+AidWd+M+ebvUuCdEgpnXGyHJkr8WzGMADrOMJPKo0xOwfY8Vgu8Wlk+DCCRG8o
        3IMlCWyMMQaH1/64dBZ407bRGK0Ps9kBjsoJnmb4zMJCS15aJdMGDXQNohclyc2sxt6Wt03aK482c
        36fD6CLA==;
Received: from [191.31.197.205] (port=35482 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jSkcB-001TTf-BY; Sun, 26 Apr 2020 13:58:47 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v4 0/3] Add Caninos Loucos Labrador CoM and Base Board Device Tree
Date:   Sun, 26 Apr 2020 13:58:32 -0300
Message-Id: <20200426165835.105970-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <f9e48fba-0da8-7ba9-d44a-7909067a1df1@castello.eng.br>
References: <f9e48fba-0da8-7ba9-d44a-7909067a1df1@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.197.205
X-Source-L: No
X-Exim-ID: 1jSkcB-001TTf-BY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.197.205]:35482
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 15
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andreas, Mani and Rob for your time reviewing it.

Changes since v3:
(Suggested by Andreas Färber)
- Fix sort on actions.yaml
- Change the file owl-s500-labrador-bb.dts to owl-s500-labrador-base-m.dts
- Add description for both the SoM and Base Board
- Add Model description for both the SoM and Base Board

Changes since v2:
(Suggested by Andreas Färber)
- Sort the entries alphabetically on vendor-prefixes.yaml
- Improve commit description
- Add Edgar Bernardi Righi and Igor Ruschi from Caninos team as CC

Caninos Loucos Labrador is a Brazilian project of open System on Modules and
Base Boards based on Lemaker Guitar. Is an initiative of LSI-TEC a non-profit
organization.

The Labrador CoM v2 is based on Actions Semi S500 processor with 16GB eMMC and
2GB RAM.

This series adds the initial work for device tree files and also adds the
vendor-prefix for the Caninos program. The work was based on the Andreas Färber
device trees for Lemaker Guitar, thanks Andreas.

Tested on my Caninos Labrador v2, only earlycon serial output is available for
now, using the fake clock. I have already worked on something here to add the
clocks and pinctrl nodes to owl-s500.dtsi, but I would like to first add the
initial device tree files and then work on the other patches calmly.

Stay safe,
Matheus Castello

Matheus Castello (3):
  dt-bindings: Add vendor prefix for Caninos Loucos
  dt-bindings: arm: actions: Document Caninos Loucos Labrador
  ARM: dts: Add Caninos Loucos Labrador

 .../devicetree/bindings/arm/actions.yaml      | 11 ++++--
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../arm/boot/dts/owl-s500-labrador-base-m.dts | 34 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 22 ++++++++++++
 5 files changed, 67 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

--
2.25.0

