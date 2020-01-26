Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE95FC35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 00:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC012071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579998885;
	bh=V2U6z9XSaNg2lFAobPZohWhVuiUiqMr2x6dsXgQhYNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Of3TxercHf6opTN+Ja3/kJsbraoKbwgqX6w/v0Bmm/Tui7bPDppdiAyRLaraVb6U7
	 xSI0UrygN4/ucPEkbj7Iy3C/fy9ZCcC3+igRGejnCX09PvHLU09SmEPFkKQ0BhDNYG
	 q2rd8i+KLPltuDfAWlsRUJ4o7dw/CjV7e7UeGVDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAZAeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 19:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAZAeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 19:34:44 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70251214DB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579998883;
        bh=V2U6z9XSaNg2lFAobPZohWhVuiUiqMr2x6dsXgQhYNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/HSUuta8Mp4dTjgiD+vt7NJYwluvhu/mUmX/0w3vU2unNX99DJxUabSUgRPIEo6c
         W7O0eGC2FMwlYXY7Pceyi9oIAfeEgGq5/ItFejl6WyX3dsUcvaWgWrhWrQV7WQb3Dy
         uvXXujcS358labKpL9tKcJ4XBQrM8HCsfDQpgiXs=
Received: by mail-wr1-f52.google.com with SMTP id g17so6710261wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 16:34:43 -0800 (PST)
X-Gm-Message-State: APjAAAW/9+PF4jSuTjFg1Z44WswrT7ZbXbhntMjqBzrN16q903r02AE5
        tWP1cZcI1A8oPruYdBd5MpxcWcZ40RNJiS9Efz+0WA==
X-Google-Smtp-Source: APXvYqzMByIDP1omF2wxhekdM1YUinGA+ZysjjYoFLEtfdsnvfhfIwTcyGWB0u913nRilErTtdaHwUexVWZh6aHWdU0=
X-Received: by 2002:adf:8041:: with SMTP id 59mr12356956wrk.257.1579998881736;
 Sat, 25 Jan 2020 16:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan> <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan> <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan> <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de> <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <875zgzmz5e.fsf@nanos.tec.linutronix.de> <20200125220706.GA18290@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200125220706.GA18290@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 25 Jan 2020 16:34:29 -0800
X-Gmail-Original-Message-ID: <CALCETrXT9zo2yFN+iz-1ijayOKNNz-717pEJggU1kC79ZVf34g@mail.gmail.com>
Message-ID: <CALCETrXT9zo2yFN+iz-1ijayOKNNz-717pEJggU1kC79ZVf34g@mail.gmail.com>
Subject: Re: [PATCH v16] x86/split_lock: Enable split lock detection by kernel
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 2:07 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>

> +void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
> +{
> +       u64 ia32_core_caps = 0;
> +
> +       if (c->x86_vendor != X86_VENDOR_INTEL)
> +               return;
> +       if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
> +               /* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
> +               rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> +       } else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +               /* Enumerate split lock detection by family and model. */
> +               if (x86_match_cpu(split_lock_cpu_ids))
> +                       ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
> +       }

I was chatting with Andrew Cooper, and apparently there are a ton of
hypervisors bugs in this space, and the bugs take two forms.  Some
hypervisors might #GP the read, and some might allow the read but
silently swallow writes.  This isn't *that* likely given that the
hypervisor bit is the default, but we could improve this like (sorry
for awful whitespace);

static bool have_split_lock_detect(void) {
      unsigned long tmp;

      if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES) {
              /* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
               rdmsrl(MSR_IA32_CORE_CAPS, tmp);
               if (tmp & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
                  return true;
      }

      if (cpu_has(c, X86_FEATURE_HYPERVISOR))
            return false;

       if (rdmsrl_safe(MSR_TEST_CTRL, &tmp))
               return false;

      if (wrmsrl_safe(MSR_TEST_CTRL, tmp ^ MSR_TEST_CTRL_SPLIT_LOCK_DETECT))
              return false;

      wrmsrl(MSR_TEST_CTRL, tmp);
}

Although I suppose the pile of wrmsrl_safes() in the existing patch
might be sufficient.

All this being said, the current code appears wrong if a CPU is in the
list but does have X86_FEATURE_CORE_CAPABILITIES.  Are there such
CPUs?  I think either the logic should be changed or a comment should
be added.
