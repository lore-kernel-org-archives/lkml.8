Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8131FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580C4206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI6oOH8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404818AbgFYNG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403941AbgFYNGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:06:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48076C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:06:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so2809140ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vc/S2EWgCHsgT5Nzz6iGODeZAQiwBDaupCDYyn5XQ4w=;
        b=sI6oOH8Jj1UA8ZnzW0P8uoV95iFg10KNGjpUyBHXsDHY3oaXDLp9YYg1AK6SfdgBKZ
         ZNQJ70XKR4CF4qiNQRPxjutfr5empIzKEwmGaMkuyQPRI5/88WcVfU7EiZ+DC4EhTo37
         x+nPzTe/l0YTbgGblwNyhGKBndoTh8GjzDu7LVxc9xFxQFPYIADe4AdawL3ZtLYpPdHg
         sJ8eQx+Rhv7YHoJehOR9+9qUxcL+xWoSr5hUJXOIhC5V3I6WIHe2KOn/SEZm7o2nnIjd
         ryKwADR7knFeAHjnscv3Rbnd3k/u4Ds/Jy7FXRPWexMVBLM15qHFe8LCYUQ2qIoEYIxT
         T8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vc/S2EWgCHsgT5Nzz6iGODeZAQiwBDaupCDYyn5XQ4w=;
        b=XijHi/vBGK7ax71+iPK0j6N0QRBU7A8MTE7yC6ni0CopuJAG48tA64RtIbsTtPo2S+
         ApGlWob+mptJhP27AGLwMbZuqlGw/T3c9o2Y5/RxbFaAH5EGYdHamoWD3p4RXN6oYw8E
         o0Aa9JZZDcP7uuyMu50WO5HUJGGTZM1uhU5wc6X1693DIJ20rF74p70iB+RAwI8nkNuX
         uAF3PNgHnBD2GBtTUwqHLc9GfXTuPAYjiPGDr1m0oISH4V3i3IzveTmAPx7ZTaDt9KAA
         iq3ww72hJvjH71PyDVK3+qqljJE2X0YEMPjyNXP046kWtWC6tMfcHJM/SCOzm0vQprE0
         BebA==
X-Gm-Message-State: AOAM531HBbjHpxPHMhNnhjE7N3aYuMrxcz+ITeMqXtCBBbv6VspVNoOs
        sU6dICHX3nedNYJhsdas6Kw=
X-Google-Smtp-Source: ABdhPJwpHGDHGppDaVjA7fx7KGXSP76D2s/LY0qTH3mWDhsQ1JqjI2sWV2fTQDILYiZ7d239mOAU8g==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr7755491lji.25.1593090383640;
        Thu, 25 Jun 2020 06:06:23 -0700 (PDT)
Received: from mail-personal.localdomain ([185.204.1.215])
        by smtp.gmail.com with ESMTPSA id x10sm4804484ljx.67.2020.06.25.06.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:06:22 -0700 (PDT)
Received: by mail-personal.localdomain (Postfix, from userid 1000)
        id 7A8A9611B4; Thu, 25 Jun 2020 16:06:24 +0300 (EEST)
Date:   Thu, 25 Jun 2020 16:06:24 +0300
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     Aiden Leong <aiden.leong@aibsd.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [RFC v2] Reed-Solomon Code: Update no_eras to the actual number
 of errors
Message-ID: <20200625130624.GC1036@mail-personal>
References: <20200625073621.4919-1-aiden.leong@aibsd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625073621.4919-1-aiden.leong@aibsd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2020-06-25 00:36:01, Aiden Leong wrote:
>Corr and eras_pos are updated to actual correction pattern and erasure
>positions, but no_eras is not.
>
>When this library is used to recover lost bytes, we normally memset the
>lost trunk of bytes to zero as a placeholder. Unfortunately, if the lost
>byte is zero, b[i] is zero too. Without correct no_eras, users won't be
>able to determine the valid length of corr and eras_pos.
>
>Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>

I'm not sure I understand what you try to do. decode_rs* already returns
the number of errors correted (or something negative upon failure). So
your last statment is false. The lengt of corr and eras_pos is returned
by the function. So this change is unnecessary. More comments inline.

>
>diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
>index 805de84ae83d..44136ea33d16 100644
>--- a/lib/reed_solomon/decode_rs.c
>+++ b/lib/reed_solomon/decode_rs.c
>@@ -24,6 +24,7 @@
> 	int count = 0;
> 	int num_corrected;
> 	uint16_t msk = (uint16_t) rs->nn;
>+	int no_eras_local = no_eras ? *no_eras : 0;
>
> 	/*
> 	 * The decoder buffers are in the rs control struct. They are
>@@ -106,11 +107,11 @@
> 	memset(&lambda[1], 0, nroots * sizeof(lambda[0]));
> 	lambda[0] = 1;
>
>-	if (no_eras > 0) {
>+	if (no_eras_local > 0) {
> 		/* Init lambda to be the erasure locator polynomial */
> 		lambda[1] = alpha_to[rs_modnn(rs,
> 					prim * (nn - 1 - (eras_pos[0] + pad)))];
>-		for (i = 1; i < no_eras; i++) {
>+		for (i = 1; i < no_eras_local; i++) {
> 			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
> 			for (j = i + 1; j > 0; j--) {
> 				tmp = index_of[lambda[j - 1]];
>@@ -129,8 +130,8 @@
> 	 * Begin Berlekamp-Massey algorithm to determine error+erasure
> 	 * locator polynomial
> 	 */
>-	r = no_eras;
>-	el = no_eras;
>+	r = no_eras_local;
>+	el = no_eras_local;
> 	while (++r <= nroots) {	/* r is the step number */
> 		/* Compute discrepancy at the r-th step in poly-form */
> 		discr_r = 0;
>@@ -158,8 +159,8 @@
> 				} else
> 					t[i + 1] = lambda[i + 1];
> 			}
>-			if (2 * el <= r + no_eras - 1) {
>-				el = r + no_eras - el;
>+			if (2 * el <= r + no_eras_local - 1) {
>+				el = r + no_eras_local - el;
> 				/*
> 				 * 2 lines below: B(x) <-- inv(discr_r) *
> 				 * lambda(x)
>@@ -312,14 +313,21 @@
> 				eras_pos[j++] = loc[i] - pad;
> 			}
> 		}
>+		if (no_eras)
>+			*no_eras = j;
At this point j will be equal to num_corrected. So why return this
information in no_eras, when it is already returned by the function?

> 	} else if (data && par) {
> 		/* Apply error to data and parity */
>+		j = 0;
> 		for (i = 0; i < count; i++) {
> 			if (loc[i] < (nn - nroots))
> 				data[loc[i] - pad] ^= b[i];
> 			else
> 				par[loc[i] - pad - len] ^= b[i];
>+			if (b[i])
>+				j++;
> 		}
>+		if (no_eras)
>+			*no_eras = j;

Same as above.

>2.25.1
>

Best,
Ferdinand

-- 
Ferdinand Blomqvist
ferdinand.blomqvist[at]gmail.com
GPG key: 9EFB 7A2C 0432 4EC5 32BA FA61 CFE9 4164 93E8 B9E4
