Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E42C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65852071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579888094;
	bh=2j/bXj4gaEsSugGcUS/+/8Mw6H42T43xtQf6dD/hqyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LbSTLaWgahPgFaoiqBt3mxtuYWc7/jZ/ZBwm86xUbkT4VKXR7U0ELPYI4Nvg+7gTz
	 gWbyQjmSHido7X8tipdyoMWdlw3iJARjVPnwDbUVeADvAM5V/cPbCxoqmpjgWeODX+
	 eo1U20VLbd9e7dLV2oO5MQXAlkzqShQiXYQVt5wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390774AbgAXRsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:48:14 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:42891 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390378AbgAXRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:48:13 -0500
Received: by mail-lf1-f52.google.com with SMTP id y19so1666228lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeNd8cDikAZfPsMDcLH3HXRHVWtJV1fmj5x2OtFe5U4=;
        b=Q7jDnV3uFGpcFOXfx0sDToVKK1+ShWxMawH60hxdkkobojekNBomm2UEWO8o7bmoTK
         HEErANJjl8S6iy89lk/sC4mE7wDDoMRvGk6OvK+x4eZg0R+df7JUg/C+RHn/1Gs9HK++
         MKLm5y9lb1HuYcsvG7Fptfe2ZYW/tYoYBXR/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeNd8cDikAZfPsMDcLH3HXRHVWtJV1fmj5x2OtFe5U4=;
        b=DBxUbhyCGbkuk+ZffTzVnDAbiQHyCZLywG6k72GDGF0GBOBHzBt6OeO4bNAecz2nIH
         G6GJuSlcsxjHw804rtxrRniFE3gPy36P/LyTsFNkwH0jMGabOLVqfkBvdypU9vFl7lVk
         6oJH5sT5/DDRfJxN0Jv2ZOppgbA1nyImEVpq8GgSTg5syx0R1+nmnmF5AmwTvY10Fr3s
         xYF+cdJ1GAUq+I9CH9V+Fx49g0zODIW18uh1Xo/RI3hbQ7RAyKA6CotC2bPTQ514YE7G
         Msf2QfkcsLkTnW0qsTuMP5W5Ngt+0mpiY7UzMfk7kDEmvJXlU7T4nF5RMIpzX//1YwSJ
         l5JA==
X-Gm-Message-State: APjAAAUqxRdMg1O4Wcd16i/0rDAYNndrEoQQCu08aQs1tHnhX1evjKHc
        JQXLg6vWyg1PchFKFHPP+iilMBeWsE8=
X-Google-Smtp-Source: APXvYqyvQsAnoIKekJvLGTLUsVdBTDBcMaRfNzCVDWOQt+Tz6n64Agm7yyYnoMdze6lg0AYjMdyAsQ==
X-Received: by 2002:ac2:4214:: with SMTP id y20mr1924189lfh.214.1579888091231;
        Fri, 24 Jan 2020 09:48:11 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r2sm3670719lff.63.2020.01.24.09.48.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:48:10 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id j1so3445318lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:48:10 -0800 (PST)
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr2898619ljq.241.1579888089736;
 Fri, 24 Jan 2020 09:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20200119221455.bac7dc55g56q2l4r@pali> <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk> <20200120074558.GA8904@ZenIV.linux.org.uk>
 <20200120080721.GB8904@ZenIV.linux.org.uk> <20200120193558.GD8904@ZenIV.linux.org.uk>
 <20200124042953.GA832@sol.localdomain>
In-Reply-To: <20200124042953.GA832@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jan 2020 09:47:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
Message-ID: <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
Subject: Re: oopsably broken case-insensitive support in ext4 and f2fs (Re:
 vfat: Broken case-insensitive support for UTF-8)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 8:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Thanks Al.  I sent out fixes for this:

How did that f2fs_d_compare() function ever work? It was doing the
memcmp on completely the wrong thing.

              Linus
