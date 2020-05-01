Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E8DC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C1B2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="olcDTUG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgEAOCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:02:01 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37228 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729529AbgEAOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:01:59 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041DvKvJ019635;
        Fri, 1 May 2020 08:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JzGqBIQszLu//+K3RgyjRVgYmCjC0eyp591kUihnjjw=;
 b=olcDTUG5L43shFMXwWoSRFqQCJ6rf1+sS+6IfQRtknWZEMgse4JyCVol2dlyaQO1dIv3
 RQULtVHb2mFr206A4+M5+MSZboaPSOn9ZUfJbCzr9QwLSdwQ5iRx5kZM+rBXEiHzNgFp
 8+Z5hugcGI4IqKPTkTm87Q5ZSMmDLVsdDxtzofu1+7H/02MFrvjasK/iQrXOedjyeMsi
 g8el1KSP2qOywMzH5jghwuTGMECa+5WGZTli4q+e4p/Hdg3zFpJWgmB1RfBfYaZ6CjKL
 lnmF2xi/prlkvUACK0OOKRyi05H13n/3ynoD/vqIWskgGdGB6/m18LskVeX9xSPiZcwJ Tw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30r7eg91ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 May 2020 08:58:54 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 1 May 2020
 14:58:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 1 May 2020 14:58:51 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CD583448;
        Fri,  1 May 2020 13:58:51 +0000 (UTC)
Date:   Fri, 1 May 2020 13:58:51 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] dt-bindings: sound: wm8994: Correct required supplies
 based on actual implementaion
Message-ID: <20200501135851.GP44490@ediswmail.ad.cirrus.com>
References: <20200501133534.6706-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200501133534.6706-1-krzk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxlogscore=757 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:35:34PM +0200, Krzysztof Kozlowski wrote:
> The required supplies in bindings were actually not matching
> implementation making the bindings incorrect and misleading.  The Linux
> kernel driver requires all supplies to be present.  Also for wlf,wm8994
> uses just DBVDD-supply instead of DBVDDn-supply (n: <1,3>).
> 
> Reported-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
