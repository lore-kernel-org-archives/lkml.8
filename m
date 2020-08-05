Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA220842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Q5EtcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgHET7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgHET7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:59:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3C5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:59:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m19so7216389ejd.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhMy8S5XtnzYbnH6nD8EjWcSqXkXJPGvQeQIvSoKX9s=;
        b=R6Q5EtcKcgGBBW9nAKHwAC6hvcP50thgMt42WVXOEz2BdbX5p4bztza6KwWWOHs8uS
         Qn1hK7PQEd/gXW9OvrYAR6H6+X7f7EN2jOS/FueoZ/EHkbz9lpjySi3yO4EScOTU14aO
         RllxGZY6CJmkFQ3cbG/18/O8ss0bxcjqKj+/3EL4IPxNuoGuTrxzveBKeKl6lL31nd9r
         g8P59E3pevyWLVpYdkyRUP9qh6WzgQ2vLwxuHGpjGzyGd+nIIsz5Y4CWiJhxrjCf4OFn
         k3A5ug1CSlqV/Fvp9yEg1asz0giVaXzWxKr1zUASNusuy5D8M5vI7ewLB7MfBWbu+SnO
         PxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhMy8S5XtnzYbnH6nD8EjWcSqXkXJPGvQeQIvSoKX9s=;
        b=jVVsm5xhFoX15VkkemMGLTw/DIK/jRgETsbced60TocxJc4JNzT4lNMjQUZRVEORdn
         b1Y4WGgkWxyT4qF3dN5SrGWHt9S4likvRR25CO8POcykztLIPUFzG0nL/lrmlecp2pl/
         +ZoZ3efOqZcQJ9dRUdvAmNDWHrAjTpgk0e5CPswK5jwkJJpyZoq5/ci6qG6qC8YDRYDe
         +b++n/zpMgW17GqsygmwjACilffOWfrtF7wH8Meq4XTUOjm9/JM1LL4jm0LQZHBwsJOY
         OkFB64LZQgTG/P02U8sXE90cZlq3mCVe6IU0spn2p9T0LDa+9RMjur1+UhXYmVIiCF1l
         zb+g==
X-Gm-Message-State: AOAM530HJzoDp8mAGZrIa3KxdTXJhtbxSYlgo2vYgUyR81aMUW+WDse3
        EjVIfOdALVch1fQAOM2jOIgiNpxA6mjyRQd9H1g=
X-Google-Smtp-Source: ABdhPJy57S3PIZvVM56FRoojpeeOLXi3gXovh4znt4V7/HgpUsMrWHweB18OHiTMxUxVMBhTQowtlVMWZfe2SVHFXQ8=
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr939357ejb.340.1596657539927;
 Wed, 05 Aug 2020 12:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <20200805172746.GC1118@bug> <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
 <CAMS8qEVzCtxrH-K4U4_TeHi3RXDQ7UeGo+sVnB-HPS0Y+mju-w@mail.gmail.com> <20200805194512.bh5hds2l46opcole@duo.ucw.cz>
In-Reply-To: <20200805194512.bh5hds2l46opcole@duo.ucw.cz>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Wed, 5 Aug 2020 21:58:23 +0200
Message-ID: <CAMS8qEUaFP8du8NJ098baKPqLtGG_PNu4oJjtL0dHVN-4N6xXw@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] ARM: SoC: changes for v5.9
To:     Pavel Machek <pavel@ucw.cz>
List-Id: <soc.lore.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I did not know how popular PinePhone is. Does it currently have useful
> battery life?

It basically sells out in a few days after a new batch is up :D You
might want to join some pine64 irc/matrix/telegram channels.
Currently, as far as I'm aware (I haven't got one), it can survive a
full day but enhancements are still coming.

> Would something like phone@vger.kernel.org be useful for low-level
> stuff?

It would certainly make for less spam (yes, I once got (jokingly)
called out for "spamming" linux-arm-msm :D) on the general arm lists.
Many commits just tackle DTS or some bizarre only-found-on-phones
hardware. Considering Xiaomi releases 1 phone a week on average,
expect to be flooded when mainlining gets popular on sites like
XDA-Developers forums where many Android devs currently are. Also it
would be easier for people to find other phone/mobile developers.

Also, you guys might want to consider arch/arm64/boot/dts/qcom/vendor
in the future to prevent it from becoming a mess of a directory that
arch/arm/boot/dts is (though that will obviously take some time) :P

Konrad
