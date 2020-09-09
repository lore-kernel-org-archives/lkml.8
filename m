Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE08C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6687E2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z+FyK1fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgIIQxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:53:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgIIQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:53:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Go329127056;
        Wed, 9 Sep 2020 16:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=viG+Jbz6Fwxpdokl7X2/WJGEpyB1AR3j2hm1syYHgHY=;
 b=z+FyK1fo9GPYe/W48+viF6RJUdU1EYjaFDbHChjEwRirOECg4STVs5RxIismIzh6nlzE
 wrw42OwVcpVS1UsOhSoYaAPUgQrS1uOSlx2xBiX8Wa+84S43R4p935kQKS68jkAskh7c
 zrOT12nDEY5mol6Il7L6hRluaZa0UWGKnPS0xS6lF0fdlxsSuTIGrRo/v7PTeCjmfoDj
 fc41uAXesampTAkh9lcSaWTOPl22RumtCoDnCYfKYB1Whs94iDfE+W/1Evp1ByX8PhEL
 1vY3bIpET5BEyM+0dC861/9i1RBgzp22oLpy7zMsMcOUiR95UL6bs6k3T+Vcmo/xm55C aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3an2xw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 16:53:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Gp5u1087160;
        Wed, 9 Sep 2020 16:53:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33cmk70v9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 16:53:00 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 089GqwaX007800;
        Wed, 9 Sep 2020 16:52:58 GMT
Received: from [10.74.104.34] (/10.74.104.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 09:52:58 -0700
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
To:     Nishanth Menon <nm@ti.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
 <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
 <20200902140834.5fficxrxy6t572um@kahuna>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <0b24a619-060a-1abb-76d9-218b5db18f11@oracle.com>
Date:   Wed, 9 Sep 2020 09:52:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200902140834.5fficxrxy6t572um@kahuna>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 7:08 AM, Nishanth Menon wrote:
> On 11:34-20200831, santosh.shilimkar@oracle.com wrote:
>> On 8/29/20 11:41 AM, Grygorii Strashko wrote:
>>> Hi Santosh,
>>>
>>> I've rebased on top of  linux-next and identified merge conflict of patch 3
>>> with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM resource types")
>>> in -next.
>>>
>>> ---
>>> This series adds support for the TI AM65x SR2.0 SoC Ringacc which has fixed
>>> errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State Interoperability
>>> Issue after Channel Teardown". This errata also fixed for J271E SoC.
>>> The SOC bus chipinfo data is used to identify the SoC and configure
>>> i2023 errata W/A.
>>>
>>> This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's removed.
>>>
>>> Changes in v2:
>>>    - no functional changes
>>>    - rebased on top of linux-next
>>>    - added ask from Rob Herring
>>>
>> Thanks. Can you please followup DT acks for PRUSS series so that I can
>> apply PRUSS + $subject series.
> 
> 
> Santosh, in this series, may i suggest that the dtsi changes[1] be hosted
> on my tree? else we are going to create a mix of rc1 and rc3 branches
> which is going to be irritating, to say the least.
> 
> I will pick [1] the day after I see the patches 1 and 2 in linux-next tag.
> 
Sure !!
