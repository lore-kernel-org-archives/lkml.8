Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D90DC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C402071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPdqCzrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDUGlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgDUGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:41:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED84C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:41:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so2259897wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xKvOssuL7JJmsttBiv1fIXPKP57ObqKY4ux9qvYDN4=;
        b=NPdqCzrCrWuwp+BbdSfKZ2wALJctVNpq9FOqH+qB9W24tH9XaW4iJTx94HdiJIg+Jk
         gJvbfBKxzzUC6+x3KsFTH5EnnMCrVoRl4jp44lzdRsMEJ0DfoFxWB2fbjVNj+p4h1SZG
         1rOvHFe/qN4OkYu8FAhb0eOBw98VasxIoCwWh253ScQjZDRNkElYpGXkFddu/4VR5xVQ
         hSOXUK/WPpre1DM5A5psxWtcBypmRzb5P3VRboIRBlIT8G3DhzRUuECQOSmxG7lY5mpi
         EkOEjP8OM3HfohmXPRu/SXqVfBuik/aEQJt7Md3CPenE81KcRt8WLCRTKneCuc2V3Qe2
         OQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xKvOssuL7JJmsttBiv1fIXPKP57ObqKY4ux9qvYDN4=;
        b=JhF5Wl2kkuTEYy/Fq38Bp7AlG4Nvv/+Vyu6AprxQ7M3e3fMnCbZXxxPhjNy4ow2fXl
         GjQ0lmhLVpJ/PDB20OClj+I5Fs7KWNeavODX7eddWxnm5aqmiQNIAm9yZgjinwJkzHd4
         U548s9mTKwQghjlmI85DW8ZL8DIOLDNs9sSGNNksn87G45jcPUAhydAjCeyDPVGmLHBP
         PAW4jruxDjuV1mRU7otQjpAeK/SwDVz5vpC4MILIhcTSwb+W+qpvMJIAhhSpeIXALOC+
         Cudm1Hg3mM8BeAYa4tlAl2NlrKSPJE8UAVPTUGs+4OXoYeCjHx83/i7WINgaGFlvPuYS
         NmxA==
X-Gm-Message-State: AGi0PuahaR3Y2g7Lwviin6NyqJkXJxASrxFfL4FNRcyoGpIsOtuSeFTP
        V5WCllcxO9zEq4oxri+aD9MT4kyZU+IPV9nKUQLgQufMjxQ=
X-Google-Smtp-Source: APiQypL02YAnnZNGNB1vVxatPuOQrOmWIDtdves32H3kJJT5fycOolc4jjUmSakihyWqP6PQdmFnK/5UgqnzgjQuM6Q=
X-Received: by 2002:a1c:148:: with SMTP id 69mr3347855wmb.181.1587451313367;
 Mon, 20 Apr 2020 23:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
 <20200421085344.1804-1-evalds.iodzevics@gmail.com> <20200421055955.GA343434@kroah.com>
In-Reply-To: <20200421055955.GA343434@kroah.com>
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
Date:   Tue, 21 Apr 2020 09:41:42 +0300
Message-ID: <CADqhmmeNd3A7Ki8SZi4j7aubm3bHDxQ-pNM6bR56geE9BwUjww@mail.gmail.com>
Subject: Re: [PATCH v2] x86/microcode/intel: replace sync_core() with native_cpuid_reg(eax)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 8:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 21, 2020 at 11:53:44AM +0300, Evalds Iodzevics wrote:
> > On Intel it is required to do CPUID(1) before reading the microcode
> > revision MSR. Current code in 4.4 an 4.9 relies on sync_core() to call
> > CPUID, unfortunately on 32 bit machines code inside sync_core() always
> > jumps past CPUID instruction as it depends on data structure boot_cpu_data
> > witch are not populated correctly so early in boot sequence.
> >
> > It depends on:
> > commit 5dedade6dfa2 ("x86/CPU: Add native CPUID variants returning a single
> > datum")
> >
> > This patch is for 4.4 but also should apply to 4.9
> >
> > Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
> > ---
> >  arch/x86/include/asm/microcode_intel.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Why are you not sending this to the stable mailing list like I have
> pointed out numerous times by sending you a link to _how_ to get a patch
> into the stable kernel trees?
>
> Again, here it is:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>
> Please follow that so that we can do this correctly.
>
> thanks,
>
> greg k-h
Sorry, I might sound dumb here but should i just send it to
stable@vger.kernel.org or try to tag it Cc: stable... in sign-off
area, its quite confusing for newcomer.
Thanks for patience!
