Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C18C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DAC252F9
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH+sEVbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgFUXod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgFUXod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:44:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1A1C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:44:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i3so17255559ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HUcHsp9ezzRKGkiZCENGcrlhI3OKE/gjI8m4DoDNNo=;
        b=CH+sEVbIuFm22Qn8H685qUHoABpXTJEj9HFD/Lb6Y+xCBzhzVXk8TxF1PMB4/VnYqG
         +Gr+fz+t4Sre1SP8UWu6xdcRPt8OSiUsP7wUNC9Jg9YmzeSzA/skWymtcyc9LuziErYE
         hh37wbZwtkEh3bpnpWzIGGG5VYz+/q8EGwJ3SvVLF00GgsQZ/H60P+xOoToaf+xVjmyO
         OgqF5WV87H7c9yp7vTcZHCpFWXKCXNq0yIiJOG0Stxc8URcPU4cNTcETcwPRcJFF7yjK
         CyH0sNAXDOEw41V0kOz1cJI8O70wwKCSOP3fMip1Z89TxGijNA/7GwPkMHe/xxXAMP+o
         nd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HUcHsp9ezzRKGkiZCENGcrlhI3OKE/gjI8m4DoDNNo=;
        b=U3Pyq1gxHo+TwUSGXtLEcnwWtxeHl5vDXYuv3FM9ReI3wPnMfHi5el2pXNHxPoi73x
         7sezaysfMfg5ak6WizRI9XC4xGT2Do8SGcgVspuY98HOfBDxh4EjV7Dbt5cse6zVBwzx
         9o9PVPJ01NC/myMM3zsWH1dJlnUaYjIuR6zo8bCrWWROjKKXW5asMH6rX/+0txHky9uy
         PQ3EFUrhqm2U3vYX3cnsUwByfm8dqDw94kCmMtolYlUEzK/03VnA7OhTqJ8ykXuj35c4
         XbSL7XMEpoxjd/+wbR/q2GOmnLanoFFhxDdQ2Ae6RbTwc1AEN+lYWDNGZR5Hx1CJgGmZ
         8NAw==
X-Gm-Message-State: AOAM533ztE5sLrwuxkn4sYnpjPLDkfnv6TkqwPd9nOQDryU4JeJ0W1O4
        q+s/MEbR+oNo+H4vTHUl5Bd336VxsqacMpo7hU0=
X-Google-Smtp-Source: ABdhPJxo5wSG5yGO7HpD+l0y7ThV8Jy8p3DBbDetLFF0fpZ3U9aj57/7zn5MWUYGZ79c2VGPyGgDUVCkeLJGJDc6MEw=
X-Received: by 2002:a2e:9b04:: with SMTP id u4mr7593843lji.364.1592783070627;
 Sun, 21 Jun 2020 16:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200621143652.53798-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200621143652.53798-1-luc.vanoostenryck@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Jun 2020 01:44:19 +0200
Message-ID: <CANiq72noMcMbHwx4HBPjF8hj_1CtXXVHBELFGyNdoAg5TihyCQ@mail.gmail.com>
Subject: Re: [PATCH] sparse: group the defines by functionality
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Sun, Jun 21, 2020 at 4:37 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> By popular demand, reorder the defines for sparse annotations
> and group them by functionality.

Thanks!

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
