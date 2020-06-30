Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5852083E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AHtX7lz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgF3M6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:58:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388063AbgF3M57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:57:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05UCvpUM102757;
        Tue, 30 Jun 2020 07:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593521871;
        bh=N4st7905B306yEUjTON3RZKPjzNz1qXCxAYNaV7aO7s=;
        h=From:To:CC:Subject:Date;
        b=AHtX7lz4p8PXl8Eo+59XSYDbqUC8BnPlSpQ/pmAA2jroAECF38uciT6P5qFNe0QKl
         8R3KsLNzZ/+4Q8gBnIm1cCMJxi/IdktlHAguip5nCNA604/mwGvL6wJwwl0zrunIr6
         hFpWGzY8a3ERjxCDQFStDoORQVPjnh1YBgZ6ikfc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05UCvklX055812
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 07:57:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 07:57:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 07:57:47 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05UCviAI084334;
        Tue, 30 Jun 2020 07:57:45 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] ASoC: ti: Add support for audio on J721e EVM
Date:   Tue, 30 Jun 2020 15:58:40 +0300
Message-ID: <20200630125843.11561-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v3:
- Fix the single clock source handling and typo

Changes since v2:
- DT binding:
 - use proper (?) patch subject for the binding docuemtn patch
 - drop pll4 and pll15 from DT - driver should check the rate via
   clk_get_parent. If it is not available (as it is not currently) then use the
   match_data provided rates.
 - add simple explanation for the clocking setup
 - Use descriptive names for clocks: cpb/ivi-mcasp-auxclk and cpb/ivi-codec-scki
 - dt_binding_check shows no errors/warnings
- ASoC machine driver:
 - Try to read the PLL4/15 rate with clk API (parent of the two clock divider)
   if it is not available then use the match_data provided numbers.
 - Support for single PLL setup

Changes since v1:
- Fixed DT binding documentation errors
- Rebased on ASoC head and updated the driver to compile and work

This series adds support for the analog audio setup on the j721e EVM.
The audio setup of the EVM is:
Common Processor Board (CPB): McASP10 <-> pcm3168a
Infotainment Expansion Board (IVI): McASP0 <-> 2x pcm3168a

Both CPB and IVI wired in parallel serializer setup.

The first patch adds the stream_name for McASP driver as it is needed in
multicodec (and would be needed in DPCM) setup for proper DAPM handling.

The second patch adds two DT schema, one for the cpb and one for the cpb+ivi
card.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: ti: davinci-mcasp: Specify stream_name for playback/capture
  ASoC: dt-bindings: Add documentation for TI j721e EVM (CPB and IVI)
  ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)

 .../bindings/sound/ti,j721e-cpb-audio.yaml    |  95 ++
 .../sound/ti,j721e-cpb-ivi-audio.yaml         | 150 +++
 sound/soc/ti/Kconfig                          |   8 +
 sound/soc/ti/Makefile                         |   2 +
 sound/soc/ti/davinci-mcasp.c                  |   3 +
 sound/soc/ti/j721e-evm.c                      | 896 ++++++++++++++++++
 6 files changed, 1154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
 create mode 100644 sound/soc/ti/j721e-evm.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

