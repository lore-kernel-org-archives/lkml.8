Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F87C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCD020734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVyS7kkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgFJPo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:44:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728020AbgFJPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591803896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uLvH8zEFZY1KRuBInn1TdRSK/ogUjKzscMti6QJ2sY0=;
        b=ZVyS7kkpyM1Z9oG/ek8ZD8c5GPO7OeIwu5QKPDNLrcHeF1mBBgTAnP1ZxxI2cpIVcXASdY
        KXXsOuL416BF+RhNG/4tMGKPP+fPuuV2gHqtdzqGis9b83tnLYITwGeJc++BeHZuPoqn4K
        1mNTgbl9+irEH2Yifl39gt0T0B7B8DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-6-x7pXxcOiCHHVYqISxEdA-1; Wed, 10 Jun 2020 11:44:50 -0400
X-MC-Unique: 6-x7pXxcOiCHHVYqISxEdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A3F0107ACF5;
        Wed, 10 Jun 2020 15:44:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2115D9D3;
        Wed, 10 Jun 2020 15:44:48 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest: runner: fix TAP output for skipped tests
Date:   Wed, 10 Jun 2020 11:44:47 -0400
Message-Id: <20200610154447.15826-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the TAP specification, a skipped test must be marked as "ok"
and annotated with the SKIP directive, for example

   ok 23 # skip Insufficient flogiston pressure.
   (https://testanything.org/tap-specification.html)

Fix the runner script to match this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 676b3a8b114d..f4815cbcd60f 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -77,7 +77,7 @@ run_one()
 		echo "ok $test_num $TEST_HDR_MSG") ||
 		(rc=$?;	\
 		if [ $rc -eq $skip_rc ]; then	\
-			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
-- 
2.26.2

