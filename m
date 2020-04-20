Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C4BC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE51F206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bhHNMY7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgDTPox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:44:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:58356 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729024AbgDTPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:44:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KFc4KW020208;
        Mon, 20 Apr 2020 10:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=WRLn6CcF91rM0kmmJj1O0brI6NJO4DbTXcBN3wswcwo=;
 b=bhHNMY7S4MFDkDMkf1pjB1386hgU0x9xNuf8aGakTE1i1lyjMPKVViZsSZQFHryijXaY
 F/bek3YWiKnG9vLQrZfo4XkwiDvc4wbAU7V2NSqVtS8cXme+OreMVIG1KzqXxtOBK93z
 EyUWp2ppQsZYg2BTHChTtBWOyYMO6QuAd9PPFH89Rx+ulcI4xLDHp1wGpZN/T3Tc7ZD2
 zhviE7TlqpPxe1fq8UdMB/wS7GWbVB9UYRFhuPKo7r0azI6QTsqaroK5CKFA1U16tAVr
 zeRohLRV19d2OCR/lUVHPHS0XGVhPmEPzLyrcMerw06X7r+wNu45rTIGbAGnM0MyeBB0 BA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4b9hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 10:44:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 Apr
 2020 16:44:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 Apr 2020 16:44:44 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7AEE22AB;
        Mon, 20 Apr 2020 15:44:44 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/4] Convert Arizona DT bindings to dtschema
Date:   Mon, 20 Apr 2020 16:44:40 +0100
Message-ID: <20200420154444.12332-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=662 malwarescore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings over, I have put all the patches in one series
so they are easy to review, but I put all the MAINTAINER updates
in the MFD patch (since it is the main binding document) so the
patches can each go through their own trees with no merge issues.

Thanks,
Charles

Charles Keepax (4):
  regulator: arizona-regulator: Move binding over to dtschema
  extcon: arizona: Move binding over to dtschema
  ASoC: arizona: Move binding over to dtschema
  mfd: arizona: Move binding over to dtschema

 .../devicetree/bindings/extcon/extcon-arizona.txt  |  76 ------
 .../devicetree/bindings/extcon/wlf,arizona.yaml    | 125 +++++++++
 Documentation/devicetree/bindings/mfd/arizona.txt  | 101 --------
 .../devicetree/bindings/mfd/wlf,arizona.yaml       | 288 +++++++++++++++++++++
 .../bindings/regulator/arizona-regulator.txt       |  18 --
 .../devicetree/bindings/regulator/wlf,arizona.yaml |  37 +++
 .../devicetree/bindings/sound/wlf,arizona.txt      |  53 ----
 .../devicetree/bindings/sound/wlf,arizona.yaml     | 114 ++++++++
 MAINTAINERS                                        |   8 +-
 9 files changed, 568 insertions(+), 252 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/arizona-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.yaml

-- 
2.11.0

