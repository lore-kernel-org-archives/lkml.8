Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B28C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A66E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgF2Sw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgF2Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75CCC031C51
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:35:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so16278061otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+UH3wGWOQh5G+qJQo+Xjrt0bsgzB7MZcrtvAHyMuuA=;
        b=aky5PAkKkX704zmcMicbgyOqvUl0DCs6BViHr+0V/yLjAjpTD5HI7SCgTvmmHLTU/7
         Rsa6bRB51qB2qlSMh0Nkt7miv8RjiFw+/uncyLBiEUChJTUZbZm6D30kn4fDyJE00MUe
         lTfDhMTSVjm9YSFrD2MBNBtCR7VIyzDkaVO5xCc23xiGim6qbMjpcxLXlD46sCZ3Yn4d
         UB9cuiH0dS6vPRp6wWHPyg/r+BJ2pKud/s9St0ZmCKqs5DmQmk8tou67qvvBPf6SQRAd
         fDtrQw0CD94TyJDWwW06pW6QqvA6PFSl3DrmAQFXm2zUg2WEczRLlPHcgZ+fKZfe41yT
         a7QA==
X-Gm-Message-State: AOAM533oFSReb4lztCEOASZXrZ+S9oKp2H53yOs+9wGL3VeCzUbrJzuY
        iv1NkshT8EO4np8JTT7O9+5Shx42OtR/lyBFySM=
X-Google-Smtp-Source: ABdhPJyyh4FjacJgxndQ8k0y5wBka4OazaHJJ5vAav2ZoaFKx0KHCgrvsElzEreE/tpiDt9YewLIivzL/PrxLK0mim0=
X-Received: by 2002:a9d:6254:: with SMTP id i20mr14283840otk.145.1593452117318;
 Mon, 29 Jun 2020 10:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200526123810.301667-1-masahiroy@kernel.org>
In-Reply-To: <20200526123810.301667-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jun 2020 19:35:06 +0200
Message-ID: <CAMuHMdVi+N5mJo4WiKr7_wkYSShBmSGOca8abpkJbwbfRjavxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] m68k: add arch/m68k/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:38 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Use the standard obj-y form to specify the sub-directories under
> arch/m68k/. No functional change intended.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.9 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
