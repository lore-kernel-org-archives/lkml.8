Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561B9207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9K3tpS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgEWW6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:58:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388194AbgEWW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590274648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=Q9K3tpS5SyybAR/iL2Sn4G4mWKfGIAlWyf5Nt+j8KtGz+tu8jgTrX9T55zpI7SbtZYbYTP
        41S5B43wvRAh1d1foRFXAetybySxB6NazWOf5YcAN5XCm/9r/Xqt/sQIvGl0M/rvGNLL8k
        WYIAkVknjYEpRkQKJOrGQe7PI5Ixjrw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-JIuNfw6tPmq2OLxROtdudg-1; Sat, 23 May 2020 18:57:26 -0400
X-MC-Unique: JIuNfw6tPmq2OLxROtdudg-1
Received: by mail-qk1-f199.google.com with SMTP id 25so14791051qkc.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=pUoYmQ+faioiXjKjRgnVUwGh/CwdUitG+Syr6XqiEID0r8luMVTCzFYtTMngl5bFvK
         nftO2Du/fsfXbPtPMLG64HFYnAD77JeuvVDdM+bhtGHDLTw+QQpH5CuqF7vT9t1FLdKR
         zBQyTG6YD/PAftdYtEaXrhLPgOV+C3mir3zbN2idyC8QZmD2Ztok0zouGJK9F1O0KnH8
         Gee3TKodvITzXXZJ1Xdm78NB/tjCnIwskM6Zq0vomKcZW5XIP0B0XsREAIHuyKU4o3Fw
         QgSlnbAs54DjYs9vgOm3GHSzdZDnyBKM3quOer8OkqI8HcCbawviq9pJe8/3eRC382/q
         naPA==
X-Gm-Message-State: AOAM53191XoIaErMerHw0G9K/CQBuCynX0uT5W3QUFqzNicNyZ3oLHow
        oSsVnZTBnViWewe0eGYugPZsAKgXTasOFegGFUZeiDGDoyr6U0J2Cvn39joyQs0D/xILGbOXaiS
        kCjwDeA38BtaPO8IlSECzPhbT
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr20834529qka.320.1590274646079;
        Sat, 23 May 2020 15:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk0/uC8B8a7Tq4U8ojXgv1fjB5zAYPcx4kog7r+EwTz8hARNAN5kGXcMOQMIw85wA3tAKlkQ==
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr20834511qka.320.1590274645857;
        Sat, 23 May 2020 15:57:25 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w14sm11630979qtt.82.2020.05.23.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:57:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v9 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Sat, 23 May 2020 18:56:53 -0400
Message-Id: <20200523225659.1027044-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
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

Reviewed-by: Andrew Jones <drjones@redhat.com>
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
2.26.2

