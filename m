Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B141C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5CC20722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIuSO/io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgDTOBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbgDTOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:01:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB03DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:01:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so10275541wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nGuznqPQVxvGaP746xcMyyf7NdOV9xFBW2bKm7VLm4=;
        b=cIuSO/iogtSFqqxX/QDtAkGGfR+FVCcgrJxKqyvkLXJuh8jRtHDvWXytftRCh26ldF
         Z8XIrM0rXu+qeQM/2GvXqTHFEtYnaOpr+vTppscJs8t2Jo6qGZianoTbxZOGuFGVTYUC
         XIQ5dq78tfn7CBGaXD6Ru1akCy2DNpJdb4UK2T/gUx3MBIE/3IcKyBkVqgbNbHFAvSYv
         YmFmir8L6CFAgeux9FS6LTiFM3XRryvv9dS6EhSyl8abo2HjE1YdwbFhLykOudPcG8QK
         u6sVIbVnNg1aL5H0uZdHv3r4Y4X9OycLq7DJ900kfHEexOztczB3jgPhN/ceSfqdasak
         tVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nGuznqPQVxvGaP746xcMyyf7NdOV9xFBW2bKm7VLm4=;
        b=s7e3pSYJvyzaS0bKQkasgWH6rk8jAw3AU3l/WT1twE4wSg0eC4AMTtWsPmo4Nl5nW9
         Pt9r7eDFMZl6hRkrE0DN1u56NEJF4rQxYVc/FJTw+prvc8q67tmcRILVEfz62HULCJ5v
         PBu251yp7S6GHioWztdwP3aMoikgHWJi9iU/j2PRuZBGrm6gh/MsC4YfonhJuBcGlzGY
         yEDyx8uBKS5rupJosy9G4QA8amLfIc1gQ2TMxTctSr4c6BK4SIK/9t1qVWwtgVqyX0ev
         WlkQ+lFoHLrpa5TzS289gogQd8J+r6/6l1DPT1qrfRAWTUTyyiZxJG/g9BT2m+mfHunk
         Wlcg==
X-Gm-Message-State: AGi0PuawU56vGuPBppF7jlHMxDlcXftSZbbV3nSyNEEd5Yfa8yM/caMt
        8NJHamW0FhCiEUXRO+uunG/UYdZAdn5PysghAtw=
X-Google-Smtp-Source: APiQypLh49tknvbJO1KoyFlR7EsoQvmG+8GHBBOTFEjZpoUaD4f1lKrwv8+eaChcXFYOhhZDbes5i/JdfgUn8Og1gpE=
X-Received: by 2002:a5d:688f:: with SMTP id h15mr19157221wru.352.1587391271524;
 Mon, 20 Apr 2020 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
 <20200420093129.GA21839@zn.tnic> <7fb8e9ac69a1c03a673875dc39fcd8f94407abca.camel@decadent.org.uk>
In-Reply-To: <7fb8e9ac69a1c03a673875dc39fcd8f94407abca.camel@decadent.org.uk>
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
Date:   Mon, 20 Apr 2020 17:01:01 +0300
Message-ID: <CADqhmmdvDXB3BQ3zk-DWF=UUwTrFhLjJWqiTce=G9KVasoec2A@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode/intel: replace sync_core() with native_cpuid_reg(eax)
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:33 PM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Mon, 2020-04-20 at 11:31 +0200, Borislav Petkov wrote:
> > On Mon, Apr 20, 2020 at 03:00:37PM +0300, Evalds Iodzevics wrote:
> > > sync_core() always jums past cpuid instruction on 32 bit machines
> > > because data structure boot_cpu_data are not populated so early in boot.
> >
> > I'm guessing because boot_cpu_data.cpuid_level is not properly set and
> > very early code in head_32.S sets it to -1 temporarily until the highest
> > CPUID level has been detected (or not).
> >
> > But the microcode loading happens *before* that.
> [...]
> > Hrm, the original patch of mine did use native_cpuid_eax():
> >
> > 4167709bbf82 ("x86/microcode/intel: Add a helper which gives the microcode revision")
> >
> > but the backport:
> >
> > commit 98cc1464cfd6edf9dc7fa96aaaf596aae952029b
> > Author: Borislav Petkov <bp@suse.de>
> > Date:   Mon Jan 9 12:41:45 2017 +0100
> >
> >     x86/microcode/intel: Add a helper which gives the microcode revision
> >
> >     commit 4167709bbf826512a52ebd6aafda2be104adaec9 upstream.
> >
> >     Since on Intel we're required to do CPUID(1) first, before reading
> >     the microcode revision MSR, let's add a special helper which does the
> >     required steps so that we don't forget to do them next time, when we
> >     want to read the microcode revision.
> >
> >     Signed-off-by: Borislav Petkov <bp@suse.de>
> >     Link: http://lkml.kernel.org/r/20170109114147.5082-4-bp@alien8.de
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >     [bwh: Backported to 4.4:
> >      - Don't touch prev_rev variable in apply_microcode()
> >      - Keep using sync_core(), which will alway includes the necessary CPUID
> >       ^^^^^^^^^^^^^^^^^^^
> >
> > decided to use sync_core() for whatever reason. Perhaps because the
> > native_cpuid* things weren't there. Adding Ben to Cc.
>
> This commit didn't introduce the call to native_cpuid_eax(), but only
> moved it.  So I didn't think it made sense for the backport to change
> from sync_core().
>
> If it's important to use native_cpuid_eax() then these older branches
> should presumably get backports of:
>
> 484d0e5c7943 x86/microcode/intel: Replace sync_core() with native_cpuid()
> f3e2a51f568d x86/microcode: Use native CPUID to tickle out microcode revision
>
> Ben.
>
> > I believe this is the background info Greg needed to figure out *why*
> > you're doing this.
> >
> --
> Ben Hutchings
> Klipstein's 4th Law of Prototyping and Production:
>                                A fail-safe circuit will destroy others.
>
As far as i can tell, these two:

484d0e5c7943 x86/microcode/intel: Replace sync_core() with native_cpuid()
f3e2a51f568d x86/microcode: Use native CPUID to tickle out microcode revision

are already made obsolete by:

98cc1464cfd6  x86/microcode/intel: Add a helper which gives the
microcode revision

except that it still relied on sync_core() witch did not behave
correctly on 32 bit machines
