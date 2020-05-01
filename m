Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B1C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15FB21775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Do9iIi/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgEAVZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:25:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:25:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041LHZ5Q146248;
        Fri, 1 May 2020 21:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zuSzrsLI04zpU7MyjpcOC3GXaiL6gjksE8kpIl6aVSM=;
 b=Do9iIi/vEPgj0bORsh1dUEGAmU61KxPit50mkIOi+hoGT9bJF+14+dgXFQXv22fY14Qy
 Miznh0jHO7jPpbQt5MG0Wz7VOvAnxaNpqrsnisSQo8eZQTtNZ0+s7FBXlp4Z9kwEln1F
 UkrJlOUu3Pw3NxzBrY28zTGP58o/t16Jwp3A1VOYXF2hYyZvxUHwNTObVx47PRrIXrwT
 EOP+i9693VRIaDihuDlI8Dkecdfrw1zp/+jupWS/2o2CChOzF1qPgkrdEODzKlXZpLy1
 88VMNVe6qckU/goNg0Dqe2nEbHiCUcHB5cR+Bjvwt34GTaJBrVCDxJWeHwt+eDLcUEFT AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30r7f5v3bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 21:25:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041LH2xC013965;
        Fri, 1 May 2020 21:25:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30r7fc2j3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 21:25:21 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041LPIvW028588;
        Fri, 1 May 2020 21:25:18 GMT
Received: from [10.159.246.37] (/10.159.246.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 14:25:18 -0700
Subject: Re: [PATCH 0/5] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200423180545.13707-1-grygorii.strashko@ti.com>
 <23b3b069-426e-a113-a8bf-816b30f10490@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <8fa7126c-3a26-442c-b239-9969d65d4a19@oracle.com>
Date:   Fri, 1 May 2020 14:25:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <23b3b069-426e-a113-a8bf-816b30f10490@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 1:55 PM, Grygorii Strashko wrote:
> Hi Santosh, Tero
> 
> On 23/04/2020 21:05, Grygorii Strashko wrote:
>> Hi All,
>>
>> This series introduces TI K3 Multicore SoC platforms chipid module driver
>> which provides identification support of the TI K3 SoCs (family, 
>> revision)
>> and register this information with the SoC bus. It is available under
>> /sys/devices/soc0/ for user space, and can be checked, where needed,
>> in Kernel using soc_device_match().
>> It is also required for introducing support for new revisions of
>> K3 AM65x/J721E SoCs.
>>
>> Example J721E:
>>    # cat /sys/devices/soc0/{machine,family,revision}
>>    Texas Instruments K3 J721E SoC
>>    J721E
>>    SR1.0
>>
>> Example AM65x:
>>    # cat /sys/devices/soc0/{machine,family,revision}
>>    Texas Instruments AM654 Base Board
>>    AM65X
>>    SR1.0
>>
>> Grygorii Strashko (5):
>>    dt-bindings: soc: ti: add binding for k3 platforms chipid module
>>    soc: ti: add k3 platforms chipid module driver
>>    arm64: arch_k3: enable chipid driver
>>    arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
>>    arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid module
>>      node
>>
>>   .../bindings/soc/ti/k3-socinfo.yaml           |  40 ++++++
>>   arch/arm64/Kconfig.platforms                  |   1 +
>>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |   5 +
>>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   5 +
>>   drivers/soc/ti/Kconfig                        |  10 ++
>>   drivers/soc/ti/Makefile                       |   1 +
>>   drivers/soc/ti/k3-socinfo.c                   | 135 ++++++++++++++++++
>>   7 files changed, 197 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
>>   create mode 100644 drivers/soc/ti/k3-socinfo.c
>>
> 
> Any more comments? I'm going resend it.
> 
If you have acks from DT maintainers, then I suggest you to split this 
series and post platform and drivers patches separately.

Regards,
Santosh
