Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB515C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4893207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv8zH9fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgCaTA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:00:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726295AbgCaTA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585681256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBeZgqbPS2/FWwO6pnXFu0eVYzKmasr03QOYT6AICyE=;
        b=Lv8zH9fMpE9BoBZ43Z16Uf0OhiydA6QPwvoTBXqJT+9Noqy98wNuC4oAxkHBVl808HjQbq
        W2TynUKfHMiH98FBcin5xayD4dQuzWCoP3IjOENUpjNYu2cckN0gdolGc6bEtssbqVaU5V
        acbncmzhE3sriRBHkDu+ox87ItRE5rY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-nTMZ8eo5OFiOSGcIZOdAEA-1; Tue, 31 Mar 2020 15:00:55 -0400
X-MC-Unique: nTMZ8eo5OFiOSGcIZOdAEA-1
Received: by mail-wm1-f72.google.com with SMTP id s9so1451505wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBeZgqbPS2/FWwO6pnXFu0eVYzKmasr03QOYT6AICyE=;
        b=KO9X+uKXGDnx3BwdUKdnmeT10TKhubVyf2tC2KYVXe7oXqhQXl8M7Xrf1Rhq+aP5UJ
         /Non9OFxG4N8DnJYk86HDPFu8bfxYFmGwxMHSHSwJ/rvoAxe5ebG843ANhhIj5/gCAQ2
         QgnWsD8EPybUX7hR9ceZrUdsZykpyU+cm4cYan3sxolzZmVVUgT8icJZJHIrsIEB84Nh
         s2j+G17VSTFJdCYr/uycygO3armkW4m1xHcgRjlJspunCeNbV5qDY5jjd9C/UPxmJuEh
         blcvbLQkyYAE9Fmt+nuNX21bAC0qMJcP08pXh2YPJruiJCOdaY9snJ6591VW3z+xozC5
         +gHQ==
X-Gm-Message-State: ANhLgQ1IseNTnp4IpD1ukL2YGcBggl4U1cPeIVpNrJk0MS7UQ9gGiqNM
        BJgwlXBagcIb38i0EHthCPRjWXg8edyrzEzXVfzAoSXe+C3IMzD/+hL9uxKqMramU4Xi2bOesOr
        uUqhV/h9Rqo5QIEliy9to0tWK
X-Received: by 2002:adf:ed42:: with SMTP id u2mr23267922wro.175.1585681253676;
        Tue, 31 Mar 2020 12:00:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvw7dspAUr3v867wOvqD+4fThISVCr4cOSo/0L9hQFvFTZpAQC3J7Z80h0Sz8FhZoplTN5kdQ==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr23267898wro.175.1585681253504;
        Tue, 31 Mar 2020 12:00:53 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o14sm4882863wmh.22.2020.03.31.12.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:00:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v8 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Tue, 31 Mar 2020 14:59:54 -0400
Message-Id: <20200331190000.659614-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331190000.659614-1-peterx@redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
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

