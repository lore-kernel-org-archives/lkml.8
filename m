Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F5EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E4220675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZy3hsvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgBNH6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:58:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42191 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgBNH6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:58:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so6127029lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymE4wWcDTZ4AlH/kInJn4kU9JLjQhMLl2OMys97727A=;
        b=nZy3hsvlMcZfE3n5bPdXmH8xVZu2quGC7nIe8Bh1yEGC8nv9V5v20T+dh2fD8BANzk
         KWU+vGXh8JxqXqgG3CD9mO2i0DI4omtVF9dg+aqcuKNEFU/5u1V01XKoU7+xjV8c7xQV
         tWb4VNixrew50D/MsLtSXmcHF+z33WoDgZjCJi9TnTm1AZ7H0MIaV9U5VRNogocswkAV
         Sj2ree9xZBb20hixgkBdf8HgVsdBfLBXiCYhxbMXb+cN3Nkc6z/hKmOVOY/Tr+Ne2+2Z
         4gIS0f22I7+LyXWcWV6ijyxBd+zTI8geRJj20VpS7bWPplBqFlATSPA8WFO/iE1XZyZq
         2clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymE4wWcDTZ4AlH/kInJn4kU9JLjQhMLl2OMys97727A=;
        b=X/bM8McYUM0+ZNPPH5JzLGtMWdM29g6f4s1VmSjXxW1v7x0BVFElurc6WTTIbFK9mn
         NVRL5m+tgWSbOV4atlVhK0Ilb78rTsUo9DEa/CggE5WhfyfbBF8oPSBxQyvtsTAa9/ZA
         QPBZXQicfwrvaBI9Uu+O0m7rvOGV+Zr61gVDpTmZH6MM7J+KHWN6P3+VoO90tKomQks5
         mCRFA/h9Sy9RBr3VwKYgabXTnJLytC3YMaW8cCQn0VcJYUuPs9dIu4VZ/nS2W26JfnV5
         B1M2Xpp3ag6q7bO6M3mybCbpHh/smoyvkWjRj42T8hEdg8K1+K7gOYkQgDvmvEYh5fVX
         WC2g==
X-Gm-Message-State: APjAAAUs6c5lRXQQOqtl7/2iKU+iLbat0AkNFC0KQnUuifNRV0BS+L+g
        Vk48kkSB5lWoF7r/Ll5iYN6aKvcnWRn8+5YxzJvgQw==
X-Google-Smtp-Source: APXvYqxVrgTWvhNGIt/68cvNnLcqmAKR2/yh4RqSuMw7dAFsIDHGzBtLAqtp6LbjMZQDirjIQnTzLRtZuhdpeY2CkW8=
X-Received: by 2002:a19:40d8:: with SMTP id n207mr996255lfa.4.1581667084690;
 Thu, 13 Feb 2020 23:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20200213053943.kxss6vvhi3jacfpw@shreyas_biamp.biamp.com>
In-Reply-To: <20200213053943.kxss6vvhi3jacfpw@shreyas_biamp.biamp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 08:57:53 +0100
Message-ID: <CACRpkdawYjK9ma6pHnZYoHgsMxgfB1PbNCA83aD3Z-KS0CVAMw@mail.gmail.com>
Subject: Re: [PATCH V4] mfd: da9062: add support for interrupt polarity
 defined in device tree
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        shreyasjoshi15@gmail.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreyas,

thanks for your patch!

On Thu, Feb 13, 2020 at 6:40 AM Shreyas Joshi <shreyas.joshi@biamp.com> wrote:

> +       switch (*trigger) {
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               irq_type = 1;
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               irq_type = 0;
> +               break;

Please create #defines for the level indicator, like

#define DA9062_IRQ_HIGH 1
#define DA9062_IRQ_LOW 0

and use that.

With that change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
