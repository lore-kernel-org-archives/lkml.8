Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF41CC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CC82051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUr9Vmax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCXRPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:15:25 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34556 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCXRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:15:25 -0400
Received: by mail-io1-f52.google.com with SMTP id h131so18955512iof.1;
        Tue, 24 Mar 2020 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YiXRlBrRsNARFfivt+q4M19L7ch08HlBHiwWszT73K4=;
        b=dUr9VmaxL5yXvGB0B5Pqvr6qpjK6TdoMypHZquv7a109cusjUgT7mSHaEEx0ZgUYr+
         4bwaQ2Sg1eAoonfdHK/ATuT776XjJT4HmK3OwKLdeAgDQvWV/9WWoIW6hudgi42fevJG
         rb2Fp4qXZSfU2MNZ0U/nSBxZ5JYVHl4BPGth0ALr0e6SaP/b8QreuwRndREC6DWbQNga
         nI6S9QFTqr4W5u3grizAJz+xa3uP5QjxYQZgufvB/K+NPBsiX8LPvqGoboQ+nIplafVu
         2Srmw3E3frsSHKjxiwwJg8qVdlCrfNUPe4r6A5viZ/OEJ3CPO/fZxKX2ea7tysEHaU32
         Ab3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YiXRlBrRsNARFfivt+q4M19L7ch08HlBHiwWszT73K4=;
        b=KAGM6I01ogLis9Pkjh7oC17HzHvdUshY8WEI+bZZmwYutNRv6fhd396nD3o++E0vXc
         +daHVusV+ecaEys6mxIHZFQImbPGqiMA+HRYZ7gCSgBsKpIyiieSSa5D9DPHTyexcgbP
         0jpDK76zSMgzjWfBlnbJs/TNSYSJI0yaq+xwRqNf09sxvECRGrdTJc5dCzxrhRZt6zhQ
         iFitNerK2qUtBM01ih+vpGPXsic3g6VO8K5Rq1LmEdCadtJGhHIS82uZEWxHddQ8IOH1
         3uD4jrHrp3kpOzmoTUDu5dIrQ7DOzUb0uldySBSIpYKn5fDKst2rgMChzDFBF/frqWWq
         YtAg==
X-Gm-Message-State: ANhLgQ3Yak+sewCCTyvXMvHjnPWGnvfpb5v8SEbwO8WYavUm8GMZ4WD9
        Vl3J2FdHUz9joNnFBcbuHFmI7stCTwvWU+sNHWg=
X-Google-Smtp-Source: ADFU+vvnlaAvK69mWlXDrcnkigXzx9IDgu1uxA1gabe6NFL7UpARiED1mD5R3sbffSU67zdCIqOcSFCArfW+SPrhQ1o=
X-Received: by 2002:a02:86:: with SMTP id 128mr25665426jaa.3.1585070124273;
 Tue, 24 Mar 2020 10:15:24 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 24 Mar 2020 12:15:12 -0500
Message-ID: <CAHCN7xLbV5BxD9PYfxNC7M64WK1nf3Y=zfeg=PqF+XgwvyZBjw@mail.gmail.com>
Subject: Versaclock usage and improvement question
To:     Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek,

I am working on a board that uses two versaclock chips using different
i2c buses, but it appears to the driver is hard-coding the names of
the clocks.  This appears to be a problem when the second instance is
loaded, it fails, because the clock names already exist.  I am
inquiring to you as how you'd prefer to see the clock names generated
so we can do multiple instances. I am planning on using kasprintf and
following a pattern similar to drivers/clk/keystone/sci-clk.c.

Secondly, our Versaclock chips are un-programmed, so we need to both
enable the clock signal and set the output type which means adding a
few device tree options.  I am curious to know if you have an opinion
on how the new flags should be named.

Lastly, we're going to use the versaclock to drive multiple devices,
and some of them do not call the function to enable the clocks, so we
need some method to force the clocks on.  Is there a method to forcing
the clock outputs on similar to a gpio-hog holding a GPIO line in a
known state?

thank you,

adam
