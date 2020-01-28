Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B07C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83262087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580245480;
	bh=+PcuDJR87Z84ZF6fHq7Xj84odDCvacpFEgLJtRCp9Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L2q4VoNm5IdhpJWJw2xWH4qQfrhBSK5CkEl7Zcfo3ZJ8Rbg1MmTWSeKmMHV/GKspJ
	 QwjAZ/NlR1BePZLoYYmiMIqtygsC/Z0OEeVM8Nhr/k8BKD2U8nEjsNjn6n5URMJWzT
	 rwH/6D6aV5ynWXRu0q40X31FrbwOWknHPLgCgqh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgA1VEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:04:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46563 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1VEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:04:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id z26so10188615lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/eULCr5vsyBQta/lIKXrIm1du/YTcW/0/5O/nZyTK4=;
        b=Lkr8rGLClNAdtpm2R/RQBZAFKlszOSJ2txy++VcJusntk1lnEdvsv2pIKFttF6bmQU
         2PHzXsyYuxD73Owljvpe4yRWQKp4cItC0hR0jenrqAwo81cgNviQiRdcmtexjiwTi1yx
         TrrkPib9A05Dd48rFoLbrdCataBAQtQLXZSEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/eULCr5vsyBQta/lIKXrIm1du/YTcW/0/5O/nZyTK4=;
        b=lUaweyIO3c4eAk2+cnxP1JchrQ5LWQoW3f/SjfW/pNzuR/dKWDrhZC66Sl+H46CQPb
         xEcQiEtzvg5DAaW2bxPxESDwyctfWhFDmoka6dgtTp4m8T0+egOoXuLE5/QpvMA8mwh6
         7VVZhxd1TC2s/AYielPIB0wU8GVHBIpscDh8xvf9HnxzNiKvrc+SraGkOPxCClE/7XWL
         K7mrtOhf1Vvxt73qq7/4eFfbwz/fhAyPCSz+mz8JJ8SEDOzwLQnggiTSBe+z+9RCx0Dr
         0ptgYiXRvIn2N42EznpJqWcNAQnucR7ysn5dZGCAahb41ctAs3XH6uf6u6TOMhk4BysI
         FYpg==
X-Gm-Message-State: APjAAAX5x0j834TtvpM+VyHUUnU6F2SMiAHuisqelcyEcmpZ4oitNDiZ
        WMer1D+UEtT5STAx3R80/PXqo7PKbVw=
X-Google-Smtp-Source: APXvYqz5YAskrvz+ds7GyzwMRB3qcaqK18nWrvkaVRA3cfFEqAgyAAFhP6OKPtHq9UUimSllvLm5vw==
X-Received: by 2002:ac2:5a43:: with SMTP id r3mr3546617lfn.150.1580245477034;
        Tue, 28 Jan 2020 13:04:37 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h24sm10128890ljl.80.2020.01.28.13.04.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 13:04:36 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id l18so10238366lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 13:04:35 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr3472139lfm.152.1580245475597;
 Tue, 28 Jan 2020 13:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20200128165906.GA67781@gmail.com> <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7F5517F9@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5517F9@ORSMSX114.amr.corp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jan 2020 13:04:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wipvtDUE=MZ=y7v1Xm7PE0pAaUwS26X1Zx5iL768yK=oQ@mail.gmail.com>
Message-ID: <CAHk-=wipvtDUE=MZ=y7v1Xm7PE0pAaUwS26X1Zx5iL768yK=oQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
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

On Tue, Jan 28, 2020 at 12:41 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Is there still some easy way to get gdb to disassemble from /dev/kmem
> to see what we ended up with after all the patching?

Hmm. No, I think it's all gone.

It _used_ to be easy to just do "objdump --disassemble /proc/kcore" as
root, but I think we've broken that long ago.

               Linus
