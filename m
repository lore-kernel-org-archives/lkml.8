Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B117C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C49220656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F21Lm0+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440409AbgDNP23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:28:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2440402AbgDNP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586878082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQl7E2J5Id3WK2U6l9dHkxOAqTFLollC0wE6NW6GpKc=;
        b=F21Lm0+DDhdl8Tl9P54z+csGOZ7Tvxf+uTYEuVw8lmpMCIIBVPVX7oAwktswN5y8jruKs7
        cbNypBRvqbAJeVKU+5LZRkuttXG6Stj14TQtskbM6x6AF4dOZ9t/2F3QYtLHhQFyNjCQTc
        08t87/PaaLaSwCwsgghPd8cs+yUahTE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-AjsOd9bjPHuGO90fH0GmLQ-1; Tue, 14 Apr 2020 11:28:00 -0400
X-MC-Unique: AjsOd9bjPHuGO90fH0GmLQ-1
Received: by mail-qk1-f197.google.com with SMTP id d15so1293236qkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQl7E2J5Id3WK2U6l9dHkxOAqTFLollC0wE6NW6GpKc=;
        b=poTXFSnGiSmR/bs2DozA7L18er7OnIvSyrBw1UZt8hqB3TxF+22C0vDRn94Bvt5Jw1
         Jem6fGoaiwQLDT/7GYOiHEnpzBNARTAn8oFkK1WJt7/sqMCUZHDSumDiAH07mqjCV2c8
         npNyiRfaYzv3Aw7is8Haj2ZOwmLxArEAkRY+NOWbw5h3qfTfTmnAkNZpblozjwpRLbFo
         iZramBnkpFFG1llJiVNfTfbVFbapa6CwTRreKzVmHGtwh8CwtfUdwf+yJIUy26X1MSe0
         IR8zChNc/40mQGBhECimVOot066Vpw9ZSjzB4r0WgimLxK+ZoNEx4sffEbCsNl7U8RRu
         CDcA==
X-Gm-Message-State: AGi0Pua6B9/mmnhkqBIJ2K7OGKrbyF56AIAjBVx3IFIKTNpzkVa5McE8
        lJ9Z69KmfCS3o8lYHvb74c8G2qIxSh5KOi+O2zXFnJHCGLzU47gtMfjh6aF34Ukv/aGMvFD9clS
        Sqh30UJF4OkBgGQBhwjZvKjIm
X-Received: by 2002:a05:620a:556:: with SMTP id o22mr9833533qko.166.1586878079970;
        Tue, 14 Apr 2020 08:27:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKi4fEpiHK//JOd6coi6+kBQGk2tK7VvXLiOPA/Nm1mgCzbzlmc1ysUQObBrefDJRDgHB3now==
X-Received: by 2002:a05:620a:556:: with SMTP id o22mr9833484qko.166.1586878079506;
        Tue, 14 Apr 2020 08:27:59 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w2sm4660953qtv.42.2020.04.14.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:27:58 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:27:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S.Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/4] hugetlbfs: clean up command line processing
Message-ID: <20200414152756.GG38470@xz-x1>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-5-mike.kravetz@oracle.com>
 <20200410203730.GG3172@xz-x1>
 <ce42fa12-023b-7ed2-a60e-7dbf9c530981@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce42fa12-023b-7ed2-a60e-7dbf9c530981@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:59:26AM -0700, Mike Kravetz wrote:
> On 4/10/20 1:37 PM, Peter Xu wrote:
> > On Wed, Apr 01, 2020 at 11:38:19AM -0700, Mike Kravetz wrote:
> >> With all hugetlb page processing done in a single file clean up code.
> >> - Make code match desired semantics
> >>   - Update documentation with semantics
> >> - Make all warnings and errors messages start with 'HugeTLB:'.
> >> - Consistently name command line parsing routines.
> >> - Check for hugepages_supported() before processing parameters.
> >> - Add comments to code
> >>   - Describe some of the subtle interactions
> >>   - Describe semantics of command line arguments
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         | 35 ++++---
> >>  Documentation/admin-guide/mm/hugetlbpage.rst  | 44 +++++++++
> >>  mm/hugetlb.c                                  | 96 +++++++++++++++----
> >>  3 files changed, 142 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index 1bd5454b5e5f..de653cfe1726 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -832,12 +832,15 @@
> >>  			See also Documentation/networking/decnet.txt.
> >>  
> >>  	default_hugepagesz=
> >> -			[same as hugepagesz=] The size of the default
> >> -			HugeTLB page size. This is the size represented by
> >> -			the legacy /proc/ hugepages APIs, used for SHM, and
> >> -			default size when mounting hugetlbfs filesystems.
> >> -			Defaults to the default architecture's huge page size
> >> -			if not specified.
> >> +			[HW] The size of the default HugeTLB page size. This
> > 
> > Could I ask what's "HW"?  Sorry this is not a comment at all but
> > really a pure question I wanted to ask... :)
> 
> kernel-parameters.rst includes kernel-parameters.txt and included the meaning
> for these codes.
> 
>        HW      Appropriate hardware is enabled.
> 
> Previously, it listed an obsolete list of architectures.

I see. It was a bit confusing since hugepage is not a real hardware,
"CAP (capability)" might be easier, but I get the point now, thanks!

