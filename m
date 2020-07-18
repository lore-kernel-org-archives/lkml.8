Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2947820717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595095235;
	bh=+wToLoKjRiINKFhQyZFsFXnAJYi9t95rRxHIuPFsFQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kgDVT70S4Kbi13NBqLU2su4VpuvfzZcDg5jg9B8JiuEBC6bwWojWOum0IpofrVQE1
	 3g4rzImO26AMHXYGKqrGgHvUp8rPDQqnNuWAdKWXdKiwHUi4oxx19jDaBUjCpDMQsh
	 3fOe2XCDvd3wuM+xnv4u/PDjtL5UYmiwftn3bwAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGRSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 14:00:32 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9713A22B48
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595095231;
        bh=+wToLoKjRiINKFhQyZFsFXnAJYi9t95rRxHIuPFsFQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JmuzoR1TT5uu+nLsEaipWnbUip9RmfZGF4ji6XcwBmY+uvhS2byFsimCUKED2nttC
         SimtWU/U5o9FoGuKRgbFj2T+ubluOamZ/v9hwVihTB+MA2g/RKiENHdCvcNX9p4PCS
         iKKe+xx7b0jPoCr/NjtDDagTrw/s/iUpQSyAO1ts=
Received: by mail-wr1-f46.google.com with SMTP id f18so14194397wrs.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 11:00:31 -0700 (PDT)
X-Gm-Message-State: AOAM533iWJJjda8c6xftvp/RQB42dyFZCAhgu15kJI1PpfP+SgXLZUW/
        cqqDM+74UQXZtc0UnsnevxxVfhjl0MP5F7DHWxADcQ==
X-Google-Smtp-Source: ABdhPJxwHKKjjxAL4xHh7C/XqdHYKDBiXpQvwS8O8VI+DurRqqF8DTxY/SOBbIQpbagV/ZqudekTEcgwhhlEWk66qvY=
X-Received: by 2002:adf:f888:: with SMTP id u8mr15668965wrp.18.1595095230100;
 Sat, 18 Jul 2020 11:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
In-Reply-To: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 18 Jul 2020 11:00:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUBDUKTcmmYD7BpZkL3869ELvha1PqOcScw4M-B_DQdiA@mail.gmail.com>
Message-ID: <CALCETrUBDUKTcmmYD7BpZkL3869ELvha1PqOcScw4M-B_DQdiA@mail.gmail.com>
Subject: Re: Random shadow stack pointer corruption
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 10:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Hi,
>
> My shadow stack tests start to have random shadow stack pointer corruption after
> v5.7 (excluding).  The symptom looks like some locking issue or the kernel is
> confused about which CPU a task is on.  In later tip/master, this can be
> triggered by creating two tasks and each does continuous
> pthread_create()/pthread_join().  If the kernel has max_cpus=1, the issue goes
> away.  I also checked XSAVES/XRSTORS, but this does not seem to be an issue
> coming from there.

What do you mean "shadow stack pointer corruption"?  Is SSP itself
corrupt while running in the kernel?  Is one of the MSRs getting
corrupted?  Is the memory to which the shadow stack points getting
corrupted? Is the CPU rejecting an attempt to change SSP?

--Andy

>
> The tests I run take a long time to complete, and some commit points in bisect
> do not show failures right away.  However, the issue can be more easily
> triggered after the point of:
>
> d77290507ab2 x86/entry/32: Convert IRET exception to IDTENTRY_SW
>
> Can anyone help me find places to look at?
>
> Thanks,
> Yu-cheng
>
