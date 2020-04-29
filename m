Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED7C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BB521BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeQpH7rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2MTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2MTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:19:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AFC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:19:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g10so1434293lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1Ts4DfOpbqwNmKAyV/9/Lll4n9YArjQ/mn7brU53Ks=;
        b=HeQpH7rxp/Oyh4cRIDkKuEC/nrOQkmhe2swtarQuUReEO9o8Fgc5g5gq10VX8AQ9Ca
         9FUz0xLE0yzVF97yDlEt5U8ogfTQLqmFS5CBYqICi2zKUeyYtLnU/dG73H3PEFPr4uzg
         O7fEBhpMIUKX1MZfGlQ3RPfC8YI+3CQ4CWCQ2+9tqLp6xSNSavLwClNKF9av4efRAURB
         KeARE2/mJ0kKPp8hy5nuL4+z4J2kd9NG229n7jc0ndiQF1qA1xFeAMNAHoETBgACTXeB
         QqIgG/CQ1UTq3Q8vG88ewPteWzXsxqDvel6D9PYwVvaXXYsiFAA8QiKShxdQzqvsKXpw
         IdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1Ts4DfOpbqwNmKAyV/9/Lll4n9YArjQ/mn7brU53Ks=;
        b=UXaf/KUgBNy+epVi5OeeVHclCM4+iu4q8/S0Zu6T5SlzB547p5PNmIGnvBihr8MvBk
         JaojVHSSFz9qKJmn7q3lhf/WDB1fRWh916HhTxWo/jqNNICFPPT7a9nCKhJS659dy1pC
         Bs3s9a48OOsBOJfiWU3ZSrklY9/KmSoPu9Z+//W0SgF3nY/f2EJ+b43f7A5BYwcUOyp4
         S1ECcGdBW/0QTkBcaMVdGAVkctARIuCT12GNu6J4UtK/ZkaD7iMnHly2mzf5MvOB1IEG
         tTk5TB+uPYuQ+WxnL+xmnzy4y3WN4dFDcrdZsgz60gybghB8ODvQA1rRNKzTDeVKDQN8
         6VFQ==
X-Gm-Message-State: AGi0PuYGHI8MgFAws/t4yqueousthsY3rWbSuFaoVsgaJa1niVa6mrBv
        hU0wZpjvxDoAxQ1eCvnJ12STDf2mKFFHm1SVKCxqUw==
X-Google-Smtp-Source: APiQypJ2jgIIIfWcY9D1adj1uOLPdacJazusj6aGHmHvzzde6RhBsWaPWv8/f2ZwRjyszUh2zAlZgyz1YZbk16iyJ9M=
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr21464343lfp.4.1588162786702;
 Wed, 29 Apr 2020 05:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
 <20200428172322.2.Iacb3c8152c3cf9015a91308678155a578b0cc050@changeid>
In-Reply-To: <20200428172322.2.Iacb3c8152c3cf9015a91308678155a578b0cc050@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Apr 2020 14:19:35 +0200
Message-ID: <CACRpkdaT_G=Wa7iYhfBVGrcViy7EbDH1+Qme+UQTGTWybu7Fzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Make "offset" and "unsigned int", not just "unsigned"
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 2:24 AM Douglas Anderson <dianders@chromium.org> wrote:

> When I copied the function prototypes from the GPIO header file into
> my own driver, checkpatch yelled at me saying that I shouldn't use use
> "unsigned" but instead should say "unsigned int".  Let's make the
> header file use "unsigned int" so others who copy like I did won't get
> yelled at.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Patch applied. Nice cleanup!

Yours,
Linus Walleij
