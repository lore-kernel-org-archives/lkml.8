Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66661C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775320873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUHowmpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgB2QeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:34:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41701 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgB2QeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:34:14 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so7004094ioo.8;
        Sat, 29 Feb 2020 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NL/uMzsUD2HZLCImnyoogjvK4Zjw6EClchIYf2JMVHo=;
        b=qUHowmpGyPUtIFeJG/+XE2zu4mA9NcB90XB5EGkBRfZk2MfI/qF/fFp8rqGBLwtf3U
         dJ07kXzM8y0FJnw9pjclsVkVck8eBhBo6L7s6e3DHHyKyl054G23BJozNq/1h+94DzEf
         zQZ7YRfmcHby109nRPpuIhZrH08FC+kDnV0xAjLywkUrdm+jNsm3gbMOi+BnFRMyy3wE
         ROcAJx52i1ET2089k86V5754YJq7mmD2JPTX1blNhggl1EFWyB5uth1VKbUjElTbCfW2
         Eh1BmWbRuPYBpyWfVkhaciG1+/ujyMAQfLHi1DQy7psuR42XtK0/KFvegsMvSAARg7Xo
         0oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NL/uMzsUD2HZLCImnyoogjvK4Zjw6EClchIYf2JMVHo=;
        b=Pc8DA1ogkmUwEGbdjVgUJSnzy7yuWr1zHh8UuooiuP/PfEzWnhsZfND4SFBAsnY3ai
         cU7uFTwbWOWShWsiidYs67xRh5qYNUAhKZh46U3d0q6UZfAMeFx1bjvmFJW5icT/Vz5U
         KOAt/iMKsiryN4XxMCWVGFKpRujVtpfmJqd1CMXQsVfa23Xr4E9oND7jEDVpXYINzaFq
         73/YDADP/FnOFSNGksYct4bkv07wjcqUs9SzTUx59N/FPZC/5nh/lIQoM1j0/L1hNGD5
         LNHBvKdvehaBSD+wKTfW79hiqHH4GzPunMf3urcJT4HOwGstu47s4Pm/XW8SxG0Bxosu
         fuJQ==
X-Gm-Message-State: APjAAAWrJcfUjr1YNSqEPHPcsQ5xkceKa9Hhrkf3GA6O94NxBdMuWxg1
        B0aZBnJ09fs+lE2t9HDg4UaXuzwh8siKk+5sdW1P+F3A
X-Google-Smtp-Source: APXvYqzYioyzyfom5TmWYdexZxNovqERZ5n+/IDhTAk/U9FLvK2ylkTM3FCnMMfDzBa+RAGEJstZ1Khhyz2/eVEkdEs=
X-Received: by 2002:a5e:8214:: with SMTP id l20mr7989403iom.168.1582994052694;
 Sat, 29 Feb 2020 08:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net> <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
 <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com>
 <20200228175905.GB3188@roeck-us.net> <CAKv9HNbugeO0E5w8PsN-EpgHBtAjOYZppkUz1u0a5Ue6k20GwQ@mail.gmail.com>
 <62d81632-4a6f-b2d8-e420-b58fb6c9d044@roeck-us.net>
In-Reply-To: <62d81632-4a6f-b2d8-e420-b58fb6c9d044@roeck-us.net>
From:   =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>
Date:   Sat, 29 Feb 2020 18:33:36 +0200
Message-ID: <CAKv9HNax9bK-60Gkv3ovZDAS_xVEQa95-J_9WKoEkifqa0u9+A@mail.gmail.com>
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 at 17:25, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Sigh. It would have been too simple. Too bad I can't test myself.
> I'd like to know if this is because URB_NO_TRANSFER_DMA_MAP is set on a
> transfer, or because the beginning of the buffer indeed needs to be aligned
> to the DMA cache line size on that system. In the latter case, the question
> is why the alignment to DWC2_USB_DMA_ALIGN (=4) works. In the former case,
> question would be why the realignment does any good in the first place.
>
> Any chance you can add some test code to help figuring out what exactly
> goes wrong ?
>

Sure, I can try to help. Just let me know what code you would like to
insert and where and I'll see what I can do.

-- 
Antti
