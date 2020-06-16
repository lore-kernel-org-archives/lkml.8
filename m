Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB92C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB190207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Yffh8200"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgFPIrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:47:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:30774 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725710AbgFPIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:47:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G8jK72024707;
        Tue, 16 Jun 2020 03:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=y6iVAoQYhB4s4KWOwHCHVro9m7K4E8yWrvdpHQHxqtA=;
 b=Yffh8200d6wzvhfNckDLknVgmVwCz84juvDOZomg1HeArtm7mxI+kzDl+yDKSTOQgr4B
 pEpw85y560Q/IIP+ue80z/oSK+tK2X9c6il1YIbkRYnpdS7PZRIP5YTq7gyu12rM5DvJ
 tTFqHtsi+vXndtnNNwY7mHiCB2sgEWt0Iqws1gWBJ72eOBuOnxUMcI0vVmGRCveaFITy
 XYPCxrajdCzxI6kDw1DIGUmEz8uT2XXrAyYzdHYwEHx86+JWCicCPIhSBdOvxW0EP87J
 zR+X0J3UlJ8leF0w1pugELONkfYOfdA54isnHj4wMhYNKxlmKlqipyNQN94S0n+8qqp2 aw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31mv73m3t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 03:47:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 16 Jun
 2020 09:47:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 16 Jun 2020 09:47:48 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1032D2C5;
        Tue, 16 Jun 2020 08:47:48 +0000 (UTC)
Date:   Tue, 16 Jun 2020 08:47:48 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] mfd: mfd-core: Add mechanism for removal of a
 subset of children
Message-ID: <20200616084748.GS71940@ediswmail.ad.cirrus.com>
References: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
 <20200616075834.GF2608702@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616075834.GF2608702@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:58:34AM +0100, Lee Jones wrote:
> On Mon, 15 Jun 2020, Charles Keepax wrote:
> > Happy to discuss other approaches as well, but this one was quite                                                                                                                                                                              │··················
> > appealing as it was very simple but affords quite a lot of flexibility.                                                                                                                                                                        │··················
> 
> What about this?
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index f5a73af60dd40..a06e0332e1e31 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -283,7 +283,7 @@ int mfd_add_devices(struct device *parent, int id,
>  }
>  EXPORT_SYMBOL(mfd_add_devices);
>  
> -static int mfd_remove_devices_fn(struct device *dev, void *data)
> +static int mfd_remove_devices_fn(struct device *dev, void *level)
>  {
>         struct platform_device *pdev;
>         const struct mfd_cell *cell;
> @@ -294,6 +294,9 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>         pdev = to_platform_device(dev);
>         cell = mfd_get_cell(pdev);
>  
> +       if (cell->level && (!level || cell->level != *level))
> +               return 0;
> +
>         regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
>                                                cell->num_parent_supplies);
>  
> @@ -303,7 +306,11 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
>  
>  void mfd_remove_devices(struct device *parent)
>  {
> +       int level = MFD_DEP_LEVEL_HIGH;
> +
>         device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
> +       device_for_each_child_reverse(parent, &level, mfd_remove_devices_fn);
>  }
>  EXPORT_SYMBOL(mfd_remove_devices);
> 
> No need for special calls from the parent driver in this case.
> 
> Just a requirement to set the cell's dependency level.
> 

Apologies if I am missing something here, but this looks like a
pretty challenging interface from the drivers side.  Rather than
just statically setting tag in the mfd_cells and separate calls
to mfd_remove_devices_by_tag, such as:

	mfd_remove_devices_by_tag(madera->dev, MADERA_OPTIONAL_DRIVER);

	pm_runtime_disable(madera->dev);
	regulator_disable(madera->dcvdd);
	regulator_put(madera->dcvdd);

	mfd_remove_devices(madera->dev);

You need to statically set the level but then also iterate through
the children and update the cell level on each subsequent remove,
in my case:

static int arizona_set_mfd_level(struct device *dev, void *data)
{
	struct platform_device *pdev = to_platform_device(dev);
	if (pdev->mfd_cell)
		pdev->mfd_cell->level = MFD_DEP_LEVEL_HIGH;
}
...
	mfd_remove_devices(madera->dev);

	device_for_each_child(madera->dev, NULL, arizona_set_mfd_level);

	pm_runtime_disable(madera->dev);
	regulator_disable(madera->dcvdd);
	regulator_put(madera->dcvdd);

	mfd_remove_devices(madera->dev);

Does this match how you would expect this to be used?

I do have some concerns. The code can't use mfd_get_cell since it
returns a const pointer, although the pointer in platform_device
isn't const so we access that directly, could update mfd_get_cell? We
also don't have access to mfd_dev_type outside of the mfd core so
its hard to check we are actually setting the mfd_cell of actual
MFD children, I guess just checking for mfd_cell being not NULL is
good enough?

Thanks,
Charles
