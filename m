Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD8C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D18221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XKuj/FAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgIKJVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:21:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53960 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbgIKJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:21:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B9HhWY013223;
        Fri, 11 Sep 2020 11:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=zPssAz57qPbck8kfcp9veYTq0xH11iTPM9Ncg86DhkU=;
 b=XKuj/FATPflF8FXfZDEYytr1MlZgK2wRKnYAHcDRqt2zyAMcb53GqDFVW8A1mnQATy7x
 cVyLDJcRNIK7TAN8zNlI1QG9YropmGb+Cr5JpZ8BLQtWf6vREJdnGW2KyAcIUdPBjwkm
 fOXmCb1ZNyG4AHWrHXvOzrP3QKp1jjc6TwhqvFzbwuXdrKE0WNYiCQHJTK61cn6492ng
 4LvXngSkPkhkAsy2QMDaUYs9ENkgAb1O9Athni0nAUus608bBvSZ9lvOmqVUz15NU4Bz
 0EZ0rxemEGqt2epCy0fk/oWpwSb7A2+lZwKeJ60UkAx21gUSwl9LbeSoUhRMZ3iDwtLl yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33c1jfgn2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:20:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9629A10002A;
        Fri, 11 Sep 2020 11:20:23 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag6node5.st.com [10.75.127.81])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E0DA21FEBE;
        Fri, 11 Sep 2020 11:20:23 +0200 (CEST)
Received: from localhost (10.75.127.44) by GPXDAG6NODE5.st.com (10.75.127.81)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep 2020 11:20:22
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <arnaud.pouliquen@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Date:   Fri, 11 Sep 2020 11:19:50 +0200
Message-ID: <20200911091952.14696-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To GPXDAG6NODE5.st.com
 (10.75.127.81)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_03:2020-09-10,2020-09-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add master clock generation support in STM32 I2S driver.

Olivier Moysan (2):
  ASoC: dt-bindings: add mclk provider support to stm32 i2s
  ASoC: stm32: i2s: add master clock provider

 .../bindings/sound/st,stm32-i2s.yaml          |   4 +
 sound/soc/stm/stm32_i2s.c                     | 310 +++++++++++++++---
 2 files changed, 270 insertions(+), 44 deletions(-)

-- 
2.17.1

