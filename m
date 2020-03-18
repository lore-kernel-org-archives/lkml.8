Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD5BC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626DA20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrvD+qe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCRQiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:38:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42985 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbgCRQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584549501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBeZgqbPS2/FWwO6pnXFu0eVYzKmasr03QOYT6AICyE=;
        b=BrvD+qe0hadDO8XJGCEXr3lp7yDQfvpJPVvA7FAoKI3Ykd8UcOCEVoVHHgwpEOODceHnCY
        3NvYQmz15EpUcpFaDGzXjB+YzIklZnvZy/7Ssh9u4YtfpB5g1t0F8NkIRn8WH1d7xEwdUc
        /EkgbnNKFeoxwvFXbYp1AfZooc7txig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-jrHatUA9MtOldEpq8f9-0A-1; Wed, 18 Mar 2020 12:38:19 -0400
X-MC-Unique: jrHatUA9MtOldEpq8f9-0A-1
Received: by mail-wr1-f72.google.com with SMTP id c6so4797811wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBeZgqbPS2/FWwO6pnXFu0eVYzKmasr03QOYT6AICyE=;
        b=tYywbU46X6tAvvchwbV6KkZ5CKzXqMMVnc17rf/64UthUZ0qrTDRL3RCuM5svptG3x
         quo8o1dPfFajYg1VB7rnm+Tx1Xh3gZq0VB6EstGX1jCQa1PZfPEcKcN3O7Q6lpH8Hx4i
         L2J50zjljTIU7UugSEaRDo6KZRsxxBz0w4YRvszpm5y1DH2wbFMqyQaoA7lEu84X6sVH
         IJAlLIEwoI43a0cwUbOFkLHkTzbqX04eHNmk1yRyo6Mskk/yz50Qcllblo1ZBHYcupGT
         cwEUr815XOsNWBhpH/slT92yukF1GS+26XMgRV/niOe1oeue9qPkefa1aBLJUAmf4Rsk
         0bQw==
X-Gm-Message-State: ANhLgQ2kTwqgVtk1Wumw4WJ7xd0q4HPX7Q6300VOyP6LQcEBE4Zcs1QF
        ofv/70p1CxWI46I33N2wAPHqKjZPZShQaiSqb7grILhcwRus2q+zR5KzDUnzeoXuSp2QK6QqBPD
        5w7h/Kek1wqryo2B1CgFvWqaA
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr6026856wmb.8.1584549498515;
        Wed, 18 Mar 2020 09:38:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMbNQOZ8x4s2gAGCZo/Ub+NqkNSMuzSEwLKiCLLTztaQdqlgzxMsvPJzHW3MD5qsvUjUfoVQ==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr6026767wmb.8.1584549497366;
        Wed, 18 Mar 2020 09:38:17 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v26sm9889715wra.7.2020.03.18.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:38:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Wed, 18 Mar 2020 12:37:14 -0400
Message-Id: <20200318163720.93929-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318163720.93929-1-peterx@redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
clear it for us before copying the dirty log onto it.  However we'd
still better to clear it explicitly instead of assuming the kernel
will always do it for us.

More importantly, in the upcoming dirty ring tests we'll start to
fetch dirty pages from a ring buffer, so no one is going to clear the
dirty bitmap for us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 752ec158ac59..6a8275a22861 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -195,7 +195,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.24.1

