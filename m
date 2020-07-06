Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6232073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgGFL3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:29:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36961 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgGFL3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:29:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id w17so23524207otl.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 04:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+rvwDnB7KNdTk0PTa6sJ+inXwhfjZGb6BKn9QP1KQI=;
        b=sdXRGMv2Eip1u2HWZTidTwQ3aGmRI7n0M08mxEPN3SMhzK2nAfmXQquiuYKUZz3g2q
         XbRBzdWCvEzYnvv08W0nZhcXvw1snNDSkt5bKUvhk+SY/e0MA7SKTZy59u4JUtJ7VwS7
         7v8RMC9Y2n6MPivGmixKuOgE16V2ijcSlLQ5W1URQODx7c0BP9W8EbCJ3sjmRg+NbERb
         WJLGiTdDzHLPoCGXaEB0qgOlxgC2ZEhTukwZxBbLw1hj+IsA0lK5jAFtPiCzRjgD7TV2
         1RYu5gao2psQ8E+GcmTkFNyHG4khMl16iK+yUGRAVv97jVf2U1jBCqsbCNWX4ZPTJTSk
         hqsA==
X-Gm-Message-State: AOAM531li42TJywsY4Rt3K/BqIMqKq8nd16rTeSCWaFIoME8ypW4MKA9
        /vvORtP39y624Zfc0u9n2DhDG6lGqT+IsAkIc3L+JRV2
X-Google-Smtp-Source: ABdhPJwPUSr6ZLB+SjD6scglo9H3KlFknYKAbY71zGS5tOBZVvDJAlogGl2aI54HOoLHq5ZOD1V5P1PfcjhR7ovqXEg=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr8365677otl.145.1594034944241;
 Mon, 06 Jul 2020 04:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200706095100.19157-1-geert@linux-m68k.org> <CAHp75Ve49Ucy9nMy1UBYirWX2niJ=6tfEGzmD+DpfRgb=JdZAA@mail.gmail.com>
In-Reply-To: <CAHp75Ve49Ucy9nMy1UBYirWX2niJ=6tfEGzmD+DpfRgb=JdZAA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Jul 2020 13:28:53 +0200
Message-ID: <CAMuHMdXQX3MXCPjqoKkFh3Jh1dBqBKSBVSjT-DNhTn9YLCd2uA@mail.gmail.com>
Subject: Re: [PATCH] lib/test_bitops: Do the full test during module init
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jul 6, 2020 at 12:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 6, 2020 at 12:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Currently, the bitops test consists of two parts: one part is executed
> > during module load, the second part during module unload. This is
> > cumbersome for the user, as he has to perform two steps to execute all
> > tests, and is different from most (all?) other tests.
> >
> > Merge the two parts, so both are executed during module load.
>
> Does your change prevent you from unloading the module?

Good point, you need a dummy module_exit() for that.
Stay tuned for v2.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
