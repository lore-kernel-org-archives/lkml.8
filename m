Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529A02071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhb0XBmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgEYHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:55:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73410C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:55:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so13222564qts.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8YX/FjgODFHrbyU0YnhV8IiHyHZk2RhYHJIXiYFKBgI=;
        b=Rhb0XBmBCwPkw4V0ECSGwY/AlQuJiNbMYJG3p92NtXWscZ2MiRuXXnDQNDEpvuOnOu
         61BWBPNeHTtpAT0R2XhhtTInt1+vdbvp++jrdI+/0a3Z/fEvEFrmG5kIq6fBquA2YgJj
         g7pXW7ov73tCWIBBUDEwBmbcKJOqGpadbH3d3PWqNWXE4lh/skzfhCnF16dka9zc3FQC
         rXYELeQTRgQWH7XgtvuPgbQUjcvcJIAYboHHslYHLCV4FsqjfyfycQ+I0BoSZqJJCxlC
         4EBvHwIS3pzv5/e6R1vpxsepuIFLL/qK59SEScMUiMByfwGNBqimCUAFDTF8Uez+mlVN
         Hx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8YX/FjgODFHrbyU0YnhV8IiHyHZk2RhYHJIXiYFKBgI=;
        b=QrPajsSA8xqNmsBR0dB/HPWrhuw1kiZnlOf6I3GXfIhZKfDKhnC3GWiBMq7TaC0TTL
         ln/CsMdesgHkDXrA+0du0So1bl6CCoDlB+iHpYEiNCBsQcV6m+RBwBYA3wMav87EfWkX
         USHjx+AxJnzRMkmUiWFhA4S2yz0A9Z8eNzfPgZTi5rif+kze97ILLnjrJs+VhC2fHuAw
         oKGiuNMDqXqdpSlDiZPGgBAX5qHOXka7jUwf9cp+xpuS4Cop1j5Dr7oDY+FC7GS+65Qe
         cYAA2VIq+SWHMg2+zONzDYnw4iWp6D6TLsqwTFmsOQrHGty5VNGpvszNK+M81ppB7100
         pifw==
X-Gm-Message-State: AOAM531ns0XoSvPg+6T+cYMZPnoiGnfSXjtxvg0+xQDECwb/lqHy7VFR
        ajuqBlUT5I2pAUcP4W2CVcH+IYkD/r25eQs0CFc=
X-Google-Smtp-Source: ABdhPJwpqRqDrN/UVFsFodcequ9Idqfu89HPWaqIzbpq4OgPV9FKWGm8uMFsVcBzj8G/S4x7YNH4cwpeIBZrR93ZpBg=
X-Received: by 2002:ac8:2c44:: with SMTP id e4mr28004200qta.13.1590393300730;
 Mon, 25 May 2020 00:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de> <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu> <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com> <20200524211945.GX33628@sasha-vm>
In-Reply-To: <20200524211945.GX33628@sasha-vm>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 25 May 2020 09:54:49 +0200
Message-ID: <CAFLxGvxeg6+DY1LMTzvJe3=iW=zLyUj4xTRda99DurKdS6TDWw@mail.gmail.com>
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        chang.seok.bae@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:20 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Sun, May 24, 2020 at 12:45:18PM -0700, hpa@zytor.com wrote:
> >There are legitimate reasons to write a root-hole module, the main one b=
eing able to test security features like SMAP. I have requested before a TA=
INT flag specifically for this purpose, because TAINT_CRAP is nowhere near =
explicit enough, and is also used for staging drivers. Call it TAINT_TOXIC =
or TAINT_ROOTHOLE; it should always be accompanied with a CRIT level alert.
>
> What I don't like about our current system of TAINT_* flags is that
> while we can improve it as much as we want, no one outside of the kernel
> tree seems to be using it. While Thomas may have been commenting on
> Graphene's behaviour, look at any other code that did the same thing:

Even if these modules would set TAINT_ROOTHOLE/TOXIC, the vast majority of =
users
have no clue what these flags really mean nor bother to take them seriously=
.

Almost every customer system I get my hands on has the following flags set:
C: Some driver from staging was "needed", mostly media or wifi stuff.
O: Customer did a custom module.
W: Random warning from vendor kernel at bootup because of a slightly
configured device-tree, etc.
P: Sadly too. Mostly because customer has custom module and forgot to set i=
t GPL

All this trained users to believe that a few taint flags don't hurt
and only in a perfect world
none are set.

What works and raises attention is Steve's trace_printk() warning:

        pr_warn("**********************************************************=
\n");
        pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **=
\n");
        pr_warn("**                                                      **=
\n");
        pr_warn("** trace_printk() being used. Allocating extra memory.  **=
\n");
        pr_warn("**                                                      **=
\n");
        pr_warn("** This means that this is a DEBUG kernel and it is     **=
\n");
        pr_warn("** unsafe for production use.                           **=
\n");
        pr_warn("**                                                      **=
\n");
        pr_warn("** If you see this message and you are not debugging    **=
\n");
        pr_warn("** the kernel, report this immediately to your vendor!  **=
\n");
        pr_warn("**                                                      **=
\n");
        pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **=
\n");
        pr_warn("**********************************************************=
\n");

Maybe we can add something like this for taints too? :-)

--=20
Thanks,
//richard
