Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAA3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A36F20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz6RD/qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgFWAQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:16:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731555AbgFWAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTIfD+5tCBwAWNOi72btfXnK7DLTQdOMYtdNacQ/2Bg=;
        b=iz6RD/qw2xUGiYgZ2LL6zkwOk/ikNHOisgKK4eWb/DmL7EF3craTpRso8vTYwmB0LLE6OT
        NpFzcb6tAXeLnWrrPLRk7XVxqfrUIvIB/nqVmauYSiVxVQhiFEWLlU+9ImkD3DbtrMv6sY
        QtdJbEkE+UljQNp6ll2G4qOxm2c8EaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-t4J6rWs7PQmwDy_Rf_LD3Q-1; Mon, 22 Jun 2020 20:15:53 -0400
X-MC-Unique: t4J6rWs7PQmwDy_Rf_LD3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325041005513;
        Tue, 23 Jun 2020 00:15:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8E8D60BEC;
        Tue, 23 Jun 2020 00:15:51 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 6/6] selftests: sync_test: do not use ksft_exit_skip after ksft_set_plan
Date:   Mon, 22 Jun 2020 20:15:47 -0400
Message-Id: <20200623001547.22255-7-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
than planned.  Move it before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/sync/sync_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 3824b66f41a0..414a617db993 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -86,9 +86,9 @@ int main(void)
 	int err;
 
 	ksft_print_header();
-	ksft_set_plan(3 + 7);
 
 	sync_api_supported();
+	ksft_set_plan(3 + 7);
 
 	ksft_print_msg("[RUN]\tTesting sync framework\n");
 
-- 
2.26.2

