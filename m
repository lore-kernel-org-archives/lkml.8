Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905F920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQMutR39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGHTt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHTt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:49:56 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF1C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:49:56 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h16so5120ilj.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9bO2SvLDKet0zC0FnvNLQImEbF2fhapt4H2nUguyC4=;
        b=VQMutR39qCwX+rzcpy2tnhenXy7JQ8m0tuhbilG4X7au0sVK1MdJWPjVT1I6rFd/6W
         LpKtfFBaByCEYDWOL2MDdF9Zyd7eeeORwzRTzNepJvCCMyDv9T7TZRGDNwtRE5DS9ouU
         aWKzFsbyiwBaAGEKDO2+5uy1AYd8ZkMuQaIYc9d/yUdQoJKhtbGmSGKpDzHWkxkZS9AP
         r90hG4a6m9XEZMi0Iz8yHPEs00oqG4JYNAMRgNKIC+lW7VShiPEn0JOgrhBLMinkSDHf
         JkdNPXBIzQmQJfnkq0X+y30oG6/81fjweNvbjVXrd+8OsllzRICCvoyI9bTxiJueNfPG
         BWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9bO2SvLDKet0zC0FnvNLQImEbF2fhapt4H2nUguyC4=;
        b=NIT8et2A3g+prmmQfbqWjAHJe+D1MvtKlIa0GZDZQ4T6F7Y7tmGVDIv6cEBQ/Wt//u
         BSFITOwOgxtQJ72WJI7rn7FJ91MvWJfhL83kBxTnol0AalVJSWEFN34jSBPUIxHuJ+Pr
         n2Oy5rM0al+3sqO1MIcz7qpdHMVpSDy+NQU2tu5C2ygr8GUOpq3GdO9FuVJ06kA8rKs/
         b53PfAvCOeHxCWswmU1OQHeFx3VOzC9rthkb8XbrzIFuw5/qaLqvyA0DwyUo0QHB4Sly
         0HPzZGDNF6qC+0VlPp1s02W54gT6EoqgOeWTLejt2RBdaxxItrbAK1xavpfqyqg/vazP
         b36w==
X-Gm-Message-State: AOAM533uJeGgtnbnFTfmycVJk3fmbPfGHdOL53zFGX3Q+ukswJSEiyve
        3HbRvMLzbUAKxv634YfNAx3/wNnNNtDtQEX8jZilaA==
X-Google-Smtp-Source: ABdhPJy9DOSdnQPU184rzJ43rhfRWcru5enbc3FbwYxuqR6UthrROMB5kbzwaT6IGXDS+2J3KMXKLi+H8r51JqyLq34=
X-Received: by 2002:a92:b685:: with SMTP id m5mr43580715ill.118.1594237794192;
 Wed, 08 Jul 2020 12:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200708192546.4068026-1-abhishekbh@google.com> <06f15327-f346-fb8d-cc8e-8e12c398324d@infradead.org>
In-Reply-To: <06f15327-f346-fb8d-cc8e-8e12c398324d@infradead.org>
From:   Abhishek Bhardwaj <abhishekbh@google.com>
Date:   Wed, 8 Jul 2020 12:49:17 -0700
Message-ID: <CA+noqohUFoCQdRKLTtGXOB=GAKYO5Er=-EVpOMowEufB9dnk_g@mail.gmail.com>
Subject: Re: [PATCH v4] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:34 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi again,
>
> On 7/8/20 12:25 PM, Abhishek Bhardwaj wrote:
> > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > index b277a2db62676..1f85374a0b812 100644
> > --- a/arch/x86/kvm/Kconfig
> > +++ b/arch/x86/kvm/Kconfig
> > @@ -107,4 +107,17 @@ config KVM_MMU_AUDIT
> >        This option adds a R/W kVM module parameter 'mmu_audit', which allows
> >        auditing of KVM MMU events at runtime.
> >
> > +config KVM_VMENTRY_L1D_FLUSH
> > +     int "L1D cache flush settings (1-3)"
> > +     range 1 3
> > +     default "2"
> > +     depends on KVM && X86_64
> > +     help
> > +      This setting determines the L1D cache flush behavior before a VMENTER.
> > +      This is similar to setting the option / parameter to
> > +      kvm-intel.vmentry_l1d_flush.
> > +      1 - Never flush.
> > +      2 - Conditionally flush.
> > +      3 - Always flush.
> > +
> >  endif # VIRTUALIZATION
>
> If you do a v5, the help text lines (under "help") should be indented
> with one tab + 2 spaces according to Documentation/process/coding-style.rst.

Apologies for missing this. Fixed in v5 -
https://lkml.org/lkml/2020/7/8/1369

>
> --
> ~Randy
>


-- 
Abhishek
