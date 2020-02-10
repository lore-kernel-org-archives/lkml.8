Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FEFC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4202080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgBJRLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:11:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727872AbgBJRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AH9GmH007379;
        Mon, 10 Feb 2020 12:10:23 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u2dy35m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 12:10:23 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01AH5dYv016782;
        Mon, 10 Feb 2020 17:10:21 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 2y1mm63n74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 17:10:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AHAL8X59244978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 17:10:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E51266A058;
        Mon, 10 Feb 2020 17:10:20 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CF706A057;
        Mon, 10 Feb 2020 17:10:20 +0000 (GMT)
Received: from [9.41.103.158] (unknown [9.41.103.158])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 17:10:20 +0000 (GMT)
Subject: Re: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
To:     Arnd Bergmann <arnd@arndb.de>, Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <1a303336-9ffb-353f-efe3-7d45ed114fd0@linux.vnet.ibm.com>
Date:   Mon, 10 Feb 2020 11:10:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/20 10:35 AM, Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 10:31 PM Eddie James <eajames@linux.ibm.com> wrote:
>> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
>> DMA operations between the SOC (acting as a BMC) and a host processor
>> in a server.
>>
>> This commit adds a driver to control the XDMA engine and adds functions
>> to initialize the hardware and memory and start DMA operations.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Hi Eddie,
>
> I'm missing the bigger picture in the description here, how does this fit into
> the PCIe endpoint framework and the dmaengine subsystem?


Hi,

It doesn't fit into the PCIe endpoint framework. The XDMA engine 
abstracts all the PCIe details away so the BMC cannot configure any of 
the things the PCIe endpoint exposes.

It also doesn't fit into the dmaengine subsystem due to the restriction 
on the ast2500 (and maybe the ast2600) that the XDMA engine can only 
access certain areas of physical memory. Also problematic would be 
pausing/resuming/terminating transfers because the XDMA engine can't do 
those things.


>
> Does the AST2500 show up as a PCIe device in the host, or do you just
> inject DMAs into the host and hope that bypasses the IOMMU?
> If it shows up as an endpoint, how does the endpoint driver link into the
> dma driver?


The AST2500 and AST2600 have two PCIe devices on them, so these will 
show up on the host if the BMC enables both of them. Either or both can 
also be disabled and therefore will not show up. On the host side, in 
order to receive DMA transfers, its simply a matter of registering a PCI 
device driver and allocating some coherent DMA.... Not sure about the 
details of endpoints/dma client driver?


Hopefully this answers your questions. Thanks,

Eddie


>
>       Arnd
