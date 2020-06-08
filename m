Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F312076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591579472;
	bh=gn50bNobrmHJlHOnCq+jCJlXEsdpnCZrGX2MUr/Mdas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wDKTeP5asWzhQdzNZj/hC6IlKn1TIeVszjJIoJFFtFLuT0NcR9hcigQ0H0pS3Ag5/
	 WNTbz1UqjU5nMqOFlmm3PLBx5WRKtJCQ7nHINHMkNO1S8Pe4GZ9iBCpqNpPX9y1Of9
	 YsGOUPunXE8ExBwZq3OiT8O4E3kzkXKUpq9acr4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgFHBYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgFHBYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:24:30 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA022075A;
        Mon,  8 Jun 2020 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591579469;
        bh=gn50bNobrmHJlHOnCq+jCJlXEsdpnCZrGX2MUr/Mdas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UOnCer4oPdEUY8quGPSMuoFl9pM8KxPTniA1r64IHO9ltJ2OCMiD6P01e+x5Pql4V
         /lWjSY20BpUiXtNJh5qd6FYRrr4tT4ZAO3OU+2hSz2sbCzp+8lciTj+ZhqTbC4WgUX
         HltYx06/Z+VckUpiSgWyZLnGCMXyoKPkuyWnpXDM=
Date:   Sun, 7 Jun 2020 18:24:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Yann Collet <cyan@fb.com>, Vasily Averin <vvs@virtuozzo.com>,
        Gao Xiang <hsiangkao@aol.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
Message-Id: <20200607182428.0d9ce5139b9ab4f36eefca1b@linux-foundation.org>
In-Reply-To: <3bf931c6ea0cae3e23f3485801986859851b4f04.camel@perches.com>
References: <20200606143646.GB10839.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
        <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
        <330eccf1-6d4b-07dd-4e55-ffe3a179e4b8@virtuozzo.com>
        <D4762145-BBC5-4574-BF68-8C1A3AF41D98@fb.com>
        <3bf931c6ea0cae3e23f3485801986859851b4f04.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jun 2020 18:02:44 -0700 Joe Perches <joe@perches.com> wrote:

> On Mon, 2020-06-08 at 00:40 +0000, Yann Collet wrote:
> > Hi Vasily
> > 
> > 
> > If I do understand the discussion, the question is about usage of `&` instead of `&&`,
> > and the speculation that it might be an error.
> > 
> > It's not an error. Unfortunately, explaining the reasoning behind this decision is a bit long.
> 
> Likely better to add a comment around the use so that
> another patch like this doesn't get submitted again.
> 
> Perhaps something like:

Yup.


From: Joe Perches <joe@perches.com>
Subject: lib/lz4/lz4_decompress.c: document deliberate use of `&'

This operation was intentional, but tools such as smatch will warn that it
might not have been.

Link: http://lkml.kernel.org/r/3bf931c6ea0cae3e23f3485801986859851b4f04.camel@perches.com
Cc: Yann Collet <cyan@fb.com>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Gao Xiang <hsiangkao@aol.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/lz4/lz4_decompress.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/lib/lz4/lz4_decompress.c~lib-lz4-smatch-warning-in-lz4_decompress_generic
+++ a/lib/lz4/lz4_decompress.c
@@ -141,6 +141,9 @@ static FORCE_INLINE int LZ4_decompress_g
 		 * space in the output for those 18 bytes earlier, upon
 		 * entering the shortcut (in other words, there is a
 		 * combined check for both stages).
+		 *
+		 * The & in the likely() below is intentionally not && so that
+		 * some compilers can produce better parallelized runtime code
 		 */
 		if ((endOnInput ? length != RUN_MASK : length <= 8)
 		   /*
_

