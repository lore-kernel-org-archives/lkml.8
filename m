Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D15C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85EF20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+HZdyhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCRTqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:46:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36146 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:46:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so4825526wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rC8AgIWLKAkCeN1KwaeJMnM0w+MPm/U05s1kupzlaXM=;
        b=f+HZdyhYyxuL7eJbw6l6sTDJuHuz3WP7jPWdt+szfdLRGtlMsafDOsxca2oImFDWip
         3ucutTXqKqsKHMy/WPqSFn58b2ybWh5r4XS8OEVPvt2Y0GySO/+rYmB1G/WHkr5JIBLU
         aRlR4pV/5L2300gYmssxWxqhkFBg/Ida+XwYZXaBH3j9ZbMxtLy53qPxRKIouP8oE7qv
         pAmf8Ev/NzW/6QObHzrkaDTBZLw3DlAzP8E0OUMCXkRMsX/8EDH6OtN9gOCmF79Tmp5+
         JBKlfn4H0eZugsFGiS2C5oxzL2ocdYJGAL0IsfyG/iFQugAOFRPuHrh4rDJdxLsJsC2S
         3gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC8AgIWLKAkCeN1KwaeJMnM0w+MPm/U05s1kupzlaXM=;
        b=lz6OZ6VsCoMtvNQWIPsMQ1Bw2ZReyaynOKAR5gVOuuMGRtCF6xByzAMu24fer7584s
         PJGftyMeXusiSozeI4mOGsbI+d2IOCyOabKxbcDDKd+0XUJvflSpwn+86mBY/aQ1lqUG
         zQ5OwQJKn8Gmbda52Kv8X7Hkb9gzLYeO0Wb8NWWQ9k2MMq3X7ckWinn7pB2Xkm/IIadm
         qkwTnAhAClz1zcNj0pakaw2RPJGX9SBv3DlhvxXFFX/sSt8H9MiIqGcKAgVYWHnOZoyK
         yDO09Y2A4mIaSTC8KmuehAQtAeKulD5kgtXnjUHnPueMNfhGST1oN+gFSstXaQtQjt5W
         LtJw==
X-Gm-Message-State: ANhLgQ11+Br3Efj0WX41rBPUIw4ABke1k0IHoygau2MaDse2ZyVY2dQ0
        9zDP/iB4EuDUtm8UYxNFYzKsL0/Vzam2HeYsBjU=
X-Google-Smtp-Source: ADFU+vvrK3C7CwxBJGdrhTZ68CbTCweqKUbwuVKZRWsz131M+cX7xDRBIqlY833fyyy1A+6tfV7AWUFnQoo9VanbNA4=
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr6726656wmh.130.1584560806892;
 Wed, 18 Mar 2020 12:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200314213626.30936-1-dkgs1998@gmail.com> <20200316125824.GB12561@hirez.programming.kicks-ass.net>
In-Reply-To: <20200316125824.GB12561@hirez.programming.kicks-ass.net>
From:   gilad kleinman <dkgs1998@gmail.com>
Date:   Wed, 18 Mar 2020 21:46:35 +0200
Message-ID: <CAOQ9fa_p2_nrxaMFf5OZRXq-u+po9=UgpX-ss2FON4zCCrPb_w@mail.gmail.com>
Subject: Re: [PATCH] x86/module: Fixed bug allowing invalid relocation addresses.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you load a bad module and the kernel crashes -- the panic message
will usually be related to the module and easily traced back. If you
load a module with a bad relocation table (because of a bit-flip \ bad
toolchain), it will override other kernel code, resulting in an
impossible to trace back kernel panic.

On Mon, Mar 16, 2020 at 2:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Mar 14, 2020 at 11:36:26PM +0200, Gilad Wharton Kleinman wrote:
> > If a kernel module with a bad relocation offset is loaded to a x86 kernel,
> > the kernel will apply the relocation to a address not inside the module
> > (resulting in memory in the kernel being overridden).
>
> Why !?
>
> If you load a bad module it's game over anyway. At best this protects us
> from broken toolchains.
