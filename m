Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2D20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580148173;
	bh=aU7bq7tHS8DrZJ/UqArC5Ljm2qkSPLu4ckj/D9FrwLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iVwkiEvGJOlRoUscKnfbCjiU74kr8+VIDzSD0tc70njHA72z7+f4akhG2RIjO7iPs
	 mDh9yaN0k/3EUo3Jixd+NhxW9aCCsRodzSAc8hyM3OPvBbji1JgxuOzcq2hzjMvmTF
	 I5nlSmMHwjaKoVYqXCoAVTRjyHKAQP8LUH9a+Idc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgA0SCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:02:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42381 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0SCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:02:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so11773063ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkK3beecWgJffCRmCf7yN7KAuYuZ7llM5zWyPle+yQs=;
        b=ZTIBUpp76jI7maRuvE9I8HDZA+IBuv4mho3BoUw0sWBm6K6GljVyIJntNBzW4NTMU+
         cB3CE1H1efE1KVLC4Xk47K+Zth4Tip2rQlJYfX7KVHNQHLIhNYsA5L+Y/D39MU3KQrmZ
         p4vWpk8id1cMjxKFc7BJW0EU5yP7rvTVTRyFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkK3beecWgJffCRmCf7yN7KAuYuZ7llM5zWyPle+yQs=;
        b=I80nyQlz5BeWoeLzTUzFfNSqwV9xobmWxBafihX0l3ASlY7eCPn/gtA6AcUIXybwnJ
         jJF8wSatEcnOq1TtVMX88qVHiQjPp4nqBuaElbwvKLS81uKj5QiHtbg2fvi6WoKpeoUo
         H7GyAjtHB6d6VjkBLO4AxB+QDFElrz2lSFMtgTJutsqN3g8X7SCX1A93i2Zv9DQ2Jv5p
         UKgrFnnNUWGA7FAqHWDUxrI3RYXmWWb1fS8lgMysq+e8R7d5HXDbfeXSL/XCBaW/pBq6
         pgsBXTPbztUoHJ+S0yvCVGeVJ8b6gp8cOSOasQeA/srzybG8cZqn7b1+hBpfZi+27ppI
         hLMg==
X-Gm-Message-State: APjAAAW/O/n9964HNNmivhNuEmpmBpRM9kqS/8ce0bsgwoZBWebwkg2D
        rdrdlQohxEo72bxDBsbOpt4a4nG1YHg=
X-Google-Smtp-Source: APXvYqxH4UVCc3loud4wGDXKnE4VOF7w6GKF21DSV4G2dxDPgK6vp2tuRPkwvJxBaSKiz8JysFazcA==
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr10380137ljo.240.1580148168903;
        Mon, 27 Jan 2020 10:02:48 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h10sm8433537ljc.39.2020.01.27.10.02.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 10:02:48 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id f24so6896781lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:02:47 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr8809322lfa.30.1580148167476;
 Mon, 27 Jan 2020 10:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20200127113903.GD24228@zn.tnic> <CAHk-=wgedtBiFok8twm499FmNCJ6icWdG7Deb7f4jcDYS4Y_Lg@mail.gmail.com>
 <20200127173852.GF24228@zn.tnic>
In-Reply-To: <20200127173852.GF24228@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jan 2020 10:02:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOQhFckQftz_bLC9qsntdm5n_TbC02=sfWy2nM+bmrFQ@mail.gmail.com>
Message-ID: <CAHk-=wiOQhFckQftz_bLC9qsntdm5n_TbC02=sfWy2nM+bmrFQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for 5.6
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 9:39 AM Borislav Petkov <bp@suse.de> wrote:
>
> Yap, you asked that the last time too:

Early-onset something or other..

> So I can stop signing the EDAC pull or I can start signing them all -
> I'm fine with whatever you prefer.

No, it's fine. I'll figure it out and maybe remember next time.

I do prefer signed tags even from kernel.org, and maybe you can
encourage the other tip people to sign things too one day ...

               Linus
