Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01ED214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkHEsWcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBGWf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:35:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34858 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbgBGWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581114925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ugZBz7enuCINLO2hCs0M9spDUSXUeBZ8X9fYPkjTl9M=;
        b=IkHEsWcQUKMpeKWLikQTM2i19H+KWkWuzinewAqA5nXJ9MOOGXdAN8Qs2lr8+akPfS+rci
        4MxGVqsoAvk1cm/BdJgePTR9scGeKpJ3sm17riGvoFq/snT9dyiOHydvbXhB8Hqg0im1Y0
        yUPEtW+qI1pnUoh5Hh8LOsaymQC2FFg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-rJzQ-TRFOfO9w3tcsfH12g-1; Fri, 07 Feb 2020 17:35:24 -0500
X-MC-Unique: rJzQ-TRFOfO9w3tcsfH12g-1
Received: by mail-qk1-f200.google.com with SMTP id a23so487147qkl.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugZBz7enuCINLO2hCs0M9spDUSXUeBZ8X9fYPkjTl9M=;
        b=QNwX6P2lfQDK/6dVMNOqib2BFY/LhS+wWPsP2ok2/qZOQik4VUYvMbiMu7NAHuS0am
         N9LQ5dMmxLU8q6EVBEBqSeJgChu28VCaFXCRViWCbhRyGAK3kte0Hzr0WliccbMZr5Zz
         KSmFeYSsiaxEgon2ZzAT4CeNwC7DEkX2SYDeuYKZeccVxPOwMcpRCXGV8PK3rA09zYIP
         OpFZFbD24Jp0kYoUxcivOcVzmrpRsFcPj2Zkqic9zBFI+3N30eH3nOWd7lADTyEKJijG
         ek+y4QEZzur1E27s7c/MxriOav6ZKI3r/kyiyMcj62uVcHsdOX4IvrHLKRM493ovy/N8
         qbCA==
X-Gm-Message-State: APjAAAWBrvw8paGdNMKdAeqkgs61aDR6qugy1kP29SimB4H4FBdQOTyZ
        DEcPKaF7pAnRT0M/ybqF9LXRW79NP97YAb/jJErANUTUvMEAksn+ttzU8Mpp+iuuWyrFhR0rHRM
        6SYiIBrC4RmDnxZEOcuJH6spw
X-Received: by 2002:ac8:1205:: with SMTP id x5mr598703qti.238.1581114923526;
        Fri, 07 Feb 2020 14:35:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFhVS1bhbCdouqP3dIqYiC7xAeG36OuHcbu/fkXUSHwKqa8FFEiGxaaY0/f//YMJs09H18pw==
X-Received: by 2002:ac8:1205:: with SMTP id x5mr598684qti.238.1581114923289;
        Fri, 07 Feb 2020 14:35:23 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id u12sm2178736qtj.84.2020.02.07.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:35:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-mips@vger.kernel.org, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 0/4] KVM: MIPS: Provide arch-specific kvm_flush_remote_tlbs()
Date:   Fri,  7 Feb 2020 17:35:16 -0500
Message-Id: <20200207223520.735523-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This series is RFC because I don't have MIPS to compile and test]

kvm_flush_remote_tlbs() can be arch-specific, by either:

- Completely replace kvm_flush_remote_tlbs(), like ARM, who is the
  only user of CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL so far

- Doing something extra before kvm_flush_remote_tlbs(), like MIPS VZ
  support, however still wants to have the common tlb flush to be part
  of the process.  Could refer to kvm_vz_flush_shadow_all().  Then in
  MIPS it's awkward to flush remote TLBs: we'll need to call the mips
  hooks.

It's awkward to have different ways to specialize this procedure,
especially MIPS cannot use the genenal interface which is quite a
pity.  It's good to make it a common interface.

This patch series removes the 2nd MIPS usage above, and let it also
use the common kvm_flush_remote_tlbs() interface.  It should be
suggested that we always keep kvm_flush_remote_tlbs() be a common
entrance for tlb flushing on all archs.

This idea comes from the reading of Sean's patchset on dynamic memslot
allocation, where a new dirty log specific hook is added for flushing
TLBs only for the MIPS code [1].  With this patchset, logically the
new hook in that patch can be dropped so we can directly use
kvm_flush_remote_tlbs().

TODO: We can even extend another common interface for ranged TLB, but
let's see how we think about this series first.

Any comment is welcomed, thanks.

Peter Xu (4):
  KVM: Provide kvm_flush_remote_tlbs_common()
  KVM: MIPS: Drop flush_shadow_memslot() callback
  KVM: MIPS: Replace all the kvm_flush_remote_tlbs() references
  KVM: MIPS: Define arch-specific kvm_flush_remote_tlbs()

 arch/mips/include/asm/kvm_host.h |  7 -------
 arch/mips/kvm/Kconfig            |  1 +
 arch/mips/kvm/mips.c             | 22 ++++++++++------------
 arch/mips/kvm/trap_emul.c        | 15 +--------------
 arch/mips/kvm/vz.c               | 14 ++------------
 include/linux/kvm_host.h         |  1 +
 virt/kvm/kvm_main.c              | 10 ++++++++--
 7 files changed, 23 insertions(+), 47 deletions(-)

-- 
2.24.1

