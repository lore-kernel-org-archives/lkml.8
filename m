Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCE3206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693009;
	bh=AWB791hdxOALpZkZaAwpck1pW/sRtxgPjMn4x3etS/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YJZsoiJPSGqS0b//IGWn0vZ9WeBheqBwmGN1i9CCbvRhVDOoMHfPX4DTlJh0jrAKq
	 XPQVqAcMQuX0IaVE59Hx4yfsAuWyf73fBPeu+FHo/4YHju9JC0dq1YCmfyUEShJ53B
	 AFStW8/Sx89btugjoX8VXIONy7UvEYGiaOpw0aMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406173AbgE1TKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406129AbgE1TKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:10:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB9C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:10:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x27so17208806lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5QaC7zkAZZvfEZZJnqo7rI0BwuGIzysoGf9yj6DhPY=;
        b=Oyp8Kr588/cPDx5RD8b3bsiUnE+YQ2WkW3H4H3gawu0qmPA/QFVO2d69AH2CX4ouxv
         L5CwQD2ftmMzzRUoAsCynb9v1hxvuA+JFAHDHgIFfDweDYc0sdqPbJ1edenfzl6FfJkY
         YDfT/dq7werTzLi2TQz9MpGnKaUzqLQeAzrKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5QaC7zkAZZvfEZZJnqo7rI0BwuGIzysoGf9yj6DhPY=;
        b=C3RG7D6qWCAqqLKU6kCLSKuQpgf019y+L8qEXAylRzWGrzh7vM58b6/aj+YVaj/ZtB
         g0AXZXf409sOdJ1KCNcb109aW5wbDOVQ54CHETL691OkGp8m7SQg6HWG1e8zE24Fx5nJ
         g7cko8xYEObKEb+osgLcDktbtgqJfSAmmu7pfjFzv0BuCHg+n7fpFuTOCirZ45XAnO7D
         5ozpp1p4+B8LaSeCUHvRAqrA/EYyvBNFhPvduZofZW+iG0hSwciNQ4ByGeim8FF+RCkw
         fM/6f6Nzbos9BIY//yOPecncxix+2JQh1CrjyAOIFz/gsbm5dtHCIexSdJOLODMXCMFT
         87Ww==
X-Gm-Message-State: AOAM532WLn1k7XjetxFUIvzxkf1XIY6+qnIywutfRRHmUdJrSn0F7I8P
        /DU13X9ioREC675vxnGNCPhNSaNry6o=
X-Google-Smtp-Source: ABdhPJwVeYoWt5lzrV71+SZU5tvTG+xifFHsN37N0bI5lHJ9k+DwN3y9Evns/r6BUKsE0PfM6Z9dkQ==
X-Received: by 2002:ac2:5314:: with SMTP id c20mr2399484lfh.75.1590693005303;
        Thu, 28 May 2020 12:10:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f9sm1812475ljf.99.2020.05.28.12.10.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:10:04 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c12so17228058lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:10:04 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr2373367lfo.152.1590693004037;
 Thu, 28 May 2020 12:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200527213447.GH23230@ZenIV.linux.org.uk> <20200528070255.GA790247@gmail.com>
 <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com> <20200528190555.GO23230@ZenIV.linux.org.uk>
In-Reply-To: <20200528190555.GO23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:09:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3dVgSn8xMC2Uqs8aahFfeqO0Wue2KqxnDYrbBM+6uZQ@mail.gmail.com>
Message-ID: <CAHk-=wi3dVgSn8xMC2Uqs8aahFfeqO0Wue2KqxnDYrbBM+6uZQ@mail.gmail.com>
Subject: Re: [git pull] coredump infoleak fix
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It doesn't fix all problems, though - you don't get an infoleak, but
> you do get incorrect data...

Oh, I'm not saying it should replace any fix to regset->get(). I'm
just saying it is in addition to.

So if a regset has a reason to return less than the asked-for data, it
can do so and there's no leak.

               Linus