[...]

> >> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> >> index 1cc0bc78d10e..de340c586995 100644
> >> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> >> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> >> @@ -100,6 +100,50 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
> >>  be specified in bytes with optional scale suffix [kKmMgG].  The default huge
> >>  page size may be selected with the "default_hugepagesz=<size>" boot parameter.
> >>  
> >> +Hugetlb boot command line parameter semantics
> >> +hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
> >> +	parameter to preallocate a number of huge pages of the specified
> >> +	size.  Hence, hugepagesz and hugepages are typically specified in
> >> +	pairs such as:
> >> +		hugepagesz=2M hugepages=512
> >> +	hugepagesz can only be specified once on the command line for a
> >> +	specific huge page size.  Valid huge page sizes are architecture
> >> +	dependent.
> >> +hugepages - Specify the number of huge pages to preallocate.  This typically
> >> +	follows a valid hugepagesz parameter.  However, if hugepages is the
> >> +	first or only hugetlb command line parameter it specifies the number
> >> +	of huge pages of default size to allocate.  The number of huge pages
> >> +	of default size specified in this manner can be overwritten by a
> >> +	hugepagesz,hugepages parameter pair for the default size.
> >> +	For example, on an architecture with 2M default huge page size:
> >> +		hugepages=256 hugepagesz=2M hugepages=512
> >> +	will result in 512 2M huge pages being allocated.  If a hugepages
> >> +	parameter is preceded by an invalid hugepagesz parameter, it will
> >> +	be ignored.
> >> +default_hugepagesz - Specify the default huge page size.  This parameter can
> >> +	only be specified once on the command line.  No other hugetlb command
> >> +	line parameter is associated with default_hugepagesz.  Therefore, it
> >> +	can appear anywhere on the command line.  If hugepages= is the first
> >> +	hugetlb command line parameter, the specified number of huge pages
> >> +	will apply to the default huge page size specified with
> >> +	default_hugepagesz.  For example,
> >> +		hugepages=512 default_hugepagesz=2M
> > 
> > No strong opinion, but considering to the special case of gigantic
> > huge page mentioned below, I'm thinking maybe it's easier to just ask
> > the user to always use "hugepagesz=X hugepages=Y" pair when people
> > want to reserve huge pages.
> 
> We can ask people to do this.  However, I do not think we can force it at
> this time.  Why?  Mostly because I have seen many instances where people
> only specify 'hugepages=X' on the command line to preallocate X huge pages
> of default size.  So, forcing 'hugepagesz=X hugepages=Y' would break those
> users.
> 
> > For example, some user might start to use this after this series
> > legally:
> > 
> >     default_hugepagesz=2M hugepages=1024
> 
> Well, that 'works' today.  You get that silly error message:
> 
> HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152
> 
> But, it does preallocate 1024 huge pages of size 2M.  Because people
> have noticed the silly error message, I suspect this usage,
> 
> 	default_hugepagesz=X hugepages=Y
> 
> is in use today and we need to support it.

Fair enough.

[...]

> >> @@ -3209,19 +3209,35 @@ static int __init hugetlb_init(void)
> >>  	if (!hugepages_supported())
> >>  		return 0;
> >>  
> >> -	if (!size_to_hstate(default_hstate_size)) {
> >> -		if (default_hstate_size != 0) {
> >> -			pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
> >> -			       default_hstate_size, HPAGE_SIZE);
> >> -		}
> >> -
> >> +	/*
> >> +	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
> >> +	 * architectures depend on setup being done here.
> >> +	 *
> >> +	 * If a valid default huge page size was specified on the command line,
> >> +	 * add associated hstate if necessary.  If not, set default_hstate_size
> >> +	 * to default size.  default_hstate_idx is used at runtime to identify
> >> +	 * the default huge page size/hstate.
> >> +	 */
> >> +	hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> >> +	if (default_hstate_size)
> >> +		hugetlb_add_hstate(ilog2(default_hstate_size) - PAGE_SHIFT);
> >> +	else
> >>  		default_hstate_size = HPAGE_SIZE;
> >> -		hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> >> -	}
> >>  	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
> >> +
> >> +	/*
> >> +	 * default_hstate_max_huge_pages != 0 indicates a count (hugepages=)
> >> +	 * specified before a size (hugepagesz=).  Use this count for the
> >> +	 * default huge page size, unless a specific value was specified for
> >> +	 * this size in a hugepagesz/hugepages pair.
> >> +	 */
> >>  	if (default_hstate_max_huge_pages) {
> > 
> > Since we're refactoring this - Could default_hstate_max_huge_pages be
> > dropped directly (in hugepages= we can create the default hstate, then
> > we set max_huge_pages of the default hstate there)?  Or did I miss
> > anything important?
> 
> I do not think that works for 'hugepages=X default_hugepagesz=Y' processing?
> It seems like there will need to be more work done on default_hugepagesz
> processing.

That was really an awkward kernel cmdline... But I guess you're right.

I think it awkward because it can be also read in sequence as "reserve
X huge pages of default huge page size, then change default value to
Y".  So instead of awkward, maybe "ambiguous".  However I have totally
no clue on how to make this better either - there's really quite a lot
of freedom right now on specifying all these options right now.

Thanks,

-- 
Peter Xu

