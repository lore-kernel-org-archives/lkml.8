Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB283C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CCA207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6inz7cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGSFDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGSFDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:03:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 22:03:41 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e12so10675216qtr.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEqZBcqpv35rf52dotkzmMLHr8VjKvDha+vHrVrlW0A=;
        b=D6inz7cPW5KtL4cfSKKNob6tOCWLXCyACu71vQf1AKdWjWW/Ru7iL8LL5KeK+iEYW9
         HaMZtnaytgIE0gXVgqMouC1psLLXQVub/40zNbJPwYWzM3JI7QPfkKkSzBmM/dfjQ0RU
         CbtoN23Yr2PuCkwrAwdFH8MzvvmuqP7W6iNjfdJUhTONAfuM7jVU+OdZ3YJXs8giGmaf
         jBVKIOIkG6Xp4bF4dBmWfZ6bENCWV/G3kch0eradlm29RFaffAJAxBcQTA7faOjm3Roz
         jODBjdS/3eq0cptBUjZwibSpiaPO00qGyJA/EBdtqpQ4TZloGI9a2L3qWY65QIkjHEJL
         7QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEqZBcqpv35rf52dotkzmMLHr8VjKvDha+vHrVrlW0A=;
        b=YWySo6KueJNZExCzCC6O5wFF5Iqrj/6KXmMib4wLQiA+poo90cnF5toPREbbJsA7rY
         g6RwunbUu37WppBuY30wEvvWT2chuakFWJZcvDZiYu5RUTDQnRe1vL++vlXpnd83fvWM
         +a1iVyGzgWKarsk1mD+ey9XC1gjYnO6aw5T26dT5RubuuCbvcMuUxjzCo9DYa+t4AEJJ
         5ujcbux2k/XbMWlWek6BODG4fLl2neCxO4A8SVwZv/NgU9OqqxQQIdJy5U3/AIebn/2u
         SP9CDDGiSUJPUoFOlnkahoNgVideZOQPRykVCfE6OMlZx7AP7G8nEptO9X1DUe3NNKmU
         DjVw==
X-Gm-Message-State: AOAM533v0EUJyyGHpzJx+GIoESZpbdHKH55+vIALk8YAMfKKKZAdYutt
        f/iDQWPKy1NSdtod3vdYJdMX0xLoOlHPsOOf/XU=
X-Google-Smtp-Source: ABdhPJw0ikC0VJ2buLuhX5AoQkeCoRIp2Y/xO+wYrRjdeukK8Al3WDMssG8e7TeQ4swr5BBN2yrSDqO5Im9oy462Hzo=
X-Received: by 2002:ac8:87d:: with SMTP id x58mr17702400qth.28.1595135019168;
 Sat, 18 Jul 2020 22:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
 <20200704122222.GB15530@amd>
In-Reply-To: <20200704122222.GB15530@amd>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sun, 19 Jul 2020 13:03:25 +0800
Message-ID: <CAAvDm6YcE7VwphmD0t4FP+JNutkC4W8B=n1X5adL7wZ2s=92Wg@mail.gmail.com>
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
To:     Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Cc:     kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel
>> Are there some potentially serious problems that I should be aware of
>> if I totally disable the CONFIG_ACPI option on the X86_64 platform?
>These machines are still mostly IBM-PC compatible, so it is likely to
>somehow work. You'll likely get worse power and thermal
>management. Try it.

Thank you for taking the time to respond to my question.

Do you mean disabling the CONFIG_ACPI option is mostly on IBM-PC
compatible platforms?

Do you think disabling the CONFIG_ACPI may cause the OS failing to boot
up?

Thank you for your attention to this matter.

On Sat, Jul 4, 2020 at 8:22 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Are there some potentially serious problems that I should be aware of
> > if I totally disable the CONFIG_ACPI option on the X86_64 platform?
> >
> > Would it do harm to the hardware?
> >
> > Thank you for your attention to this matter.
>
> These machines are still mostly IBM-PC compatible, so it is likely to
> somehow work. You'll likely get worse power and thermal
> management. Try it.
>
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
