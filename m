Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BBC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B93222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6m5Gx7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBUNpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:45:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41571 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBUNpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:45:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so1518414lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hndYq/hvuTQ2lgb+uDJJiLZLvwvgOhX4+x+wDseLksM=;
        b=D6m5Gx7huhhh7gdrPjKZZTKodPH+VJBd7jLXv4HQu/pErnlqMfDSIeF+/Fk9ho8Xi6
         SDtlO70M+qTWb26Zg9yOElNX3DNkm9LOKpwL0Z55aq4wKWR9W9+nTTVQaRecUvfhoviz
         sbC6aEIkyg2dn4VyOEH0N6Q9LZ86xAFpLQeT8CBKtMg3gaJ+P+X9DVwTAK5GXipVDZHp
         XS0l90I6ZHZZCYafFBiJ/XuwaSlrwsHRA8tTQ+tzApIbRHimQdkd1BQpqEj9c5Q5L3Qk
         ujZ3ZW+23ztbeDUWoeGMPmIb9DY3xy27O+oGZnb9dAMSh9muZh1kMSqaJQ75GVtEYRYM
         24sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hndYq/hvuTQ2lgb+uDJJiLZLvwvgOhX4+x+wDseLksM=;
        b=uMokv0P/5Obl9hPH4wQSKukHEjvq5BV3I571EwqO5ObMBzGoqS49+mn5wC00fnQDqn
         UT1xhLs4Sboj1BabLZ3ayCw7d5P8Kau0+hfnia3A2xTd3N/ghi8GVa8WcOBYRl+DGUB+
         hYorTwczm53WyOnYBgFln+w0A6M/Crh0xTf/+R6JFm3QaE2PlWjDamna8K4YO/josksA
         yuXXMgQLHWi/m3obU6O6MEnTYtNm3dkN2FiJaVRRxip/En7TJ+v/p8MLdlZ94mNyMgf/
         aI2FBor+7P96EyRru28R1j2aiX9lt27iSBU1N4zvsBHgP1Q8O2YssXLrZicUBPC9Tan9
         589Q==
X-Gm-Message-State: APjAAAV9g1QvzontOvkOzSRLLR2xcaW0kFwD49N4uOzhoKxekStGTrro
        8wluTLUkKer2DHGFQ1oNN2DKsWDlh1QRaTdzIqFaXQ==
X-Google-Smtp-Source: APXvYqxoapboUoEkJoxhUkJEVbZMdob4xVZCqQ+cCbE7awK32LSRAnI4GtKJTVv6OiaV3ZNjbPljMj3NANKLQQjyDLA=
X-Received: by 2002:a19:ed0b:: with SMTP id y11mr799008lfy.77.1582292713960;
 Fri, 21 Feb 2020 05:45:13 -0800 (PST)
MIME-Version: 1.0
References: <1581942793-19468-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1581942793-19468-1-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 14:45:03 +0100
Message-ID: <CACRpkdbL4rSDfbzJSF67o93WEPaDB6th2MtaQQG=JQ6r_3DxFA@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] gpio: zynq: Update on gpio-zynq driver
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 1:33 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> This patch series does the following:
> -protect direction in/out with a spinlock
> -Add binding for Versal gpio
> -Add binding for pmc gpio node
> -Add Versal support
> -Disable the irq if it is not a wakeup source
> -Add pmc gpio support
> -Remove error prints in EPROBE_DEFER
>
> ---
> Changes in V2:
> - In previous series [PATCH 1/8] already applied on "linux-next".
> - Fixed checkpatch warning for spinlock description.
> - Added description for Versal PS_GPIO and PMC_GPIO.
> Changes in V3:
> - Updated commit description for PATCH 4 and 6.

I agree with Bartosz, this looks really good.

If you fix the remaining commit messages and post a v4
we can apply this series.

Yours,
Linus Walleij
