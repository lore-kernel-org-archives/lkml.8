Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E71C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7053C208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jICJdeBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCIPwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:52:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28165 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgCIPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583769143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UB/IvUr/ugaH4om1futJLL45EG+xV5yXpIjZW59btTM=;
        b=jICJdeBOpzZZzG7HCXZmd402/aR/XINqc0nr6xY4GVI1wbozVYNC31Nn6J9OUx4rMN0LYt
        OPW1l/z+Mz/SxYn+WH8lWqo2eRGCKUQZYCfDs6WFr4224hm8NDgMyBfhPJm3Frqr99BkKU
        7PUFcPFeXXS5fzm2P8FnKG6IW0IMW8s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-ngRDbO02PeKkE2gRo8Es-g-1; Mon, 09 Mar 2020 11:52:21 -0400
X-MC-Unique: ngRDbO02PeKkE2gRo8Es-g-1
Received: by mail-wr1-f69.google.com with SMTP id c16so4533314wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UB/IvUr/ugaH4om1futJLL45EG+xV5yXpIjZW59btTM=;
        b=qH9tOO69ZRwcwiF3OUQLFhRq51RRE3GYsEyZvp3f63qhf5B5E3MNbEV7JT7Ui3sEjX
         6WmCSjMkQhPUl0wY8i+TpAe2k+6aoLO7BCemLNweNix+9mhe/OaiAtELkZUI5+CoA4Hh
         3RFI031x09A9DxqMM0iybKUvXdqx7ygfwlovaJ4/2hPZ58ff1q78/07yUThGoTEb06ln
         QQ1Wz7CVT+DxMIk9XfZFyWrxSmGeXFpcBLU/UXVhOCecxXjPt2vqPJM09bsHPK5QwxE3
         ARpjCKN7S6x3mzLSqmrTbHd0K0Ublt29qc20x5tfBOmLn+4Zoj2IJMf8WqyPa2SF/EBH
         0upw==
X-Gm-Message-State: ANhLgQ1yFC06OdwRAZCIBqIrNvabt3lVHdIZy2L0+hPJjAzaXjUG5SVq
        Wmko+QvgpKO/pEivZs5LLXlJVNNiOBIZel8ztscTaSVuqkopaGmppzAJD863y7rsJkJQ+Ofldbt
        NZaOPnoxPCa3Y7U/k3vg25CTX
X-Received: by 2002:a05:6000:10f:: with SMTP id o15mr6853053wrx.351.1583769139971;
        Mon, 09 Mar 2020 08:52:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtw/xasyVnTCQ/tSOo6zLe/OXjzuXj8HRel7v1396vtd+EE+E43smyhMCZMQ8azfB0ke2vLQw==
X-Received: by 2002:a05:6000:10f:: with SMTP id o15mr6853031wrx.351.1583769139725;
        Mon, 09 Mar 2020 08:52:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q4sm17294521wro.56.2020.03.09.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:52:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 0/6] KVM: nVMX: propperly handle enlightened vmptrld failure conditions
Date:   Mon,  9 Mar 2020 16:52:10 +0100
Message-Id: <20200309155216.204752-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin noticed that we incorrectly handle enlightened vmptrld failures
in nested_vmx_run(). Trying to handle errors correctly, I fixed
a few things:
- NULL pointer dereference with invalid eVMCS GPAs [PATCH1]
- moved eVMCS mapping after migration to nested_get_vmcs12_pages() from
  nested_sync_vmcs12_to_shadow() [PATCH2]
- added propper nested_vmx_handle_enlightened_vmptrld() error handling
  [PATCH3]
- added selftests for incorrect eVMCS revision id and GPA [PATCHes4-6]

PATCH1 fixes a DoS and thus marked for stable@.

Vitaly Kuznetsov (6):
  KVM: nVMX: avoid NULL pointer dereference with incorrect EVMCS GPAs
  KVM: nVMX: stop abusing need_vmcs12_to_shadow_sync for eVMCS mapping
  KVM: nVMX: properly handle errors in
    nested_vmx_handle_enlightened_vmptrld()
  KVM: selftests: define and use EVMCS_VERSION
  KVM: selftests: test enlightened vmenter with wrong eVMCS version
  KVM: selftests: enlightened VMPTRLD with an incorrect GPA

 arch/x86/kvm/vmx/evmcs.h                      |  7 ++
 arch/x86/kvm/vmx/nested.c                     | 64 +++++++++++++------
 tools/testing/selftests/kvm/include/evmcs.h   |  2 +
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |  2 +-
 .../testing/selftests/kvm/x86_64/evmcs_test.c | 25 ++++++--
 5 files changed, 72 insertions(+), 28 deletions(-)

-- 
2.24.1

