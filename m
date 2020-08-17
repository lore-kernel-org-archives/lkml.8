Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBE42072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gIUAROwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgHQVtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:49:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728147AbgHQVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:49:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HLX0Hb022210;
        Mon, 17 Aug 2020 17:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=Tq/uE0SXbNExMxY3ew7lO372jMbMpFBJGrQbS5RiDDE=;
 b=gIUAROwkI6VGltsJX/wTziYt2Hh1LIpA1aLhttWDsGrHQMdipl26J0DpLGOm+tkBgI+t
 z4aRFlvzaxnAY93L8llPPiqVwNksZVjWAokGnXNY1QhV1mrS64fterjNXSquN3AsL5dt
 fO0S4V9ePFTTwqSkt86flY1q+kEhRb35QlQ7x64i3X2Ip8enFXEt2WebCPa1SUDBWbDC
 qnCBmp2BnQKr3hiZw9Z9aFpGRx8DdRDqbvWQAAPPWGSne8zVMsqy6Cs/UWz+381P0xVb
 1Cl+n5s0j3jYJQc9iIjycr39nzX7YpfV1EPVkm1PgIdsHWhZJxZ5Ui2VUlhw10LJkG+X oA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32yxagwvn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 17:48:58 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HLien2011858;
        Mon, 17 Aug 2020 21:48:56 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 32x7b911yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 21:48:56 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HLmtm819005936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 21:48:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7784778063;
        Mon, 17 Aug 2020 21:48:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C599E78060;
        Mon, 17 Aug 2020 21:48:52 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.138.167])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Aug 2020 21:48:52 +0000 (GMT)
References: <20200815204536.663801-1-bauerman@linux.ibm.com> <20200817102020.GD25336@lst.de>
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
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] swiotlb: Allow allocating buffer anywhere in memory
In-reply-to: <20200817102020.GD25336@lst.de>
Date:   Mon, 17 Aug 2020 18:48:49 -0300
Message-ID: <87o8n96j0e.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=930 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Christoph,

Christoph Hellwig <hch@lst.de> writes:

> On Sat, Aug 15, 2020 at 05:45:36PM -0300, Thiago Jung Bauermann wrote:
>> POWER secure guests (i.e., guests which use the Protection Execution
>> Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
>> they don't need the SWIOTLB memory to be in low addresses since the
>> hypervisor doesn't have any addressing limitation.
>> 
>> This solves a SWIOTLB initialization problem we are seeing in secure guests
>> with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
>> memory, which leaves no space for SWIOTLB in low addresses.
>
> What about just open coding the allocation and using
> swiotlb_init_with_tbl?

Yes, that works too. I just sent a v2 implementing that change. I just
had to add a small accessor function so that I could set no_iotlb_memory
from outside swiotlb.c.

Thank you for the quick review.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
