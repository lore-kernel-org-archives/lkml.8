Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8490C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09C320857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EAtLibjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgC0LvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:51:10 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28752 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbgC0LvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:51:09 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RBn6Bc018997;
        Fri, 27 Mar 2020 06:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=U2zt+3OMfjozGKH48uShfLBqCKXb8nbcSzxsYJ1OIE0=;
 b=EAtLibjW2kZz6gWc9mlRfVmjcJql4GnQsUPTKPZ7u4CRLalnjOogshY3Lpbbwp6ElxlD
 3/jO8CA9zcma2snlb8Soq8l7xKLLIEUiv2DYNTS/ChFfa0Yc/ssHy4IvUmm58w2DtV7+
 6yDlDczvIdEsc+nlz/pqmExSWfjE/mY6JMCsFIe+02B9VDYFoG5TwJgeWTn5Y6vGs7oG
 BCoBadW5zdwZLbsgM/Y9PFL3x5n9w0978SGweH3YLPO+/gr96Gr1rV4fNxZCRWOP29fL
 SvcVWnMm/gn3EXcDI9XmAvwcF3fJzW8YYgTytafJ4sRMJDLrGaZExiUEqGJ9WSJhNdCo kw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ywgb2k57b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Mar 2020 06:50:49 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 27 Mar
 2020 11:50:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 27 Mar 2020 11:50:47 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EF5542A1;
        Fri, 27 Mar 2020 11:50:46 +0000 (UTC)
Date:   Fri, 27 Mar 2020 11:50:46 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     <linux-i2c@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <patches@opensource.cirrus.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: mach-s3c64xx: convert to use
 i2c_new_client_device()
Message-ID: <20200327115046.GB5096@ediswmail.ad.cirrus.com>
References: <20200326211014.13591-1-wsa+renesas@sang-engineering.com>
 <20200326211014.13591-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200326211014.13591-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=783 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:10:14PM +0100, Wolfram Sang wrote:
> Move away from the deprecated API and remove printing a stale 'ret'
> value.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
