Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F9B20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY4pOyYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391439AbgFST6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390834AbgFST6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:58:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4A4C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:58:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 190so6258573vsr.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5P1biYgKc9Nq54rw9Pc6fjuvnDZztG4MWOhECOt2hVo=;
        b=jY4pOyYzaQugUwgcqlEWlo46LB1hb2MhsDOLXIc2Op9UORON/wBv0h5BH6cS4ube2h
         jGVYX3hWlyR/6d9RVg6BkU4hc6zuVvgRH67T+dDrveH7IFIkytgCP1SjBs6vqxYyJ+eD
         DjaR1mSKtkS/KmtbKpAI9Ei1l65GPpTOSDomVKw6Atrn65aAvZiykFgFafvfkwFGS9x9
         0qZIi5aB9zZVJUYVtmlU/RGS/ZLT+QAhGC84IDRVIlTDUoLxekuklzDHB2oaqi5HOQhF
         duNtSIcV8as6MyfUvg+toYwCX2Iunk76e418g0juybCYrwk++w+f5sd4+59Jn7k843Wg
         atZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5P1biYgKc9Nq54rw9Pc6fjuvnDZztG4MWOhECOt2hVo=;
        b=io8GI/l3aPpF23R3SUOgFvQ+p2g6eKfCw2MgGREwCI4JUb41623f8V97xei7PZhL9j
         igUFtxEHya8l1yDbmrdO/Epl/i5USohLSuIrW/qb0UM6ZubNBooHdohP3Vjfd5HTJCax
         igXabOjo9iqJ56oLuOuz/QzqjOuYyaBlh6UKdTWlBdIKxbpmZ89q1lWjLwzBpnO7m9nM
         PRK7NUbNVlJa+u2VpUH3Suo/OCB8Vopy7DUX/2uuA5p0U+8zC0dIXqTRtb/UtC4BPiAI
         SlFnd/J3gJlniUTc//i68NkaqlOoP4Se5UTkdclJzEYeXTjWqtJ8aBFlwZOoqQTYnbG6
         cb5A==
X-Gm-Message-State: AOAM530T0HK8jGfk9FN0Xf4eaicB/vTgXg1ldhvtfh4c8BcZQo0gh9OZ
        MpRBGlwtwDf0xuHA5gSHhhTrPnTQUtWiSSHBEFk=
X-Google-Smtp-Source: ABdhPJw+ETlDl45aFICnKOzzy1Yi7P9QIkbq+ufeg+SIGWBI5Hl8B4bZNIOqObpsuZ4AaJZulMhQLz/QyfTA7IRtjFo=
X-Received: by 2002:a67:d597:: with SMTP id m23mr9178092vsj.209.1592596715104;
 Fri, 19 Jun 2020 12:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic> <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <20200619161026.GF32683@zn.tnic> <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
 <20200619164056.GB2235992@kroah.com> <CAD2FfiHVyt2hWBqcgtxbBaLEuxuzz6yAe1+8sK5J0SYWVEr5qQ@mail.gmail.com>
 <CALCETrXKzmdXtHsdBTJB7+RYZX5UOD_Q4MVd9zVAVOjYgU5WRA@mail.gmail.com>
In-Reply-To: <CALCETrXKzmdXtHsdBTJB7+RYZX5UOD_Q4MVd9zVAVOjYgU5WRA@mail.gmail.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 20:58:23 +0100
Message-ID: <CAD2FfiGT5bsb0sd2k8NGNmShvW_q3UV9YXgn-EwxBCJjx6PSTw@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 20:41, Andy Lutomirski <luto@kernel.org> wrote:
> I don't object in principle to Linux giving userspace more visibility
> into what's going on, but I'm not convinced that adding a new
> must-support-for-a-long-time interface that only solves 5% of your
> problem is worth it.

At the moment the only visibility we have is "the CPU supports TME"
and "the kernel printed a message in the journal". The sysfs/procfs
file read allows us to notify the admin if the firmware is
deliberately disabling TME for some reason, without resorting to
`grep` on dmesg. I don't think perfect should be the enemy of the
good.

Richard.
