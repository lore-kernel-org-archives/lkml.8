Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC020206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgFHBCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:02:48 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:33036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgFHBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:02:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1784B1808E84C;
        Mon,  8 Jun 2020 01:02:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: love83_601194f26db5
X-Filterd-Recvd-Size: 2236
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 01:02:45 +0000 (UTC)
Message-ID: <3bf931c6ea0cae3e23f3485801986859851b4f04.camel@perches.com>
Subject: Re: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
From:   Joe Perches <joe@perches.com>
To:     Yann Collet <cyan@fb.com>, Vasily Averin <vvs@virtuozzo.com>,
        Gao Xiang <hsiangkao@aol.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Date:   Sun, 07 Jun 2020 18:02:44 -0700
In-Reply-To: <D4762145-BBC5-4574-BF68-8C1A3AF41D98@fb.com>
References: <20200606143646.GB10839.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
         <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
         <330eccf1-6d4b-07dd-4e55-ffe3a179e4b8@virtuozzo.com>
         <D4762145-BBC5-4574-BF68-8C1A3AF41D98@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 00:40 +0000, Yann Collet wrote:
> Hi Vasily
> 
> 
> If I do understand the discussion, the question is about usage of `&` instead of `&&`,
> and the speculation that it might be an error.
> 
> It's not an error. Unfortunately, explaining the reasoning behind this decision is a bit long.

Likely better to add a comment around the use so that
another patch like this doesn't get submitted again.

Perhaps something like:
---
 lib/lz4/lz4_decompress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0c9d3ad17e0f..5371dab6b481 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -141,6 +141,9 @@ static FORCE_INLINE int LZ4_decompress_generic(
 		 * space in the output for those 18 bytes earlier, upon
 		 * entering the shortcut (in other words, there is a
 		 * combined check for both stages).
+		 *
+		 * The & in the likely() below is intentionally not && so that
+		 * some compilers can produce better parallelized runtime code
 		 */
 		if ((endOnInput ? length != RUN_MASK : length <= 8)
 		   /*


