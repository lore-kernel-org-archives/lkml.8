Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F44FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757BB206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZSqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:46:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgFZSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:46:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QIWiWv128475;
        Fri, 26 Jun 2020 14:46:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31wm7x3n7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 14:46:28 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05QIYUIh140679;
        Fri, 26 Jun 2020 14:46:27 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31wm7x3n6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 14:46:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QIipO0007348;
        Fri, 26 Jun 2020 18:46:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 31v7fwh9fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 18:46:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QIkMj264618732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 18:46:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0C9AE045;
        Fri, 26 Jun 2020 18:46:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A071AE058;
        Fri, 26 Jun 2020 18:46:22 +0000 (GMT)
Received: from thinkpad (unknown [9.171.60.45])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Jun 2020 18:46:22 +0000 (GMT)
Date:   Fri, 26 Jun 2020 20:46:21 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200626204621.55248f99@thinkpad>
In-Reply-To: <20200626192253.2281d95d@thinkpad>
References: <20200625150029.45019-1-david@redhat.com>
        <20200626192253.2281d95d@thinkpad>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_10:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 19:22:53 +0200
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> On Thu, 25 Jun 2020 17:00:29 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > I can't come up with a satisfying reason why we still need the memory
> > segment list. We used to represent in the list:
> > - boot memory
> > - standby memory added via add_memory()
> > - loaded dcss segments
> > 
> > When loading/unloading dcss segments, we already track them in a
> > separate list and check for overlaps
> > (arch/s390/mm/extmem.c:segment_overlaps_others()) when loading segments.
> > 
> > The overlap check was introduced for some segments in
> > commit b2300b9efe1b ("[S390] dcssblk: add >2G DCSSs support and stacked
> > contiguous DCSSs support.")
> > and was extended to cover all dcss segments in
> > commit ca57114609d1 ("s390/extmem: remove code for 31 bit addressing
> > mode").
> > 
> > Although I doubt that overlaps with boot memory and standby memory
> > are relevant, let's reshuffle the checks in load_segment() to request
> > the resource first. This will bail out in case we have overlaps with
> > other resources (esp. boot memory and standby memory). The order
> > is now different compared to segment_unload() and segment_unload(), but
> > that should not matter.
> 
> You are right that this is ancient, but I think "overlaps with boot
> memory and standby memory" were very relevant, that might actually
> have been the initial reason for this in ancient times (but I do not
> really remember).
> 
> With DCSS you can define a fixed start address where the segment will
> be loaded into guest address space. The current code queries this address
> and directly gives it to vmem_add_mapping(), at least if there is no
> overlap with other DCSS segments. If there would be an overlap with
> boot memory, and not checked / rejected in vmem_add_mapping(), the
> following dcss_diag() would probably fail because AFAIR z/VM will
> not allow loading a DCSS with guest memory overlap. So far, so good,
> but the vmem_remove_mapping() on the exit path would then remove
> (part of) boot memory.
> 
> That being said, I think your patch prevents this by moving
> request_resource() up, so we should not call vmem_add_mapping()
> for such overlaps. I still want to give it some test, but need
> to find / setup systems with that ancient technology first :-)
> 

Verified with DCSS overlapping boot and standby memory, works fine.
As expected, the error message changes, but I don't think that is a
problem, as long as you also remove the old -ENOSPC case / comment
in arch/s390/mm/extmem.c. It is actually more correct now I guess,
-ENOSPC doesn't look like the correct return value anyway.

Thanks for cleaning up! Looks good to me, and removes > 100 LOC,
unless Heiko remembers some other issues from ancient times.

Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [DCSS]
