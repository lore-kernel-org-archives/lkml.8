Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D2C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803392084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583681347;
	bh=B1wJc+CpOm5GRchAe0f7K+/ByFXco/NAt7yvNZDB7wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fmukTUTmB2C2O0OTZcIiTdK5QPRx43OQygQHX5hJ6sjdNfAsdMA7n3l8RL/0kln4l
	 eXBt09FV+1QFxhaG7B8uDNalkmAizJA8O0WV0d6qPRL4cFygRkWwx/lwYzgNWlkrNi
	 bbcbMB3tpaZarwwkkVzeidK/muUYcvMYWt7+0QQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgCHP3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:29:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43850 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCHP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:29:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so7302112ljp.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKqNMTrM2DApFRCZUksaRgpNCHpxLVxfx7dej2cNK1A=;
        b=gHS0ecSWggkA/QdDjRk3dDNKHJyhqVq4+Zpi0JXbSCMTkEfEm065HPrnWvogfZQGTJ
         UZ95Qmbs3aU8N0Bh2QPD8eF8lhEYrarz3iI4IoUa1wHilPgbtHBuKuuk/hRXZQhI3S/F
         o2fL4uifeREy76rKJJ38QFFqPFDxUwjFMn01Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKqNMTrM2DApFRCZUksaRgpNCHpxLVxfx7dej2cNK1A=;
        b=pTZnWF9uXsENaopffOloD7pbeeMo8ChPdZn3ygUjFNMCiLBjmtU4zZ+1WF384LlrkA
         PBnJbaRyx7oo0/oS+REsBOOz9eXfucSnEPKujKxHD2Lqqiid3AkKyPVbpPA0eDOgmBNK
         0FV0h+5+yUkabNMYE7CQv9dH6Zc6TLS6GJitd+3ad0gmhhleHTmYDbZlfUgtc4IEvCEb
         ajiDqPFJXWxtrsRE8uXx0SupChBecchCQwvuAZOH2U97taQYKZjde3+ZDg2HGSSKB1Ba
         4Sp+PWHtYWpVu9fUcKfHhDBMaV4S/9Obt3mkcT/Ag9dt7E23rq9tg2gefuJrUcYNQSzN
         Tfkg==
X-Gm-Message-State: ANhLgQ38rZElOJkxD04GvnTxNyTLPN7U6ry/2w0K9KMJqgRIGejEFBWP
        OfAjZ4GflSVXnNewMurKWst6MeDnkComCQ==
X-Google-Smtp-Source: ADFU+vsdpETByQs61ni5tV1TrRD8Ia4DKKvaKjjc75+OnsoLnVN0QUzRZB1AGuVPxmIZj4pOpCg/Ew==
X-Received: by 2002:a2e:86d0:: with SMTP id n16mr7351060ljj.117.1583681342082;
        Sun, 08 Mar 2020 08:29:02 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h13sm14784446lfp.80.2020.03.08.08.29.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 08:29:00 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u12so3122827ljo.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 08:29:00 -0700 (PDT)
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr7402622ljp.150.1583681340245;
 Sun, 08 Mar 2020 08:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140200.GO5972@shao2-debian> <CAHk-=wgJV7xrxsTkOG203huPShzZBEC6N_BG0KGwHBmEq4yqWg@mail.gmail.com>
In-Reply-To: <CAHk-=wgJV7xrxsTkOG203huPShzZBEC6N_BG0KGwHBmEq4yqWg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Mar 2020 10:28:44 -0500
X-Gmail-Original-Message-ID: <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com>
Message-ID: <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com>
Subject: Re: [futex] 8019ad13ef: will-it-scale.per_process_ops -97.8% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Just a re-send without html crud that makes all the lists unhappy.
I'm still on the road, the flight I was supposed to be on yesterday
got cancelled.. ]

I do note that the futex hashing seems to be broken by that commit. Or
at least it's questionable.  It keeps hashing on "both.word",  and
doesn't use the u64 field at all for hashing.

Maybe I'm mis-reading it - I didn't apply the patch, I just looked at
the patch and my source base separately.

But the 98% regression sure says something went wrong ;)

           Linus

On Sun, Mar 8, 2020 at 9:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 8, 2020, 08:02 kernel test robot <rong.a.chen@intel.com> wrote:
>>
>>
>> FYI, we noticed a -97.8% regression of will-it-scale.per_process_ops due to commit:
>>
>> commit: 8019ad13ef7f64be44d4f892af9c840179009254 ("futex: Fix inode life-time issue")
>
> Well, that's not optimal.
>
> Peter, any ideas? One of the things that worried me about changing to
> an u64 was what I think it causes extra padding, I think. And maybe
> that messes with the comparison and hashing of the futexes?
