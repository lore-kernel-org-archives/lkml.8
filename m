Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD4C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759692070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDZOlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 10:41:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55746 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgDZOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 10:41:49 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03QEXVXZ055062
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:41:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mg14yp70-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:41:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 26 Apr 2020 15:40:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 Apr 2020 15:40:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03QEffVI60686488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Apr 2020 14:41:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5E59A4051;
        Sun, 26 Apr 2020 14:41:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B54A4040;
        Sun, 26 Apr 2020 14:41:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.207.229])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 26 Apr 2020 14:41:40 +0000 (GMT)
Date:   Sun, 26 Apr 2020 17:41:39 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: compaction: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
X-TM-AS-GCONF: 00
x-cbid: 20042614-4275-0000-0000-000003C662A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042614-4276-0000-0000-000038DBF2BE
Message-Id: <20200426144139.GA340887@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-26_04:2020-04-24,2020-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=21 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=897 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004260131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 05:25:56PM -0400, Qian Cai wrote:
> Compaction starts to crash below on linux-next today. The faulty page belongs to Node 0 DMA32 zone.
> I’ll continue to narrow it down, but just want to give a headup in case someone could beat me to it.
> 
> Debug output from free_area_init_core()
> [    0.000000] KK start page = ffffea0000000040, end page = ffffea0000040000, nid = 0 DMA
> [    0.000000] KK start page = ffffea0000040000, end page = ffffea0004000000, nid = 0 DMA32
> [    0.000000] KK start page = ffffea0004000000, end page = ffffea0012000000, nid = 0 NORMAL
> [    0.000000] KK start page = ffffea0012000000, end page = ffffea0021fc0000, nid = 4 NORMAL
> 
> I don’t understand how it could end up in such a situation. There are several recent patches look
> more related than some others.

Can you please add "mminit_loglevel=4 memblock=debug" to the kernel
command line?

> - mm: rework free_area_init*() funcitons
> https://lore.kernel.org/linux-mm/20200412194859.12663-1-rppt@kernel.org/
> Could this somehow allow an invalid pfn to escape into the page allocator?
> Especially, is it related to skip the checks in memmap_init_zone()?
> https://lore.kernel.org/linux-mm/20200412194859.12663-16-rppt@kernel.org


-- 
Sincerely yours,
Mike.

