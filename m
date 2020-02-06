Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A999C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171A12082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580951918;
	bh=RzauNC0p9SmydYmAC3mdFxStDDwMVTQiULBVPp3jyaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cPmY5Yd5aNpfBMvkq/Q+GB1OijZSTpK1N1lZx3ieGZ9qywVpviptgKosa2p14hsZF
	 ZSIUtb4Y0LaUo0o7XimQ2ch0kb4OjyUMPFiTsHXnz5c0y3OwyquecEOFnsfkqTMYO1
	 /2Z7MIrhVKDoAq8G1PhFOD0ORzwdV3jOY8lZ6aTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgBFBSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBFBSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:18:36 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0322082E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Feb 2020 01:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580951916;
        bh=RzauNC0p9SmydYmAC3mdFxStDDwMVTQiULBVPp3jyaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZIfsL0tCuj13sylJD2DJstgV6RBZ7N2gh6tR4KfTqzhucRkJe4gV3D/pqFBIidmVx
         uZKagvbgRlNZCWjYb5+IeC24M4rSUplknbX+6cTT+/D77l1VwOot/kpHvD281H9olL
         YlxOZP+BxpXFvTBLhiyaglTVX2PRWnxmhJ/t0LfU=
Received: by mail-wm1-f42.google.com with SMTP id g1so4472619wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 17:18:36 -0800 (PST)
X-Gm-Message-State: APjAAAU9KjcPmCLrHCHwaLO/K0xNZqnFjP2fNYpd7YaiPiith6N5i9Q4
        hA3zx5sqJ8VyjewWi3rYT3yyKptvsZAzSuU/qaNx6g==
X-Google-Smtp-Source: APXvYqxZyuYG6uwhhAsz4t3M6RhGGzZg/4FofigHd0VwxaU4SNWjf6bQsgkC/bPxhvhpfhYlOM41rDcbFMRFntFIE4E=
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr632802wml.138.1580951914672;
 Wed, 05 Feb 2020 17:18:34 -0800 (PST)
MIME-Version: 1.0
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
 <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com> <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com>
 <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com> <20200203204155.GE19638@linux.intel.com>
 <20200206004944.GA11455@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200206004944.GA11455@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Feb 2020 17:18:23 -0800
X-Gmail-Original-Message-ID: <CALCETrWmuTbHn9YCpGsWLBjR9rV1QEoEQ-m63NDd9cu7SecV6Q@mail.gmail.com>
Message-ID: <CALCETrWmuTbHn9YCpGsWLBjR9rV1QEoEQ-m63NDd9cu7SecV6Q@mail.gmail.com>
Subject: Re: [PATCH] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 4:49 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> In a context switch from a task that is detecting split locks
> to one that is not (or vice versa) we need to update the TEST_CTRL
> MSR. Currently this is done with the common sequence:
>         read the MSR
>         flip the bit
>         write the MSR
> in order to avoid changing the value of any reserved bits in the MSR.
>
> Cache the value of the TEST_CTRL MSR when we read it during initialization
> so we can avoid an expensive RDMSR instruction during context switch.

If something else that is per-cpu-ish gets added to the MSR in the
future, I will personally make fun of you for not making this percpu.
