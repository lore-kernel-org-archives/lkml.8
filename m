Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE0DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34060206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h/tHb5PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgFDRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:47:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47816 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgFDRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:47:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054Hg1B1108564;
        Thu, 4 Jun 2020 17:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=H+yjHdHVMgAwN/YdZHBsmqCfOgg0+bl2Ldo7Ah9xkgY=;
 b=h/tHb5PG66kAghNFzUd4Vx1LQoi84zpsyWuil5mUNGpR75OinkDaDwpEWmF82WG66zPA
 9HQSynWSTEUs4S+nwEVmkL8TvXLYIV69wL30uXv0J5rd79GuLgJiEW/GBIyy5tKFf52+
 Po6sn/SimYgWZQAeivgWvl5yWSTver6PhtoJo2K5NpejDCyDkyw6JJGhDuhdsICAU2kC
 54hI2iCtEVFoCGmQ90vIj2wK+1lHF2YLMo/yO4Yf5rdW4UUewUKbgyzrEnJr1bGqsS45
 x2QeRmLAsAcLoR7f0C2QSjjbkMZ36FOXSRyDj+7+GKndxG3v7EkwFlr3vaWS6C91apHy cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31evvn2ukg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 17:47:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054HbPvP128619;
        Thu, 4 Jun 2020 17:47:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31c1e25s33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 17:47:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054HlY4G002987;
        Thu, 4 Jun 2020 17:47:34 GMT
Received: from [10.39.223.159] (/10.39.223.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 10:47:34 -0700
Subject: Re: [PATCH v2 08/11] swiotlb-xen: introduce phys_to_dma/dma_to_phys
 translations
From:   boris.ostrovsky@oracle.com
To:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-8-sstabellini@kernel.org>
 <af4c8c3f-6bb5-5b42-8589-8fe66fc7621a@oracle.com>
Organization: Oracle Corporation
Message-ID: <4aba4b53-5f24-6c7e-d874-682313eb1798@oracle.com>
Date:   Thu, 4 Jun 2020 13:47:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <af4c8c3f-6bb5-5b42-8589-8fe66fc7621a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/4/20 1:46 PM, Boris Ostrovsky wrote:
> On 6/3/20 6:22 PM, Stefano Stabellini wrote:
>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>> index 0a6cb67f0fc4..60ef07440905 100644
>> --- a/drivers/xen/swiotlb-xen.c
>> +++ b/drivers/xen/swiotlb-xen.c
>> @@ -64,16 +64,16 @@ static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
>
> Weren't you going to rename this to xen_phys_to_dma()? (And the the one
> below to xen_dma_to_phys())?


Nevermind, I see you did that in the next patch.


-boris

