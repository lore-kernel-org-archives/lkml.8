Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA6EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528B0206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQd3cv57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgEKPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727093AbgEKPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:39:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2594C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:39:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so7884683otf.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5b9l8bgmMnIgbr+knL+15A1EoK4Eipc/zjZg84NCxvU=;
        b=gQd3cv57aXXh8e8Nergjvt1NwZXpu/2+0Bw01nEuOzTY5ZouY8Mw6U2paku4QqxRiF
         ZjqH/UD0LFJWcH05sZ/VC5UK83jYEXS8Go9FUlRTLPZqGQBIokUKW/9NkweWizCu6HWj
         wKvaEl+mhm7FzgtBJQrYZsCZ6ibb8Jl8kPbhTDKqFsd6ZOtZbw1l2qAJY7a3vhghgW/Q
         t1e9xyVFQPGRPH1ofLIw1TnPQK7ju64lqZcgB7UpN4aKJSLfN49rxmQjtyYKfUd4yZNj
         r0mpXXlGo/BNOxpikEmvtEGs36O25jv4FmqyAYmJypzJUiaQNesPI9BMRvhphtiFqUMz
         aZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5b9l8bgmMnIgbr+knL+15A1EoK4Eipc/zjZg84NCxvU=;
        b=s4A+6to/14QsHnF6nxmcC6DpPT3/KYSILIx4uezDMAKXVajBUiAkZVPzIWVVS0K4eF
         F8UUxXMp6bk6zGnD1HS1mv9Ts/fvR4HwxBFhAdrDQq+RDz6jWVg0q0C5XqUH+rfBWquc
         vNMptLTBScajNXMAjuasfHYRuOETN/ph2QNUZ4A05He+u/O8oaVAjRZRSanHS4H0Bnw0
         6FVv7oAVfzkjiLFNjVstQdHz8vL89hi2Do4HcnSB2AKKoOXZm5hRDjDF1mTrNt4mD+WM
         RjaTDie6+zpfTd5Ns41wrBPR9D5rSPeJQ/x6Abd20WCMAv+b3Pc32+PSPaRRWJ901WJ9
         D0ZA==
X-Gm-Message-State: AGi0PubctfGuSVVblQVo3I0+S01zxTWwY7EYDw4ZOG9u4gr67sd7YBbE
        jbUouql4sSd4x0+aLcKqfL2YDqVy6STCGErRB+bJvA==
X-Google-Smtp-Source: APiQypJCZEtyGYpfRr+qdSDZUeQIQYPvFj+sn1QcmzvS3L35iVcIMptGCSQQ7v8yqg6FKSf8ptyivy4WkTW13yKpU7s=
X-Received: by 2002:a9d:4e17:: with SMTP id p23mr12513619otf.298.1589211574994;
 Mon, 11 May 2020 08:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200509113717.9084-1-pmenzel@molgen.mpg.de> <87eerr3ppb.fsf@nanos.tec.linutronix.de>
 <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de> <CAM4=Rn+7RGHEGa7u33zUA0b-cBehadw4NKN75JtjKjOhxm2Fxg@mail.gmail.com>
 <87y2py6466.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2py6466.fsf@nanos.tec.linutronix.de>
From:   Radoslaw Biernacki <biernacki@google.com>
Date:   Mon, 11 May 2020 17:39:23 +0200
Message-ID: <CAM4=RnKVBhfnHRnvZado_8h__J2eq4BaXEK7KwdPnOoMhzco5w@mail.gmail.com>
Subject: Re: [PATCH] x86/tsc: Use hard-coded crystal clock for Skylake mobile
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 2:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Radoslaw Biernacki <biernacki@google.com> writes:
> > We found that regression only on specific SKU which was used in one
> > model of ChromeBook.
> > What's interesting is that some other SKU is fine.
> >
> > The consequences of this are rather not trivial,
> > so this was considered a quickfix and temporary till we develop
> > something better.
> > In contrast to ChromeOs, I know that there is no way of finding if
> > there are in fact regressions on generic kernel in the field (this is
> > SKU dependent),
> > but we also think that this problem should be addressed in a better
> > way (if possible).
>
> Fix the BIOS to setup the CPUID/MSRs correctly?
>
> Thanks,
>
>         tglx

Yes of course, but "if possible" might mean we would not be able to
fix the BIOS.
Anyway, let me see what actually can be done.
