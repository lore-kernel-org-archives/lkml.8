Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134EF21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pv653W5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgHGQGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:06:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563FC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:06:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so2149194wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lB0exDTiK20r9BbG9hUJ8sI2xKN99bAKX09J/wOfYgY=;
        b=Pv653W5ZVisEcxtjFyenjeunZsKN18fv2BdrcqLuWJdEKDMrK3E7NldrgIxtjnt76U
         pKMzLl0Koi0AUXJGkB72nWNx3/8cWHlJBm8Jxwe86GvGOJJOFho9lsjr+Sv1MTzSTvCy
         YLoOciWt4h35aAMUWnFQoy1WbSUvSMKU9pJJSXZHwyDEdOqLZ+Qx5Dz+KuSrzZWZVSO0
         KGnagkQM+nvvc5ENVebzTYBM08suFVzJJyvZ5kUgnOKNQq50QQbeTv+xKEIre9QfkJL8
         KJf42QB1a/qnnybMNPlwuUhn0zaU7VbzYstm9y8o2qH7Bw3E8TmriS/JCalTYPienORB
         Qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lB0exDTiK20r9BbG9hUJ8sI2xKN99bAKX09J/wOfYgY=;
        b=AcpJoTooTGyNqu3kcL21vCegvr8ZMCO2nkYmGOkSInf/mTX++m2+bUahYz/n9mioFo
         wWNG2lG4WTKk3uJ4UDBuLEXOAypxlEB+ZD1CIGuFo3NRBS9i5/HOMkoihKeTWlVVOsOO
         SKGUb0+NyVeH07UiEyop2JqVugzb3S5qwvHe1ve9ktY1K5IsclxK1Ssqoha2xu7XMY0E
         WkVWMTBF9QH/y74H7YO/c60Ez5oA+clT4/mNYdd1yL+QGJ6ba1AQ74xJd/+f7oABwkAh
         b9io9HJJwRAvzOekx9YuaEmXEJMfSSY0HgVuZNUgxnkX1XSe9rHYgc/YEPY6ccd01Ovm
         /8hw==
X-Gm-Message-State: AOAM530PZXxCrGCp0C0E5J4aAv/06EbNh4EuSS9WkZGX6MXfveERylqS
        enQ+vtR/ac6XjRUcfp3X6Pm/Wg==
X-Google-Smtp-Source: ABdhPJxjL3jMt5Wy5ksVlEbm66TfAanj9ABaYa2JHKO7ZQb/rdeyfGvNWXktkJkneOL02RrIDNvgRw==
X-Received: by 2002:a5d:4a41:: with SMTP id v1mr13852053wrs.371.1596816394436;
        Fri, 07 Aug 2020 09:06:34 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id t133sm18135689wmf.0.2020.08.07.09.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 09:06:33 -0700 (PDT)
Date:   Fri, 7 Aug 2020 18:06:27 +0200
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Odd-sized kmem_cache_alloc and slub_debug=Z
Message-ID: <20200807160627.GA1420741@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that the below debug-code using kmem_cache_alloc(), when using
slub_debug=Z, results in the following crash:

	general protection fault, probably for non-canonical address 0xcccccca41caea170: 0000 [#1] PREEMPT SMP PTI
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #1
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
	RIP: 0010:freelist_dereference mm/slub.c:272 [inline]
	RIP: 0010:get_freepointer mm/slub.c:278 [inline]
	RIP: 0010:deactivate_slab+0x54/0x460 mm/slub.c:2111
	Code: 8b bc c7 e0 00 00 00 48 85 d2 0f 84 00 01 00 00 49 89 d5 31 c0 48 89 44 24 08 66 66 2e 0f 1f 84 00 00 00 00 00 90 44 8b 43 20 <4b> 8b 44 05 00 48 85 c0 0f 84 1e 01 00 00 4c 89 ed 49 89 c5 8b 43
	RSP: 0000:ffffffffa7e03e18 EFLAGS: 00010046
	RAX: 0000000000000000 RBX: ffffa3a41c972340 RCX: 0000000000000000
	RDX: cccccca41caea160 RSI: ffffe7c6a072ba80 RDI: ffffa3a41c972340
	RBP: ffffa3a41caea008 R08: 0000000000000010 R09: ffffa3a41caea01d
	R10: ffffffffa7f8dc50 R11: ffffffffa68f44c0 R12: ffffa3a41c972340
	R13: cccccca41caea160 R14: ffffe7c6a072ba80 R15: ffffa3a41c96d540
	FS:  0000000000000000(0000) GS:ffffa3a41fc00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ffffa3a051c01000 CR3: 000000045140a001 CR4: 0000000000770ef0
	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
	PKRU: 00000000
	Call Trace:
	 ___slab_alloc+0x336/0x340 mm/slub.c:2690
	 __slab_alloc mm/slub.c:2714 [inline]
	 slab_alloc_node mm/slub.c:2788 [inline]
	 slab_alloc mm/slub.c:2832 [inline]
	 kmem_cache_alloc+0x135/0x200 mm/slub.c:2837
	 start_kernel+0x3d6/0x44e init/main.c:1049
	 secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:243

Any ideas what might be wrong?

This does not crash when redzones are not enabled.

Thanks,
-- Marco

------ >8 ------

diff --git a/init/main.c b/init/main.c
index 15bd0efff3df..f4aa5bb3f2ec 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1041,6 +1041,16 @@ asmlinkage __visible void __init start_kernel(void)
 	sfi_init_late();
 	kcsan_init();
 
+	/* DEBUG CODE */
+	{
+		struct kmem_cache *c = kmem_cache_create("test", 21, 1, 0, NULL);
+		char *buf;
+		BUG_ON(!c);
+		buf = kmem_cache_alloc(c, GFP_KERNEL);
+		kmem_cache_free(c, buf);
+		kmem_cache_destroy(c);
+	}
+
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
