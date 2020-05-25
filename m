Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B925AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E36204EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orLdfY6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbgEYLqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390252AbgEYLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:46:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:46:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so10377269lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtZVEMzdq38fu53lZDWzc8NBLCjAY5aGK/W4AvmImNs=;
        b=orLdfY6loriaooo8N1Yd30vlFmmNB9q1KKM1rXkgsRGO1UqAnvTG7ZoMvuV27N9pdi
         T46nTc25B2KLLpwLNcABtXNZapEwjmcZMgKULM/PduML1b00kHZXNEh8TcHbWfqB7HjY
         DjlB746elPEoLY59e78jxBTT/+oXS/EAZdfSrvsGttLFFYApLbPaDTk9o9mQmJ1UwUiN
         yKmSq9ANG0ujjnTwR5zTMDNY+R+4tAbv+GKl0q1omEGzjMt0vyTmLwrhIC+cljwrbi6C
         s2WzWYR43FRwDgGpO9PbwjRmLFAILwv+wo6iXjqNXTm71MT1+SSyBvbJpR2QjNoE2ngU
         IFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtZVEMzdq38fu53lZDWzc8NBLCjAY5aGK/W4AvmImNs=;
        b=i0WA6kMmor+mZ1kZvarmMZXOpBj5TCbPWYWwq/0ItTkAYpkPZLkx1KVldTk522j7C2
         PBslV9GBJqo5QYQEujDSBKDd0098rjawwYatTJ+fOh8y5mh8N1saJodljD/SzwwWFnwV
         UpOqWR1rh6XWbCKqaDuCtpHsTE4g4fyA0znPNCgOtCRSYKngk5XTvs7L/EaHMHBNqIk/
         LU88PVWx5n+a2bJhocGin+pXRU5I3LW7bWcpuA9GrcMnPCioaUJd1igzAM4srFIdgCHn
         M8VGZZoU+kLQKANAqq6NDfWHFJTLevNMkKBvO5CUu9ZJ0pYFIblz0rs8nBTSSJtgCJSS
         C7Yg==
X-Gm-Message-State: AOAM532J86GVPvl0cm3bArh8o5uIZtE9kmB9njncwqPHtbrgIPVOQRdF
        o0Zo12XoZHs59BUN87I1s6j0RTYiA52gOrJrWEvlOQ==
X-Google-Smtp-Source: ABdhPJysZMoeNaQ3OPOlBMkS29naRx7Bh6IeU57eA0JtB9tQoxG0XrAfI4YgfVn1j2BeWhx+NdPq9Np3+N5wErMVRRk=
X-Received: by 2002:a19:c8cb:: with SMTP id y194mr14613330lff.89.1590407180569;
 Mon, 25 May 2020 04:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200523170859.50003-1-sudeep.holla@arm.com> <20200523170859.50003-5-sudeep.holla@arm.com>
In-Reply-To: <20200523170859.50003-5-sudeep.holla@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:46:09 +0200
Message-ID: <CACRpkdafY2JaCUfR5SGqSULLsMcnz5Xa+JdXAoVZ5wH=n9MtXw@mail.gmail.com>
Subject: Re: [PATCH 4/8] soc: integrator: Use custom soc attribute group
 instead of device_create_file
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

> Commit c31e73121f4c ("base: soc: Handle custom soc information sysfs
> entries") introduced custom soc attribute group in soc_device_attribute
> structure but there are no users treewide. While trying to understand
> the motivation and tried to use it, it was found lot of existing custom
> attributes can moved to use it instead of device_create_file.
>
> Though most of these never remove/cleanup the custom attribute as they
> never call soc_device_unregister, using these custom attribute group
> eliminate the need for any cleanup as the driver infrastructure will
> take care of that.
>
> Let us remove device_create_file and start using the custom attribute
> group in soc_device_attribute.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
