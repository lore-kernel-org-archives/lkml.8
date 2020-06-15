Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D245AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B974E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgFOLny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:43:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:25026 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgFOLnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:43:53 -0400
IronPort-SDR: 1vlCd7VQLBDGKTb2qohiWeHMspQmVX4U4JBy7oXdLPByATbSwxXiOWN2E5ap8DtrkhSEYF05un
 7rsp1purRKHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 04:43:53 -0700
IronPort-SDR: hzUKGDPnSx9L0pMgkrxPR9g1JsvmgTVE2L4Smeh0RIm78Yl6iVb8T/AA7KNvV02ZsQjb4UewHS
 dTxtyUVhBlMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="420344395"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2020 04:43:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jknWr-00DYtl-JK; Mon, 15 Jun 2020 14:43:53 +0300
Date:   Mon, 15 Jun 2020 14:43:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bitmap: Add test for bitmap_cut()
Message-ID: <20200615114353.GY2428291@smile.fi.intel.com>
References: <cover.1592155364.git.sbrivio@redhat.com>
 <5fc45e6bbd4fa837cd9577f8a0c1d639df90a4ce.1592155364.git.sbrivio@redhat.com>
 <20200615094155.GQ2428291@smile.fi.intel.com>
 <20200615094616.GS2428291@smile.fi.intel.com>
 <20200615130825.60283f1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615130825.60283f1b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 01:08:25PM +0200, Stefano Brivio wrote:
> On Mon, 15 Jun 2020 12:46:16 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Jun 15, 2020 at 12:41:55PM +0300, Andy Shevchenko wrote:
> > > On Sun, Jun 14, 2020 at 07:40:54PM +0200, Stefano Brivio wrote:  
> > > > Inspired by an original patch from Yury Norov: introduce a test for
> > > > bitmap_cut() that also makes sure functionality is as described for
> > > > partially overlapping src and dst.  
> > > 
> > > Taking into account recent fixes for BE 64-bit, do we have test cases for a such?  
> > 
> > It might be enough to have only these, but perhaps s390 guys can help?
> 
> There's no behaviour difference due to endianness in this test itself --
> just word size was a topic, hence that BITS_PER_LONG usage with
> redundant values (checked on i686).
> 
> That is, if you have:
> 	{ 0x0000ffffUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL },
> 
> then 1 as array subscript always denotes the second item (from the left)
> there, it doesn't matter how and where different architectures store it.
> 
> Indeed, if bitmap_cut() directly addressed single bytes within the
> words, I would need to pay special attention there. The values I picked
> for these tests are also meant to show any issue in that sense.
> 
> > Alexander, can you apply this patch (w/o the first one, which is suppose to
> > fix) and confirm that you have test case failure, followed by applying first
> > one and confirm a fix?
> 
> I did that already on s390x (of course, I thought :)), I can confirm
> that. Without patch 1/2 the test also fails there:
> 
> [   20.917848] test_bitmap: [lib/test_bitmap.c:666] bitmaps contents differ: expected "0-16,18-19,21,24,26-27,29", got "1,3-4,6,9,11-12,14,16,18-19,21,24,26-27,29"

Thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> If Alexander wants to test this on a z14 or z15, sure, it won't harm.

Sure.

> By the way, tests for 'parse', 'parse_user' and 'parselist' report
> issues:

I believe this [1] will fix it.

[1]: 81c4f4d924d5 ("lib: fix bitmap_parse() on 64-bit big endian archs")

-- 
With Best Regards,
Andy Shevchenko


