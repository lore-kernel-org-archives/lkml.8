Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0D1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F8720775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yj8Esauw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgDTQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:07:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45830 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:07:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03KG71N7107479;
        Mon, 20 Apr 2020 11:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587398821;
        bh=KciNRdiw2cw0KPXkQoCX8Mz1MevzdmPH0gBj3JA4anA=;
        h=From:To:CC:Subject:Date;
        b=yj8EsauwBRCyAyHIQ1OWLrQWIhhvNjbigTvsGfcU3/WdvTMGvQ+ufqa3QLfxfrFZq
         PoiBsUmpU/DT62DvK4KVPvCi8oDcp2Sw/CPXGjdJy9Y+GBkvOTKe5WRrsmjfB6Mhkm
         jBcR7fKK9Mx5ifCB4jlNpormjbpiNtY77jFVMS3M=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03KG71as065537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Apr 2020 11:07:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 20
 Apr 2020 11:06:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 20 Apr 2020 11:06:06 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03KG66f9024775;
        Mon, 20 Apr 2020 11:06:06 -0500
Received: from localhost ([10.250.70.56])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 03KG66sB128161;
        Mon, 20 Apr 2020 11:06:06 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 0/2] Misc. rproc fixes around fixed memory region support
Date:   Mon, 20 Apr 2020 11:05:58 -0500
Message-ID: <20200420160600.10467-1-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This is another minor revision of the fixes around fixed memory region
support [1] series. Patch 1 is revised to go back to the logic used in v1
after a long discussion on the v2 version [2]. The other suggestions can
be future improvments as they would require corresponding platform driver
changes. Please look through the discussion there and let us know your
preference. Patches are based on v5.7-rc1.

I really appreciate it if you can target the series for the current 5.7 -rc's.
The fixes would apply for all 5.1+ kernels.

Please see the v1 cover-letter [1] for the details on the issues.

regards
Suman

[1] https://patchwork.kernel.org/cover/11422723/
[2] https://patchwork.kernel.org/comment/23274389/

Suman Anna (1):
  remoteproc: Fix and restore the parenting hierarchy for vdev

Tero Kristo (1):
  remoteproc: Fall back to using parent memory pool if no dedicated
    available

 drivers/remoteproc/remoteproc_core.c   |  2 +-
 drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.26.0

