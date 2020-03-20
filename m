Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88931C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8920722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="z6WhGAWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCTDvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:51:51 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.95]:47748 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbgCTDvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:51:51 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id EEE7D10FB3A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 22:51:49 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id F8hJjXMUwVQh0F8hJjmJD2; Thu, 19 Mar 2020 22:51:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AmW9KW6fyjVw/q4SNibq40anvInSMWalfJcTk2nYiAE=; b=z6WhGAWiAO6VWX8phU39p6TPAq
        e+V2aJqbqB9wpKxiKKk8BW1rGrWRU71/f2cKESjtnY8wCd5MKHyBS4/nBXeV1/N5lL3u36T8IzjAN
        bEdTtpwPV3pJWBhhGDGJXWuoJtwmWCc+iXNDhgaqVQlyZMjct/2ieZoaygxa6YFizVzAsO36OY53h
        4dlBtil9T76JS1KTM3bDqkNaC7F/o6SmPO262JpgOr2YOQ01fv3wYKxtcKgHLMF9scMytQS6pxWZG
        wa2lgtpsg8YTmksCu+UPsVqnR7dE/CTPLCmJTdHACxcDNFLUDIBfnalbsx1FOLdQo2MSnKpg7FK3a
        9h+2YJkw==;
Received: from [191.31.203.148] (port=48890 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jF8hJ-000OUT-A5; Fri, 20 Mar 2020 00:51:49 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 0/3] Add Caninos Loucos Labrador CoM and Base Board Device Tree
Date:   Fri, 20 Mar 2020 00:51:01 -0300
Message-Id: <20200320035104.26139-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200229104358.GB19610@mani>
References: <20200229104358.GB19610@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.203.148
X-Source-L: No
X-Exim-ID: 1jF8hJ-000OUT-A5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.203.148]:48890
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andreas and Mani for your time reviewing it.

Changes since v2:
(Suggested by Andreas Färber)
- Sort the entries alphabetically on vendor-prefixes.yaml
- Improve commit description
- Add Edgar Bernardi Righi and Igor Ruschi from Caninos team as CC

Changes since v1:
(Suggested by Manivannan Sadhasivam)
- Sort the entries alphabetically on Makefile
- Add title comment to the base board dts
- Remove the dt-bindings/leds/common.h (garbage from tests, sorry about that)
- Split the vendor-prefix and documentation in two patches

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

 .../devicetree/bindings/arm/actions.yaml      |  5 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/owl-s500-labrador-bb.dts    | 34 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 21 ++++++++++++
 5 files changed, 63 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-bb.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

--
2.25.0

