Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F09C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D204720767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gunMysvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDXItB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:49:01 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43718 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgDXItA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:49:00 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O8il1D028258;
        Fri, 24 Apr 2020 03:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=fXrN/vRnScSWJDcmtCru77GbgI4wSk3jscD+7uVlLms=;
 b=gunMysvL7ZtWVNTuOnAPfqQUhKNWjSLqvvKkRqm0zbqn3yR37whEPBjAXq/r0eKCf5jW
 90hlUbJ/ZaA/ESrj0qbrUV4ZVPWskncgkBNdfyw2k9HdVE8JYeAXo7xq8xndznVRoZGN
 cdyy3LjdlV2CpY+U2Bu/I+jXBnPVP3zNZbldBjyk1WvZivIaJTnmevF2Q5p1e8hmz8Ge
 LL56j7LSTo0bzZx71S2+0sliu7+3ShNfmMpAawHttOLVru+30ZgrwFtJfcUE3c+NXaqg
 OC1N6UmXVDkWUeb9RB8D+PQsRrzYYcEFi0wcbXmvPPo0gXxEkFzaS3VnQS4OYJHfAq4X rA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30fxy4kq6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 03:47:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 24 Apr
 2020 09:47:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 24 Apr 2020 09:47:54 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C5EBF44A;
        Fri, 24 Apr 2020 08:47:54 +0000 (UTC)
Date:   Fri, 24 Apr 2020 08:47:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <tglx@linutronix.de>, <allison@lohutok.net>,
        <info@metux.net>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8962: set CLOCKING2 as non-volatile register
Message-ID: <20200424084754.GI44490@ediswmail.ad.cirrus.com>
References: <6d25d5b36d4b9aeb8655b5e947dad52214e34177.1587693523.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d25d5b36d4b9aeb8655b5e947dad52214e34177.1587693523.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=667 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:01:38AM +0800, Shengjiu Wang wrote:
> Previously CLOCKING2 is set as a volatile register, but cause
> issue at suspend & resume, that some bits of CLOCKING2 is not
> restored at resume, for example SYSCLK_SRC bits, then the output
> clock is wrong.
> 
> The volatile property is caused by CLASSD_CLK_DIV bits,
> which are controlled by the chip itself. But the datasheet
> claims these are read only and protected by the security key,
> and they are not read by the driver at all.
> 
> So it should be safe to change CLOCKING2 to be non-volatile.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
