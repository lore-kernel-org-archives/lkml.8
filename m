Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE85C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784F02078D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgEEN43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:56:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729089AbgEEN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:56:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045DXI0R093720;
        Tue, 5 May 2020 09:56:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4xkqjv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 09:56:03 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045DpEP1025688;
        Tue, 5 May 2020 09:56:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4xkqjtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 09:56:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045Dtpcf025867;
        Tue, 5 May 2020 13:56:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5q3w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 13:56:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045DtvUG8585642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 13:55:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA14C11C054;
        Tue,  5 May 2020 13:55:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A631311C05B;
        Tue,  5 May 2020 13:55:57 +0000 (GMT)
Received: from oc3748833570.ibm.com (unknown [9.145.26.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 13:55:57 +0000 (GMT)
Received: by oc3748833570.ibm.com (Postfix, from userid 1000)
        id 193C1D80361; Tue,  5 May 2020 15:55:56 +0200 (CEST)
Date:   Tue, 5 May 2020 15:55:56 +0200
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
Message-ID: <20200505135556.GA9920@oc3748833570.ibm.com>
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:34:45AM -0700, Dave Hansen wrote:
> On 5/4/20 6:41 AM, Ulrich Weigand wrote:
> > You're right that there is no mechanism to prevent new references,
> > but that's really never been the goal either.  We're simply trying
> > to ensure that no I/O is ever done on a page that is in the "secure"
> > (or inaccessible) state.  To do so, we rely on the assumption that
> > all code that starts I/O on a page cache page will *first*:
> > - mark the page as pending I/O by either taking an extra page
> >   count, or by setting the Writeback flag; then:
> > - call arch_make_page_accessible(); then:
> > - start I/O; and only after I/O has finished:
> > - remove the "pending I/O" marker (Writeback and/or extra ref)
> 
> Let's ignore writeback for a moment because get_page() is the more
> general case.  The locking sequence is:
> 
> 1. get_page() (or equivalent) "locks out" a page from converting to
>    inaccessbile,
> 2. followed by a make_page_accessible() guarantees that the page
>    *stays* accessible until
> 3. I/O is safe in this region
> 4. put_page(), removes the "lock out", I/O now unsafe

Yes, exactly.

> They key is, though, the get_page() must happen before
> make_page_accessible() and *every* place that acquires a new reference
> needs a make_page_accessible().

Well, sort of: every place that acquires a new reference *and then
performs I/O* needs a make_page_accessible().  There seem to be a
lot of plain get_page() calls that aren't related to I/O.

> try_get_page() is obviously one of those "new reference sites" and it
> only has one call site outisde of the gup code: generic_pipe_buf_get(),
> which is effectively patched by the patch that started this thread.  The
> fact that this one oddball site _and_ gup are patched now is a good sign.
> 
> *But*, I still don't know how that could work nicely:
> 
> > static inline __must_check bool try_get_page(struct page *page)
> > {
> >         page = compound_head(page);
> >         if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> >                 return false;
> >         page_ref_inc(page);
> >         return true;
> > }
> 
> If try_get_page() collides with a freeze_page_refs(), it'll hit the
> WARN_ON_ONCE(), which is surely there for a good reason.  I'm not sure
> that warning is _actually_ valid since freeze_page_refs() isn't truly a
> 0 refcount.  But, the fact that this hasn't been encountered means that
> the testing here is potentially lacking.

This is indeed interesting.  In particular if you compare try_get_page
with try_get_compound_head in gup.c, which does instead:

        if (WARN_ON_ONCE(page_ref_count(head) < 0))
                return NULL;

which seems more reasonable to me, given the presence of the
page_ref_freeze method.  So I'm not sure why try_get_page has <= 0.

I think I understand why we haven't seen this in testing: all the
places in gup.c where try_get_page is called hold the pte lock;
and in the usual case, the pte lock itself already suffices to
lock out make_secure_pte before it even tries to use page_ref_freeze.
(The intent of holding the pte lock there was really to ensure that
the PTE entry is and remains valid throughout the execution of
the ultravisor call, which will look at the PTE entry.)

However, I guess we could construct cases where the pte lock doesn't
suffice to prevent the try_get_page warning: if we create a shared
mapping of the secure guest backing store file into a second process.
That doesn't ever happen in normal qemu operation, so that's likely
why we haven't seen that case.

> > We thought we had identified all places where we needed to place
> > arch_make_page_accessible so that the above assumption is satisfied.
> > You've found at least two instances where this wasn't true (thanks!);
> > but I still think that this can be fixed by just adding those calls.
> 
> Why do you think that's the extent of the problem?  Because the crashes
> stopped?
> 
> I'd feel a lot more comfortable if you explained the audits that you've
> performed or _why_ you think that.  What I've heard thus far is
> basically that you've been able to boot a guest and you're ready to ship
> this code.

Not sure if you can really call this an "audit", but we were really
coming from identifying places where I/O can happen on a page cache
page, and everything we found (except writeback) went through gup.
We obviously missed the sendfile case here; not sure what the best
way would be to verify nothing else was missed.

> But, with regular RCU, you're right, it _does_ appear that it would hit
> that retry loop, but then it would *succeed* in getting a reference.  In
> the end, this just supports the sequence I wrote above:
> arch_make_page_accessible() is only valid when called with an elevated
> refcount and the refcount must be held to lock out make_secure_pte().

Yes, exactly.  That's what comment ahead of our arch_make_page_accesible
says: To be called with the page locked or with an extra reference!
(Either is enough to lock out make_secure_pte.)

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  GNU/Linux compilers and toolchain
  Ulrich.Weigand@de.ibm.com
