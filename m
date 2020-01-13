Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F4C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FB62075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgAMHx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:53:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34464 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgAMHx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:53:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so7434014oig.1;
        Sun, 12 Jan 2020 23:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLuIgnm2TQQHGBGG49vfLi7gp63ZT4uPLtOQXHwpeS0=;
        b=iTmrhShXK3IDipViQIfzskZuCAsUBVXF03H0CzrbNr6Q74Q+CnDTx+gSrlpaHuvth6
         ac92+dzT3qfmdGympjPA4MpOSe4JEuz3XnWKxt3aJ2S/aExrqcUH8181qCxZnjUFLI6c
         j7FEgHWXXIihnko+RrpT7OeqStFNSpNfhEmOOSW8z4UkKAENb6oBkmRinHaVB7U9CjJm
         6Qw1Kt95O31tENjQsd2xjSO0L7gm9BkS9l+XfmZFoH8tXJjSy+NxdMX4v81aeolNgbh7
         kzlTAPR0jS1iluuP7bZJUBC1S/hwzyDosm94HjCoGNPS0RW82AZe1TWk2ULeoiStWiYh
         9l/w==
X-Gm-Message-State: APjAAAVgGa1nc+VDaJXR0RzTpLUQsX1mhQSPF2NNVNPsGcXIZak+LsV+
        ZrB0PGUO5bIEsRrSJKx4juV8Xh7APJyED6CZuKYN8g==
X-Google-Smtp-Source: APXvYqys64qsgvQc7xo/eGx9/mMr1haqg37sk5b/MhI4S+yIAHdTdsUZGpjOaHGFISTY6n8UsSPRZnyPjEA4152KZoY=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr12293776oia.102.1578902006917;
 Sun, 12 Jan 2020 23:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20200112165613.20960-1-geert@linux-m68k.org> <CACz-3rgg+SkZdkMFZH=vOwZFeD1dbOzoVHAGH55Mqkaif7YhJQ@mail.gmail.com>
In-Reply-To: <CACz-3rgg+SkZdkMFZH=vOwZFeD1dbOzoVHAGH55Mqkaif7YhJQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jan 2020 08:53:15 +0100
Message-ID: <CAMuHMdWwy=q3Cv4=rW73nKsTEK8oiUT5UKJVjC0OjL6GUE1s6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] dio: Miscellaneous cleanups
To:     Kars de Jong <karsdejong@home.nl>
Cc:     Philip Blundell <philb@gnu.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kars,

On Mon, Jan 13, 2020 at 8:43 AM Kars de Jong <karsdejong@home.nl> wrote:
> Op zo 12 jan. 2020 om 17:56 schreef Geert Uytterhoeven <geert@linux-m68k.org>:
> > This patch series contains miscellaneous cleanups for the Zorro bus
>
> Zorro -> DIO

Thanks! Fortunately the issue is present in the cover letter only ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
