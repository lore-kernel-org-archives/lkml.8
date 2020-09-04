Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74535C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B373206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599244996;
	bh=N5PAkSlIk0qcHX4rtRlCLcSF64blII7w8mhZIM/MbFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kUzWQCaKG1TcnYF9kyg/87zl9sTHQzjUf6dz22EVrX0LIVEI7jfvHT9AOHr4R3W7a
	 F85Lawh29CrDnVU2eZs97QnlNrxln5u+ugx+C330gcJUdzsqQxeHnvqCqy4Kdstfi3
	 T3stY30ZiWDFTpnzQugF2ax6wuH/aj8lG9h4ZHXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIDSnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDSnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:43:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42184C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:43:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so9163387ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGVkw+VA7Ozv3hFmklGnXOESB94iioBKwZC/vClHWhs=;
        b=OrfWsLi5zsx7qv2p1cK4X32zmscuCKlgmthoMdeY0cg3rmZpFdM3J9SvTCb9h5NnO9
         l0B0liyZtyXuNnV2gWB/4L3fr4ZoZu9bcbKCQOsRIl87cavO0SjGkvX9fTqXGzvbc3Rk
         8ry1Oj9UgjhZbRiLcVNkm18IHcMLIsEb6rQfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGVkw+VA7Ozv3hFmklGnXOESB94iioBKwZC/vClHWhs=;
        b=BKpvw4J4Db4A+mrKMG5iaPmPxXYVhJT7JcItEEUO2L4MOHJq0y61HtiXxCqO8hakrt
         wVOO5vmm8feskEgMYZZChwwsrgo1rodeS4f8Cs9WTRXDl5Np7UhM1VgstKTuslnNSA2n
         HrsWFnk/G87uI0GbQWijZhuPIIYsUjL50xJZldASfzTsHimRmy4+0uGuSkt9sRwxADLo
         3MeAT7wh7fb2HzCvpT4glgw7MsWMdjqtvyv1CgImLziUFZ4Qcn9opX5FmEjRDE03IFcS
         ryCjrR5eW/IpKCQfsaiGvuZVJGdC+EWVhxtU5VF6z4UK0gThnDJ6ymiZDjnv2s0LAMa5
         s8BA==
X-Gm-Message-State: AOAM530ST15OkI85VSzSKZhllY4hZDk1ZFbgKFEAE9MCxsDS+dazwAQF
        b1HC/m1sFekJGNsDHh7sbpzV3IrikDzC4g==
X-Google-Smtp-Source: ABdhPJzPB4CLKfh0NKQArGbUxJNTDpXQFy1Fl1P+8GkWvKGFrPHthFCb/S3P79SrRWLTU2AQHsaUMg==
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr4738109ljc.245.1599244980511;
        Fri, 04 Sep 2020 11:43:00 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y5sm1422446lfy.88.2020.09.04.11.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 11:42:59 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r13so9197997ljm.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:42:58 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr3675523ljh.70.1599244978377;
 Fri, 04 Sep 2020 11:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200904060024.GA2779810@gmail.com>
 <20200904175823.GA500051@localhost.localdomain>
In-Reply-To: <20200904175823.GA500051@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Sep 2020 11:42:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUUBnp9JSK+u8gYQ-RpMZxgd3UfvpihCPA_vSN_8G8Mg@mail.gmail.com>
Message-ID: <CAHk-=wjUUBnp9JSK+u8gYQ-RpMZxgd3UfvpihCPA_vSN_8G8Mg@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 10:58 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> set_fs() is older than some kernel hackers!
>
>         $ cd linux-0.11/
>         $ find . -type f -name '*.h' | xargs grep -e set_fs -w -n -A3

Oh, it's older than that. It was there (as set_fs) in 0.10, and may
even predate that. But sadly, I don't have tar-balls for 0.02 and
0.03, so can't check.

The actual use of %fs as the user space segment is already there in
0.01, but there was no 'set_fs()'. That was a simpler and more direct
time, and "get_fs()" looked like this back then:

  #define _fs() ({ \
  register unsigned short __res; \
  __asm__("mov %%fs,%%ax":"=a" (__res):); \
  __res;})

and all the setting was basically part of the kernel entry asm and. Lovely.

                 Linus
