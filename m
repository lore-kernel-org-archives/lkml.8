Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C72207CD
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2fAIXnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFNNVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgFNNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:21:46 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E91C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:21:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so5894517pjv.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7cP+mQI0zQhwvMzCwzM1g6my9t24Zv77a3K2bh1EtiQ=;
        b=j2fAIXnY31BJIK/Ksr6sAZdLsdL3/LaYUdn/acBEVQ4zcC2z06yKrYQlvbFJWZS4S9
         eiReDtqSO96Hrm/W+k/l9StZi5Htbp/JWOIAWmyr5AH4jKW92uBRlISV6IAuHOspIZDE
         v1fwN3089NBrHQJsM5sTaKnKmIerNZLfCS+8d/ok6BeMnCWC8m0PKdcOcfJXuycwhFq+
         XRpbfeHl3YbTKtJq9mDs3EAvhoeoKLlsKF+DGB6kOjAqnF7ZFDzUSETcFvY/ISEH5Aun
         nyl0lsAgfr2nvdZaqG0/+NRqRv2WNQpIHQ0iQKs344JCSIpwBC04/TCms5OAXaxxLVaC
         aETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7cP+mQI0zQhwvMzCwzM1g6my9t24Zv77a3K2bh1EtiQ=;
        b=pB0pZ0Os7AeYu0uXk53Wv6UalXKBZYEsspvOJAKy4G4a0gcFt9OgqNz3Gcj41g1ote
         Bakfw2mbdJlPV6uwTSuZUtwDeQpt+GUBZjvQfIX9OrYklwmLIacmnSj+FOiChYdRRUfd
         ThwPYZROAV8pKfGIIlVmadCIBodyi3F6k+4M542QTEhdEW4b+PBMTY0UV6Ki3v5GrDWt
         SMoQog8qrQTrRi5zLcflbtwOzbz7yNa0WSTDoGry925cRa2IXKzHEtpougGjVorYZbwK
         DO4lz78xsmNQOEMgPKTA0yWJcw7ftEzbc3zFFZ88CSqI6z5ciISu21glM2DrniDONIqA
         vG9g==
X-Gm-Message-State: AOAM531vn7ZsjjtvXCRjBv+fnm0qhtly7v0zOxQwvNLMv9A4Y84ibLqK
        uHORO42Ze2SrBKB+H9RVC2s=
X-Google-Smtp-Source: ABdhPJymbPMR9I+mWmNb9K2IXVZ9Xzx6fiqm4hLsTe6OUYPlBvObLcCmI+3Mf5QIm90Q+6b74FnFkQ==
X-Received: by 2002:a17:90a:e288:: with SMTP id d8mr7936307pjz.173.1592140905737;
        Sun, 14 Jun 2020 06:21:45 -0700 (PDT)
Received: from localhost ([49.207.199.244])
        by smtp.gmail.com with ESMTPSA id y9sm11333111pfr.184.2020.06.14.06.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jun 2020 06:21:45 -0700 (PDT)
Date:   Sun, 14 Jun 2020 18:51:43 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200614132143.GA599@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 13, 2020 at 10:45:33PM +0200, Arnd Bergmann wrote:

> 4% boot time increase sounds like a lot, especially if that is only for
> copy_from_user/copy_to_user. In the end it really depends on how well
> get_user()/put_user() and small copies can be optimized in the end.

i mentioned the worst case(happened only once), normally it was in
the range 2-3%

> From the numbers you
> measured, it seems the beaglebone currently needs an extra ~6µs or
> 3µs per copy_to/from_user() call with your patch, depending on what
> your benchmark was (MB/s for just reading or writing vs MB/s for
> copying from one file to another through a user space buffer).

It is MB/s for copying one file to another via user space buffer, i.e.
the value coreutils 'dd' shows w/ status=progress (here it was busybox
'dd', so instead it was enabling a compile time option)

> but if you want to test what the overhead is, you could try changing
> /dev/zero (or a different chardev like it) to use a series of
> put_user(0, u32uptr++) in place of whatever it has, and then replace the
> 'str' instruction with dummy writes to ttbr0 using the value it already
> has, like:
> 
>       mcr     p15, 0, %0, c2, c0, 0  /* set_ttbr0() */
>       isb  /* prevent speculative access to kernel table */
>       str    %1, [%2],0 /* write 32 bit to user space */
>       mcr     p15, 0, %0, c2, c0, 0  /* set_ttbr0() */
>       isb  /* prevent speculative access to user table */

> It would be interesting to compare it to the overhead of a
> get_user_page_fast() based implementation.

i have to relocate & be on quarantine couple of weeks, so i will
temporarily stop here, otherwise might end up in roadside.

Reading feedbacks from everyone, some of it i could grasp only bits &
pieces, familiarizing more w/ mm & vfs would help me add value better
to the goal/discussion. Linus Walleij, if you wish to explore things,
feel free, right now don't know how my connectivity would be for next
3 weeks.

Regards
afzal
