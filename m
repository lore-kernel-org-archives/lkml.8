Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4235CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C32D206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oT2sQNKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHSKQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHSKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:16:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDBDC061757;
        Wed, 19 Aug 2020 03:16:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so24733178ljc.8;
        Wed, 19 Aug 2020 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PmuNCA8C1J0O1Ha2312XfEb0igOWHqaUnPbG9bzLCNc=;
        b=oT2sQNKHBwoqtocu5xss6pTe050xjKx7Xm6n8w1yeKBnDOZCKLy+jdONHu71a00DG4
         NseI1U26kkBM6w4vofkOT1JKfYrhdieK9LoNp0+ceTS2+Fdx3mQUQXhxJ0Og2twf7poc
         CBuDPmt2eQH38F0STOKfnsmXXamHU3tnxKRWNlse/6a9856MYEPo3Gnh0n77ILDxBML7
         9gSPiyo4qSeUXfZ7jhZjJv/IjjON9M3vsBK1y5k2ICpYiSTpclDUMacCXnOily5TELuM
         JDNchGPNrWUzPnfDbDKyi1TMZ9DGapn8gfavtBXg4RN6yAUXUIvUUcb1PlFCPZbHUxgu
         oyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PmuNCA8C1J0O1Ha2312XfEb0igOWHqaUnPbG9bzLCNc=;
        b=Tks7G4B7PAsQcUOxvNZoHeFLOxocwCe6c4EQVnflNV5Q8VH4r9NnJ/6NfC8QGNTpEx
         ptAzj1wzc72xJPt8ey//I5qU4LaR1glFOafBWrNnd454ExhOjF/cFLCfsyyVE8IZVh10
         OK9EPSTxv0KmInTC/85SkNlYSm2Dqh61fwIubtxbwRZ8cYxLzMZr2bhTvo9RRIs7IT3t
         4JRnbMv/FzL8jMNeLCEZloCRoTis6hgvlUJjHae0F12m/1BHL2pNRrqzwMakOf/N/6X2
         8DcuGSBM4M3aIzxGEQ+wFyoDP5K2ZZnwdXpLjpPqXQ4bQyP3GB1u5ndUhitLpT5vgVlR
         Z5BA==
X-Gm-Message-State: AOAM530CVFScWv1/zRheoN6mrSXvRJCMSjlKdznkZRpQ81VMFxDG0Jea
        eS7ljhrVqnSbk3ilsi8oGRyvZamNEy4qz0DHJQzQFuKBq0w=
X-Google-Smtp-Source: ABdhPJymMkRsWLyrLUupkQlTO2L8iBAdAJQrdzlms9YSPIf/rtNURQO06yV37hNiopDdSxXVpDyuCOYzl1oLMJaUfDY=
X-Received: by 2002:a2e:3817:: with SMTP id f23mr10937015lja.118.1597832178487;
 Wed, 19 Aug 2020 03:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com> <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com> <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
In-Reply-To: <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 19 Aug 2020 15:46:06 +0530
Message-ID: <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
Subject: Re: Scheduler benchmarks
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Greg KH <greg@kroah.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:45 PM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 8/18/20 7:53 PM, Muni Sekhar wrote:
> > On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
> >> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> >>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> >>>> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> >>>>> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> >>>>>> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> I=E2=80=99ve two identical Linux systems with only kernel differe=
nces.
> >>>>>> What are the differences in the kernels?
> >>>> You didn't answer this question, is this the same kernel source bein=
g
> >>>> compared here?  Same version?  Same compiler?  Everything identical?
> >>> Both systems are having exactly the same hardware configuration.
> >>> Compiler and kernel versions are different. One system has Ubuntu
> >>> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel an=
d
> >>> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gc=
c
> >>> version 7.5.0).
> >> Those are _very_ different kernel versions, with many years and tens o=
f
> >> thousands of different changes between them.
> >>
> >> Hopefully the newer kernel is faster, so just stick with that :)
> > But unfortunately the newer kernel is very slow, that is the reason
> > for starting this investigation :)
> > Any type of help,  and guidelines to dive deeper will be highly appreci=
ated.
>
> On the 4.4 kernel you dont have
>
> +CONFIG_RETPOLINE=3Dy
> +CONFIG_INTEL_RDT=3Dy
Thanks! That is helpful. Yes, I see 4.4 kernel don't have the above
two config options.
What analysis can be done to narrow down the root cause?
Any example of reference could be helpful to understand.

>
> And your base is very different two.
>
> Try to use mainline on both system and see.
>
> You can also use the same base kernel version from ubuntu and
>
> run your test.
>
>
> >> greg k-h
> >
> >
>


--=20
Thanks,
Sekhar
