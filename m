Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FCC54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 05:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E236B20735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 05:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589087658;
	bh=7isHzGzCpzOUp3aZaHy+M4ZgG1t9EaoA4y3cc5CT/+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P17w7INVjBg6UZNKnEHjzwY7hjyKyhYiwiv53oisRgcbfttx+8OLWD8TJv0cSGYlA
	 Pva3ClFzZ6WWhbxR/iy9LG6OypQUzVbmQvXV+qV1NGrlJNmmIy0XbBbsCXQqV0JIQf
	 YveGRta1Ddd3oS58MEZnVIBgSLnC+6m3wRufzMm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEJFOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 01:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgEJFOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 01:14:15 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C886D24953
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589087655;
        bh=7isHzGzCpzOUp3aZaHy+M4ZgG1t9EaoA4y3cc5CT/+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hVUysjs5QVcdHw055Qy9Z2x9DVFu/JdegOtHfX/A95yItlA9GrttfKC54wQrGaNFm
         WC/IbQ4BT7O4QXGrW1fibhNDdAFsLODWySuw53Renemox7Pxv3KBMUm7uxnaTiyrns
         6zflWNTIHHEQNHsUkNGTDOX/fK9mCA+TzAHeYiiY=
Received: by mail-wr1-f49.google.com with SMTP id l11so754742wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 22:14:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuaK1dfcKFbqcNrLePnHyfIH1XlC+SW1ziyzCR8PDd/7L0qRzBoG
        xmSbv5fZVvKCQoEHKpVd4U88UMJxX6aaXiWcUleS2w==
X-Google-Smtp-Source: APiQypJHm42zo0OswqKUKiQUmdaZq5CulgDYWtAJFAkr38/7YPyx+cmz3Am/hZuNVsRrlIKtjewIJct+UzO0+8kdC8s=
X-Received: by 2002:adf:a298:: with SMTP id s24mr1085851wra.184.1589087653237;
 Sat, 09 May 2020 22:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200509110542.8159-1-xiaoyao.li@intel.com> <20200509110542.8159-4-xiaoyao.li@intel.com>
In-Reply-To: <20200509110542.8159-4-xiaoyao.li@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 9 May 2020 22:14:02 -0700
X-Gmail-Original-Message-ID: <CALCETrXwtj5rhVM6YYNEDeDqT3eKFNkGFCgSB_hUd7aOYBFXmw@mail.gmail.com>
Message-ID: <CALCETrXwtj5rhVM6YYNEDeDqT3eKFNkGFCgSB_hUd7aOYBFXmw@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] x86/split_lock: Introduce flag X86_FEATURE_SLD_FATAL
 and drop sld_state
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 8:03 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> Introduce a synthetic feature flag X86_FEATURE_SLD_FATAL, which means
> kernel is in sld_fatal mode if set.
>
> Now sld_state is not needed any more that the state of SLD can be
> inferred from X86_FEATURE_SPLIT_LOCK_DETECT and X86_FEATURE_SLD_FATAL.

Is it too much to ask for Intel to actually allocate and define a
CPUID bit that means "this CPU *always* sends #AC on a split lock"?
This would be a pure documentation change, but it would make this
architectural rather than something that each hypervisor needs to hack
up.

Meanwhile, I don't see why adding a cpufeature flag is worthwhile to
avoid a less bizarre global variable.  There's no performance issue
here, and the old code looked a lot more comprehensible than the new
code.
