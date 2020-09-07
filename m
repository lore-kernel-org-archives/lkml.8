Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03ADC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67232145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgIGIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:45:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46454 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgIGIp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:45:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id u126so12926578oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+EHi2XR9MD4uz2c6qMrc9aO2txOuSKIm/lxpOY1Ydg=;
        b=taI9pHiuZNmd8VN8r9AdLkR1qZ/9arL3xHtGS29ncqt0rhqL8E0u/Vpin/VZUAvotP
         HOPjrITLsZJeVBeQmMjPY35709w4nMwKgf+GBbXoOeP1hWq0uOfUDeNh/gxLLHtu50pu
         YkpVzV7psdz0iyrp0rUKKru6/mxOXlTa6u0D7ukmpfDXqLdfjIX1Is0S2tpsss/3poLc
         ixVwz1agC9o1/auxdE2y3aK+KDp/J848/IfOFq/JJCvmD8wVTWUR7dfL0hhr6Ks0mJzl
         14Bzvrr2f2Wweh+30rPn8McftVVvz9HUfNy89bTdNvtNtEqMfYXiOzJag2+U2PzBRJIf
         5yaA==
X-Gm-Message-State: AOAM530RHAXpWkujYwI8G/2ynaSpjAnAQfwg+luPQBnb1lqz+aUFzEtI
        UcnIBzuwgu4VzG66ZNEJHBp0W80CKC0HDcIpxvo=
X-Google-Smtp-Source: ABdhPJwLvEZ1MTxg/ftLIK+LwF+Qt5TKEIxtCyoZYcyHfoixAaB2x5MbsxABSqdOStHGVn3RCENRqiMG3Rje/OqtefE=
X-Received: by 2002:aca:4441:: with SMTP id r62mr795734oia.153.1599468328250;
 Mon, 07 Sep 2020 01:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200826125124.23863-1-geert@linux-m68k.org>
In-Reply-To: <20200826125124.23863-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Sep 2020 10:45:17 +0200
Message-ID: <CAMuHMdVd=4dhv234z7y75ssMimAcAn1=GUOY4BzQ5+Rrrx1wcQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: amiga: Clean up Amiga hardware configuration
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Move the generic Amiga hardware configuration section out of the
> switch statement, which allows to replace all ugly jumps by break
> statements.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, queueing in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
