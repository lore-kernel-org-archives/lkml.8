Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE0520737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664188;
	bh=8uZj89EysRnr7CDvLiuKG1OmXk9XZZAADOB7HSB/dOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJ5gsf9a1rpAD1/sd9ZtA/NL8kFrRIP6Ujvr1SzHQcUy7oenUtVHy3Og5m7P8B88P
	 7tU1pdQwWD/umgb9m7h6/hVUN+FW2KLgReeGrV78kVe1RlTThAIMQKqKR9+oD0Sspy
	 Hn84IkY8gS/9b+2xpRntVzdKFH6X1u0y0pbmod00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgFHXJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgFHXHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5379720842;
        Mon,  8 Jun 2020 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657674;
        bh=8uZj89EysRnr7CDvLiuKG1OmXk9XZZAADOB7HSB/dOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xue1XR5Dgm7LLZtvscZR7J4GY9ok7bWoYfifSdpv9JJl4dEjwVKGfZkmmSuyoPNK6
         92igR8nQWirt0qMUMqpFHj30c0CSvBK0LEvv2qEf9BHN+PEk39YO4V+N8qtLUn+8Vh
         wsSoEop2iN+ICmkg8a9gQXVyseZyzSGfHP8Rb7aI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jon Doron <arilou@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Roman Kagan <rvkagan@yandex-team.ru>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 082/274] x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
Date:   Mon,  8 Jun 2020 19:02:55 -0400
Message-Id: <20200608230607.3361041-82-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Doron <arilou@gmail.com>

[ Upstream commit f7d31e65368aeef973fab788aa22c4f1d5a6af66 ]

The problem the patch is trying to address is the fact that 'struct
kvm_hyperv_exit' has different layout on when compiling in 32 and 64 bit
modes.

In 64-bit mode the default alignment boundary is 64 bits thus
forcing extra gaps after 'type' and 'msr' but in 32-bit mode the
boundary is at 32 bits thus no extra gaps.

This is an issue as even when the kernel is 64 bit, the userspace using
the interface can be both 32 and 64 bit but the same 32 bit userspace has
to work with 32 bit kernel.

The issue is fixed by forcing the 64 bit layout, this leads to ABI
change for 32 bit builds and while we are obviously breaking '32 bit
userspace with 32 bit kernel' case, we're fixing the '32 bit userspace
with 64 bit kernel' one.

As the interface has no (known) users and 32 bit KVM is rather baroque
nowadays, this seems like a reasonable decision.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20200424113746.3473563-2-arilou@gmail.com>
Reviewed-by: Roman Kagan <rvkagan@yandex-team.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/virt/kvm/api.rst | 2 ++
 include/uapi/linux/kvm.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index efbbe570aa9b..750d005a75bc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5067,9 +5067,11 @@ EOI was received.
   #define KVM_EXIT_HYPERV_SYNIC          1
   #define KVM_EXIT_HYPERV_HCALL          2
 			__u32 type;
+			__u32 pad1;
 			union {
 				struct {
 					__u32 msr;
+					__u32 pad2;
 					__u64 control;
 					__u64 evt_page;
 					__u64 msg_page;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 428c7dde6b4b..9cdc5356f542 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -189,9 +189,11 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_SYNIC          1
 #define KVM_EXIT_HYPERV_HCALL          2
 	__u32 type;
+	__u32 pad1;
 	union {
 		struct {
 			__u32 msr;
+			__u32 pad2;
 			__u64 control;
 			__u64 evt_page;
 			__u64 msg_page;
-- 
2.25.1

