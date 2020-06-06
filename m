Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CEFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF12074B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591402592;
	bh=CGfJzErRzJMhI7G13mavATOTt80pm47l9xbcMGH7+jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WCTKrv4WePDIiS3QdV5ppCwHaA4Y2La4napI1EkZMbeP9APqg6c+MoJ78nTKg3L+h
	 t8+UfeU435cqfd7HpzlBLP/xJJYoa2mMhhNp/HyDyJt70Jw6nfH8jKpqNlhWJM37dp
	 0Eo8RY8lPeRCr/imUMzyicMOjy4/o3GIPPaOfHjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFFAQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgFFAQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:16:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D262206DB;
        Sat,  6 Jun 2020 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591402590;
        bh=CGfJzErRzJMhI7G13mavATOTt80pm47l9xbcMGH7+jU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p34NcdGXoudX/KQr9fqgG/BtiYkKo7N/kZEsDn93sMxRK7BjiJ3L1jtae1J33u8Bc
         5ZGCifnWan0vpPWPIIcfI1JVocfeKSXjc7rFcj0Rk/NQS/186JLdvqVEg2UCmLkdNn
         szhVb6nJg+TSiGdUxc+vzj1RZcP2xoVpIWTRVMDU=
Date:   Fri, 5 Jun 2020 17:16:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-Id: <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
In-Reply-To: <20200605230610.bizp2j23ivyma5rn@master>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
        <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
        <20200604122805.d2ndjmkmti6wl3nz@master>
        <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
        <20200605230610.bizp2j23ivyma5rn@master>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 23:06:10 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> On Thu, Jun 04, 2020 at 02:51:40PM +0200, Geert Uytterhoeven wrote:
> >Hi Wei,
> >
> >On Thu, Jun 4, 2020 at 2:28 PM Wei Yang <richard.weiyang@gmail.com> wrote:
> [...]
> >>
> >> You mean
> >>
> >>        {0x0000000000000003,  2},
> >>        {0x0000000000000004,  2},
> >>        {0x0000000000001fff, 13},
> >>        {0x0000000000002000, 13},
> >>        {0x0000000050000000, 31},
> >>        {0x0000000080000000, 31},
> >>        {0x0000000080003000, 32},
> >
> >Yes, those values.  And those should work with get_count_order_long()
> >on both 32-bit and 64-bit.

Geert meant "no, the values in order_comb[]" :)

We have a table of numbers in order_comb[] so we may as well feed them
into get_count_order_long() (as well as get_count_order()) just for a
bit more testing.

So how about the below?  order_comb_long[] just can't be used on 32-bit
machines because their longs are 32-bit.  If we had a
get_count_order_u64() then we could use it.

I haven't runtime tested this - could you please do so?


static unsigned int order_comb[][2] = {
	{0x00000003,  2},
	{0x00000004,  2},
	{0x00001fff, 13},
	{0x00002000, 13},
	{0x50000000, 31},
	{0x80000000, 31},
	{0x80003000, 32},
};

#ifdef CONFIG_64BIT
static unsigned long order_comb_long[][2] = {
	{0x0000000300000000, 34},
	{0x0000000400000000, 34},
	{0x00001fff00000000, 45},
	{0x0000200000000000, 45},
	{0x5000000000000000, 63},
	{0x8000000000000000, 63},
	{0x8000300000000000, 64},
};
#endif

static int __init test_bitops_startup(void)
{
	int i;

	pr_warn("Loaded test module\n");
	set_bit(BITOPS_4, g_bitmap);
	set_bit(BITOPS_7, g_bitmap);
	set_bit(BITOPS_11, g_bitmap);
	set_bit(BITOPS_31, g_bitmap);
	set_bit(BITOPS_88, g_bitmap);

	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
			pr_warn("get_count_order wrong for %x\n",
				       order_comb[i][0]);
	}

	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
		if (order_comb[i][1] != get_count_order_long(order_comb[i][0]))
			pr_warn("get_count_order_long wrong for %x\n",
				       order_comb[i][0]);
	}

#ifdef CONFIG_64BIT
	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
		if (order_comb_long[i][1] !=
			       get_count_order_long(order_comb_long[i][0]))
			pr_warn("get_count_order_long wrong for %lx\n",
				       order_comb_long[i][0]);
	}
#endif
	return 0;
}


From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib-test-get_count_order-long-in-test_bitopsc-fix

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/test_bitops.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/lib/test_bitops.c~lib-test-get_count_order-long-in-test_bitopsc-fix
+++ a/lib/test_bitops.c
@@ -28,7 +28,7 @@ enum bitops_fun {
 
 static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
 
-unsigned int order_comb[][2] = {
+static unsigned int order_comb[][2] = {
 	{0x00000003,  2},
 	{0x00000004,  2},
 	{0x00001fff, 13},
@@ -38,7 +38,8 @@ unsigned int order_comb[][2] = {
 	{0x80003000, 32},
 };
 
-unsigned long order_comb_long[][2] = {
+#ifdef CONFIG_64BIT
+static unsigned long order_comb_long[][2] = {
 	{0x0000000300000000, 34},
 	{0x0000000400000000, 34},
 	{0x00001fff00000000, 45},
@@ -47,6 +48,7 @@ unsigned long order_comb_long[][2] = {
 	{0x8000000000000000, 63},
 	{0x8000300000000000, 64},
 };
+#endif
 
 static int __init test_bitops_startup(void)
 {
@@ -62,14 +64,23 @@ static int __init test_bitops_startup(vo
 	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
 		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
 			pr_warn("get_count_order wrong for %x\n",
-				       order_comb[i][0]); }
+				       order_comb[i][0]);
+	}
 
-	for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
+	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
+		if (order_comb[i][1] != get_count_order_long(order_comb[i][0]))
+			pr_warn("get_count_order_long wrong for %x\n",
+				       order_comb[i][0]);
+	}
+
+#ifdef CONFIG_64BIT
+	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
 		if (order_comb_long[i][1] !=
 			       get_count_order_long(order_comb_long[i][0]))
 			pr_warn("get_count_order_long wrong for %lx\n",
-				       order_comb_long[i][0]); }
-
+				       order_comb_long[i][0]);
+	}
+#endif
 	return 0;
 }
 
_

