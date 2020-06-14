Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7061DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4DF206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sazcY3c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFNOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:55:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3AC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 07:55:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s135so5790137pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78et8/D357auQlo0tCw3bdJP4HVAFW0j/pRZND2qTtE=;
        b=sazcY3c4vmvNP2euOvXd5CXPaq3kPKLH/MNh+gVDRpQaIKOaEWPeecO4JCEvIynp7S
         0t30PpYebVU4RcPjQb4piVODuUru6rsiiaDv4NKUTvJ2Ek95EWHFOrYaFVJFW7W9R9HG
         LIExhntgTIPGQPln0XnelSkS7ZeWo1k30J7/rKDzwnwgm2wTJNr0Kcu2wl0ZH6FTTuP7
         JyF7usF9uS3WCU0od9zMpfU0I8wK/fNb8cEpir0zaGrGl9sAUaYqkrKHQDRnjarODso/
         THxm3iGHYQCz+t7A76OoxBEErKJnVgzLX6+iKTEC21Ar4vGHoEE/lTJhKHnMGWeyEf6b
         p4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78et8/D357auQlo0tCw3bdJP4HVAFW0j/pRZND2qTtE=;
        b=Wv0rK48iFTTij/gnmwtOsrLhhfWXXDSW1ZKNCqNxFxJpGve6nZTD0NHHw+DUIROajm
         n3y37ZkXn5uqgf61p98eaYDXhDDiTdpoGJu7/sEFYBa+HAUKFUUa+L/4MlbwBWXgzk11
         jiTCnGYuHqGm9jsA53VWKzy6omhAxlHmJRljEyFDjJku6Zn6FHNxKebMl8QyGKo17iHT
         sQubazFKVLOfiNuwLRj0h7Gn2wrAf70Z4BRo4CazG1OfnawwFiOQ1FDEuu3kZuP1Bfsu
         H3XDrOpddFii11krDzf+JATLJcewOF3rm9K63J+uhBfXuyCnrG/Ma7i5tI4kS+ZTj/fU
         Z5jw==
X-Gm-Message-State: AOAM532Lv1PQRTzDLmKHU2m9/PElMMgrkyq0I2sqwSfKFF8tMtkO0xeh
        Y943VHfLQyL34TiETFuuAE0=
X-Google-Smtp-Source: ABdhPJwob5y5LO2njY/GBTjC/Nb9xaivIHoaUJJmM7RQWU7OYld/epBeaS+a1qrdU1xmpEEEJKo52g==
X-Received: by 2002:a62:2ccb:: with SMTP id s194mr19106321pfs.127.1592146510447;
        Sun, 14 Jun 2020 07:55:10 -0700 (PDT)
Received: from localhost ([49.207.192.101])
        by smtp.gmail.com with ESMTPSA id l195sm1332101pfd.18.2020.06.14.07.55.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jun 2020 07:55:09 -0700 (PDT)
Date:   Sun, 14 Jun 2020 20:25:07 +0530
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
Message-ID: <20200614145356.GA3134@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
 <20200614132143.GA599@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614132143.GA599@afzalpc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 14, 2020 at 06:51:43PM +0530, afzal mohammed wrote:

> It is MB/s for copying one file to another via user space buffer, i.e.
> the value coreutils 'dd' shows w/ status=progress (here it was busybox
> 'dd', so instead it was enabling a compile time option)

Just for correctness, status=progress is not required, it's there in
the default 3rd line of coreutils 'dd' o/p

Regards
afzal
