Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E10C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 01:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40E92073A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 01:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXNn7AqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBOBjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:39:48 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37153 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgBOBjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 20:39:47 -0500
Received: by mail-ua1-f68.google.com with SMTP id h32so4278321uah.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 17:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMs0i+uoo9dEPE33t+AXfXB1++1njbxKLeTu5JqtYr0=;
        b=fXNn7AqPrZ5ZwcZLjbkNrdxYZMTjnSacepUQ1h0/QR7892FFCnDn7C47Us/bBOetFQ
         X01EKp+TRXzsQl9vd1FlE3GKII5nj2LbiJppR9s/S2uzzT4zkgje6NSiNxGdoxERSlWK
         X5PypfkyXAc9TEycom6L8cgdPWAn8V93M3Y/ZexYz+o/TvKMLwHxv0cPaTDSTuVjESNE
         WoUDTfsgE/FIneJ49vWD5j8PvgRKWutgdNraTDfzQZSQazElkfpYxqL8Jyg+Fjxjt76D
         U0Nsmg15IT6ho38kecVo+Dr3/Y0NwKk68sqs5mDih8NUxyFnczcsucgY/Go1UUTmJTes
         dM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMs0i+uoo9dEPE33t+AXfXB1++1njbxKLeTu5JqtYr0=;
        b=jRV1XPGlSArgckxLNlmhb2LtqL0Cd8+FdUHN000xaBPaE4dNG1morXvOf8SELA0RDe
         xaNmK4ZLMSuuLUWxwd4HhVTugJVhBIOPE9Z+HPlUU4emx1B2gAyhkcVxRz0CvouqOKT9
         lBBrXr3Vw2Bx5qy5vweSUugjCzsAaWs0YMFsc+88D5MGMPeVMg2+KE2/PA5e5xWWmzHH
         O9QNCpY6QownAptdOpndhQR83kioQh2A1REWR7E/AFfwp7szTaWd3p+7djdBuVLEamf8
         k4e43YWK09xsXyQDvhCNM626+e4+JE2sq+hrzZvyTbegLcqd2XkChTF0/rxCL0F0QXSr
         +kjA==
X-Gm-Message-State: APjAAAXb12NFPq7Bxy/2Zdks4oUF8gnB9Ld6MpL4kQGiWpWqPmU357O1
        vlq5lQPxsxnVgojzltQKwO2uTzurdlJA92jGM24a5k6Jxhs=
X-Google-Smtp-Source: APXvYqyRF8/JMZJhylgjcPF+Qhj2QxTzBoJcSQm2A3xYu1dpgHXvJA+yiR3FUgFfdj8dXU/4MSre36eYYR9XKPHdYUk=
X-Received: by 2002:ab0:2006:: with SMTP id v6mr2955494uak.22.1581730786453;
 Fri, 14 Feb 2020 17:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.2.I7c8247c29891a538f258cb47828d58acf22c95a2@changeid>
 <804d3cc5-688d-7025-cb87-10b9616f4d9b@roeck-us.net> <CAODwPW-d_PpV4Jhg2CC+7Tfyrrh=gh6hRfcEKFb4gj+LB6vrWw@mail.gmail.com>
In-Reply-To: <CAODwPW-d_PpV4Jhg2CC+7Tfyrrh=gh6hRfcEKFb4gj+LB6vrWw@mail.gmail.com>
From:   Evan Benn <evanbenn@google.com>
Date:   Sat, 15 Feb 2020 12:39:22 +1100
Message-ID: <CAKz_xw3NH7saKUda3o0uz3qf4rSc63Yn6E0KrHW=ncxVsk78ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Julius Werner <jwerner@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Evan Benn <evanbenn@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > As written, one would assume this to work on all systems implementing
> > ARM secure firmware, which is not the case. Please select a different
> > name, and provide information about the systems where this is actually
> > supported.

> Back when I wrote this I was hoping it could be something that other
> platforms can pick up if they want to, but that hasn't happened yet
> and the code on the Trusted Firmware side is still MediaTek-specific.

Thanks, I will re-word as mediatek,mt8173-smc-wdt, and address other comments.
In the event this does become a standard arm watchdog interface, I assume
but do not know that it will be straightforward to change the name here.

I am not sure how to proceed with modifying Julius' authored patch in
kernel preferred way.
I can add myself as co-authored-by and modify patch 2, or add a patch
3 to make preferred changes.

I will use approach 2 for now unless otherwise advised.
