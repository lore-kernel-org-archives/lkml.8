Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2926CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BED620746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588898428;
	bh=6DvqviWnsP5o86+PhIomjPeqp2M6x7IJfqoZNaxxcDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B07laZlB3+MuQq0EDEEbjQiWpcSySZgZ+Rf/vveqczAEJlRl/emTSigMw+5QZhfkR
	 vXoAtkJeuDH57XbSghq07+7WMQNjIsFjjrJ2JQa5FL/PuOl3+xqvPVSFkbjH0K75WE
	 4bnVQdROty1UaE5HLczaJeclKipwuCWsT7O+g6Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEHAk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEHAk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:40:26 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C664B21841
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588898426;
        bh=6DvqviWnsP5o86+PhIomjPeqp2M6x7IJfqoZNaxxcDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CmJN7cvkpT6h2/Ygm8zn3kkmnMlgnIgznuN13Yeyn989fiekb7Ss6tvUF5j7N6jVd
         LbFZwA4Hh2PJoy09qNNCbIknr9pZjgzWvmSW9w1nDFxqBhbBr6ckKpPbrAHFLEvoUe
         XyjhCjnRU4ZfX3u6MzPPKDIxPbevbWERiv4D+qas=
Received: by mail-wm1-f44.google.com with SMTP id u127so8848751wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 17:40:25 -0700 (PDT)
X-Gm-Message-State: AGi0PuY8qr3anib6yQ+uE/syTP9qki6Z2rBzuv0nJr7NyWpO0DHDP+Lr
        dHKkvkn9tlJjVuQGs7bCWVeL8WwEpkPuPzuLbc/yyQ==
X-Google-Smtp-Source: APiQypIiNdEVngEJqufHhpfzHhTA6Ke6tWhuGIVec6lorOQ3VlVHnGPVwiFmqm+URaG+oH5Zn1AX8OpBQzK+85IIG64=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr6049575wmk.21.1588898424128;
 Thu, 07 May 2020 17:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
 <20200426165753.GA11046@wind.enjellic.com> <20200429153004.GD15992@linux.intel.com>
In-Reply-To: <20200429153004.GD15992@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 17:40:11 -0700
X-Gmail-Original-Message-ID: <CALCETrX9w3anusPhNWkv-hs554N6MF9GfChazrG+Br16oFfCaw@mail.gmail.com>
Message-ID: <CALCETrX9w3anusPhNWkv-hs554N6MF9GfChazrG+Br16oFfCaw@mail.gmail.com>
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Dr. Greg" <greg@enjellic.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Neil Horman <nhorman@redhat.com>, npmccallum@redhat.com,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>,
        "Xing, Cedric" <cedric.xing@intel.com>, puiterwijk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:30 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Sun, Apr 26, 2020 at 11:57:53AM -0500, Dr. Greg wrote:
> > In closing, it is important to note that the proposed SGX driver is
> > not available as a module.  This effectively excludes any alternative
> > implementations of the driver without replacement of the kernel at
> > large.
>
> No it doesn't.  The SGX subsytem won't allocate EPC pages unless userspace
> creates an enclave, i.e. preventing unprivileged userspace from accessing
> /dev/sgx/enclave will allow loading an alternative out-of-tree SGX module.
> Yes, SGX sanitizes the EPC on boot, but that's arguably a good thing for
> out-of-tree modules.
>
> And if you want to get crafty and squash in-kernel SGX altogether, boot
> with "clearcpuid=<SGX_LC>" and/or "clearcpuid=<SGX>" to disable in-kernel
> support entirely.  SGX won't be correctly enumerated in /proc/cpuinfo
> relative to the existence of an out-of-tree module, but that seems like a
> very minor issue if you're running with a completely different SGX driver.
>
> > It also means that any platform, with SGX hardware support,
> > running a kernel with this driver, has the potential for the
> > security/privacy issues noted above.
>
> Unless I'm mistaken, /dev/sgx is root-only by default.  There are far
> scarier mechanisms available to root for hosing the system.
>
> > If key based policy management is not allowed, then the driver needs
> > to be re-architected to have modular support so that alternative
> > implementations or the absence of any driver support are at least
> > tenable.
>
> As above, using an alternative implementation is teneble, albeit a bit
> kludgy.

It is worth noting that, if someone actualy does this, and a future
kernel patch breaks it, the upstream developers are unlikely to
apologize or even feel particularly bad.  See, for example, the
current situation with VirtualBox.
