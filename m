Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8DC3F2C1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBAE24690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="lRMc9TaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgB0VBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:01:24 -0500
Received: from gateway23.websitewelcome.com ([192.185.47.80]:22855 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgB0VBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:01:23 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 16:01:23 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 7AD965F25
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:16:19 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id 7PZzj0erKvBMd7PZzjwE8c; Thu, 27 Feb 2020 14:16:19 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O9Ta8jqoR7xvtXnW35tk+UGBKOY48qRRa7KgNc+IA7U=; b=lRMc9TaOZ2BZQfzftZUL7wYbgf
        bQJNrdeBEpvAO1rb9obaKegi8YN/JE6ibWNYlZVFkMAwEVlz60Hyrlpf4QI1neiB7DdfP6nywori7
        KeFc/a3b9kF3q9LFLQZivNdh5arO13LnoIil4AdUh5NLwR+E/8r8cVCpYatPqAkEj2XzIt4NCYami
        1drpAQGejnROIkhnuxTozzTorSka/VEWWjRVcUL7qJVW2FAJ5DzpO5tYyVUVvjxxh/87KeBfmvbrN
        5KeyOTgqiUWsQqoAy7LOQCv6lLxypH3OnVgWBksHBfhFm6hwG5AVTAqHpRusEQTatVbcNASTDg3TD
        AaAn+mjw==;
Received: from [191.31.195.84] (port=40030 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1j7PZy-002xJo-Fk; Thu, 27 Feb 2020 17:16:18 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1 0/2] Add Caninos Loucos Labrador SoM and Base Board Device Tree
Date:   Thu, 27 Feb 2020 17:15:55 -0300
Message-Id: <20200227201557.368533-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.84
X-Source-L: No
X-Exim-ID: 1j7PZy-002xJo-Fk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.195.84]:40030
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caninos Loucos Labrador is a Brazilian project of open System on Modules and
Base Boards based on Lemaker Guitar. Is an initiative of LSI-TEC a non-profit
organization.

The Labrador SoM v2 is based on Actions Semi S500 processor with 16GB eMMC and
2GB RAM.

This series adds the initial work for device tree files and also adds the
vendor-prefix for the Caninos program. The work was based on the Andreas Färber
device trees for Lemaker Guitar, thanks Andreas.

Tested on my Caninos Labrador v2, only earlycon serial output is available for
now, using the fake clock. I have already worked on something here to add the
clocks and pinctrl nodes to owl-s500.dtsi, but I would like to first add the
initial device tree files and then work on the other patches calmly.

BR,
Matheus Castello

Matheus Castello (2):
  dt-bindings: arm: actions: Document Caninos Loucos Labrador
  ARM: dts: Add Caninos Loucos Labrador

 .../devicetree/bindings/arm/actions.yaml      |  5 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  3 +-
 arch/arm/boot/dts/owl-s500-labrador-bb.dts    | 33 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 21 ++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-bb.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

--
2.25.0

