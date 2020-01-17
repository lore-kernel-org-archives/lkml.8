Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B08BC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF02072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJglOkpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgAQIMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:12:23 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:35213 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgAQIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:12:22 -0500
Received: by mail-lf1-f44.google.com with SMTP id 15so17670244lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 00:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxTtS/PAyYu4PhY4731eluF8s7eyQqI9JZGrr1rS1gQ=;
        b=SJglOkpFfLGWso6JXxp8TVd9mBPLE/eyxasneimQbQAVPow3Ff5F9sMXAiZ6xjRtOq
         teqkgdFTNtOj130NNo3fxCVjqQRUocxq3rem1kT+7EXYwVbM9QDL6osexKS5WO58aIq8
         Bnlgu/urUeXdGfqHz2k2yBP4lumbDurARlHjrGFo0aLsmucK8LvSPiA9fSQQlZA4GbYN
         JplUsgekZ+upgunt139DFbsyZzKJKkn0BCKTUBXivr2DUroqxiKJPtQy2I2ZxgPI21rB
         V8WpBqkvkUZK/IE5WurqkgIe/ik4jGrYc3sQNqwG6XJ8fkKvV4CIvyI+TLT/L32Kl4L8
         Ls7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxTtS/PAyYu4PhY4731eluF8s7eyQqI9JZGrr1rS1gQ=;
        b=DJXgDAeQTgYL3xdOOg9cjIJt/TI4IW8rFL7pSPdo4KQnHf6Mp9PgW7Ktg2LQeDRios
         MYAr9xPLAp8QP+XiNZU06pD5LaS1bkBKK0UwyDs++10wrwq8JpUpcbmQ0q81+O/TQvyz
         one/FgwrcutimseTOt+JljzBcL4FeNsfpMJoXw4cUH28Q3Q/lGc7KkmDb3fFnikr6V/0
         gOD9c0wYxuylV5LJjOemUAaYeN31szX8pL16ysAG8CJhNLbzTiViqma5VU0aSfi0Rdtv
         0W9aifcZ6+C2ennyc4n+nqRriju2Av+bRnC5B01sjhmff7qt09dyr5NoEivelbMMBTMs
         N9wg==
X-Gm-Message-State: APjAAAX2LfiHR4mqt2RHciTkLKnpO5NxytjiuqkxrtdfHvLBBlTGFY/A
        2RH/BKbLPNUTGcXq7dVm1UulViskHlZeNyb98vnTYQ==
X-Google-Smtp-Source: APXvYqwCoFlwaX9pa3RlM+pU/7sFZuE1VmJHQPiIfhyj1SSU/TjNQuX90/vXu+jBdalB0tDwuHviahRMlO+f+K/nWLA=
X-Received: by 2002:a19:40d8:: with SMTP id n207mr4522802lfa.4.1579248740306;
 Fri, 17 Jan 2020 00:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20200116142927.58908-1-yuehaibing@huawei.com>
In-Reply-To: <20200116142927.58908-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jan 2020 09:12:09 +0100
Message-ID: <CACRpkdbO14QeTBX0C5X5B3tH9x5QvahaAkW2_bVx5bfRiCzgOQ@mail.gmail.com>
Subject: Re: [PATCH -next] gpiolib: Remove duplicated function gpio_do_set_config()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 3:29 PM YueHaibing <yuehaibing@huawei.com> wrote:

> gpio_set_config() simply call gpio_do_set_config(),
> so remove the duplicated function.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
