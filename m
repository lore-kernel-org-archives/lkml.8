Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304D12074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="utfNXl4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgGQXsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:48:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45372 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm6S5083779;
        Fri, 17 Jul 2020 18:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595029686;
        bh=4TAey2VvFLXj0C9s/GRiaccjT5Iz0zlLeCg6jzFZ23I=;
        h=From:To:CC:Subject:Date;
        b=utfNXl4ZAeOe7W2TiejJ5kgkHRaEb8GtNBmmu1WXMYURChauNBTFuehb+ms4bA/hw
         Pv7qMMVl2bjuAvUjC0XL+XxebjCWTZossamAE56cS6Zm9XEzuDu8O41Ih3iUw4AWWb
         MHQI2ZalVEGYXLxBmIJEFWOGf07yK0FsJHvKi8ks=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HNm6iU062173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 18:48:06 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 18:48:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 18:48:06 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HNm5Q4037386;
        Fri, 17 Jul 2020 18:48:05 -0500
Received: from localhost ([10.250.34.57])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 06HNm5jl108241;
        Fri, 17 Jul 2020 18:48:05 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v4 0/6] TI K3 DSP remoteproc driver for C66x DSPs
Date:   Fri, 17 Jul 2020 18:47:54 -0500
Message-ID: <20200717234800.9423-1-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following is v4 of the K3 DSP remoteproc driver supporting the C66x DSPs
on the TI K3 J721E SoCs. The patches apply cleanly both on v5.8-rc1 as well
as laster commit on the master branch.

This series is largely unchanged, addressing various minor comments from
Mathieu and Rob. The ti,k3-sci-proc bindings patch (patch #3) is the only
patch without an Ack from v3.

Following are the changes in v4:
 - Fixed Rob's review comments on ti,k3-sci-proc.yaml
 - Moved the ti_sci_protocol.h header file from ti_k3_dsp_remoteproc.c
   to ti_sci_proc.h
 - Replaced the TI http link with https following similar changes
   submitted recently
 - Removed an unnecesary addr check before iounmap

Please see the individual patches for further delta differences.

v3: https://patchwork.kernel.org/cover/11602331/
v2: https://patchwork.kernel.org/cover/11561787/
v1: https://patchwork.kernel.org/cover/11458573/

C71x v3: https://patchwork.kernel.org/cover/11602345/

Hi Bjorn,
This series is ready to be picked up for 5.9 merge window. Please also
pick the C71x v3 series on top of this, there are no pending comments
on that one and is waiting for this series.

regards
Suman

Suman Anna (6):
  remoteproc: Introduce rproc_of_parse_firmware() helper
  remoteproc: k3: Add TI-SCI processor control helper functions
  dt-bindings: remoteproc: Add common TI SCI rproc bindings
  dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
  remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs
  remoteproc: k3-dsp: Add support for L2RAM loading on C66x DSPs

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 139 ++++
 .../bindings/remoteproc/ti,k3-sci-proc.yaml   |  48 ++
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  23 +
 drivers/remoteproc/remoteproc_internal.h      |   2 +
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 771 ++++++++++++++++++
 drivers/remoteproc/ti_sci_proc.h              | 104 +++
 8 files changed, 1101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
 create mode 100644 drivers/remoteproc/ti_sci_proc.h

-- 
2.26.0

