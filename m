Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5790BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3890F2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbgDBOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:37:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38064 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:37:28 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK0xx-0005q5-Nd; Thu, 02 Apr 2020 16:37:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D175F100D52; Thu,  2 Apr 2020 16:37:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX hypervisors
In-Reply-To: <alpine.DEB.2.21.2004020641470.7052@xps-7390>
References: <20200402123258.895628824@linutronix.de> <alpine.DEB.2.21.2004020641470.7052@xps-7390>
Date:   Thu, 02 Apr 2020 16:37:08 +0200
Message-ID: <875zeinecr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kenneth R. Crudup" <kenny@panix.com> writes:

> On Thu, 2 Apr 2020, Thomas Gleixner wrote:
>
>> As Peter and myself don't have access to a SLD enabled machine, the
>> KVM/VMX part is untested. The module scan part works.
>
> I just applied both of these patches to my (Linus' tip) tree, and unfortunately
> VMWare still hangs if split_lock_detect= is set to anything but "off".
>
> Was there anything else I'd needed to do?

Hmm. Not really. Does dmesg show the warning when the VMWare module loads?
Something like:

  x86/split lock detection: disabled due to VMLAUNCH in module: ....

Thanks,

        tglx


