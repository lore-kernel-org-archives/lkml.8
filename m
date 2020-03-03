Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D5C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645B42064A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej3upRdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgCCOdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:33:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727725AbgCCOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eKkzvWfCT/rGHHgN9ulO4K42Kuyz8FLmS0u2A3ohfjg=;
        b=Ej3upRdr+dMSMy68O25a/iiy/ykmI2Oe1X2a9CP25t12TTLXIJKtNYtbanB4IkUOzamPRp
        IWAHeKGzGHQvUDjjXhac7/fwCC9Ls2zeT7cp6yekOhNVviVDOsZZLaGuaZKjQXi7/yIeWf
        rvHgLa723kXf4OU0KhvRqhZBYnD8qTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-Y8xiBLcmPjipX4MmBZNm7Q-1; Tue, 03 Mar 2020 09:33:20 -0500
X-MC-Unique: Y8xiBLcmPjipX4MmBZNm7Q-1
Received: by mail-wm1-f70.google.com with SMTP id m4so1163448wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKkzvWfCT/rGHHgN9ulO4K42Kuyz8FLmS0u2A3ohfjg=;
        b=Li/dKuiVinogZIXmtsMqNjODTZz9Qme48lyFXjrNgpptZU+KCQyPpot+WkeOjHsisA
         F70h/Vea4hX1S/kVn9XfiMhsLwDSjo9nZSxfErwj8++aLaYYGsiv3XZB9zDBO1edJpx1
         CSS6TrzN/kkhp1K/U3bIPu1GK/fl7yvF8gXwmfiWD84NmGz30M+0hM5yyt+w9O2kryKN
         PZtD/di9FS/a9zZ6RzlmNKYIQ/tYoL/9izD68LNKWdk1q67rnEw8wUuUydhgx57ggBxo
         o1MEEyFXMkn6JGgxdXv0aJkHLpOXrqOxQzc/wqwZGiu6kZuu7+7UmVK14O+5lyiR2ttb
         WWWg==
X-Gm-Message-State: ANhLgQ2HxJB2AQtRfqNujDKGSR7LnrNUtbeqBZqtDXSmMnrHxgQU9JhW
        b6QRkRbZSmYa9gyW6PM3sjTTICclxlAFxQciYt0oJZ0/1BcddOugVQW0W3pHlI6drJ+6NsPYaoO
        WdHPHz4OPrSYbAicjEQ+4sRe7
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr5426140wrx.327.1583245998956;
        Tue, 03 Mar 2020 06:33:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuh4OGE/Mw192/tAEELL/A48sw9lwJA5J10+koNsf1V2Sdz5rHD/kuhdwpWLwvXp6mm2DxkjA==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr5426121wrx.327.1583245998726;
        Tue, 03 Mar 2020 06:33:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s5sm32248504wru.39.2020.03.03.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:33:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Bandan Das <bsd@redhat.com>, Oliver Upton <oupton@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: x86: avoid using stale x86_emulate_ctxt->intercept value
Date:   Tue,  3 Mar 2020 15:33:14 +0100
Message-Id: <20200303143316.834912-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest
mode") Hyper-V guests on KVM stopped booting and tracing shows that we're
trying to emulate an instruction which shouldn't be intercepted. Turns out,
x86_emulate_ctxt may hold a stale 'intercept' value.

This is a regression in 5.6-rc4 and I'm marking PATCH1 for stable@. The
commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest mode")
is, however, correct, it just seems to reveal a pre-existing condition.

Vitaly Kuznetsov (2):
  KVM: x86: clear stale x86_emulate_ctxt->intercept value
  KVM: x86: remove stale comment from struct x86_emulate_ctxt

 arch/x86/include/asm/kvm_emulate.h | 1 -
 arch/x86/kvm/emulate.c             | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.24.1

