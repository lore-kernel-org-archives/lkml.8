Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D1C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B6E217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="j3ah9nk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgBFNeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:34:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33058 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbgBFNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:34:08 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016DXWb3005724;
        Thu, 6 Feb 2020 14:33:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=sFSdghaGwcEuGACCiIwzydVPOJAOPD3AD4EI/6caQ7w=;
 b=j3ah9nk5/KaQ34Jue8t6lwoh+4ei4ejP/YZd4jWh0mJFlsiNwFum3b4gy1sy0bZUdtV3
 LNkAeCTsYBAARF0N3Q/OMOUHhnLqUkrTHRZJ54s0f0X4DpNrbCiF5jK/MuzXwJKpft69
 V4ZQkajgAuGgBxc3epCojIVh1oYlX7VFxEKv08JLuDcDc6Xy/SwgKMuds3BypwRfUVDJ
 df0OqKXd3uU1QJviIewrGJrfRJuq7XkFOr8YuJGhAaKjAfXCRNbXChihlF8xwuB8WMrJ
 uJKElQ4jEPc0NjmJqlDkW06ZNz5gLf9G2mUnw/G2qEPoloPuGpJ4YfP6G4TFVrKyZU/C Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhkyqv5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 14:33:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAD0510003A;
        Thu,  6 Feb 2020 14:33:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7B242BC7DB;
        Thu,  6 Feb 2020 14:33:49 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Feb 2020 14:33:49
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <thierry.reding@gmail.com>, <sam@ravnborg.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <philippe.cornu@st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 0/3] dt-bindings: add simple DSI panels
Date:   Thu, 6 Feb 2020 14:33:41 +0100
Message-ID: <20200206133344.724-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To complement panel-simple.yaml, create panel-simple-dsi.yaml.
panel-simple-dsi-yaml are for all simple DSP panels with a single
power-supply and optional backlight / enable GPIO / reset GPIO.

Some DSI panels like orisetech,otm8009a or raydium,rm68200 are quite
similar to simple dsi panel but with small variations. Create dedicated
yaml files for them.

Benjamin Gaignard (2):
  dt-bindings: panel: Convert raydium,rm68200 to json-schema
  dt-bindings: panel: Convert orisetech,otm8009a to json-schema

Sam Ravnborg (1):
  dt-bindings: one file of all simple DSI panels

 .../bindings/display/panel/orisetech,otm8009a.txt  | 23 --------
 .../bindings/display/panel/orisetech,otm8009a.yaml | 53 +++++++++++++++++
 .../display/panel/panasonic,vvx10f034n00.txt       | 20 -------
 .../bindings/display/panel/panel-simple-dsi.yaml   | 67 ++++++++++++++++++++++
 .../bindings/display/panel/raydium,rm68200.txt     | 25 --------
 .../bindings/display/panel/raydium,rm68200.yaml    | 56 ++++++++++++++++++
 6 files changed, 176 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panasonic,vvx10f034n00.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml

-- 
2.15.0

