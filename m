Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA73C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6EE20838
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596245335;
	bh=iEFTd5J3OaIz2CPblhNjm4HIdHFf3NTyBlaCyk5tBwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TrpkJ0UiSlZivyB78uSIz30iZ0VfB6+44Mpb64kj3YdhLb9nTV9ENIppGXVXy8AlD
	 cac8BuKAQWEYJj9YLHIhvyo3cdfNER4pHX/WDSkn0hSP3E3uL+j7EiZhRer6kWvK+R
	 jqsnd3VUNalJJuEJ0Su+T5dpu1iqQw1lm/10PN3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHAB2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgHAB2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:28:51 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3448E22CBB
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596245330;
        bh=iEFTd5J3OaIz2CPblhNjm4HIdHFf3NTyBlaCyk5tBwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oyiKjd9jYrsQoTyhz9So/eaYiCUToFDRE+yR5g+YKhAtuoTBf++uEjYmgaJO0yqqO
         qnJf3bCLRvBIa7DYC2uz+LmCEDskSnC4cnYhI+4Ncll+MjqEsOQuS2Xxm8wbccwuol
         vNVp2k1dV+au0yLp8bu3hI5+0WnCXeDq9gno9e+U=
Received: by mail-wm1-f52.google.com with SMTP id t14so5528091wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:28:50 -0700 (PDT)
X-Gm-Message-State: AOAM532PVWM18aVWQaThFqjFgBtH0C1Q1Qp4+CwW/EuBXH5MLxwdl6O0
        W6GUR9jkHVwJeDaghTMz1Az6cyGJRu2r+eOXyOHUOg==
X-Google-Smtp-Source: ABdhPJwqMB4yU9t8y4FC7B3ExHcTCCL1w+nLeHjKE26+trC+5yOlCmBolk7+/lVqfoJLVEkj6eyrxs3QsKfB+JPQNtY=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr5903705wmk.176.1596245328660;
 Fri, 31 Jul 2020 18:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com> <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-13-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Jul 2020 18:28:37 -0700
X-Gmail-Original-Message-ID: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Message-ID: <CALCETrV6yTjFzuTMEP8T9_QfjAXktHZcMXSqionZGJ=Lj0YdFg@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> A #GP fault is generated when ENQCMD instruction is executed without
> a valid PASID value programmed in the current thread's PASID MSR. The
> #GP fault handler will initialize the MSR if a PASID has been allocated
> for this process.

Let's take a step back here.  Why are we trying to avoid IPIs?  If you
call munmap(), you IPI other CPUs running tasks in the current mm.  If
you do perf_event_open() and thus acquire RDPMC permission, you IPI
other CPUs running tasks in the current mm.  If you call modify_ldt(),
you IPI other CPUs running tasks in the current mm.  These events can
all happen more than once per process.

Now we have ENQCMD.  An mm can be assigned a PASID *once* in the model
that these patches support.  Why not just send an IPI using
essentially identical code to the LDT sync or the CR4.PCE sync?

--Andy
