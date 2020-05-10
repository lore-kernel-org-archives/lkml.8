Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D1C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142B32082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589139209;
	bh=E4qPoHAx/szjuYCabvtvm6PI5+61FwFrOM+D6yDWKTM=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=GkqYABd0aEDTskM+dEC2cEQa8eGayddADzIzLz2ZS6QloeIgq/DT9Fpw5Xqcknb54
	 dTiAPtn6PYgO3QTgtOLY6a4nNn+z21AUYSlhSwtNLzPiMdMP5Y5ncZ509+zOAoCjoJ
	 Va73Nc4Rbl6dDREuxIzntSDma1cfIrZ6UBymMRmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgEJTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728756AbgEJTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:33:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5CC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:33:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so7163258ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=64aVMu5SFNfNdOUT9Ix/3DAFCIgTTx15yZ6T/tdCN8U=;
        b=ClyKc72F70OGSkFtcbjc9in+WBnY2pAZ4fNwYkkAklspAiiBCf+vCkAxbYpG6KMbd+
         rUtDWos63C4LDtpRdmJCPHj9e9WqPQBrST+qgJWhfpf7jTbcBaUClzfLxm+VQpfDd0nx
         PeD2AQQKYQP3niA7VtIyx2vAjn8HI9zCqf9YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=64aVMu5SFNfNdOUT9Ix/3DAFCIgTTx15yZ6T/tdCN8U=;
        b=CDQtlacNlbAqA2jB11G99Vzk3z2fJlW6yctWDHz6Kq4OYkf9suX+g3RYOu3iYofn4n
         8LTOJQqVB74LebNQ/rkqaHTmmt5enDpk1xFD60w12C+2Zib4IKanuvSkDW+PzO/xqqtK
         InhdzO7af2bZeAjj1y+M/c536jhI15k/AAXotSfl6GfHan80Pi6q6k6ZGFNcQyjzpjCZ
         3o5vqhNk22kmem1caIR+P5O6tRxdooUxVgFE1EyyWQlKl1wzOmMNEx2n74rqzbm6JqFa
         rLPZhc4WB3xYZ2nMBdLlz0CjEqh0rBKoHNXArWIAEDVczcikmZ2wWrCLfH/xu83I2ro3
         +uQQ==
X-Gm-Message-State: AOAM530FZFXNX3y529xQlmmeB5wK4a5HaziUnhi5o8uyvMfTC86iZXnR
        62tueIILl6mvemrh2nzUCtXk+7FzRSY=
X-Google-Smtp-Source: ABdhPJxZ0sT0t3NaqCXjKtAdvbj8GP59a9fkbCqHLO4VNzKmpyzm6lK6BW3OZcsxMBVyy4a3vzvq9w==
X-Received: by 2002:a2e:3a0a:: with SMTP id h10mr7483489lja.54.1589139205059;
        Sun, 10 May 2020 12:33:25 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x29sm8202706lfn.46.2020.05.10.12.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 12:33:24 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u6so7167086ljl.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:33:23 -0700 (PDT)
X-Received: by 2002:a05:651c:50f:: with SMTP id o15mr3421753ljp.16.1589139203442;
 Sun, 10 May 2020 12:33:23 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 May 2020 12:33:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
Message-ID: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
Subject: I disabled more compiler warnings..
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Masahiro, (anybody else?),
  I don't know how much you care - I thought at least Arnd might - but
I've upgraded my main desktop to gcc-10. I did that partly because a
bug report that initially seemed to blame the compiler, but eventually
turned out to be unrelated.

And as part of that, there were a lot of new warnings in the kernel build.

I let them go for a while, in the belief that I could deal with it,
but then yesterday I did a pull and didn't initially even notice that
the end result didn't compile for me, because the build error was
hidden by the hundreds of lines of warnings (not hundreds of warnings,
but gcc has gotten to be pretty verbose about the warnings, so each
warning was often 5+ lines of "this is where it happened, this is
where it was included from, and this is where the offending thing was
declared")

A lot of them were good warnings where gcc warns about things it
really should warn about - if you have modern source code and actually
use flexible arrays etc. Which we're moving towards, but we're not
there yet, and clearly won't be for 5.7.

So I don't think those parts are at all controversial. We'll get the
zero-sized arrays converted, and then we'll have another slew of
one-sized array declarations that will also have to be taken care of,
but I hope we can re-enable those array limit warnings in the not too
distant future. They should be fairly unambiguously a good thing once
we've sorted out the legacy code, which people are working on anyway.

Same to some degree goes for the 'restrict' warning, which we don't
need right now and triggers for what is a somewhat odd - but not
entirely unusual - case for the kernel. That warning right now has no
upside for us, but it's a potentially interesting warning for the
future. And the special 'free()' warning is gcc doing things the wrong
way, but that one was easy enough to just avoid in the first place,
without making the source code any worse.

So most of the warning removals are fairly innocuous:

   gcc-10: disable 'restrict' warning for now
   gcc-10: disable 'stringop-overflow' warning for now
   gcc-10: disable 'array-bounds' warning for now
   gcc-10: disable 'zero-length-bounds' warning for now

and two were fixes/cleanups to the kernel to avoid new warnings:

   gcc-10: mark more functions __init to avoid section mismatch warnings
   gcc-10: avoid shadowing standard library 'free()' in crypto

but the one commit I wanted to point out - because I think Arnd may
care - is me giving up on the "maybe initialized" warning once again.

This is the usual "gcc optimizations changed, now it can't follow the
flow of code it used to handle fine, and it warns in several new
places that are almost certainly false positives":

   Stop the ad-hoc games with -Wno-maybe-initialized

so now -Wno-maybe-uninitialized is the default behavior, and if you
want to see those (very unreliable) warnings, you need to use "W=2"
which has explicitly enabled it for a longish time.

I simply refuse to be in the situation where I might miss an
_important_ warning (or, like happened yesterday, an actual failure),
because the stupid warning noise is hiding things that matter. Yes, I
caught the build error despite the noise, but that was partly luck (I
did another pull before I pushed out, and caught the error on the
second build). And yes, I've made my workflow now hopefully make sure
that the actual build error will stand out more, but even hiding just
other - more real - warnings is a problem, so I do not want to see the
pointless noise.

But I wish there was a better model for handling those "maybe
uninitialzed" issues. Some of them _have_ been valid, even if a huge
amount are just the compiler not following the use of the variables
well enough.

So I thought I'd at least mention this thing, and see if people have
any sane solutions.

             Linus
