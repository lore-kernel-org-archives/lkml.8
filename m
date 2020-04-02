Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5EFC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405E20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbgDBNBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:01:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37719 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgDBNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:01:24 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJzSt-0004Fu-Ig; Thu, 02 Apr 2020 15:00:59 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E2104FFAA7;
        Thu,  2 Apr 2020 15:00:58 +0200 (CEST)
Message-Id: <20200402123258.895628824@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 02 Apr 2020 14:32:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX hypervisors
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth reported that a VMWare guest crashes in the VMWare BIOS due to a
Split-Lock induced #AC which is injected by the VMWare hypervisor into the
guest.

While this is a good thing in principle, it's not really practical.
That means that Split-Lock-Detection has to be disabled when any
unprepared VMX hypervisor is loaded.

As hypervisor modules are not really identifiable, the only safe solution
we came up with is to scan the module text at load time for a VMLAUNCH
instruction. If VMLAUNCH is found then Split-Lock-Detection is disabled on
the host to prevent the above. If the hypervisor has at least minimal
handling code, the module can tell the kernel by adding MOD_INFO(sld_safe,
"Y") which disables the text scan.

For KVM it's simple enough to handle it at least at the basic level by
checking guest CR0.AM and EFLAGS.AC state and a trivial host side
handler which depending on the SLD mode handles it gracefully or tells
the VMX handler to deliver the #AC to user space which then can crash
and burn itself.

As Peter and myself don't have access to a SLD enabled machine, the
KVM/VMX part is untested. The module scan part works.

Alternatively we can obviously revert SLD, but that does not make the
problem vs. out of tree hypervisors go away magically. So we can just
get over it now.

Thanks,

	tglx



