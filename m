Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72DA205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZZutium"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGHTfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:35:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgGHTe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594236866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=EZZutiumfZvzjn8RNVzxfEF1kJWBMpFtWLqRLUsS3202EJ6HmvJ+Ec6dxwlMkXM8p8HCIf
        0LQ3YHiqaC8nlkW/9sIlrQ937GoSkQc2I0xDpkmKCU14iRuekzUM2SSnTLyrHZewmGqnhw
        GjF35iN4klQ4fSuOMYNf7rByrJitPOg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-K4snakq7NXCe2woiy2Teiw-1; Wed, 08 Jul 2020 15:34:24 -0400
X-MC-Unique: K4snakq7NXCe2woiy2Teiw-1
Received: by mail-qt1-f200.google.com with SMTP id e4so33942962qtd.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=M636sUx7VvPulaPkkGHJOpLzNwrBJ7KX9LHcQJ4OpPvEfuwJ8GRU7aaYp4VwxwmkfX
         bDLoqmAXj5hKfIY4MVnKZEzZ2ENA2+giUCh1jTMWqHRLx5sXPtWbLJb0FfM4zx+ISKfN
         yv9SUHcHCNy8ob0jn2vv0SLZCXKEurV41ylDUcBSW4EuLoZztZT1/dK1Hy0Fh5I253vA
         UgmWOo6BM/uE3HDYwPdqBgKji9gDVTuM4TBfDOAr539XdXGP2fNXgrb8eZecUQlp/vvW
         cjC7hnsym2PE8Eqd4KoXrf0YdvlAPgT3tAhLE8Z0BFYX9DW1nfY9o0Bj5HpUKNUzH/Qu
         slyA==
X-Gm-Message-State: AOAM531YXUA1VsQ20+KWxA5/lXdTtmPNC3dG4tamETyRYJ3B5yczRDTj
        6yuEZFKmJNksf2JaySxJ1T1+tT7bpxaUN+xiIrEeemr9DGSJNtZ16J1ejjDz+l+ZfDsUPF8WVa9
        YlUvHVURRUWpUqGhLFWoXjUa2
X-Received: by 2002:a0c:f007:: with SMTP id z7mr12358708qvk.7.1594236864410;
        Wed, 08 Jul 2020 12:34:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNudtqF/CkjxEg9VqtYEqf+ZZpg4k8TSXkm0fMX6iXRSwsXGO5WKceDC9wqDsQaRDfMvt/OA==
X-Received: by 2002:a0c:f007:: with SMTP id z7mr12358695qvk.7.1594236864170;
        Wed, 08 Jul 2020 12:34:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id f18sm664884qtc.28.2020.07.08.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:34:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 07/13] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Wed,  8 Jul 2020 15:34:02 -0400
Message-Id: <20200708193408.242909-8-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708193408.242909-1-peterx@redhat.com>
References: <20200708193408.242909-1-peterx@redhat.com>
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

