Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB74EC4345A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E6E207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGJN6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:58:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbgGJN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:58:35 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ADW5d1006613;
        Fri, 10 Jul 2020 09:58:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpr3yq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 09:58:33 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06ADW6Mr006663;
        Fri, 10 Jul 2020 09:58:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpr3ynx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 09:58:32 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ADt0H8004646;
        Fri, 10 Jul 2020 13:58:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 326bcf0p7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 13:58:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ADvBjQ59638268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 13:57:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F7DFAE053;
        Fri, 10 Jul 2020 13:57:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F08AE055;
        Fri, 10 Jul 2020 13:57:11 +0000 (GMT)
Received: from osiris (unknown [9.171.65.223])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Jul 2020 13:57:11 +0000 (GMT)
Date:   Fri, 10 Jul 2020 15:57:09 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200710135709.GB14845@osiris>
References: <20200703133917.39045-1-david@redhat.com>
 <20200707120849.GB12303@osiris>
 <f4a87c47-4987-e3f8-8c06-ff6dd60f6a39@redhat.com>
 <51813747-a2d6-03a4-fe61-b8d62dbca05b@redhat.com>
 <13549874-c33b-c47a-adbd-d625c83cc87d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13549874-c33b-c47a-adbd-d625c83cc87d@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_07:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=759
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:16:39PM +0200, David Hildenbrand wrote:
> >>> Hmm.. I really would like to see if there would be only a single page
> >>> table walker left in vmem.c, which handles both adding and removing
> >>> things.
> >>> Now we end up with two different page table walk implementations
> >>> within the same file. However not sure if it is worth the effort to
> >>> unify them though.
> >>
> >> I tried to unify vmemmap_populate() and vmem_add_range() already and
> >> didn't like the end result ... so, unifying these along with the removal
> >> part won't be any better - most probably. Open for suggestions :)
> >>
> >> (at least arm64 and x86-64 handle it similarly)
> >>
> > 
> > I'll play with something like
> > 
> > static void modify_pagetable(unsigned long start, unsigned long end,
> > 			     bool direct, bool add)
> > 
> > and see how it turns out.
> > 
> 
> Did a quick hack. With a single walker (modify_pagetable) I get
> 
>  arch/s390/mm/vmem.c | 628 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 434 insertions(+), 194 deletions(-)
> 
> Overall looks cleaner, only modify_pte_table() and modify_pmd_table()
> are a little more involved ...

Would you mind to resend the series with this integrated?
