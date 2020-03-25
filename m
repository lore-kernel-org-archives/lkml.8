Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6925C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7A620773
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yg49EB0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCYUrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:47:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40230 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCYUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:47:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02PKl5SK077576;
        Wed, 25 Mar 2020 15:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585169225;
        bh=w/UqBt2u20ALR9hXBqeGYXAKy3v6acQbksJMkudmy28=;
        h=From:To:CC:Subject:Date;
        b=yg49EB0pfGXzFBX1n8lzp8fA6mIDckMdl2JsVyoKeAQL+4kaexg8ZJMFSvZ7gknG3
         h15YbvaBa1LTDmEo23XGYBNCpRnBEebwbZNSrhPmakHsX6eVZW0en7AlR2uC6BQdhV
         8c7tduJzmI4Hg3mww99/ixLKe0eGN/cQNqk2dSDg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02PKl52c102381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Mar 2020 15:47:05 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 25
 Mar 2020 15:47:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 25 Mar 2020 15:47:04 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02PKl42h015387;
        Wed, 25 Mar 2020 15:47:04 -0500
Received: from localhost ([10.250.35.147])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 02PKl46k063366;
        Wed, 25 Mar 2020 15:47:04 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/4] Update K3 DSP remoteproc driver for C71x DSPs
Date:   Wed, 25 Mar 2020 15:46:57 -0500
Message-ID: <20200325204701.16862-1-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series adds support for a new next generation 64-bit TI DSP based on
the TMS320C71x CorePac processor subsystem called the C71x. The support is
enabled through couple of enhancements to the remoteproc core (primarily to
support a 64-bit trace resource entry), and does depend on the K3 DSP
remoteproc driver posted earlier today [1]. 

The loading support leveraged the 64-bit ELF loader support code added by
Clement and already staged on the rproc-next branch. I am posting this
series separate from the C66x series because of the new 64-bit resource
type enhancement needs (patches 2 and 3). I have leveraged the existing
resource types as is by introducing a new version element, and am open to
ideas if it is desired to just define it as a separate resource type.

The C71x DSP boots using firmware segments loaded into the DDR with a 2 MB
aligned address requirement on the boot vectors. There is no support for
internal memory loading, and all internal memories shall be used as fast 
RAMs/scatchpads by the firmware executing on the DSPs. IPC is through the
virtio-rpmsg transport. There is no support for Error Recovery, Power
Management or loading into on-chip SRAMs at present.

Following is the patch summary:
 - Patch 1 updates the K3 DSP bindings for C71x cores
 - Patch 2 introduces a concept of version element into existing resource types
 - Patch 3 adds support for a new 64-bit trace resource entry
 - Patch 4 enhances the K3 DSP remoteproc driver for C71x

regards
Suman

[1] https://patchwork.kernel.org/cover/11458573/

Suman Anna (4):
  dt-bindings: remoteproc: k3-dsp: Update bindings for C71x DSPs
  remoteproc: introduce version element into resource type field
  remoteproc: add support for a new 64-bit trace version
  remoteproc/k3-dsp: Add support for C71x DSPs

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 78 ++++++++++++++++---
 drivers/remoteproc/remoteproc_core.c          | 65 +++++++++++-----
 drivers/remoteproc/remoteproc_debugfs.c       | 50 ++++++++----
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 17 ++++
 include/linux/remoteproc.h                    | 34 +++++++-
 5 files changed, 203 insertions(+), 41 deletions(-)

-- 
2.23.0

