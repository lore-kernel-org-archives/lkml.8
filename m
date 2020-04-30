Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51318C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31636208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588263590;
	bh=vXe/HdnbSuZfJl9OidYv3Q/hs+GyVRE+klxJQ69rx54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jk9BhnGvGSNptiO8gA/MnMrVYFXemAWC1f+zos3DF+q27bB+9mMpsvvc4+/K+AQsQ
	 pvblHccx6wU7sBf1s1ezFXVjNL1QaYUbozBrdiZB/b3ZfPJmjl7BfIBZ5yvb3gj8Fg
	 2HYmu0LmBWr80+qqBreE08UBHCm9H/HOHAvG50XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgD3QTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgD3QSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261532495C;
        Thu, 30 Apr 2020 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263518;
        bh=vXe/HdnbSuZfJl9OidYv3Q/hs+GyVRE+klxJQ69rx54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtx3SnHRHrNTNhfhf/04l0NCxiEXknPK2Y0GvSr1HfNNbhpY9CHlVFIBFPRDW91zJ
         gjEjLrax6+FHaoCaZe0LF7DPDdhp5+rLZAvuL0dnYmprsIpMz/DZQ+tuz/GUo1HQ7b
         8ceo1n9nyAthKiPwlMWed6E+M04fImfODWeHXCZ8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00Axi1-Dy; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v4 18/19] docs: kvm: get read of devices/README
Date:   Thu, 30 Apr 2020 18:18:32 +0200
Message-Id: <83e4aa5a0574babcbce0a3ed8b4242cf1c8faa3b.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the information there inside devices/index.rst

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/kvm/devices/README    | 1 -
 Documentation/virt/kvm/devices/index.rst | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)
 delete mode 100644 Documentation/virt/kvm/devices/README

diff --git a/Documentation/virt/kvm/devices/README b/Documentation/virt/kvm/devices/README
deleted file mode 100644
index 34a69834124a..000000000000
--- a/Documentation/virt/kvm/devices/README
+++ /dev/null
@@ -1 +0,0 @@
-This directory contains specific device bindings for KVM_CAP_DEVICE_CTRL.
diff --git a/Documentation/virt/kvm/devices/index.rst b/Documentation/virt/kvm/devices/index.rst
index 192cda7405c8..cbadafc0e36e 100644
--- a/Documentation/virt/kvm/devices/index.rst
+++ b/Documentation/virt/kvm/devices/index.rst
@@ -4,6 +4,9 @@
 Devices
 =======
 
+The following documentation contains specific device bindings
+for KVM_CAP_DEVICE_CTRL.
+
 .. toctree::
    :maxdepth: 2
 
-- 
2.25.4

