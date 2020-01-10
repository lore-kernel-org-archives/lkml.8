Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE3C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA17D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 02:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG765F8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgAJCJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:09:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45196 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgAJCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:09:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so416648ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 18:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4EGY9E2x/SkAY5ypNNovap4WyyEX7OCvqo4o4ElTiI=;
        b=CG765F8Wc69HfycniYIukc82Y/Lt+AnIHQ4oupzFv9Ay/kIZEqDWcuncuJ453mu4TG
         mb9SuTTKH4Nsq7LC18frT+FHu2iQAqpsslZkH06uj/WSEmyDDqwKF1Bzb5akSTP3xrEr
         KguU9wsqhKxAVv9X4ocQvQJHIC37EzBW6e4+My55/m4nZ65JtdXerh99zQegUTv/9JaB
         AUJoaRYlZc2E8nyt4fIGtzhlo44b0bVrx3xkegLnfsY1rLlRTRkJyuQtrNDWK+VQrbfb
         SlqhHnIlP/ZvYPyF/YHxiZrlWonn5EitlNbADiQnMSgdRM8XPi/MozfxpXaIP2d9mb3C
         L4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4EGY9E2x/SkAY5ypNNovap4WyyEX7OCvqo4o4ElTiI=;
        b=DnaFhZqE19qq6RIpLfz7FbOhOHscyyuLtp3qJ1urkcf6e1jZ94v0vGVhW4GbLX6d7Q
         lQj6yFSyC0m770qlZYU5fIbafvbGAvsQkJaZ6mOqe0tYqLOhr3UlwYR+q4/zyrJ8CX3x
         RHuP8ATs8v2uc9M/Vz2aLMadSgOPuYYP6GBDACy3eHwGNuT1TVZZOqRzAwUqWbluhJCd
         jAP68GHYBG13PErjHiTkW3aUqJgVfWU6uPsQaK66uadRyyCGsUGWcvNRV3G5K8102uRg
         B2lI+0Pz6nHqIp8IFRX/9/dymeB3aczeZEJUN6tqpo3nmH9wEruliQjNq+qpYIjvOPnz
         d2Tg==
X-Gm-Message-State: APjAAAWThgxUtVIgWi8WfeHNWuZeQGyRdwi4/ghXb5mZ56uWJcCc49cI
        VkKZOvuVhs13UFGJo6kCAQS8xe7GULZHVdCfp3M=
X-Google-Smtp-Source: APXvYqzaR21ZRmjdArwdj62lKXqcCd/et0SbF+lqBPclZJIYeCEgY4LUONnwnhFOK2TgpOZm/8qVgA9F5xYSC3dby9o=
X-Received: by 2002:a2e:7518:: with SMTP id q24mr706748ljc.119.1578622189693;
 Thu, 09 Jan 2020 18:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic> <20200109204638.GA523773@rani.riverdale.lan> <20200109205041.GJ5603@zn.tnic>
In-Reply-To: <20200109205041.GJ5603@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Fri, 10 Jan 2020 10:09:38 +0800
Message-ID: <CAFH1YnNdmHD9rnriTVx-se-Z5MHsgUZ0jYWMrg6OYVjr4Ap+JQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:50 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Drop fanc.fnst@cn.fujitsu.com from Cc because it bounces.
>
> On Thu, Jan 09, 2020 at 03:46:41PM -0500, Arvind Sankar wrote:
> > The boot/compressed Makefile resets KBUILD_CFLAGS.  Following hack and
> > building with W=1 shows it, or just add -Wunused in there.
>
> I'm interested in how he reproduced it on the stock tree, without
> additional hacks or changes.

I indeed used additional parameters as below for daily build.
# make O=/build/kernel/ -j4 EXTRA_CFLAGS=-Wall binrpm-pkg

Regards
Zhenzhong
