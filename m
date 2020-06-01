Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6888C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7732074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy30+Ojp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAMA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:00:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgFAMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591012820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=Xy30+OjpWBHGrOyuSl10nGmcpqXLCAMApAgxUDLE/UoBBFJ4m/mAuw8RGoZ596xcmarrSc
        hrovQLcrhKSmQj1rrWg3FMA9u9huwsvBXCr48g+d9evOg+uhOF1WiPhwCPmgjqtAIVRhJw
        5rCNubr2+CEjT4cptnZKJ+lCFk0rH8s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-YWOwZY4PP6qDhenUOV4gGw-1; Mon, 01 Jun 2020 08:00:19 -0400
X-MC-Unique: YWOwZY4PP6qDhenUOV4gGw-1
Received: by mail-qt1-f199.google.com with SMTP id w14so2495627qtv.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 05:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=F+k8k37XMjkGySQKNSZYt527UTOWG09jrw/Df0lC6phJNk85ehqArSATQuW8YxIiuF
         mXxv1Rqma9NTUxiK4fML0HpnbVQflTi25wJDdpIi6szgbOuC4Yn5xgs8E6Ej4Sz74/BB
         izuYELoE1oU95gN6P3MRPWWVLXE53YdgQ2ZgHZIYLH+60qeeF/SzCRg7Qe33z/l7bzaw
         pU+wJFPLb1/Qh+RG0mDf+8G4qGfv6Ed6Xq/iAEvGF5kYZmi0CK68w9Kmb6MwkDDgKjj/
         U95T2itqPXdd51j7aLcNZe/PGe/O5ydWgmeV/9KanqjgOUnHfukM1Avtp6HiRaXlBhve
         cAGw==
X-Gm-Message-State: AOAM532s4gBbIHucOJ4O4Gw4DZnoGWxaMmK1CN70xCUbstZ98re/av7G
        CaR0fD1nYo8q37vvQ4Pg+B8swh9Xeh35IBRUcgCU1KM/PmDLpCdTnbKgvq7fnnkB4G4C4v8jsyc
        WeO0PdMA9bO3TP+lkUDbFg9cJ
X-Received: by 2002:a37:812:: with SMTP id 18mr20383586qki.296.1591012818016;
        Mon, 01 Jun 2020 05:00:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl3klJycwFuEZEHpAXxHeBS9I7YZxgbj0iq08iHaZTYo1YjLTWu1gRzD+mC6kfDz211XgKFA==
X-Received: by 2002:a37:812:: with SMTP id 18mr20383551qki.296.1591012817625;
        Mon, 01 Jun 2020 05:00:17 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l9sm14474185qki.90.2020.06.01.05.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 05:00:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v10 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Mon,  1 Jun 2020 07:59:51 -0400
Message-Id: <20200601115957.1581250-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601115957.1581250-1-peterx@redhat.com>
References: <20200601115957.1581250-1-peterx@redhat.com>
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

