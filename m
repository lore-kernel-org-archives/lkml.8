Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1FC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C71121556
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg4o3CZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgCDRvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:51:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388362AbgCDRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=Tg4o3CZOGfdDkyvsCDIcBOP1k+Vm68feVkewYLavE4pdGN3IOEslZ3HZ7GOWNOJTuefQeB
        fkOUTiAMvrt+Jut8ewpEXXFi17d136rJrHsNUK2JG/zEy4eAFwo7wYBktxjM+0tq4MSvN7
        bdIBSKip5FOTk6OLa72LkbGATN8ZHfg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-WejweCkwPF-XUxL2c8nDSQ-1; Wed, 04 Mar 2020 12:50:18 -0500
X-MC-Unique: WejweCkwPF-XUxL2c8nDSQ-1
Received: by mail-qt1-f199.google.com with SMTP id i6so1996522qtw.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=XBenmaCR4lwOWYhwU0PMScEFg/LMLtlN56fIhBP2mWxvOrDYgFtWkbyE5LdknbJmP/
         Ru4AA6w9VPM7kOamRO98HRTaS1qrIRnbRHHA8GTEFeYIfwMSytUn1927eE0gjZqq76ZL
         QnwSo0HtDgPk74bq87VQXh2aBwhIAVsk1H2Ilyy1h/6nMqBQxsx6YDcg4a4aP3rk2/bg
         yDyEMRnSncX5tIBNrGro6L6T/12wGbMv1yawO1L5t+mW0xKriAS4OJOkXcHqKV+kViuV
         JyGkdRxuiXuAGPnHt0//Y08v7Uefbm/A3ACoK9Q5meeAKXtrZak21GiNOFurlnTOYmt/
         UK1A==
X-Gm-Message-State: ANhLgQ17aodLs9yvuE71MEAIwOIo8nkFcNRo7HVAQmjuvq1u+od+BgTN
        TAZFe0IbEz8BQloeZi/rDej/myL1MvLtCLf7B1CFFxoys8Wysr/qaokf936nU7/4MjOVQQpxR0J
        8f74G9NQYOBck068WiRRhhSPM
X-Received: by 2002:a37:9f41:: with SMTP id i62mr2368534qke.494.1583344217746;
        Wed, 04 Mar 2020 09:50:17 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv/meqIN9VvRgDGaOSnYRmOfW3WetEnPx5O2ltnwdaLHNa8jtllNzbEA8f3VK/mpez14DTlpQ==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr2368502qke.494.1583344217516;
        Wed, 04 Mar 2020 09:50:17 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i1sm9033276qtg.31.2020.03.04.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:50:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v5 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Wed,  4 Mar 2020 12:49:41 -0500
Message-Id: <20200304174947.69595-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
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
index 5614222a6628..3c0ffd34b3b0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -197,7 +197,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.24.1

