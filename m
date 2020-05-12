Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2FC54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D6E20730
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cmr9KFtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgELNQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:16:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49064 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:16:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CDG2mu091972;
        Tue, 12 May 2020 08:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589289362;
        bh=h/Hv47WcjhG9VuUQ8uKmgAHJp1wp4aGRTo5I3HJrIVo=;
        h=From:To:CC:Subject:Date;
        b=Cmr9KFtr9gbpcES+o4LjfHOKZ7HE24D3uxHUfMUij8hwYhq5eBcf8TUT1YtzmTdWG
         DDfZ4yEqQKOxYMkahYeuWfoYef0taZUNSjU7SPbi8WSzOx3IetwyJjW5YFYqRfdYJP
         SWb+P1kwoWOL4bNNj0qg8Pp1Z4mmhDo1W3qGRD8k=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDG2UE065346;
        Tue, 12 May 2020 08:16:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 08:16:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 08:16:01 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDFxaa079268;
        Tue, 12 May 2020 08:15:59 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] ASoC: ti: Add support for audio on J721e EVM
Date:   Tue, 12 May 2020 16:16:30 +0300
Message-ID: <20200512131633.32668-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
  bindings: sound: Add documentation for TI j721e EVM (CPB and IVI)
  ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)

 .../bindings/sound/ti,j721e-cpb-audio.yaml    |  93 ++
 .../sound/ti,j721e-cpb-ivi-audio.yaml         | 142 +++
 sound/soc/ti/Kconfig                          |   8 +
 sound/soc/ti/Makefile                         |   2 +
 sound/soc/ti/davinci-mcasp.c                  |   3 +
 sound/soc/ti/j721e-evm.c                      | 867 ++++++++++++++++++
 6 files changed, 1115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
 create mode 100644 sound/soc/ti/j721e-evm.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

