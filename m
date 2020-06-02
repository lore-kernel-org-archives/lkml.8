Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53899C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21661206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 06:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591079667;
	bh=F7YZbPYiN71e1bTg0PEGxxOXDvOpaBNYCH3Vx+AkD28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EYhLKl6MVmjqa123QOACpzjdxYecH01lH88O5T7KpC718OVMTzxgii6K8y+HGMwoY
	 XG36RiSNXQGokj/hILJuw0xnyw+XA1mTEFB+MLdQM0/4K7ITezzl+04x8s5X6FGLmm
	 MkOePM02NSHblT7+XgnM2W4r0Y2YJ67TR7E3AGmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgFBGe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFBGeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 02:34:25 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CAE206C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591079665;
        bh=F7YZbPYiN71e1bTg0PEGxxOXDvOpaBNYCH3Vx+AkD28=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NuzlUw+XytCoI2Wzvn8L/zilAb0jbpwC5zE4FvRkX2z91uc0FVhMcG3mNmBtyvQ9P
         TCCV5A8ElP5+vp4/ANdS7LyqcOf6RDW3oatSSnzw5ua27olDgzXwaZ6vqQSpHQEOP9
         Znfm92H/alS/A7OobWcJ28iP5+AxqbNr3s7aGt3Y=
Received: by mail-ot1-f46.google.com with SMTP id m2so8138667otr.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 23:34:25 -0700 (PDT)
X-Gm-Message-State: AOAM531+RLrx2/hYWVZE6GdaLjcWbcizwB6CAdD3+eT97KLVDLG017wi
        Sv5GwLXhO3BCuzzRXyeKkgN6ktvc6r83+yZ/6mQ=
X-Google-Smtp-Source: ABdhPJyHxlvEsyAIH07io7sueke1XvM4e3N4qPypJbdwgB110o791doJH4AX7dXfNuyXHgG2f1P7jCiwFfMDXUzcd5A=
X-Received: by 2002:a05:6830:2417:: with SMTP id j23mr9842146ots.108.1591079664660;
 Mon, 01 Jun 2020 23:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200601132443.GA796373@gmail.com> <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
 <CAHk-=wjt9O8JReJbSTLTSeZoD3X9KkQiMhQfgRyqjA1FyQXgRw@mail.gmail.com> <CAHk-=wh2xgJ=nnfjW-yYQ4yzMOTQ17eVsfQupjd3dXu1BuguUA@mail.gmail.com>
In-Reply-To: <CAHk-=wh2xgJ=nnfjW-yYQ4yzMOTQ17eVsfQupjd3dXu1BuguUA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 Jun 2020 08:34:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGxO7WHA6nzxnvS24bEiXrbFzQaRArrU_fJXV6JKQD-nw@mail.gmail.com>
Message-ID: <CAMj1kXGxO7WHA6nzxnvS24bEiXrbFzQaRArrU_fJXV6JKQD-nw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 01:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jun 1, 2020 at 1:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok, I'll try to remember, but I probably won't. So it would be lovely
> > to be reminded when I get the arm pull.
>
> Well, the arm pull already came in, and mentioned it, and it all
> looked entirely local and simple, so it's all good.
>
> Or rather, it's all _potentially_ good, but completely untested by yours truly.
>
> rmk said he'd take a look, but maybe Ard might want to peek at it too.
>

Builds and boots fine via EFI on ARM32, thanks.
