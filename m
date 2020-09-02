Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CBC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481B20826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MUAq85PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIBIO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:14:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:14:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0828390p133343;
        Wed, 2 Sep 2020 04:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=a3eXUdWb9RaaXm+62pNlv1dQyk3xkRZiWvAIB6OZmnA=;
 b=MUAq85PRK89Wm8cYXUeziaM3qczOQB6DXwm7XfAyjRA8UKx+paii7V7YMn8j5XDDomV1
 kr0ybB6VitA71nayULAWiSUVcQ6WLFGmA6psCpl6F2RFQ6vKUlFOZ97UwAtW8ca4Pq2W
 cf8pynKWfdqYvthy6Up5CbC/EWPJ7+Q0t7KqvFCipUhYn8eWlOZMLFi9DRQK4cqOnbqw
 QrLvfIROHcqf/RLL0ccXA0H+YFwb060+5PNPAHWAf1XaCv693bWErsVknr7kJRjso7zn
 5x8vXhc7nljLFOM6oDreF+oF5syUKxovYNLfSpkD11x1Ll+rKtmVQgw+LvQJ4kCntgED aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a7hwra2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:13:20 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08283IGY133724;
        Wed, 2 Sep 2020 04:13:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a7hwra1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:13:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0828DCBO002494;
        Wed, 2 Sep 2020 08:13:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8ce7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 08:13:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0828DEhL29819180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 08:13:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A4C3A4051;
        Wed,  2 Sep 2020 08:13:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B6ABA405D;
        Wed,  2 Sep 2020 08:13:12 +0000 (GMT)
Received: from oc5500677777.ibm.com (unknown [9.145.78.43])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 08:13:12 +0000 (GMT)
Subject: Re: [PATCH 0/2] dma-mapping: update default segment_boundary_mask
To:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de
Cc:     sfr@canb.auug.org.au, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
References: <20200901221646.26491-1-nicoleotsuka@gmail.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <2c8db0aa-e8b5-e577-b971-1de10ecc6747@linux.ibm.com>
Date:   Wed, 2 Sep 2020 10:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901221646.26491-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 12:16 AM, Nicolin Chen wrote:
> These two patches are to update default segment_boundary_mask.
> 
> PATCH-1 fixes overflow issues in callers of dma_get_seg_boundary.
> Previous version was a series: https://lkml.org/lkml/2020/8/31/1026
> 
> Then PATCH-2 sets default segment_boundary_mask to ULONG_MAX.
> 
> Nicolin Chen (2):
>   dma-mapping: introduce dma_get_seg_boundary_nr_pages()
>   dma-mapping: set default segment_boundary_mask to ULONG_MAX

I gave both of your patches a quick test ride on a couple of dev mainframes,
both NVMe, ConnectX and virtio-pci devices all seems to work fine.
I already commented on Christoph's mail that I like the helper approach,
so as for s390 you can add my

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>

> 
>  arch/alpha/kernel/pci_iommu.c    |  7 +------
>  arch/ia64/hp/common/sba_iommu.c  |  3 +--
>  arch/powerpc/kernel/iommu.c      |  9 ++-------
>  arch/s390/pci/pci_dma.c          |  6 ++----
>  arch/sparc/kernel/iommu-common.c | 10 +++-------
>  arch/sparc/kernel/iommu.c        |  3 +--
>  arch/sparc/kernel/pci_sun4v.c    |  3 +--
>  arch/x86/kernel/amd_gart_64.c    |  3 +--
>  drivers/parisc/ccio-dma.c        |  3 +--
>  drivers/parisc/sba_iommu.c       |  3 +--
>  include/linux/dma-mapping.h      | 21 ++++++++++++++++++++-
>  11 files changed, 34 insertions(+), 37 deletions(-)
> 
