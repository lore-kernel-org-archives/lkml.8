Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6101C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B755B2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQKBtVxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405734AbgFSQr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbgFSQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:47:54 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4458C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:47:54 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q2so5967007vsr.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWEHEDf9ab+QI14tCX+z1GolOFkuRHuWtHZkHv7sE/8=;
        b=ZQKBtVxbpMHTtarCdFEv2SLhsy1BOUCpKkvJz+7JCgxv+YLk8hpjSCZhAzUBGAQ2t4
         +4YZTMvnx+jQZOqP8+yheWFmnjN6wUksFeVVlPRasvalm5mL/phB2Uw2Dpwkx4wYwtx1
         ak4GFtqU29TNADOA1+On2OteQPA5/swts1SbLg92Igwa6/zSOrESGoCqlzS4kGd6qbV0
         fUA8bTqfUeUHaaBzHIfPrWawa//gyGKcrkLltdj6GguP+ufq93wLJbA1CYEEknvQEs9Z
         w0Z2OJvuAhb28Xf7dsz6nK3QfzKqBfyzurDhADJ8v0x4BqJBMKiLfZgIMYq/dx+H9BfL
         rVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWEHEDf9ab+QI14tCX+z1GolOFkuRHuWtHZkHv7sE/8=;
        b=cm8iXqi4svszy32nPAmJJ8+mrXfPgxsLjDQRYL6ZWg4TMzC87FcKHBS+iOSnoc6AnF
         lkhnUuN5DLsDvuWjptUQAJmfM9KY9wCZHnV25BGNJvU+aFWTZOjxRutu0aFI+3MmQhnT
         vKhzedrNruYyC7XD21j7bzD82R/l/wTARz9MKPzSb5qfFmbUrz7w53QLoYrz5wPkPlDc
         7Bn95OIRy2suHsj9I4vQs7KNwhlXOjKV5z++ZSoyxJwseIs5evmikACNOr4kcXhaA1rB
         P4DauHWCTgRJ9gqnDTzQ0KK7Ho/6k9YZz5yCutkyeMjqTK40XZhEcMOiDjU7JMOM6hUD
         SVDw==
X-Gm-Message-State: AOAM5337sg+igYKPlotJs2YrclgpL710kfoWB+pfduR9AqUMP5bZYS8T
        MOy33bYuv327u5De/sP2yfMuK99qLcJTWep2Wpo=
X-Google-Smtp-Source: ABdhPJzoqfCqyBo15NraAidXM2iN73KVqB72eAgjyPEtEdAyPlU41JcnyfE4tEok1IiLqFElTgTX4gcAbxB4NSramx0=
X-Received: by 2002:a67:fd16:: with SMTP id f22mr8103695vsr.213.1592585273962;
 Fri, 19 Jun 2020 09:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic> <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <20200619161026.GF32683@zn.tnic> <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
 <20200619164056.GB2235992@kroah.com>
In-Reply-To: <20200619164056.GB2235992@kroah.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 17:47:42 +0100
Message-ID: <CAD2FfiHVyt2hWBqcgtxbBaLEuxuzz6yAe1+8sK5J0SYWVEr5qQ@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
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

On Fri, 19 Jun 2020 at 17:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > Yes. I want to show the user *why* TME is not available.
> So even if it is "available" that's fine, even if it is not being used?

No, it's just one more thing we can check and report. For instance,
"Full memory encryption: NO [firmware-disabled, unencrypted-swap, EFI
memory map incomplete]

> And how can you ever tell if a BIOS disables a CPU feature, yet the chip
> still has it?

Isn't that what the "x86/tme: enabled by BIOS" kernel log entry is for?

Richard.
