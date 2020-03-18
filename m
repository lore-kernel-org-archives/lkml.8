Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C391EC5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E1A20775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ouvh+62O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCROnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:43:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14172 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbgCROnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:43:01 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IEd4n8021917;
        Wed, 18 Mar 2020 15:41:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=glh+neVr3hU2AAir3F/WpKodtMms5/f6uoCBtXe+P8c=;
 b=ouvh+62OJe3TfAiCI3m+1utTHcf0+n0+PwUyMaC51xx1MRrpwgRVOZHfFR2ZI2uBDzKX
 V9TjJMuu1J9syUeui1OAKjBSIran8uX/kpO1GKqA7qs1nmLIeFmBIi7JQzz5pfPpTt3B
 OtQENCymMCPqevX2g9CP2gWdYZk/oHz9twgDr8FkaHpbEt+voEZDrelvENYyM0/GIwg9
 M9GslGgGxm64uH0oo7M9pWaRnapzSDOxKmK4Of1OS3Jd1PXBqDNJf4OO9XMN3U51FQL0
 Fvh1ZDoBCXoCVZE2v6ObneNoqAMwNtJp2uox96wATUJjBo5S3DQ9NM5/dNnL4zF1BoGD Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yua4wbscg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 15:41:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56C2510002A;
        Wed, 18 Mar 2020 15:41:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 206962AE6C9;
        Wed, 18 Mar 2020 15:41:57 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Mar 2020 15:41:55
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] ASoC: stm32: manage rebind issue
Date:   Wed, 18 Mar 2020 15:41:22 +0100
Message-ID: <20200318144125.9163-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_06:2020-03-18,2020-03-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset corrects a rebind issue on STM32 SPDIFRX and I2S drivers.

The same correction has already been applied for SAI driver:
0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")

The commit e894efef9ac7 ("ASoC: core: add support to card rebind")
allows to rebind the sound card after a rebind of one of its component.
With this commit, the sound card is actually rebound,
but may be no more functional.

The following problems have been seen on STM32 drivers.

1) DMA channel is not requested:

With the sound card rebind the simplified call sequence is:
    probe
        snd_soc_register_component
                snd_soc_try_rebind_card
                        snd_soc_instantiate_card
        devm_snd_dmaengine_pcm_register

The problem occurs because the pcm must be registered,
before snd_soc_instantiate_card() is called.

Modify the driver, to change the call sequence as follows:
    probe
        devm_snd_dmaengine_pcm_register
        snd_soc_register_component
                snd_soc_try_rebind_card

2) DMA channel is not released:

dma_release_channel() is not called when
devm_dmaengine_pcm_release() is executed.
This occurs because SND_DMAENGINE_PCM_DRV_NAME component,
has already been released through devm_component_release().

devm_dmaengine_pcm_release() should be called before
devm_component_release() to avoid this problem.

Call snd_dmaengine_pcm_unregister() and snd_soc_unregister_component()
explicitly from the driver, to have the right sequence.

Olivier Moysan (3):
  ASoC: stm32: spdifrx: fix regmap status check
  ASoC: stm32: spdifrx: manage rebind issue
  ASoC: stm32: i2s: manage rebind issue

 sound/soc/stm/stm32_i2s.c     | 40 ++++++++++++++++------
 sound/soc/stm/stm32_spdifrx.c | 64 +++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 41 deletions(-)

-- 
2.17.1

