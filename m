Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E83DC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4632208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEGTn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:43:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:49363 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgEGTnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:43:25 -0400
IronPort-SDR: IOuQnjpxDtYVnnUmRhGQOW+sEpA5+TnFcGsBqjH/6QjQC6O8FHQMUfQ3naPFakyHkJcumlqEjN
 5lWFBzb+RWGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 12:43:24 -0700
IronPort-SDR: 08o7ATRyAi9mAFigoZ+HjkcEM0EvLpHu/JpG6yj4ChlRR5OzDycoxW1qDCEYcRqx3HsKOKC2Eg
 BbbaDCcdYEgQ==
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="251602971"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 12:43:24 -0700
Date:   Thu, 7 May 2020 12:43:23 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] treewide: Replace zero-length array with flexible-array
Message-ID: <20200507194323.GA9073@agluck-desk2.amr.corp.intel.com>
References: <20200507185334.GA14456@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185334.GA14456@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:53:34PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'm fine with this specific change ... so

Acked-by: Tony Luck <tony.luck@intel.com>

for anyone picking up all of these treewide: patches
(if they don't, then I can apply this to the ia64 tree)


But a question ... is sizeof still ok on a structure that
contains a flexible-array-member?

E.g. I'd expect:

struct foo {
        int stuff;
        struct boo array[];
};

	printk("size of foo = %d\n", sizeof(struct foo));

To not give any complilation warnings and to tell me that
the size of the structure is 4 bytes.

Is that still true and OK?

-Tony
