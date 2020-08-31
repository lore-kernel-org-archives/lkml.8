Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75416C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D922071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pih+LDx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgHaShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:37:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgHaShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:37:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VIYGEm051975;
        Mon, 31 Aug 2020 18:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CxUVVWf6SgJDaiWvwXz/nyOwKZNav8Y6h7elQ2lOS30=;
 b=Pih+LDx74nhyR2E34qgX3VR2rUN9GKVegKQcjeK8cZ19KOAgXXjp43+Z4/WUI5rS2SpL
 LmgPJpsrnUWj/uTxjHSU2hVxnhP3bGwLfSeGhGr7VLenXfHSKtVe4PeEMYhxGopDjdu0
 jYeQbOmCDca0lI6NWjgqLU4qJZfLI6sERQXWs+4gBhLZPbBbgcLgASMAyazqBEZ0Me9K
 BmTNNCq9LxAeE6LucdrOO+mGrvntlF1+VQ4jbENLldkfjzpAoRIVMmBPlDTvsCuTH0eK
 3Siz7qDm4Q2aNjoW56gxSbBCS+bWUEBYpjpnai+prd6jSVUa5zj5E6hXa+ONB4xsV81s Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eykyujy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 18:37:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VIUppH153197;
        Mon, 31 Aug 2020 18:35:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380x1046y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 18:35:01 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VIYuFD014971;
        Mon, 31 Aug 2020 18:34:57 GMT
Received: from [10.74.106.189] (/10.74.106.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 11:34:56 -0700
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
Date:   Mon, 31 Aug 2020 11:34:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200829184139.15547-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/20 11:41 AM, Grygorii Strashko wrote:
> Hi Santosh,
> 
> I've rebased on top of  linux-next and identified merge conflict of patch 3
> with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM resource types")
> in -next.
> 
> ---
> This series adds support for the TI AM65x SR2.0 SoC Ringacc which has fixed
> errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State Interoperability
> Issue after Channel Teardown". This errata also fixed for J271E SoC.
> The SOC bus chipinfo data is used to identify the SoC and configure
> i2023 errata W/A.
> 
> This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's removed.
> 
> Changes in v2:
>   - no functional changes
>   - rebased on top of linux-next
>   - added ask from Rob Herring
> 
Thanks. Can you please followup DT acks for PRUSS series so that I can
apply PRUSS + $subject series.

> v1: https://urldefense.com/v3/__https://lore.kernel.org/patchwork/cover/1284233/__;!!GqivPVa7Brio!PCmZ-nZZ6YQak-0T43bPZYI0gHsYL9k6N7S2gZEFbIr8BRKtv2BK01VejQzlBPBBgcfvCQ$
>      
> Grygorii Strashko (3):
>    soc: ti: k3: ringacc: add am65x sr2.0 support
>    bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk
>    arm64: dts: ti: k3-am65: ringacc: drop ti,dma-ring-reset-quirk
> 
>   .../bindings/soc/ti/k3-ringacc.yaml           |  6 ----
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  1 -
>   drivers/soc/ti/k3-ringacc.c                   | 33 +++++++++++++++++--
>   4 files changed, 30 insertions(+), 11 deletions(-)
> 
