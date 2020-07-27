Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423D62070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UrRHlzLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgG0Rxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:53:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG0Rxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:53:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RHqoFv190461;
        Mon, 27 Jul 2020 17:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=v4an3MuX4g4lWL9k6MyepQTjR+HAxvvY/v4v0a98gns=;
 b=UrRHlzLQf7TYexQ/9nkZqap+J3KX+KYKcyqhV+87gk+WtqzNuyY74QdHn4JWqTitHghC
 vsFa4jYPklWCOm1iE7N/xmU/6rlglmf1Ikr+KRiofdkA63tGvYXu9QZ/YN3+LXK7KX/7
 PYl8PsYaKPvxfGpKx+xq4YiBfIfmpIqHwJtD1Uz9yAr8jsYHubRZLAghJBh6VFBYmrsI
 0YeM07qd5i4c+yBi9Klud62Y/wIfP/0Yd9y6auGZ2Xdj6eUdVZTW/4XA5hlXkfy5X04j
 0uE8CItjoee4xkkrdWUCUqe9yi0v9lhcR+sa9sqiMKV7erTdfhCTCm9oz16uITbCqHG6 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32hu1j30yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:52:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RHqMgT041167;
        Mon, 27 Jul 2020 17:52:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32hu5rb7x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 17:52:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RHqpqA014090;
        Mon, 27 Jul 2020 17:52:52 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 10:52:51 -0700
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
 <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
 <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
 <1efdfe52-abdb-3931-742c-70e4a170e403@oracle.com>
 <11b03fcd-c210-032c-16d2-79ada41e0349@arm.com>
 <c0c9f0a4-ae2c-e3e5-1df8-884f8300066c@oracle.com>
 <874kptm3b4.fsf@linux.ibm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <523426cd-1586-5d57-9650-134a2ac30d16@oracle.com>
Date:   Mon, 27 Jul 2020 10:52:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <874kptm3b4.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 7:37 AM, Aneesh Kumar K.V wrote:
> There is variant of this which is pseries powerpc where there is
> hypervisor assistance w.r.t allocating gigantic pages. See the ppc64
> enablement patch 
> 
> https://lore.kernel.org/linuxppc-dev/20200713150749.25245-1-aneesh.kumar@linux.ibm.com/
> 

Thanks Aneesh,  I missed the powerpc support.

I knew about the powerpc hypervisor assistance which caused me to rethink
my original idea that all this could be arch independent.  My next idea was
that architectures would only need to provide a constant something like:

#define HUGETLB_CMA_ORDER (PUD_SHIFT - PAGE_SHIFT)

However, it looks like this can not be a compile time constant on powerpc.

Moving more of the CMA support to arch independent code has moved down on
my priority list.  So, it it likely not to get much work in the immediate
future.

Just curious, can you have multiple gigantic page sizes supported at one
time (one system instance) on powerpc?
-- 
Mike Kravetz
