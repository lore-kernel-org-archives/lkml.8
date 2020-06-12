Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05015C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CC62078E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YZvXZVmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFLWyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:54:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32982 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgFLWyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:54:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CMs1kL111988;
        Fri, 12 Jun 2020 17:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592002441;
        bh=VSni54BIp+7PUxHdxMxFN65bOJ1eAWoDkUhvs/ixIvM=;
        h=From:To:CC:Subject:Date;
        b=YZvXZVmAaMoYn+tYHOU0MNyPcBtTZiQ9trW5r74/atWbn+OH8mAETCL42JDa/VDSw
         t2ORncyIhSzR4L2fU/jqANcL3T/dA5MiCnZzfouwyJn0lVg4kbFKIhm1nmL+TtDVAR
         loQm6tFue07fQ1434AH43VZTPkp2rHxr62cKac1g=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CMs1wX125918
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:54:01 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 17:54:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 17:54:00 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMs0O0040608;
        Fri, 12 Jun 2020 17:54:00 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05CMs0Vg063923;
        Fri, 12 Jun 2020 17:54:00 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 0/2] Update K3 DSP remoteproc driver for C71x DSPs
Date:   Fri, 12 Jun 2020 17:53:55 -0500
Message-ID: <20200612225357.8251-1-s-anna@ti.com>
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

This series is the updated v3 version of the 64-bit TI C71x DSP support
that goes along with the updated v3 TI K3 C66x DSP patch series [1].
Please see the previous cover-letters [2][3] for a summary of supported 
features.

The only change is to Patch 1 that had to be rebased and adjusted for
the changes to the K3 DSP binding file in the C66x series. Please see the
individual patches for differences in v3.

regards
Suman

[1] C66x v3: https://patchwork.kernel.org/cover/11602331/
[2] C71x v2: https://patchwork.kernel.org/cover/11563229/
[2] C71x v1: https://patchwork.kernel.org/cover/11458599/


Suman Anna (2):
  dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
  remoteproc: k3-dsp: Add support for C71x DSPs

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 68 +++++++++++++++----
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 20 +++++-
 2 files changed, 73 insertions(+), 15 deletions(-)

-- 
2.26.0

