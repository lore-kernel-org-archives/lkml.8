Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F591C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9CB2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403990AbgDCOwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:52:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390807AbgDCOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:52:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033EYbWw119203;
        Fri, 3 Apr 2020 10:52:32 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yfk0mkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 10:52:32 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 033Eq4Cr009672;
        Fri, 3 Apr 2020 14:52:31 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 301x77x514-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 14:52:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 033EqVTP17891686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Apr 2020 14:52:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E21112805E;
        Fri,  3 Apr 2020 14:52:30 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31D902805A;
        Fri,  3 Apr 2020 14:52:30 +0000 (GMT)
Received: from [9.163.91.129] (unknown [9.163.91.129])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Apr 2020 14:52:30 +0000 (GMT)
Subject: Re: [PATCH v7 0/5] soc: aspeed: Add XDMA engine driver
To:     Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
 <8ca08ea0-2f3e-4b44-a595-bfe96ca02b3f@www.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <d1fe0157-8a4b-f0f5-f0e4-443d6f4e3e4a@linux.ibm.com>
Date:   Fri, 3 Apr 2020 09:52:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8ca08ea0-2f3e-4b44-a595-bfe96ca02b3f@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_11:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=911 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/20 7:32 PM, Andrew Jeffery wrote:
>
> On Fri, 3 Apr 2020, at 06:19, Eddie James wrote:
>> This series adds a driver to control the Aspeed XDMA engine embedded in the
>> AST2500 and AST2600. The XDMA engine performs automatic DMA operations
>> over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.
>>
>> Changes since v6:
>>   - See individual patches
> v7 is not an evolution on v6 - v7 contains a bunch of bugs that v6 fixed (at least
> wrt locking). How did you generate this series?


My goodness, I could have sworn that was v6. I took the series that was 
merged in the openbmc kernel. Must have gotten mixed up. -_-


>
> Also my name is misspelled in each of the Reviewed-by: tags which makes me
> think that something has gone quite wrong with the posting of v7, and I'm
> concerned that this was based on e.g. v5 but with my tags against v6 applied.


Well thats because I added them manually since they had "disappeared" or 
so I thought from v6 during the application to openbmc... guess that 
should have been a warning sign

>
> Andrew
