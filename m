Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA53E2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgFZRXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:23:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgFZRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:23:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QH2ASY046541;
        Fri, 26 Jun 2020 13:23:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31wkbgbjhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 13:23:01 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05QH3V6t054082;
        Fri, 26 Jun 2020 13:23:00 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31wkbgbjgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 13:23:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QHLgt5030416;
        Fri, 26 Jun 2020 17:22:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 31uusjk676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 17:22:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QHMt1D55902410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 17:22:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 997AFAE056;
        Fri, 26 Jun 2020 17:22:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3472DAE053;
        Fri, 26 Jun 2020 17:22:55 +0000 (GMT)
Received: from thinkpad (unknown [9.171.60.45])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Jun 2020 17:22:55 +0000 (GMT)
Date:   Fri, 26 Jun 2020 19:22:53 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200626192253.2281d95d@thinkpad>
In-Reply-To: <20200625150029.45019-1-david@redhat.com>
References: <20200625150029.45019-1-david@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_08:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=922 impostorscore=0
 cotscore=-2147483648 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 17:00:29 +0200
David Hildenbrand <david@redhat.com> wrote:

> I can't come up with a satisfying reason why we still need the memory
> segment list. We used to represent in the list:
> - boot memory
> - standby memory added via add_memory()
> - loaded dcss segments
> 
> When loading/unloading dcss segments, we already track them in a
> separate list and check for overlaps
> (arch/s390/mm/extmem.c:segment_overlaps_others()) when loading segments.
> 
> The overlap check was introduced for some segments in
> commit b2300b9efe1b ("[S390] dcssblk: add >2G DCSSs support and stacked
> contiguous DCSSs support.")
> and was extended to cover all dcss segments in
> commit ca57114609d1 ("s390/extmem: remove code for 31 bit addressing
> mode").
> 
> Although I doubt that overlaps with boot memory and standby memory
> are relevant, let's reshuffle the checks in load_segment() to request
> the resource first. This will bail out in case we have overlaps with
> other resources (esp. boot memory and standby memory). The order
> is now different compared to segment_unload() and segment_unload(), but
> that should not matter.

You are right that this is ancient, but I think "overlaps with boot
memory and standby memory" were very relevant, that might actually
have been the initial reason for this in ancient times (but I do not
really remember).

With DCSS you can define a fixed start address where the segment will
be loaded into guest address space. The current code queries this address
and directly gives it to vmem_add_mapping(), at least if there is no
overlap with other DCSS segments. If there would be an overlap with
boot memory, and not checked / rejected in vmem_add_mapping(), the
following dcss_diag() would probably fail because AFAIR z/VM will
not allow loading a DCSS with guest memory overlap. So far, so good,
but the vmem_remove_mapping() on the exit path would then remove
(part of) boot memory.

That being said, I think your patch prevents this by moving
request_resource() up, so we should not call vmem_add_mapping()
for such overlaps. I still want to give it some test, but need
to find / setup systems with that ancient technology first :-)

One change introduced by this patch is that we no longer
see -ENOSPC and the corresponding error message from extmem code:
"DCSS %s overlaps with used storage and cannot be loaded"

Instead, now we would see -EBUSY and this message:
"%s needs used memory resources and cannot be loaded or queried"

That should be OK, as it is also the same message that we already
see for overlaps with other DCSSs. But you probably also should
remove that case from the segment_warning() function for
completeness.

Regards,
Gerald
