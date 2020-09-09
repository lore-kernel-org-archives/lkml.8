Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB8320EDD
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dhE5EDFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIICng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:43:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIICnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:43:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892WDpo195897;
        Wed, 9 Sep 2020 02:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eukrwp7H2koQjeyZA6wBLLVQSjtXdS08WqjhoStToms=;
 b=dhE5EDFsaaXmDeiHDJi/Zfj7NwjpIdn5QX+5RoKACONs4OU9k61rSUoDxA80UXOeNfVS
 EM8YoduhExTYX/r5wcf61KqBKP0rK6Uq5XmHl7VUqfEc3oM2AQdN1IbPzgWTHuSuwnkB
 DeMddPbQ750+uvZZUAQ0M7G5+J66QKOC8/1ZrZAz1atZOdeg4ImFSCGn25kFUQtQ7V0Q
 +fsluw2UQ6poGwhoJbO1MJtf3nnKqeBN2PNyd0FDUJHe7hTMKqJhrCnupjCuZOV/zRaV
 CH1MfUs+NIj0fksF8YLDCFqc7cnIomPVrSBrmdzNpNMILnDz+SiJ60BDtWcKC5WzzidT xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33c3amxw43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:42:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892VbmW148878;
        Wed, 9 Sep 2020 02:40:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33dacjqvg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:40:54 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0892erJe026700;
        Wed, 9 Sep 2020 02:40:53 GMT
Received: from [10.74.86.35] (/10.74.86.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:40:53 -0700
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
To:     Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
 <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
 <1661043e-15a3-b8de-b16c-ef6ff88f18e5@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <39eeac89-b87b-e3ef-e061-20021e9bb0b9@oracle.com>
Date:   Tue, 8 Sep 2020 19:40:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1661043e-15a3-b8de-b16c-ef6ff88f18e5@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/20 3:09 PM, Suman Anna wrote:
> Hi Santosh,
> 
> On 8/31/20 1:34 PM, santosh.shilimkar@oracle.com wrote:
>> On 8/29/20 11:41 AM, Grygorii Strashko wrote:
>>> Hi Santosh,
>>>
>>> I've rebased on top of  linux-next and identified merge conflict of patch 3
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
>>> This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's
>>> removed.
>>>
>>> Changes in v2:
>>>    - no functional changes
>>>    - rebased on top of linux-next
>>>    - added ask from Rob Herring
>>>
>> Thanks. Can you please followup DT acks for PRUSS series so that I can
>> apply PRUSS + $subject series.
> 
> PRUSS dt binding is acked now, so can you pick up the PRUSS v2 series for 5.10
> merge window.
> 
Yes, I saw ack from Rob. Will try to get to this over coming weekend.

Regards,
Santosh
