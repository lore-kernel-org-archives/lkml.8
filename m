Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE86C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3FE20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FPbm6ddg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404919AbgFXQYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:24:21 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13800 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404468AbgFXQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:24:20 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OGOFi9018499;
        Wed, 24 Jun 2020 11:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ckrvlB8Dw3frM8BYudQeZbvk7wFuvz5qojyaKBhhE24=;
 b=FPbm6ddgjNT4Z2EH7Bj6D4+bX0fH9JXnF6ROvM4eiq/u+o4/TJSDDTkXAPOgUlCiYnEf
 WefGYacBX2Lz9/7lLS42jUnQPhtnYqrurB7F7icTJ/o8X93n7BC2nhj/4g3bldEtBCXw
 zYaKUuv62+jY0sWDiN802REBgLsLPUzmzC2KMm7+HuWFa96ETrArKEiOptAgGqcTm39P
 ReQHs1RkqIMbxIZm+bwGpizPIsnbzOQ64Jeoj0DERYKdj3pBXF+92hfG8HatwA+WHiRB
 Xg4sHJ1pppuQg4BXtm9Q6NRn0mJ6ONhS3X6CHoR9U13445v2ip+cmaJAwsDAEYQ2+83x lw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31uus3952v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Jun 2020 11:24:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 24 Jun
 2020 17:24:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 24 Jun 2020 17:24:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 865CF44A;
        Wed, 24 Jun 2020 16:24:10 +0000 (UTC)
Date:   Wed, 24 Jun 2020 16:24:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 09/10] mfd: wm8400-core: Supply description for
 wm8400_reset_codec_reg_cache's arg
Message-ID: <20200624162410.GY71940@ediswmail.ad.cirrus.com>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
 <20200624150704.2729736-10-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200624150704.2729736-10-lee.jones@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=886 phishscore=0 spamscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006240112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:07:03PM +0100, Lee Jones wrote:
> Kerneldoc syntax is used, but not complete.  Descriptions required.
> 
> Prevents warnings like:
> 
>  drivers/mfd/wm8400-core.c:113: warning: Function parameter or member 'wm8400' not described in 'wm8400_reset_codec_reg_cache'
> 
> Cc: <stable@vger.kernel.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
