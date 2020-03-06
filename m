Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9549C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BE020848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIPJbpP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCFA0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:26:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42244 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCFA0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:26:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id u3so99770plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 16:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I+H+aBsk+aErmv7EQrFez4S6k+Jo/VLRM9wBUoRhvdk=;
        b=kIPJbpP4aDjikDwERd83CWqw0g1gDeaOpN3rKxN7U17opQWk+DszN7EOBIYAYkfIE7
         U3kALe3j030A6c828cw57yTR/uSXIZSeMfZ7+fYCnFpufu2dOki1HqYnphcu9isu3/UX
         OZMgxzbxAdtSb8z0beCH5HUQyv18GY9HcvP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I+H+aBsk+aErmv7EQrFez4S6k+Jo/VLRM9wBUoRhvdk=;
        b=Fpvx8rhAKD7qpiBhtnitFzMqFtzw3g02P6ajg1yej8lR3hx3MnBpcs6ox7amEIPyqU
         NsBr79AqN2BawN0eT6b7Gd6ml6MEO0E6+vrMGewjpBbM6yySLKi0seOhxKaDIy0r0nzB
         +xfXrJb5WmysKwNcLsCwc10Y703scEscbSQnFjGjCCK5oJLZKsiSTkT+PQ36HSWzMGlU
         9q+M6FZoeOE84cKRus8x9hx0z6Vit/WAx/zapHxFb/cnFyM9GvfYMp8hbKKqrAp0h/gb
         n5j6+Ux41RUe0UYpL3sVATpgN8f0thcOVSEkBMtocdrxmqqLMBG2rh55a19PHVmUTT9l
         hkIw==
X-Gm-Message-State: ANhLgQ3Irt2pM4dVWpRVEltxBHuv8QeApb5bp+pXHu3C739fxiQbinLY
        tdzuOxHXM4F82Afq9ELdhPWapQ==
X-Google-Smtp-Source: ADFU+vvsEmRas83z6b6EOfPKmn+c0YwxGHS7MDsICsIW90k0sEU9LxS8X8RfEwavWXkWsBUZOqRfkQ==
X-Received: by 2002:a17:90a:b94a:: with SMTP id f10mr748899pjw.1.1583454380995;
        Thu, 05 Mar 2020 16:26:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm22013249pge.48.2020.03.05.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 16:26:19 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:26:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Vitaly Nikolenko <vnik@duasynt.com>,
        Silvio Cesare <silvio.cesare@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slub: Relocate freelist pointer to middle of object
Message-ID: <202003051624.AAAC9AECC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a recent discussion[1] with Vitaly Nikolenko and Silvio Cesare,
it became clear that moving the freelist pointer away from the edge of
allocations would likely improve the overall defensive posture of the
inline freelist pointer. My benchmarks show no meaningful change to
performance (they seem to show it being faster), so this looks like a
reasonable change to make.

Instead of having the freelist pointer at the very beginning of an
allocation (offset 0) or at the very end of an allocation (effectively
offset -sizeof(void *) from the next allocation), move it away from
the edges of the allocation and into the middle. This provides some
protection against small-sized neighboring overflows (or underflows),
for which the freelist pointer is commonly the target. (Large or well
controlled overwrites are much more likely to attack live object contents,
instead of attempting freelist corruption.)

The vaunted kernel build benchmark, across 5 runs. Before:

	Mean: 250.05
	Std Dev: 1.85

and after, which appears mysteriously faster:

	Mean: 247.13
	Std Dev: 0.76

Attempts at running "sysbench --test=memory" show the change to be well
in the noise (sysbench seems to be pretty unstable here -- it's not
really measuring allocation).

Hackbench is more allocation-heavy, and while the std dev is above the
difference, it looks like may manifest as an improvement as well:

20 runs of "hackbench -g 20 -l 1000", before:

	Mean: 36.322
	Std Dev: 0.577

and after:

	Mean: 36.056
	Std Dev: 0.598

[1] https://twitter.com/vnik5287/status/1235113523098685440

Cc: Vitaly Nikolenko <vnik@duasynt.com>
Cc: Silvio Cesare <silvio.cesare@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 107d9d89cf96..45926cb4514f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3562,6 +3562,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
+	} else if (size > sizeof(void *)) {
+		/*
+		 * Store freelist pointer near middle of object to keep
+		 * it away from the edges of the object to avoid small
+		 * sized over/underflows from neighboring allocations.
+		 */
+		s->offset = ALIGN(size / 2, sizeof(void *));
 	}
 
 #ifdef CONFIG_SLUB_DEBUG
-- 
2.20.1


-- 
Kees Cook
