Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F4020748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XXN9tuUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgEUPQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:16:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38230 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgEUPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:16:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGdLd106510;
        Thu, 21 May 2020 10:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590074199;
        bh=xeF3uqjn0PZozN4ybOvKTivNEawwwc9tj9QBVURFGSw=;
        h=From:To:CC:Subject:Date;
        b=XXN9tuUgbc6bCXffPyKNSpCBedUG9yoTCQEVzaclhTffN3bjEPpX7bmW7t1+GTQex
         804iRou6Vpx+S/4WeKgV13HOICQ0TS59efUP3epwyNyOIleV8+EMHt3JInBp9UoDie
         hpTcSCmnNFHt1D0NwuXAEPS/3HvoP2fm9LqmhvoE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LFGd7k036994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 10:16:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 10:16:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 10:16:39 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGdTC071695;
        Thu, 21 May 2020 10:16:39 -0500
Received: from localhost ([10.250.48.148])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 04LFGciZ076170;
        Thu, 21 May 2020 10:16:39 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 0/2] Update K3 DSP remoteproc driver for C71x DSPs
Date:   Thu, 21 May 2020 10:16:34 -0500
Message-ID: <20200521151636.28260-1-s-anna@ti.com>
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

This series is an updated version of the enhancements to the K3 DSP
remoteproc driver to support the 64-bit TI DSP called C71x. The series
is on top of the K3 DSP remoteproc driver v2 [1], and includes only
the platform driver portions. Please see the v1 cover-letter [2] for
a summary of supported features.

The 64-bit resource type enhancements (patches 2 and 3 from v1 [3][4])
can be reviewed and discussed separately. I can post the next versions
just for those based on any review comments on those.

Please see the individual patches for differences in v2.

regards
Suman

[1] https://patchwork.kernel.org/cover/11561787/
[2] https://patchwork.kernel.org/cover/11458599/
[3] https://patchwork.kernel.org/patch/11458593/
[4] https://patchwork.kernel.org/patch/11458589/

Suman Anna (2):
  dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
  remoteproc/k3-dsp: Add support for C71x DSPs

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 76 +++++++++++++++++--
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 20 ++++-
 2 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.26.0

