Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C084C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEE3206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNKVBW/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgEDTFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:05:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgEDTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588619131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qIVg0JQeyCu7kn+dY+lPaTgPQT/NdBxPgGWYbUJIIXA=;
        b=RNKVBW/kf7N18LPuDJNpGkbK9WE5VtNg0xVlxj1q4mBz8Z2Wwy39VN83wxFqrrwh0omSZ+
        +lX7zlbBu6BogIXPURUhAtkGJ42z5lfG0DO7TA7Vml21aMeDDRxoJFpOmN/OGgCIBMV3LW
        LErSltT83vlvN/kmg1Fu9Iu4abS1L8Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-V6PG8ecQOqGs8JRyPorgbQ-1; Mon, 04 May 2020 15:05:29 -0400
X-MC-Unique: V6PG8ecQOqGs8JRyPorgbQ-1
Received: by mail-qk1-f199.google.com with SMTP id i2so356809qkl.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qIVg0JQeyCu7kn+dY+lPaTgPQT/NdBxPgGWYbUJIIXA=;
        b=V7m/KfAmV02Y4I0h9/O13AJKWvWrT2pd3YXDUu7Z9r4s0LDVc2Xe6K7nSJjKLd0VbQ
         hUv/AxWk9CO5+jJKPyMFasvkuDwYVaIWA3RzOb111Umpu/GrIq4Iv2NhWGGS8B0rdVah
         4BEJIO4QN/rnanGKxdAS9jzCDEWKsX+ufesUWZ9kbmXKkrjVpRM86maYBgTmJ8rEQUH8
         RDIuPoFop66bsq75wiXEiA2QJbwpVasqneB0l9aoyzxXtlZDjfibR9ytqr8juSjHvDbQ
         8y++KAoBiqmfnjuJ8MWlB1A4tMOejltyXlj8MmbGKr2DP7J//Dcn74r6R1uGcFksffp1
         5aOQ==
X-Gm-Message-State: AGi0PubNvnYOzJrNdPc/EEU2o9Z8dz26VvB3nkbVb0e5G02lGXeuu7H/
        U5j/ymCe5+Xl6U02IohLk6FhnaTfH/BrLsJXLlEtrOGoL3eL6Rpza6CPi9BAlGcA/XeZtvl0qcG
        viqZJgAmDdmGUF5BYWGT8nXSm
X-Received: by 2002:ac8:44d6:: with SMTP id b22mr640165qto.366.1588619128934;
        Mon, 04 May 2020 12:05:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypICFt1DWmxwrFZqvsi6oraH8Ztk1a0hOa6r+UUKVpePo5HU+yUDiugMPSKG00KJ7y+T26omxQ==
X-Received: by 2002:ac8:44d6:: with SMTP id b22mr640146qto.366.1588619128682;
        Mon, 04 May 2020 12:05:28 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p22sm12111549qte.2.2020.05.04.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:05:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com
Subject: [PATCH] KVM: Fix a warning in __kvm_gfn_to_hva_cache_init()
Date:   Mon,  4 May 2020 15:05:26 -0400
Message-Id: <20200504190526.84456-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 10.0.1 gives me this warning when building KVM:

  warning: ‘nr_pages_avail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  2442 |  for ( ; start_gfn <= end_gfn; start_gfn += nr_pages_avail) {

It should not happen, but silent it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 74bdb7bf3295..2da293885a67 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2425,7 +2425,7 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 	gfn_t start_gfn = gpa >> PAGE_SHIFT;
 	gfn_t end_gfn = (gpa + len - 1) >> PAGE_SHIFT;
 	gfn_t nr_pages_needed = end_gfn - start_gfn + 1;
-	gfn_t nr_pages_avail;
+	gfn_t nr_pages_avail = 0;
 
 	/* Update ghc->generation before performing any error checks. */
 	ghc->generation = slots->generation;
-- 
2.26.2

