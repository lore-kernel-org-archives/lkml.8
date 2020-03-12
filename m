Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB29C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744620737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgCLAmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:42:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:28947 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731555AbgCLAmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:42:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 17:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="246203295"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2020 17:42:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5569516D; Thu, 12 Mar 2020 02:42:52 +0200 (EET)
Date:   Thu, 12 Mar 2020 03:42:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: remove unnecessary memory fetch in
 PageHeadHuge()
Message-ID: <20200312004252.efb3bfirdk4ghe4z@black.fi.intel.com>
References: <20200311172440.6988-1-vbabka@suse.cz>
 <20200312004119.b7uew2jriwx2mks5@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312004119.b7uew2jriwx2mks5@black.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:41:19AM +0300, Kirill A. Shutemov wrote:
> On Wed, Mar 11, 2020 at 06:24:40PM +0100, Vlastimil Babka wrote:
> > Commit f1e61557f023 ("mm: pack compound_dtor and compound_order into one word
> > in struct page") changed compound_dtor from a pointer to an array index in
> > order to pack it. To check if page has the hugeltbfs compound_dtor, we can
> > just compare the index directly without fetching the function pointer.
> > Said commit did that with PageHuge() and we can do the same with PageHeadHuge()
> > to make the code a bit smaller and faster.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> We use literaly the same check in the function next to this one --
> PageHuge().

Ugh.. I have to read the commit message, not only the code :P

-- 
 Kirill A. Shutemov
