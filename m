Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B239C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8627206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oUSY+0Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLI6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:58:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37436 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgFLI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:58:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05C8wPPS034203;
        Fri, 12 Jun 2020 03:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591952305;
        bh=NBDf0YaA1YfALk0ATaTtdnHy3hK4L7pWE3/OLak5WNo=;
        h=From:To:CC:Subject:Date;
        b=oUSY+0IgWeRsNy2KUsBOfjE1c+2yGkVx/l7JpLv6ZCz37sRlaeGNEEB2x2P5WPD1/
         GLDX5VTzcHtNluO3Hp67fyRSG0X3Pc94peDxuC8wPsoDs9MaHjR9rc0ovt8SxubmXv
         2YmuCXEOyUOZjNiGrp7Qjyx7eGaRCRsdpCShAKAI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05C8wP1W124701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 03:58:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 03:58:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 03:58:24 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05C8wMMJ036678;
        Fri, 12 Jun 2020 03:58:23 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] ASoC: ti: Add support for audio on J721e EVM
Date:   Fri, 12 Jun 2020 11:59:06 +0300
Message-ID: <20200612085909.15018-1-peter.ujfalusi@ti.com>
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
 sound/soc/ti/j721e-evm.c                      | 887 ++++++++++++++++++
 6 files changed, 1145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
 create mode 100644 sound/soc/ti/j721e-evm.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

