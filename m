Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359812077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXqrH9wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGJNHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:07:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727061AbgGJNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594386423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IrQ2y6oqMFzcLSC+a+hsU9IW+yAmZRwX9zeWYh8Q/Zs=;
        b=OXqrH9wgjUlSoD44ewjpXRKRekdoaEgeLzQc2eKLARQte/uxv1MYLA3tyMNoFtAQUSy0bp
        uzDi+qkp/oJOpQL2Tf2dOyVqLfYIT9OQ4Q5jRBK8WunodQ4ADbwathuK8L0DPhvomDvOLv
        GMplmINDvmklw/GCA76q7BbPXyV/MN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-3v4nffOSP_-9xvqzVJ-YQw-1; Fri, 10 Jul 2020 09:07:01 -0400
X-MC-Unique: 3v4nffOSP_-9xvqzVJ-YQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B21C100960F;
        Fri, 10 Jul 2020 13:07:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2878D724A4;
        Fri, 10 Jul 2020 13:07:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] Second batch of KVM changes for Linux 5.8-rc5
Date:   Fri, 10 Jul 2020 09:06:59 -0400
Message-Id: <20200710130659.10507-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 8038a922cf9af5266eaff29ce996a0d1b788fc0d:

  Merge tag 'kvmarm-fixes-5.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-master (2020-07-06 13:05:38 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 3d9fdc252b52023260de1d12399cb3157ed28c07:

  KVM: MIPS: Fix build errors for 32bit kernel (2020-07-10 06:15:38 -0400)

----------------------------------------------------------------
Two simple but important bugfixes.

----------------------------------------------------------------
Huacai Chen (1):
      KVM: MIPS: Fix build errors for 32bit kernel

Paolo Bonzini (1):
      KVM: nVMX: fixes for preemption timer migration

 Documentation/virt/kvm/api.rst  | 5 +++--
 arch/mips/kvm/emulate.c         | 4 ++++
 arch/x86/include/uapi/asm/kvm.h | 5 +++--
 arch/x86/kvm/vmx/nested.c       | 1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

