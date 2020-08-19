Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02228C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF841207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sLx9zKbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHSQvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:51:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgHSQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:51:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JGWpjh074353;
        Wed, 19 Aug 2020 12:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=tqJsL3NOrZOpVuHKMhwEymWTkIxr1YpclBsxqWSalzQ=;
 b=sLx9zKbj7U7tJhda2zJeJPEJuwI8ggCh38319LJjZEsCAQM8KuNL/C1zHPbnFstaTTCY
 JHGTbgSY9Ud5PklEwhC3/OzTahMCCdpzot3SWKICHX6iLaJZL5JQTR68F/DzipCvK2fQ
 7U8pzVCegj4JZTlDiC322gAF3B7qpUCB3OjWNx+nwQuF5cNGoe877c+Fw9KIkHDKaUJU
 8kIYNDCaP2dunh7Sy7wuzj9DolaJ5Smg8JkiJImCr8QGMYyG+B3NH3fzkquAIWczfwja
 FMf3rpxcLuJ+KYRr/BkFpIZD3wtGSv4p8OtVD/VuMEdgbQ/TKemxbgkED5xBUhbHWYxw eQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 330ccb8m0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 12:50:41 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JGodv2019248;
        Wed, 19 Aug 2020 16:50:39 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3304uenck9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 16:50:39 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JGodUj54329768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 16:50:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D95CAE05C;
        Wed, 19 Aug 2020 16:50:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B75AE062;
        Wed, 19 Aug 2020 16:50:36 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.41.171])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Aug 2020 16:50:35 +0000 (GMT)
References: <20200818221126.391073-1-bauerman@linux.ibm.com> <20200819044351.GA19391@lst.de>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in memory
In-reply-to: <20200819044351.GA19391@lst.de>
Date:   Wed, 19 Aug 2020 13:50:31 -0300
Message-ID: <87lfiaeg14.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_09:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@lst.de> writes:

> On Tue, Aug 18, 2020 at 07:11:26PM -0300, Thiago Jung Bauermann wrote:
>> POWER secure guests (i.e., guests which use the Protection Execution
>> Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
>> they don't need the SWIOTLB memory to be in low addresses since the
>> hypervisor doesn't have any addressing limitation.
>> 
>> This solves a SWIOTLB initialization problem we are seeing in secure guests
>> with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
>> memory, which leaves no space for SWIOTLB in low addresses.
>> 
>> To do this, we use mostly the same code as swiotlb_init(), but allocate the
>> buffer using memblock_alloc() instead of memblock_alloc_low().
>> 
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Looks fine to me (except for the pointlessly long comment lines, but I've
> been told that's the powerpc way).

Thanks! Do I have your Reviewed-by?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
