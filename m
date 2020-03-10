Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB5C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C40F24673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoBYCttk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCJCvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:51:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33683 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgCJCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583808676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=X5rRvUDvsTgQao4JkzzYjt+VB8uH8OR/+ZrMMAk7Ask=;
        b=AoBYCttkx7lbB9Urg7zaLxLZaiImkuSYobuIwod3leoa5/YQce4642vLaRCt51isL532Fo
        1oKsXix7g4EATgqIIgWB51lksGzlKtZl9MlwSsBhLprJglAuhdXe7jUSgcU7Za9+g+Sz2x
        l7+t6HuJ/tgfCpHJEt70QbFVjwqSvtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-6H4BNnzzOGSeQ8-6mYA9tw-1; Mon, 09 Mar 2020 22:51:12 -0400
X-MC-Unique: 6H4BNnzzOGSeQ8-6mYA9tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62495184C800;
        Tue, 10 Mar 2020 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.gru2.redhat.com [10.97.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 863605C1C3;
        Tue, 10 Mar 2020 02:51:07 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sean.j.christopherson@intel.com, shuah@kernel.org,
        tglx@linutronix.de, thuth@redhat.com
Subject: [PATCH v2 1/2] selftests: kvm: Introduce the TEST_FAIL macro
Date:   Mon,  9 Mar 2020 23:50:58 -0300
Message-Id: <20200310025059.9301-2-wainersm@redhat.com>
In-Reply-To: <20200310025059.9301-1-wainersm@redhat.com>
References: <20200310025059.9301-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some tests/utilities use the TEST_ASSERT(false, ...) pattern to
indicate a failure and stop execution.

This change introduces the TEST_FAIL macro which is a wrap around
TEST_ASSERT(false, ...) and so provides a direct alternative for
failing a test.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a41db6fb7e24..903a7576d0e1 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -39,4 +39,7 @@ void test_assert(bool exp, const char *exp_str,
 		    #a, #b, #a, (unsigned long) __a, #b, (unsigned long) __b); \
 } while (0)
 
+#define TEST_FAIL(fmt, ...) \
+	TEST_ASSERT(false, fmt, ##__VA_ARGS__)
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
-- 
2.17.2

