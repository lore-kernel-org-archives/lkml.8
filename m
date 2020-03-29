Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0DD20732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585506018;
	bh=crMz1Zyr5XgPte9/fLqgDvVlusjBcgz27qlMuuuIh2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l44W21ObFTPlYeTserWSn4GmRCWz5/uXt2IomuWMV+Hnd+XjamKPF0Xg9jaEgm15z
	 prm9LDJJR0O7QKgsolReBS1+mY5zkUx4odbICZDQQRVgID7ouk7KabSpDymwnJh+AZ
	 Lkc+GrkIYSOr5NbuQb9VWqpYfTZOoVu8Kjyzte5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgC2SUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:20:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34881 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC2SUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:20:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so15604840ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZgVqb4y2QWgkLb7plXJBf0r4LTT7aqW4Cc9niuX5cs=;
        b=X6rjXs8vhB27dDuIHfTaryhJH5+o9Hav/CRHSHFk5SWXqW0GsRuypXAiq0GaFA0Xwn
         YN4+D58xzljj4iPZCYGyyAibUe7O8eMXu+eRr83DisWp0nLJ5MKuv/Mcz6Sybxmg4Bws
         4wMdPGMB9P82xc+iqc2+Te8wAp+7H53dw482s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZgVqb4y2QWgkLb7plXJBf0r4LTT7aqW4Cc9niuX5cs=;
        b=b/nP5TSdOfWpj0dAjuCxo6j7G+m0q9EwawUuIr9B1xfGkOmzQjsez8yhk2kQvxcQUw
         gNLMoiC8MqxsiJV7+0pR4SW1LkJPClo5UTt9EoXzgHWTvJ1IEKG5YAjSZy3yevrvRJCC
         h+vSL/1QI4MEIZLXs8xCSPV/09/r0odnvgFIjDNJrxqs5Z0cHoZA9G5T3jIiMf7iVCIt
         JnMabBmEiUexNR+q1PJ7SRlccaeZvzQp9fo17tPoDwDaTxGA48G5ud0BNe9xt4hX+39Y
         J6QyRYQYnj2QHZZxV1iKFL4lZfwd7Gf1gzDJLp7yHAL0K8JIGkN1NBKCrh1OKc+foif4
         snKA==
X-Gm-Message-State: AGi0PubwNCiGSTqP5eoWnmS2hXOZuT4V+vXhI0Y9FJogmWOk0gOSm6fp
        ALTuDE23qoS4LPh7NzK5KixVtopI/mY=
X-Google-Smtp-Source: APiQypJITmiIFGXmd7RAmyzKzfinTGSEktwyv86pJLIo1YeYRIr7xSGkzntQlb6pksLPBFHlLjJJ9Q==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr5078821ljg.185.1585506014354;
        Sun, 29 Mar 2020 11:20:14 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o4sm6548983lfl.62.2020.03.29.11.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 11:20:13 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j17so12122658lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 11:20:13 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5733869lfk.192.1585506013304;
 Sun, 29 Mar 2020 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com> <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <20200329181627.GD23230@ZenIV.linux.org.uk>
In-Reply-To: <20200329181627.GD23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 11:19:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs=mHpM3MxrHCShwo1A-U3mag1azVvKNEkQK36NroQ3A@mail.gmail.com>
Message-ID: <CAHk-=wgs=mHpM3MxrHCShwo1A-U3mag1azVvKNEkQK36NroQ3A@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:18 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Except that you'd better make that
>         if (!user_access_begin(...))
>                 return -EFAULT;

Yeah, that should teach me not to just write random code snippets in
the mail reader rather than just cutting-and-pasting actual working
code ;)

                 Linus
