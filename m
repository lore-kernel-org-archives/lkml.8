Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC1CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FBE22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW5xQK2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHEWM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEWMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:12:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A99C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 15:12:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m19so7574833ejd.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIbNAVW8l51ZPykJQx/ZJr3vWk/56E6q7sXHHquBNq0=;
        b=tW5xQK2QkBqnAXY+XYgTRtPCTAIUOH5Qiho1wmjpwx5djDw+eiQyxdiaiWkhjj6mza
         6MwRL4Sh9k75VF92Gf37s6u5h3u0NYgyNobRF95J39OI5x0b2Mo33kbjKquHnZc+8vl1
         QQQicbXBxR1qOk3BGfkPRm4POMvG2B2rryhTAEIjMJpy6V8EvSiKcYYsZniQg9+4H1dx
         xQghiK+PQ4fKQLgDeYRMjnLJKC92t4RoGwq+3MM1OoHR4RcgPIrWXReTZzbpLUrpFxgp
         JOHeJUguavFyxYFuu6AwwE6Cb/KcI2Lui+7L7FBkPXdisizhrh2SAJAVzWAf+i9WQYVr
         ZnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIbNAVW8l51ZPykJQx/ZJr3vWk/56E6q7sXHHquBNq0=;
        b=oEVtiBN0P4HaXhoWW2YFvj993pJf9JisSQXa+ZWI7uLRZYmstOl03EpUo+F8+kMnPs
         bVYIvMBJOEniu6G8zdng/AsH26sz0uNol38lWvWuySiks/gFZrWPkEj2CybPhKt7qVRM
         sxG5ioF2adjHq9CxA5uqOxOD5xz8DiKy3vCH/PnNhtU9WQAu75+CWyOaMJM44VnH6LwM
         l2ygNpqzEq6TY2NGQRDxkZv2lRDJ91USVP7UEpzd6VEW3QB0gRLCixhSvRISz8V47Dob
         c3hmTVwk2aZo3ZNAPW/mfelbc5hF2aNkN0pk2FyjgARLMfqOFBJDgV5NiyiTlgrjcbbG
         gmMg==
X-Gm-Message-State: AOAM531vVWr0lelIeIO6KLDuZFeYLdyoUU+VAmFDxTfGXQXiIdVqgg+Z
        vrmVY3J3VcRSKIuAqhnEjWsvOlrfMXkDB+PgOeU=
X-Google-Smtp-Source: ABdhPJy4Odg9iUA0wlOKVZ1EX5jozIda84R+jB9i9eWUEQ4U2yucxj4j4AyzCh692cMmYfzo3ONdGhtBYQY2ZXNKYjA=
X-Received: by 2002:a17:906:5812:: with SMTP id m18mr1485573ejq.66.1596665571861;
 Wed, 05 Aug 2020 15:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <20200805172746.GC1118@bug> <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
 <CAMS8qEVzCtxrH-K4U4_TeHi3RXDQ7UeGo+sVnB-HPS0Y+mju-w@mail.gmail.com>
 <20200805194512.bh5hds2l46opcole@duo.ucw.cz> <CAMS8qEUaFP8du8NJ098baKPqLtGG_PNu4oJjtL0dHVN-4N6xXw@mail.gmail.com>
In-Reply-To: <CAMS8qEUaFP8du8NJ098baKPqLtGG_PNu4oJjtL0dHVN-4N6xXw@mail.gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Thu, 6 Aug 2020 00:12:15 +0200
Message-ID: <CAMS8qEVKma-axQGbEVfzxVahFCGMy8iGiadg2wArXrC=wfXcdw@mail.gmail.com>
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

>Regarding msm8992/4, there is a need for the 20nm DSI PHY driver.

Well... Of course I meant DSI PLL there. It's so easy to mistake
three-letter acronyms..

Konrad
