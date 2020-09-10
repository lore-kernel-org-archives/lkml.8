Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20C1208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MpjF/hY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgIJVvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:51:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46424 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbgIJMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:41:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfCwS058807;
        Thu, 10 Sep 2020 07:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599741672;
        bh=nzSal+6OsgkooGCpPLASc7epDcU1mtLH8VlEHBjVaT8=;
        h=From:To:CC:Subject:Date;
        b=MpjF/hY5RgChDuhPz9O/wrU1Kx4vX3NTzEeomiYjFGa3td1TCtayAwYoe9xzlbaLK
         onqR/5WfhDnPO8CHgx9tthWm4xTBtvMEd3Ks8ZnTqSXSglfUginB4d9IBtPzMi9WP6
         5OewJXzxDCmCwHndy78yYAsLljHats6tzGQlWD8M=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfC8f006482;
        Thu, 10 Sep 2020 07:41:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 07:41:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 07:41:12 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfAGM024223;
        Thu, 10 Sep 2020 07:41:10 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] ASoC: ti: j721e-evm: Support for j7200 variant
Date:   Thu, 10 Sep 2020 15:41:08 +0300
Message-ID: <20200910124110.19361-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
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
- Suffix the 2359296000 constant with 'u' to silence C90 warning

When j7200 SOM is connected to the CPB, the audio setup is a bit different:
Only 48KHz family have clock path, 44.1KHz is not supported.

Update the binding documentation and add support for the j7200 version of CPB
to the driver.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: dt-bindings: ti,j721e-cpb-audio: Document support for j7200-cpb
  ASoC: ti: j721e-evm: Add support for j7200-cpb audio

 .../bindings/sound/ti,j721e-cpb-audio.yaml    | 92 ++++++++++++++-----
 sound/soc/ti/j721e-evm.c                      | 11 +++
 2 files changed, 81 insertions(+), 22 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

