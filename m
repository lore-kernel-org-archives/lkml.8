Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8DC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA882068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDUQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:04:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:6986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgDUQE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:04:56 -0400
IronPort-SDR: yii7rNWjbB2ZqdxRO7ovcA4thHBneoG7SbotbLsNP7aQuDe4oOxirmM60aiZP9+5lcbU8vcO4e
 F7mj6T2296ZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:04:56 -0700
IronPort-SDR: qRcJMXn+SpuAzjLVQ+pUxSoamDQ1pOkcUjVQ5GA9MbDsuXFxcr2tJthsMkbiuG/coEFXn5/EYX
 q0jpOS2/4lhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="279691377"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2020 09:04:56 -0700
Message-ID: <6eb0a398097d16f7247accdfa9c21c1da90e0461.camel@intel.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Date:   Tue, 21 Apr 2020 09:04:57 -0700
In-Reply-To: <CAG48ez1u9=Uqcx2dH=7xea1R+WpnL239DSoVHLwV09=FxZUevQ@mail.gmail.com>
References: <20200419100848.63472-1-glider@google.com>
         <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
         <202004201540.01C8F82B@keescook>
         <20200421034249.GB23230@ZenIV.linux.org.uk>
         <CAG_fn=X_eQ4G-0+oAO_q+_zRnkfMf4uhfMcnoYt4i1N_noKgdA@mail.gmail.com>
         <CAG48ez1u9=Uqcx2dH=7xea1R+WpnL239DSoVHLwV09=FxZUevQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-21 at 17:09 +0200, Jann Horn wrote:
> +x86 folks
> 
> (rest of thread is on lore
> <https://lore.kernel.org/lkml/20200419100848.63472-1-glider@google.com/>;,
> with original bug report on github
> <https://github.com/google/kmsan/issues/76>;)
> 
> On Tue, Apr 21, 2020 at 2:54 PM Alexander Potapenko <glider@google.com> wrote:
> > On Tue, Apr 21, 2020 at 5:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> > > > On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > > > > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > > > > 
> > > > > > KMSAN reported uninitialized data being written to disk when dumping
> > > > > > core. As a result, several kilobytes of kmalloc memory may be written to
> > > > > > the core file and then read by a non-privileged user.
> > > > 
> > > > Ewww. That's been there for 12 years. Did something change in
> > > > regset_size() or regset->get()? Do you know what leaves the hole?
> > > 
> > > Not lately and I would also like to hear the details; which regset it is?
> > > Should be reasonably easy to find - just memset() the damn thing to something
> > > recognizable, do whatever triggers that KMSAN report and look at that
> > > resulting coredump.
> > > 
> > 
> > Seems to be REGSET_XSTATE filled by xstateregs_get().
> > Is there a ptrace interface also using that function?
> 
> It looks to me like the problem KMSAN found is that
> copy_xstate_to_kernel() will not fill out memory for unused xstates? I
> think this may have been introduced by commit 91c3dba7dbc1
> ("x86/fpu/xstate: Fix PTRACE frames for XSAVES", introduced in v4.8).
> 
> There seem to be no other functions that reach that path other than
> coredumping; I think the correct fix would be to change
> copy_xstate_to_kernel() to always fully initialize the output buffer.

Yes, that makes sense.  On the other hand, the kzalloc() fix prevents potential
similar problems for other regsets.

Yu-cheng

> 
> The ptrace path uses copy_xstate_to_user(); there, instead of leaking
> kernel memory to userspace, parts of the userspace buffer are simply
> not written to at all.

