Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581B8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A82221473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587390215;
	bh=QZam6/Jc0zmflQrHk/tdI2JQLCdcFtvCqq02VxQ2xgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BeNXLh7XUP21oH70wmUTKjXLruOE1QuLxofNGncr4LpnMkXDwEgdaBn+3sitUXClJ
	 cE7VpHrJdlrxm5Fprb+HFkx53FbccQXeoJMABOJKz27pIxRZOAcHEn8Nx3LUW7+Z9o
	 /uJz6iDbgIPCjJkXm2wSNJ76/a5/ZZo6R9MuR63s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgDTNne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgDTNnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:43:33 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F87721473
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587390213;
        bh=QZam6/Jc0zmflQrHk/tdI2JQLCdcFtvCqq02VxQ2xgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iUF22fF6UL3O3WqRu185lGxaT4VR1bUQPVizSD8ZNeX7VpAcN0ohK0bWwhmNPzVxR
         nOF8P6I+1ry5tSjvG7rmO0ijXhF1jR9sl2Xri+8x95E5M9ZGydOVdK3p3IRJGb343n
         FSAISa/0xSk89rwOJcJYA/PxID0SmIDz8CLiMmTk=
Received: by mail-io1-f51.google.com with SMTP id z2so6610740iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:43:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuberwbKt43mY/Ohfngl9r/gMhzJHTuEzeCeHDAHGNfz0rI07ow2
        1vQI++PsiSC85LLLVTDfQ36rxQ6RFuE5JFG4D1s=
X-Google-Smtp-Source: APiQypKXum9Iy6YtGvuvucK0LrpReg+xpC/7+/mbiL65m2YUD50V074/5roSPLc8Gg4mpQXrq9k2/pZgUFrzmcrhhvM=
X-Received: by 2002:a02:3341:: with SMTP id k1mr16096555jak.74.1587390212759;
 Mon, 20 Apr 2020 06:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210452.27436-1-kristen@linux.intel.com>
 <20200415210452.27436-10-kristen@linux.intel.com> <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
 <cff1fa99-c692-d9f2-f077-60d630bb40bc@linux.intel.com>
In-Reply-To: <cff1fa99-c692-d9f2-f077-60d630bb40bc@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Apr 2020 15:43:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHtT9Ope+rcuGipK20ovAWq7Vpt17zeLuFA=acRYPyxag@mail.gmail.com>
Message-ID: <CAMj1kXHtT9Ope+rcuGipK20ovAWq7Vpt17zeLuFA=acRYPyxag@mail.gmail.com>
Subject: Re: [PATCH 9/9] module: Reorder functions
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Jessica Yu <jeyu@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 at 15:37, Arjan van de Ven <arjan@linux.intel.com> wrote:
>
> On 4/20/2020 5:01 AM, Ard Biesheuvel wrote:
> > Is that the only prerequisite? I.e., is it sufficient for another
> > architecture to add -ffunction-sections to the module CFLAGS to get
> > this functionality? (assuming it defines CONFIG_FG_KASLR=y)
>
> I suspect you also need/want at least normal KASLR enabled as
> a "does it even make sense" common sense threshold

Fair enough. But that is more of a policy concern than a functional concern.

FWIW I took patches #8 and #9, hardwired a couple of CONFIG_FG_KASLR=y
checks and added the -ffunction-sections GCC option for the modules,
and everything appears to be working as expected on arm64. I was just
wondering if I was missing something.

Note that arm64 does not have a decompressor, so there the fine
grained randomization of the core kernel is not really feasible using
the approach presented here.
