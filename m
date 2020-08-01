Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B03206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 12:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLuWNKE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgHAMui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgHAMuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 08:50:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD19C06174A;
        Sat,  1 Aug 2020 05:50:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so25410485ljd.0;
        Sat, 01 Aug 2020 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqClmlC3LlAm3Xey7EC8Tw9GBmxSznPUo4DzWC4sUS8=;
        b=iLuWNKE0OuxwTdlpWutGCACBMoNvEnpvkOl2bv4v8aI80LSYSHcd2hYHfabBoevd12
         2Psb90f3bVmwzIC7FvfmpaapnRLf3uNUDrueEBoppCJt9+0wkOb6w8PBXXoNluN72pHG
         11p2UCnD5HJVyyClSaxy80pex1LZ8KoKFqjfRsK24iTUnez5t6FxPC9P2+wPhaiojygq
         0ZPgxBTdmTPweYKPbF+Sua4uYdXv9DO8MM2kLPy5xGzaVvzoz9LxrUeRi19l7mem8+YU
         gPCL+5X5CmpaG8XUyLGYoCQnchEjD8QrEKSAQCjljD9c3mWjfhMUCcRgyL7UzvAQ/MNz
         xpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqClmlC3LlAm3Xey7EC8Tw9GBmxSznPUo4DzWC4sUS8=;
        b=chLmQ74ay2Jqf+oVItugLMEzAm1ohvU6uEsZwy07jC+uMzRT83HTq22OgP88WINRDd
         gXt+Es87guMMH8sR1cbqOv9gfBnLqQOAznH5E6lEjVYhnwkZqKlMp23PqsjURvJm3K7w
         3yhYbgSgko5gIeFX4y3rZM60AIxY5OVyHKvo+9ixpSIx74CtIFhrbfxUh4gMxPBeAiu6
         96fNJkGYsygnm1/rGP7Ake7fv+YpdG49bl4jc+cKutXnLKkwkPEmrz8WKhyBlEi7inFj
         5ZV2u0PBzdY0r7qxiyOWSGd8agwb55Vw7cs6uCAt/ob41b2+DruaY+FCAk1b+7ZFXZwG
         SQ5Q==
X-Gm-Message-State: AOAM532Eynipxt5/2DST3jONd54804PO4qq09nunBtThjUvuqbFJq7np
        B+KsfmMXLpZnPL9hkXVFzr56ZANEXEUtKG0ClMKrOA==
X-Google-Smtp-Source: ABdhPJy0GAoIzwM3RjlqAq4gd4Iba8EMceGiCkI1SC9ZAJmwI+D/oI+tmSZ9b95MMo5uhDyGr0qYo9nKHXqidjdJO4w=
X-Received: by 2002:a2e:b814:: with SMTP id u20mr3740179ljo.202.1596286235379;
 Sat, 01 Aug 2020 05:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200801122718.543376-1-masahiroy@kernel.org>
In-Reply-To: <20200801122718.543376-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Aug 2020 14:50:24 +0200
Message-ID: <CANiq72ke=j4DQ4=YA0ZdnYRzJf-XOjPbvwugUdn6afM8wK8YNg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: introduce hostprogs-always-y and userprogs-always-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  samples/auxdisplay/Makefile         |  3 +--

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
