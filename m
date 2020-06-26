Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBAC20836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EGRieoWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFZJUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:20:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43996 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgFZJUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:20:09 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q9G0tR002063;
        Fri, 26 Jun 2020 04:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Kj6HZLYZWCeCHvsyw1G8dr+CnF0yiki0CnjiT571U/M=;
 b=EGRieoWBcslbRBSCcBzShP9e5trWaj0EoIC3TGxgOsyeF5k9rZzcQeHTJpely7ly4wJs
 Fv8QJ/qb6UGbKrnYTo02FnfSkmb6hmMdlRHPQEhb5GTPWeQ+kLK7NhynEJ6fqD7ZQQod
 39/xTA8IJ8NaL7kdH9P6GNCIee9X/WRhTtLxqtW57Jk0DuSi21r51C4BKYzsyoswuAIm
 nWrVpGx62sRBLJn4quDYW7RWuY6og/BFbpxogIcxpvRyHb9EpkAg2dWlwxuVOu9YYOO0
 rBno02GKEnVVRAAHcSN+o2JsJhMY9Z2aUuI/hkKT4flAQpFIPxD6WH3e15hXd/QYorgD VQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31uus3c11p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jun 2020 04:20:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 26 Jun
 2020 10:20:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 26 Jun 2020 10:20:02 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 80E922AB;
        Fri, 26 Jun 2020 09:20:02 +0000 (UTC)
Date:   Fri, 26 Jun 2020 09:20:02 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 8/9] regulator: wm8400-regulator: Repair dodgy kerneldoc
 header formatting
Message-ID: <20200626092002.GA71940@ediswmail.ad.cirrus.com>
References: <20200626065738.93412-1-lee.jones@linaro.org>
 <20200626065738.93412-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200626065738.93412-9-lee.jones@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006260068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:57:37AM +0100, Lee Jones wrote:
> W=1 kernel builds report a lack of descriptions for various
> function arguments.  In reality they are documented, but the
> formatting was not as expected '@.*:'.  Instead, some weird
> arg identifiers were used.
> 
> This change fixes the following warnings:
> 
>  drivers/regulator/wm8400-regulator.c:243: warning: Function parameter or member 'dev' not described in 'wm8400_register_regulator'
>  drivers/regulator/wm8400-regulator.c:243: warning: Function parameter or member 'reg' not described in 'wm8400_register_regulator'
>  drivers/regulator/wm8400-regulator.c:243: warning: Function parameter or member 'initdata' not described in 'wm8400_register_regulator'
> 
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
