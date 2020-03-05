Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D00C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E08220726
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsKwVdNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCEShg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:37:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgCEShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583433453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yAqQBw7q9t4PgjjslG8SKuDvnBf92v/kO5v+bREuIJ8=;
        b=QsKwVdNig4WhDoGRSAZ9fExtP2Rf+hAS3lG6zWo43eDdMPdkCIZ6IiLjgP3wD0e4RM5b8U
        NtrVWUbm+0IE5xr8OplUGLoHJ3kyblxRTCEVBVKGOE5cAmtVWqoylr3i6dKZdbd2FaDHky
        TUZTM5B2GVa4dmIrvMT9gXC/6gg5FG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-PFnlk863M8y1SbTibzO61g-1; Thu, 05 Mar 2020 13:37:30 -0500
X-MC-Unique: PFnlk863M8y1SbTibzO61g-1
Received: by mail-wr1-f71.google.com with SMTP id w8so2625148wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yAqQBw7q9t4PgjjslG8SKuDvnBf92v/kO5v+bREuIJ8=;
        b=l7PxWEsg2wL1jB0gUfJ69mNB9do4O7/meG2uQKt57NF/XoopNCC8Ajwu/oI/51e3dv
         f2voKOAw6UTqBC5DfUgeWRNeDX6VxHY0aRqomZUds6tc275XrNA0cr/hAZ72rSOazVOg
         Ht52bassLMxsmlHjlhZFghd1kt2tz42tGBGyjECFW/+1XQWik9D+H2XxUsGo5Fnvtgng
         at6k6jD0FoOfhC+n2vaMgJtx8LUvWCK1k1XMj1PcvYMSDI93yxkdrzq1nVU7P0biOWxZ
         sUdO+zjcOUrLbuDQkO3h1bs8Fj+w0jZKaNBxEgtdMkOtM+SMlQzImlNEJUpDzX+Y+Bmy
         vPSg==
X-Gm-Message-State: ANhLgQ3YyHHOB+IogCWP17TFuOK/QgNkXrS+l5c3N6ky7RP9jPHmJlb4
        i0+5DDCpdfSaXLEa2pz8/XDjP/xDZnhDPSZbbM/hSLiYrZbJn2AV61xkcFzANRLiHr2XrpyvWPK
        lloAc2Y1P/wpB7hempJZ1r6bd
X-Received: by 2002:adf:94a3:: with SMTP id 32mr296962wrr.276.1583433449214;
        Thu, 05 Mar 2020 10:37:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvhHuGisFdgFqK+06OOLUW1ehdv33D3YUuQu/8RquwUxfPL95K46vixq9wQPfQFCkl0BQDXoQ==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr296951wrr.276.1583433449033;
        Thu, 05 Mar 2020 10:37:29 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u17sm9369121wmj.47.2020.03.05.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:37:28 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: VMX: cleanup VMXON region allocation
Date:   Thu,  5 Mar 2020 19:37:23 +0100
Message-Id: <20200305183725.28872-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup with no functional change (intended):
- Rename 'kvm_area' to 'vmxon_region'
- Simplify setting revision_id for VMXON region when eVMCS is in use

Changes since v1:
- Patches prefix ('KVM: VMX:' now) [Sean Christopherson]
- Add Sean's R-b to PATCH1
- Do not rename alloc_vmcs_cpu() to alloc_vmx_area_cpu() and add a comment
  explaining why we call VMXON region 'VMCS' [Sean Christopherson]

Vitaly Kuznetsov (2):
  KVM: VMX: rename 'kvm_area' to 'vmxon_region'
  KVM: VMX: untangle VMXON revision_id setting when using eVMCS

 arch/x86/kvm/vmx/vmx.c | 42 +++++++++++++++++++-----------------------
 arch/x86/kvm/vmx/vmx.h | 12 +++++++++---
 2 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.24.1

