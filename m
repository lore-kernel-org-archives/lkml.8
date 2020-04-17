Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22742C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D6D21D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQEXkcdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgDQKVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728631AbgDQKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E03C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:21:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q22so1498823ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQOUnSzPjZ8rvbaZqPPxjqcJfgipgrmZi1Zgn0PyywM=;
        b=mQEXkcdMMwE/eQPM0YapPBtjMo6DST8o/moyzKmeqyXHWeNXpaubL07pfHl0TCMyoP
         UDzcaqza5elEsa5JBNm9+fq7gPLXOG2qh4fD8KB2OL9HLLRnkaV6TMU0VHE7Nt62638r
         U45iyML7axS810w9+Q5wyOkZ/VeJ53MjVgt6o98t//JMLxEkXjYYjbO8X+rloy0brHZ0
         DPkso4foCSua+bH6ScvruldG2dbqu2uXxpJ7RXCqfWADAOnm8oM86LF3QZ8P5jrSIwsH
         HHIiFP9hwT4MlYhyPmIrLS7Iko6Y6GqA5kuQNDGTB9NqLnv90/OgaYq++M/g7hDwDiX5
         QnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQOUnSzPjZ8rvbaZqPPxjqcJfgipgrmZi1Zgn0PyywM=;
        b=NP3f3AwvDZfofhsnR2j3u9ooW8OFz7SK12uiS1ENzpY12iV9arUmQXD6DMW7sBc0+r
         Yzmdkssc13NP6K52jhKdhV2Wr9WwptdMog+NufSJB+Zlnl/oCPd/LzJrV52bI7DZaJiW
         O6jZ037yGCgq0bN6rdUi8fO+xnhwtFaVZcB9XBko47HIzJ9PqiZt8ygLDOH6voKB/HHE
         CbzjC+5nmjrP0ihbzmung8YSwoIlb/9cwN4PcSFGU7YJY8/A1lA3wjONpKcnmUZQLKlo
         0Fz/ji1XGZj1mIM1S4kUInrsuxWuAObvhXxIgh1D76s9aAUvHsdzcOvclccN2e4vns++
         V3cw==
X-Gm-Message-State: AGi0PuY9SxP0HHcc1+utnrWd4PHjPXAX8NnWSf1B63seSHImnI7i1Sr9
        rCRK8RkaUllpVfIS0TA8+WIxz2mNGaXzQbzWVikZKw==
X-Google-Smtp-Source: APiQypLTHEN5Wyv0xGHW8W9/+MjNtXfHLBoSN6+O6bavkPZo9Vmsv7BORVR9ikzPGn8HwVlxK1NAzmMA+uwJYGmoXoI=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr1602091ljh.258.1587118893186;
 Fri, 17 Apr 2020 03:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200417092125.12513-1-yanaijie@huawei.com>
In-Reply-To: <20200417092125.12513-1-yanaijie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Apr 2020 12:21:21 +0200
Message-ID: <CACRpkdYm7_DYSxvj+cwciUrfDZETbJSdGj=5L8O=QK5xcGYcCQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: add module license
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:55 AM Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following build warning:
>
> WARNING: modpost: missing MODULE_LICENSE() in
> drivers/pinctrl/pinctrl-mcp23s08.o
> see include/linux/module.h for more information
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks, patch applied.

Yours,
Linus Walleij
