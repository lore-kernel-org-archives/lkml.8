Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D5CCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5282205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qdTnP3aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgEMKS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:18:56 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60174 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732382AbgEMKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:18:53 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DAEXuR016126;
        Wed, 13 May 2020 05:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=K22z8bse+K8s4RWO+bw7+os1Pk2/9NLjp4JtcfuDgYY=;
 b=qdTnP3aYx4wcxEJyrcV1ho8BqDuag03Ev2PRc/i7c0/IERFnSGAIf7bhiV2oKyRXYGIa
 pq9eVD7rvOGTJNZWvX0+R0arwAwJw2p4LhYN/h6O6ABV/lFfLsMHrCQc2PHCWsfM4WsR
 rvrhfi0NIy/z4zCI3U05fs4ccxphJLqG7xD4o3L13mIvq3Cl4xvTW2/an8Pf7E0K6oZR
 s3Wh+X02+zLZPh/GgyfGKI2jG67/gAxPV1TOoHrIjAalqdNfBMHQ0DEvZNoRTPGXBlqx
 xC8CCBu2WAKhczO+AkkCcdu9q2+a9w/GrAQzAhEIffXt4DEbhNk+ypBMFOwpd8a6EqaC yA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3100yphbtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 05:18:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 11:18:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 13 May 2020 11:18:49 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5E6F9448;
        Wed, 13 May 2020 10:18:49 +0000 (UTC)
Date:   Wed, 13 May 2020 10:18:49 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mfd: mfd-core: Add mechanism for removal of a subset
 of children
Message-ID: <20200513101849.GG71940@ediswmail.ad.cirrus.com>
References: <20200511155333.2183-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511155333.2183-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 cotscore=-2147483648
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 04:53:32PM +0100, Charles Keepax wrote:
> Currently, the only way to remove MFD children is with a call to
> mfd_remove_devices, which will remove all the children. Under
> some circumstances it is useful to remove only a subset of the
> child devices. For example if some additional clean up is required
> between removal of certain child devices.
> 
> To accomplish this a tag field is added to mfd_cell, and a
> corresponding mfd_remove_devices_by_tag function is added to
> remove children with a specific tag. This allows a good amount of
> flexibility in which child devices a driver wishes to remove, as a
> driver could target specific drivers or a large group. Allowing other
> use-cases such as removing drivers for functionality that is no longer
> required.
> 
> Some investigation was done of using the mfd_cell name and id fields,
> but it is hard to achieve a good level of flexibility there, at least
> without significant complexity. Since the id gets modified by the core
> and can even by automatically generated. Using the name alone would
> work for my usecase but it is not hard to imagine a situation where it
> wouldn't.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Following on from our discussions here:
> 
> https://lore.kernel.org/lkml/20200122110842.10702-2-ckeepax@opensource.cirrus.com/#t
> 
> Happy to discuss other approaches as well, but this one was quite
> appealing as it was very simple but affords quite a lot of flexibility.
> 
> Thanks,
> Charles
> 
> 
>  drivers/mfd/mfd-core.c   | 11 +++++++++++
>  include/linux/mfd/core.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index f5a73af60dd40..83a57186169de 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -287,6 +287,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev;
>  	const struct mfd_cell *cell;
> +	int tag = (int)data;

Yeah as the build bot points out should have actually used a
pointer here. Will update for that if we don't have any major
objections to the approach in general.

Thanks,
Charles
