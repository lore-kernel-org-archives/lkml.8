Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7C3C3524B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81412082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArsDTZcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBEC7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:59:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727987AbgBEC66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=ArsDTZcn7hPrEwfmlbPv9avqYvR6lJHyK085RkuXkmGD6bfAzf/kQ5fJZgJmwUGkGiv1uK
        9ZDn7U/z3Lml/MQMy59M/3gFDTjw9P4b26cbEEb3zo0tjZ8IIUc+FT90RDAI3hZLeTMKLk
        D/I/SyzcjILbISzcbPB6n6iEqqD5WxM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-0azc1zi0PGa3i7lXOrr6UA-1; Tue, 04 Feb 2020 21:58:55 -0500
X-MC-Unique: 0azc1zi0PGa3i7lXOrr6UA-1
Received: by mail-qk1-f199.google.com with SMTP id m13so406774qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=L8J/IHTWOnA6t2TbU/7rmGkw442f6dQieK1IgbxGAjBAdB0XM/5+eq6mOQT8QgMV6R
         cXQtnz6d1SG0fuyXBQ+Qy+pb5EK/vrq3SR2wlZnu+fT3WEKhIcEU+hNmDuh9MNEoM/RD
         Xs+I/FuS30uYCMY8pGaxWj4k65h6aP/KG5k0AopREeu+Yp8A3+YmLDkm3FcjYKvHsq1v
         HH5HCu+6Hk0kVrr0HqBrDTKjq8hnna/VRxV7po+iZ+5j8wMoqa8FAP9+Q4K4wX7Yimwg
         bi9TxwgaYk0YQX+jSOS2V/F+bQDKMm38AExAbs5ljOT1BzMzPRxtnUmU2Kis/VfCb2yx
         kX4g==
X-Gm-Message-State: APjAAAVzqNSZSnVFFcS6yXlU2nxW7l88czbeRj9IUV4kimRvKDo4hy60
        hyFq29ORXesZzwsK7bbhsd+kRwi9szkBqIYPtngkXIzjRGoo3DqaX0wqTlRffb9e8B6oEEo+VJ3
        U2LTaLF7LTNw/jdmJ5D37qORw
X-Received: by 2002:ac8:8e7:: with SMTP id y36mr31638485qth.26.1580871534554;
        Tue, 04 Feb 2020 18:58:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBrtfjh/WegxUDnL0gSdyIHl6hW1ZsZRs5d/otM4voagMpbjCc/TQ+O2fujc/H2QcwMgpFTA==
X-Received: by 2002:ac8:8e7:: with SMTP id y36mr31638473qth.26.1580871534337;
        Tue, 04 Feb 2020 18:58:54 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm12961649qtd.45.2020.02.04.18.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:58:53 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, peterx@redhat.com, kevin.tian@intel.com,
        alex.williamson@redhat.com, dgilbert@redhat.com,
        vkuznets@redhat.com
Subject: [PATCH 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Tue,  4 Feb 2020 21:58:36 -0500
Message-Id: <20200205025842.367575-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025842.367575-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
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

