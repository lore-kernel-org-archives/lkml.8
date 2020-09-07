Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6D1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E858220757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIGIux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:50:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33440 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgIGIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:50:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id 3so13002750oih.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VmnovsxiIuyCoqFMb8GIYc41hE57G64mj7pOl0e0CE=;
        b=gt1Y+ecdBhxsDQ1+w9GkzwlSKBnf0+7Jpy3tzgdfAE86+SMAIl/7dSRtASjUY1L+k7
         7prVIL/7wWbHAREXlvWPFaOIcRTVciuS7FudpGT36r93eW8e+me0xP4jpRPAlZgs9A3Z
         yXrpc/xqqgA6fqFD+C3/VmN5Sj4Bp8p3tMlBcPw8bPLIuIn1px/O3wCix5+mlhqMcAKz
         uTnJosXTH7FRhUwabBA91G8wNPlY47ysZgylobq7c10cz3md269/Nr6ZOuz6oc33BQjn
         O0dCUhBYuKGcspPl/ciuhBC2Lg0AbR/Tk/ojmai0jO3SwB37nD/a46sXSkDLp5q+vWWp
         9AVw==
X-Gm-Message-State: AOAM532h3KeXZx/fBBxfYkWU10ILfi6Nc3+sfeHiyu0K5eOt3V9y7lQo
        Xw6OQL8r9/SbYall18V/icizSRloKja6stuOxQM=
X-Google-Smtp-Source: ABdhPJzyGjKZuSYHphbCWZaMWs2PBiQ3GMIYOUwiI+oCv1l7DXbkW4yl9Y1HbG1Zx203mUmhqcXYAsEXM1Tl8L58gKg=
X-Received: by 2002:aca:4441:: with SMTP id r62mr802248oia.153.1599468650679;
 Mon, 07 Sep 2020 01:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200826122923.22821-1-geert@linux-m68k.org>
In-Reply-To: <20200826122923.22821-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Sep 2020 10:50:39 +0200
Message-ID: <CAMuHMdX1sf2FJqKyPE7SMrrHvWJ5y7qj3z_QcgZU0VFEBNBnLg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Revive _TIF_* masks
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> While the core m68k code does not use the _TIF_* masks anymore, there
> exists generic code that relies on their presence.  Fortunately none of
> that code is used on m68k, currently.
>
> Re-add the various _TIF_* masks, which were removed in commit
> cddafa3500fde4a0 ("m68k/m68knommu: merge MMU and non-MMU
> thread_info.h"), to avoid future nasty surprises.
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
