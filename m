Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90430204EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wntl+SwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgEYLq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbgEYLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:46:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:46:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c11so18272668ljn.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtZVEMzdq38fu53lZDWzc8NBLCjAY5aGK/W4AvmImNs=;
        b=wntl+SwBMbjTVLSjCzfXL4lZBWDORiVo7jKBQtyuJNmBEa+JX+hFHc90oI5p93MmIw
         7Vku1Od56aWGJjM8UzLHBbWv+TBowntLoOoTlqUjBXHTYoXg8tMmLyEDUnwOnoM0B9VU
         dLG6zfe5wvjWBRaB0I32BcY9J6R2ZooI1C60ko4ij26+NS4CFS6ckhes3zzE6XgZ3ZjH
         59pLQE3IiKWc1IVka37TGUAnSPIlQ/zYfSW8rDeTmVQnrAaLT6cy7yvZeElaMEILicsd
         jJUmutQrVef6xE+GmQiC6z6zwASoOZP7gu1UkLOKiwWPimCbxlm4I61EXYqJPc0hZ7KG
         vNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtZVEMzdq38fu53lZDWzc8NBLCjAY5aGK/W4AvmImNs=;
        b=lXuT7PplrRNa4AXgrQf5p5+B9VS+A44WJKrTcbn14n6Cm7fFjlOjp+xW+bEUOSMyAw
         TWZXn4MIolgKbLhiKZJwS7fFsaXTtm9cA2vhEafZhdeEnawcMXLb76jHIjl16UiODE3x
         40wFP6725Opeo1WRTcjftvuzgE3QYD4JZxwEwsAFLpqFyc0LQ52XwHDUYE2OVjrf/AG2
         W2H1ExrKpitF3Qz6CeULcLv9rUegB3IT4Yz1nHAkXSk6oWIW17WirY4BPrqiUvrFE7lb
         b2M6ceBECNzJ4oZXbEdA+0Vxm6jb9bcgBbJ4nBKThHpQMDlKSd+g2FKoK6Oyrli0rk/R
         zzUg==
X-Gm-Message-State: AOAM530YQK3ktTSni4sy8YgGn/m46JYxrbvRWYwN4SGaI3+Bh2YtIYDP
        HRqvpnfag9HrOMreMsEFWhliNPj0IZ3s94MgRE8fDA==
X-Google-Smtp-Source: ABdhPJw5ECdRR0sT2j9LkRJkgjus2cyG5DJ9ePNpehKNpHs1eYNP0nQD76ry5+o8e6vYyTFN7E8BrPnW3RB52TR3RaY=
X-Received: by 2002:a2e:b5b0:: with SMTP id f16mr1271162ljn.100.1590407214125;
 Mon, 25 May 2020 04:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200523170859.50003-1-sudeep.holla@arm.com> <20200523170859.50003-7-sudeep.holla@arm.com>
In-Reply-To: <20200523170859.50003-7-sudeep.holla@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:46:43 +0200
Message-ID: <CACRpkdbfgqRTv6Cnt85Dao+xTqdcxUWmrzRBWo3VjfPEd21eXg@mail.gmail.com>
Subject: Re: [PATCH 6/8] soc: ux500: Use custom soc attribute group instead of device_create_file
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
