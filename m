Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687CFC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4003821973
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtd/LmV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEEUib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgEEUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:38:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B02C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:38:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v22so558429ejg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lM3p30680+HO4LTTBTaxc/ptA4SjZgldh/owLfue8tM=;
        b=Jtd/LmV6s/1ld7ZPQFm9bu0nUCz61SDqUP3XVhPzu7Q+HsUOsLyanOXrAbn1enT6Um
         ABghwjMDsztWe3Xvp+YkOStgfG7+E3KWN4qSdOVX8p4PCz/qAp6EXSfshSt9IcpyFA3V
         mqEKU0VtrhMupc1QsApzSC5dw9OZLQmiVauoxTPP8KWrY5Vuxq7kENvphhHH0AAY/XVg
         uENHDQiogdyHP6j31fZv7G3i0VfnMOix4ECPcMX+4KpIQBuVC1bJqozDCDVmaEG6PgEm
         rfBYIzPZZKpEV8jrEhk9sdU9j+KVM9rujvgmZyEY+J6s2YINdFPWgKZxnT8JRpMLl9VZ
         kh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lM3p30680+HO4LTTBTaxc/ptA4SjZgldh/owLfue8tM=;
        b=bats3rFamPNejq/67QvbYmYRgCx4UMv164bdq+DsGkiTc5CEks/CFJ+1SeXjBB0KHg
         xwfzEGjmXpuWKXNMV8jesjckKIa+pVcN0NKtqPluw3PQlvdy2HgsuuI+IGkHAzNEL8hp
         ddFYv50HHSLULF7Gdhxpjz27Xm73MMAYjfO7bL9CzDwTeKkDKzfajkhy55bBoR89X3es
         jiMDywPjedyA/KvsRrWn4jo6ALDBEkS1fB2h9keDiwITT5+KBFqU54PLCe6xdC8sPHIq
         n83ALOXfnh+QBVv8pcmt1PLYuuA/mKlL7JFnAuJq8IJlCq4FncV+UiJ1ZJSiNZq2VKJk
         qiKA==
X-Gm-Message-State: AGi0PuZwpuJWY+jNWhsNNoa90hUMq0FH61cn7BA/wKtWka/u8aYTif5n
        +Q/OY+5oMroRiXk7Kz927Wz3TxO/tNaEdeEa0oc=
X-Google-Smtp-Source: APiQypIP5gxyYlW+70VuICA6vZwe1QWzSLDOaE+j3XrbmcsdRkjxr+4mFzQ9qekUWG27/3fVLCK5FHPRmRIV7qtCKps=
X-Received: by 2002:a17:906:748c:: with SMTP id e12mr4254088ejl.375.1588711108870;
 Tue, 05 May 2020 13:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <a0ed6b56-33b1-b5ab-00d1-268fcd61b754@prevas.dk> <20200505200744.GV34497@piout.net>
In-Reply-To: <20200505200744.GV34497@piout.net>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Tue, 5 May 2020 22:38:13 +0200
Message-ID: <CAH+2xPB7LJSxsr1vYhc=u+Qweu6_-S5oEQETUVZSVu1ATW=BYw@mail.gmail.com>
Subject: Re: battery switch-over detection on pcf2127
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        =?UTF-8?Q?Per_N=C3=B8rgaard_Christensen?= 
        <per.christensen@prevas.dk>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus

Den tir. 5. maj 2020 kl. 22.07 skrev Alexandre Belloni
<alexandre.belloni@bootlin.com>:
>
> On 05/05/2020 21:54:47+0200, Rasmus Villemoes wrote:
> > Hi Bruno
> >
> > I just noticed your "rtc: pcf2127: add tamper detection support"
> > (03623b4b04) from 5.4. Unfortunately, clearing the BTSE bit breaks a use
> > case of ours:
> >
> > We rely on the battery switch-over detection to distinguish a powerfail
> > during boot from a PORESET by the external watchdog (in the latter case,
> > the RTC is still powered throughout, meaning there is no battery
> > switch-over event). OTOH, we do not use the tamper detection - in fact,
> > the TS signal is unconnected on our board.
> >
> > We're currently still on 4.19, but we will eventually upgrade to a
> > kernel containing the above commit. So I was wondering if we could
> > figure out a way that would work for both of us - either some CONFIG
> > knob, or perhaps something in the device-tree. Any ideas?
> >
>
> Yes, I was working on a patch series last week allowing to read BF. I'm
> not sure clearing BTSE is your issue but clearing BF is.
>
> I'm going to send it tonight, I'll copy you, let me now if that works
> for you. You can then read BF using the RTC_VL_READ ioctl. The
> RTC_VL_BACKUP_SWITCH flag will be set if a switchover happened.
> The RTC_VL_CLR ioctl can be used to clear the flag.
>
> I think clearing BTSE is still the right thing to do.

I think your use case is valid and it sounds like Alexandre solution will
solve it as you just need to know if a battery switch-over has happened
not when exactly it happened.

I can help test the patches too. Now without google auto html..

Bruno
