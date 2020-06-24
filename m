Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788122077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O9+Xgjp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405021AbgFXQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:15:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50402 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404802AbgFXQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:15:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OGF1cl038472;
        Wed, 24 Jun 2020 11:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593015301;
        bh=PERrQrRfdmam6H0p9AISJ5uvgazKR0B7qBwzzHc92JA=;
        h=From:To:CC:Subject:Date;
        b=O9+Xgjp1yiFV1ez/tC5FJaYDrH7dzhajKNpZbiK31kD8bvPAqFwo3n721Ww7l2lhT
         3onjWEhL7U2JN3QYoO27m/SaNPniSKNqaGJwqH0OqpXi979pGI3r8pL1VTRCQYzKLN
         p0NBdi0LROr/Bi3KAxnUkJGY0XdK+1zP3/aSPyIo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OGF120079293;
        Wed, 24 Jun 2020 11:15:01 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 11:15:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 11:15:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OGF0de112577;
        Wed, 24 Jun 2020 11:15:00 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 0/7] TAS2562 issue fixes and slot programming 
Date:   Wed, 24 Jun 2020 11:14:52 -0500
Message-ID: <20200624161459.19248-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This series fixes issues tih the shut-down gpio device tree allocation and a
code format issue found.

While working on a project slot programming for the tx and rx paths needed to be
enabled.  In addition the vsense slot programming needed to be configurable and
not directly a simpler adder to the isense slot.

Finally the yaml conversion patch was moved to be the last patch in the series
so that the fixes can be applied and the yaml can be reviewed appropriately
and does not hold up the rest of the fixes.

Dan


Dan Murphy (7):
  dt-bindings: tas2562: Fix shut-down gpio property
  ASoC: tas2562: Update shutdown GPIO property
  ASoC: tas2562: Fix format issue for extra space before a comma
  ASoC: tas2562: Add rx and tx slot programming
  dt-bindings: tas2562: Add voltage sense slot property
  ASoC: tas2562: Add voltage sense slot configuration
  dt-bindings: tas2562: Convert the tas2562 binding to yaml

 .../devicetree/bindings/sound/tas2562.txt     |   34 -
 .../devicetree/bindings/sound/tas2562.yaml    |   77 +
 arch/arm/boot/compressed/fdt.h                |   66 +
 arch/arm/boot/compressed/libfdt.h             | 2072 +++++++++++++++++
 arch/arm/boot/compressed/libfdt_internal.h    |  173 ++
 sound/soc/codecs/tas2562.c                    |   88 +-
 sound/soc/codecs/tas2562.h                    |    4 +
 7 files changed, 2462 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
 create mode 100644 arch/arm/boot/compressed/fdt.h
 create mode 100644 arch/arm/boot/compressed/libfdt.h
 create mode 100644 arch/arm/boot/compressed/libfdt_internal.h

-- 
2.26.2

