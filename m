Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC78C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6264920838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iun4E6T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgCCOdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:33:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729198AbgCCOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89Ze1It+GtPoLXw9gXBuQh65Mg9trWRIkcttx5v04pM=;
        b=iun4E6T8nnWqn7xTU7sn0q8lu3rPvu1Uj7OpU8MBa40gf82X+5IxE7rzGRYy3c237hXRgP
        9zMBhyOjP5Grqei1uv0jSSQlchjtEZ+q4FGBSkkMuXoW/+X+Vh+a7R0Lo/8UkY0tEq3Dou
        YLJRLJkjcPormJUfmY80Hh4gHpEUfhs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-ubznXLBHP_-fheYBmsSDFQ-1; Tue, 03 Mar 2020 09:33:21 -0500
X-MC-Unique: ubznXLBHP_-fheYBmsSDFQ-1
Received: by mail-wm1-f71.google.com with SMTP id p186so55160wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89Ze1It+GtPoLXw9gXBuQh65Mg9trWRIkcttx5v04pM=;
        b=fWzn9LtnBngCHRAihRsxuYLHr/hgEjS1inoJdhl/IOeKeyfGmov07L7Hf+Yx7/lU/J
         ozfrKXlpkWdOtopMv1lcvJ8Cq4DruYfgijW5p6rQCrT1+AE0cRJH6lHVhubQ9GGlTh3H
         Pk+8yhyM18jTFSRSPglxyeqZT5DUIi8xuQ+gpTeahuzkMrqkP1fa4tpqjagb62HLvkSA
         Ne02lqvooHLwUahWkMnY5smc60Mofbc5bXYKQKyM4zp8ydGMHVZbythEDbuxUR+TwuVj
         KL91vy/lC1nR6RIQVdLdq0RTC+M98YJOIgFxP9jNZZDqDMvFn9M9eIOjHl8uydSxIlUJ
         P2NQ==
X-Gm-Message-State: ANhLgQ0IqvL+AFT3i6HtKM9vAnuk6CTaUvZMBOCBwP2BAPJPXk8Zyi1Y
        RZOXjlqL0RVwZiuaMijyK6NjlQ4l0BM6Rt0wAdR1YN9bfNLLdEoXL0C0sBZs8hOoJL3YT/2y2Ga
        5SdxDwDszFQI6fWNnIgUsTUf9
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr4505871wmj.1.1583246000305;
        Tue, 03 Mar 2020 06:33:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuINeyCMJT4x0cTD7jAV6m0Gk8tTQJGisiIxOqoW5FQMhdO0tVh7STf4uEv41BsxDxn3roLAw==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr4505852wmj.1.1583246000102;
        Tue, 03 Mar 2020 06:33:20 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s5sm32248504wru.39.2020.03.03.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:33:19 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Bandan Das <bsd@redhat.com>, Oliver Upton <oupton@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: clear stale x86_emulate_ctxt->intercept value
Date:   Tue,  3 Mar 2020 15:33:15 +0100
Message-Id: <20200303143316.834912-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303143316.834912-1-vkuznets@redhat.com>
References: <20200303143316.834912-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
init_decode_cache") reduced the number of fields cleared by
init_decode_cache() claiming that they are being cleared elsewhere,
'intercept', however, seems to be left uncleared in some cases.

The issue I'm observing manifests itself as following:
after commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest
mode") Hyper-V guests on KVM stopped booting with:

 kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181
    info2 0 int_info 0 int_info_err 0
 kvm_page_fault:       address febd0000 error_code 181
 kvm_emulate_insn:     0:fffff802987d6169: f3 a5
 kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
 kvm_inj_exception:    #UD (0x0)

Fixes: c44b4c6ab80e ("KVM: emulate: clean up initializations in init_decode_cache")
Fixes: 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest mode")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/emulate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dd19fb3539e0..bc00642e5d3b 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5173,6 +5173,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 	ctxt->fetch.ptr = ctxt->fetch.data;
 	ctxt->fetch.end = ctxt->fetch.data + insn_len;
 	ctxt->opcode_len = 1;
+	ctxt->intercept = x86_intercept_none;
 	if (insn_len > 0)
 		memcpy(ctxt->fetch.data, insn, insn_len);
 	else {
-- 
2.24.1

