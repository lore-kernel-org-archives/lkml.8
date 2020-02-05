Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B51C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860CD20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm1/w/b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBENmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:42:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgBENmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580910130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=63RqOoE/SUxs1bxyPTKTBeyS1B1iUtNQLL9J9vLKYh8=;
        b=Cm1/w/b8lLfgyIoa6+JBlgsJ8NSXb8TVyk7xhNd2uZIuZdV2pwDSSeo80/FJVa4BJhqCzY
        wX6tEY459yBdzvxS5fY0lPe5K2i53WfkwMx3dCJaHdLy7iKrrVz/7VaBbo2MzeZkFExArZ
        FBtt9ZMAwelSG6Y0Gu7lazCYgHbsXBA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-e3nCvyzEMJ-YICYjzf9Cog-1; Wed, 05 Feb 2020 08:42:05 -0500
X-MC-Unique: e3nCvyzEMJ-YICYjzf9Cog-1
Received: by mail-qv1-f69.google.com with SMTP id c1so1472109qvw.17
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63RqOoE/SUxs1bxyPTKTBeyS1B1iUtNQLL9J9vLKYh8=;
        b=g6mCl0b0rI/R77sPLaXDlAQjUK6YXlUOkWHquopZywENWVa4qcZxzEQPnZD/xcOb4h
         5kf5nTApaY4cklr3YJGCJ/GZ5DczDVN0YHTf5HEE0aI3b9Y1K+C0dpHvrbemVDLtI7Px
         PIjDkZ2T+0HX41cCDt769rb+coWjagXF+GLDlJCL1+mWO8WIOCYPfoAtpuwEIoFKta9n
         vBO5eYb1mvtKlhCpdrYQozbTXyQh2ivFtjlDbw65nQoWK3GMhpEGo76mZWgkJvaZLLv5
         uaKDHq/8SPJN3HWJGqwXYz/iw9wwgL9yJLgNWP4eazSaTLdCUCu0a+ZWxw7pIgRyvITj
         D0Aw==
X-Gm-Message-State: APjAAAWtCvNJVpam+0nzV3Xvny8T9VxGNKEGDzvbOoYfioxZA6EmTGsF
        22zi/mH2+C0JMC1vr9CesWC+3nNavfRxcWMEf/P0MhJ15l/H5FvSbTN/BPGJueEHxYdTxYL/EB/
        /kLZSn5jrMwCYZHgJENK2Qq7M
X-Received: by 2002:a37:d0c:: with SMTP id 12mr33423425qkn.464.1580910124622;
        Wed, 05 Feb 2020 05:42:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZ/1/Sty6fHl96Q69KjRb0mE9NhGj48HPjM78jNDpEMNN3g2vmML86vdJ+YqD/niUHe9OAuw==
X-Received: by 2002:a37:d0c:: with SMTP id 12mr33423403qkn.464.1580910124353;
        Wed, 05 Feb 2020 05:42:04 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id g62sm12797091qkd.25.2020.02.05.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 05:42:03 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] KVM: arm/arm64: Fix up includes for trace.h
Date:   Wed,  5 Feb 2020 08:41:46 -0500
Message-Id: <20200205134146.82678-1-jcline@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedora kernel builds on armv7hl began failing recently because
kvm_arm_exception_type and kvm_arm_exception_class were undeclared in
trace.h. Add the missing include.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---

I've not dug very deeply into what exactly changed between commit
b3a608222336 (the last build that succeeded) and commit 14cd0bd04907,
but my guess was commit 0e20f5e25556 ("KVM: arm/arm64: Cleanup MMIO
handling").

Fedora's build config is available at
https://src.fedoraproject.org/rpms/kernel/blob/master/f/kernel-armv7hl-fedora.config

 virt/kvm/arm/trace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 204d210d01c2..cc94ccc68821 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -4,6 +4,7 @@
 
 #include <kvm/arm_arch_timer.h>
 #include <linux/tracepoint.h>
+#include <asm/kvm_arm.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
-- 
2.24.1

