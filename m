Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD7C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A800220678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQqrdPIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDGXPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:15:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55969 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:15:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id fh8so379829pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZOBitavj4S6ILIuLSBytWPReKVdwTjFE2ZWsCjAPqcU=;
        b=AQqrdPIjnmwF6hVVXFRsx2ZLxK/7DA1im736romYNf0isFcDjejsG8Fiss1kK9U2Ae
         IQlAzlGGdoMwzWF2CX6e2hgSE31FxhhaCAxgf6mNiZ6+hvsPRDgh5V1g2xpQ3/bcV/jo
         uvpwZ/e/gnrMcOLv2exciIA1XRMNOZqhzZyqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZOBitavj4S6ILIuLSBytWPReKVdwTjFE2ZWsCjAPqcU=;
        b=IhOoWF13CEHvtp/h8vx27WsI8Wg06ypxZatX/ZfJUu35zFRKJjQzAUQyEAc7DFheHI
         fY1ZitBbNArxpdsSGGrulRlaOSrxB0pH6q3ssl4aKtu76Yv9clBpELJhPBb683VBYj6B
         8wU6oRyXgb441fq3IsFa9fnDAolAkk3z352slT+vx/9sTqi/AF00r9mBgXJaYbEA0uIU
         bvRGVyT07334ScrbnmFwgpD9mENLpiunvR+YHWHJGOhuOZaP7xtYigQYxjJxd22lgxFM
         T49NSzRVdC832JJa0mPkKQzIF3CdVL2Wdz6lfCrXuZBB0+KkuxjRnsMgWzqorto4JxRR
         KRfQ==
X-Gm-Message-State: AGi0PuYjrNw5NCNaQ4wTwlq68cwT48FFclYE8U4cIq201Kfe6j6nZPvH
        GACegyDinKCuzjYxcvxi0CncNA==
X-Google-Smtp-Source: APiQypKAILdy3JyxMtfot6PLQALbTVcSiRiXACxyMrXDwKR9EG1Cn289vLqSYShT6VtgmmoMDwsVlQ==
X-Received: by 2002:a17:90a:fb94:: with SMTP id cp20mr1881215pjb.117.1586301314117;
        Tue, 07 Apr 2020 16:15:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q67sm2655364pjq.29.2020.04.07.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:15:13 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:15:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Peter Zijlstra' <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kenny@panix.com" <kenny@panix.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "thellstrom@vmware.com" <thellstrom@vmware.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "dcovelli@vmware.com" <dcovelli@vmware.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <202004071611.233B0045@keescook>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
 <23787a63b28744b1906c4d4b6209b6af@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23787a63b28744b1906c4d4b6209b6af@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:25:56PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 07 April 2020 12:03
> > 
> > It turns out that with Split-Lock-Detect enabled (default) any VMX
> > hypervisor needs at least a little modification in order to not blindly
> > inject the #AC into the guest without the guest being ready for it.
> > 
> > Since there is no telling which module implements a hypervisor, scan
> > all out-of-tree modules' text and look for VMX instructions and refuse
> > to load it when SLD is enabled (default) and the module isn't marked
> > 'sld_safe'.
> ...
> > +	while (text < text_end) {
> > +		kernel_insn_init(&insn, text, text_end - text);
> > +		insn_get_length(&insn);
> > +
> > +		if (WARN_ON_ONCE(!insn_complete(&insn))) {
> > +			pr_err("Module text malformed: %s\n", mod->name);
> > +			return -ENOEXEC;
> > +		}
> > +
> > +		if (!allow_vmx && insn_is_vmx(&insn)) {
> > +			pr_err("Module has VMX instructions and is not marked 'sld_safe', boot with:
> > 'split_lock_detect=off': %s\n", mod->name);
> > +			return -ENOEXEC;
> > +		}
> > +
> > +		text += insn.length;
> > +	}
> 
> There is a slight flaw in the above.
> A malicious module can hide the required instruction by jumping into the
> middle of a long instruction.
> 
> Even checking branch targets hit instruction barriers isn't enough,
> an indirect jump could be used.

If I understand the goals here, it's to provide feedback for good actors
doing things that they don't realize aren't safe. Trying to stop a
malicious module from doing malicious things is basically impossible:
it can just load a data blob and self-modify, etc. :)

Though, Peter, this does get me thinking: if this is meant to be helpful
for module authors tripping over things they shouldn't be touching,
perhaps every test needs to include explicit recommendations? It's
_kind_ of doing this already. Maybe the above should be:

pr_err("%s: contains VMX instructions but is not marked 'sld_safe'. Please see <url> or boot with: 'split_lock_detect=off' to ignore.\n", mod->name);

?

-- 
Kees Cook
