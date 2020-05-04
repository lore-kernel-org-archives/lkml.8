Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CFC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A8E20752
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEDNmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:42:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728200AbgEDNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:42:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044DW7Y7055840;
        Mon, 4 May 2020 09:42:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s1svqswk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 09:42:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 044DWOju057415;
        Mon, 4 May 2020 09:42:01 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s1svqsuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 09:42:01 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 044Df6An000445;
        Mon, 4 May 2020 13:41:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 30s0g5a01p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 13:41:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 044DfttG33685572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 13:41:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5D664203F;
        Mon,  4 May 2020 13:41:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C7742045;
        Mon,  4 May 2020 13:41:55 +0000 (GMT)
Received: from oc3748833570.ibm.com (unknown [9.145.79.102])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 May 2020 13:41:55 +0000 (GMT)
Received: by oc3748833570.ibm.com (Postfix, from userid 1000)
        id 21614D80317; Mon,  4 May 2020 15:41:55 +0200 (CEST)
Date:   Mon, 4 May 2020 15:41:55 +0200
From:   Ulrich Weigand <uweigand@de.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        viro@zeniv.linux.org.uk, david@redhat.com,
        akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        jack@suse.cz, kirill@shutemov.name, peterz@infradead.org,
        sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
Message-ID: <20200504134154.GA21001@oc3748833570.ibm.com>
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_07:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:32:45AM -0700, Dave Hansen wrote:
> The larger point, though, is that the s390 code ensures no extra
> references exist upon entering make_secure_pte(), but it still has no
> mechanism to prevent future, new references to page cache pages from
> being created.

Hi Dave, I worked with Claudio and Christian on the initial design
of our approach, so let me chime in here as well.

You're right that there is no mechanism to prevent new references,
but that's really never been the goal either.  We're simply trying
to ensure that no I/O is ever done on a page that is in the "secure"
(or inaccessible) state.  To do so, we rely on the assumption that
all code that starts I/O on a page cache page will *first*:
- mark the page as pending I/O by either taking an extra page
  count, or by setting the Writeback flag; then:
- call arch_make_page_accessible(); then:
- start I/O; and only after I/O has finished:
- remove the "pending I/O" marker (Writeback and/or extra ref)

We thought we had identified all places where we needed to place
arch_make_page_accessible so that the above assumption is satisfied.
You've found at least two instances where this wasn't true (thanks!);
but I still think that this can be fixed by just adding those calls.

Now, if the above assumption holds, then I believe we're safe:
- before we make any page secure, we verify that it is not
  "pending I/O" as defined above (neither Writeback flag, nor
  and extra page count)
- *during* the process of making the page secure, we're protected
  against any potential races due to changes in that status, since
  we hold the page lock (and therefore the Writeback flag cannot
  change), and we've frozen page references (so those cannot change).

This implies that before I/O has started, the page was made
accessible; and as long as the page is marked "pending I/O"
it will not be made inaccessible again.

> The one existing user of expected_page_refs() freezes the refs then
> *removes* the page from the page cache (that's what the xas_lock_irq()
> is for).  That stops *new* refs from being acquired.
> 
> The s390 code is missing an equivalent mechanism.
> 
> One example:
> 
> 	page_freeze_refs();
> 	// page->_count==0 now
> 					find_get_page();
> 					// ^ sees a "freed" page
> 	page_unfreeze_refs();
> 
> find_get_page() will either fail to *find* the page because it will see
> page->_refcount==0 think it is freed (not great), or it will
> VM_BUG_ON_PAGE() in __page_cache_add_speculative().

I don't really see how that could happen; my understanding is that
page_freeze_refs simply causes potential users to spin and wait
until it is no longer frozen.  For example, find_get_page will
in the end call down to find_get_entry, which does:

        if (!page_cache_get_speculative(page))
                goto repeat;

Am I misunderstanding anything here?

> My bigger point is that this patches doesn't systematically stop finding
> page cache pages that are arch-inaccessible.  This patch hits *one* of
> those sites.

As I said above, that wasn't really the goal for our approach.

In particular, note that we *must* have secure pages present in the
page table of the secure guest (that is a requirement of the architecture;
note that the "secure" status doesn't just apply to the phyiscal page,
but a triple of "*this* host physical page is the secure backing store
of *this* guest physical page in *this* secure guest", which the HW/FW
tracks based on the specific page table entry).

As a consequence, the page really also has to remain present in the
page cache (I don't think Linux mm code would be able to handle the
case where a file-backed page is in the page table but not page cache).

I'm not sure what exactly the requirements for your use case are; if those
are significantly differently, maybe we can work together to find an
approach that works for both?

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  GNU/Linux compilers and toolchain
  Ulrich.Weigand@de.ibm.com
