Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A035C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C302465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV03FqL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAORK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:10:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36958 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728998AbgAORKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579108223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oh8syvO3W6gUaj5dvdzY+X7LicIsoPtaC11FOH1zRXg=;
        b=MV03FqL2S9SPquadi0qA/KKu43ahwCdDHUURU24ujMtcXSoZ10ypeN/RSqAaQVrLxlJdIb
        XUMuvDkojhoYXa9n0R6Sju4COA7BuEu3QAXYN4oRyN93365hQko1jmQS9ObrjV8f3i1A6l
        9QWvHp4NvKkyAf8OpDfutd+5UNCAhNk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192--q0OPdngOuKiIy7x-IZOQQ-1; Wed, 15 Jan 2020 12:10:17 -0500
X-MC-Unique: -q0OPdngOuKiIy7x-IZOQQ-1
Received: by mail-wr1-f71.google.com with SMTP id j4so8212907wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oh8syvO3W6gUaj5dvdzY+X7LicIsoPtaC11FOH1zRXg=;
        b=MgpxmNPM/X/TDX7/3gsgoXlX8UjRoty5lXWerzKtcMpHo5az0Q0F1dIpeZ3OJKOuWM
         gbuTKjv6wc1uovGLyHYP0WFOTi2EGQh26m6gECDQRJdNpBTcaf8V3IHG9glO+KDpeQEx
         3pFf3lhZJ4EOxc8+6JkJCi0azMy1QrDGcn8VnRxUGWfoFUCWWrY5lAOuT8zO2bx+tIjJ
         R0QcLPQRUFGnDEfPVZqdbFHuP8YdIdCoqDPQg3TTrEcIOKhs+OH/HzIPbf23lnEiOW2h
         TliCmDj2dovgmBpo8PF1zuKXpe/O0k5delHhf/XyOI+o8BtkINl/06b8oBf4mIEsRpt6
         6zDg==
X-Gm-Message-State: APjAAAVySB/iRbRRE5ClDzZEuLIp21k6pnVazyTc2iyh/qW7kJDE+DZr
        Hirp/SPx0nWfm1S8ENvOM6JZLae0PtNbhU6kxrOTHrlAk/1LsoSambqdrSj3C6WAxIv56QzFei/
        AAR6HEY5LOywsukMFP2rtrhW0
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr868448wmc.63.1579108216782;
        Wed, 15 Jan 2020 09:10:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxAUtkMeLimE0mSVgQTbE8fcqGapcKBRgSHFCBxThX2YfhrLDkFqEnKuSGULrLXasq18IvZA==
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr868433wmc.63.1579108216524;
        Wed, 15 Jan 2020 09:10:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y20sm525071wmi.25.2020.01.15.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:10:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH RFC 0/3] x86/kvm/hyper-v: fix enlightened VMCS & QEMU4.2
Date:   Wed, 15 Jan 2020 18:10:11 +0100
Message-Id: <20200115171014.56405-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With fine grained VMX feature enablement QEMU>=4.2 tries to do KVM_SET_MSRS
with default (matching CPU model) values and in case eVMCS is also enabled,
fails. While the regression is in QEMU, it may still be preferable to
fix this in KVM.

It would be great if we could just omit the VMX feature filtering in KVM
and make this guest's responsibility: if it switches to using enlightened
vmcs it should be aware that not all hardware features are going to be
supported. Genuine Hyper-V, however, fails the test. In particular, it
enables SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES and without
'apic_access_addr' field in eVMCS there's not much we can do in KVM.

The suggested approach in this patch series is: move VMX feature
filtering to vmx_get_msr() so only guest doesn't see them when eVMCS
is enabled (PATCH2) and add a check that it doesn't enable them
(PATCH3).

I can't say that I'm a great fan of this workaround myself, thus RFC.

My initial RFC sent to qemu-devel@:
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg00123.html

Vitaly Kuznetsov (3):
  x86/kvm/hyper-v: remove stale evmcs_already_enabled check from
    nested_enable_evmcs()
  x86/kvm/hyper-v: move VMX controls sanitization out of
    nested_enable_evmcs()
  x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for
    nested guests

 arch/x86/kvm/vmx/evmcs.c  | 99 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/evmcs.h  |  2 +
 arch/x86/kvm/vmx/nested.c |  3 ++
 arch/x86/kvm/vmx/vmx.c    | 10 +++-
 4 files changed, 100 insertions(+), 14 deletions(-)

-- 
2.24.1

