Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155EC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3500420732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MyRXyQ29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgBZAP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:15:56 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40203 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgBZAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:15:55 -0500
Received: by mail-vs1-f54.google.com with SMTP id c18so676810vsq.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 16:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTRomC2W+BSThGwAQZ4mFHuy58uAWVt5delRT81IvjU=;
        b=MyRXyQ29K/5rD2ii3vJTRTLOQGj7HhOiybWmpSn7wQARePsB21oMCNPqUfbw9IaLkk
         fEjTnM0c2DDcQCOnKybAVQGg6IvEpPJl+yg2p7SHDkweG+05yI8+cKr/gCSIP1gB7R1F
         2uI0P2Q2CK/LKaq2R3M3UpOFhAR122qdsb7KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTRomC2W+BSThGwAQZ4mFHuy58uAWVt5delRT81IvjU=;
        b=m2ItNbcsnEQ/I3ixk1clhhUaJi6/MLZ3DCddsUG8LSc/sRa9V47n/5aanjnTs0IG3G
         zwEmqI2+HLfYHdYFQkBWT8W6GGuwCJfVdgoV5FKMbnSBQk1K/dlYIJ7zjfdz9QFL8tQq
         1i+xDPnFe0lSuPkD3bJbsWe8QuI/nQcUZ7aaB5R3tjns4RQUm9A7NKi7263/n+iqhLjy
         Gk+s888TyhMoPWnbKr0Ut/x2U54bCJMJeYrDzvMyeH94wJWw9FCh5SEa382SjCZt6bWz
         ZL7dET2TvIV5KpHwpElzfsJZRFYk3uq6VfTMUBU7iNB8k0+RbD1gUJlNMeQRfQXCEGcr
         jbEQ==
X-Gm-Message-State: APjAAAUj7w6cu7qObbMhNG3coi9Nd5qXDWKJTiwd7wHF9JLARrw1LAq/
        1gjILpIUJStFfApXJpUbwkZdsJgbn24=
X-Google-Smtp-Source: APXvYqwn9uAN6bPxgt3WqJ1j9mB02KQXyA07/lJLIE2e73L8zfSRcLRn/lVKC6Vtb+sp4n7WsXsvyg==
X-Received: by 2002:a67:db97:: with SMTP id f23mr1923892vsk.100.1582676153964;
        Tue, 25 Feb 2020 16:15:53 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g22sm139785uap.1.2020.02.25.16.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 16:15:51 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id x18so689844vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 16:15:50 -0800 (PST)
X-Received: by 2002:a67:f541:: with SMTP id z1mr1739800vsn.70.1582676150352;
 Tue, 25 Feb 2020 16:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20200221053802.70716-1-evanbenn@chromium.org> <20200221163717.v2.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
 <CAL_JsqL94vtBEmV2gNWx-D==sLiRXjxBBFZS8fw1cR6=KjS7XQ@mail.gmail.com>
In-Reply-To: <CAL_JsqL94vtBEmV2gNWx-D==sLiRXjxBBFZS8fw1cR6=KjS7XQ@mail.gmail.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Wed, 26 Feb 2020 11:15:24 +1100
X-Gmail-Original-Message-ID: <CAKz_xw2ETZ5eyNfdWU5cF6Qy23E1NqhpFHoLT_CzUDHWTCbw4Q@mail.gmail.com>
Message-ID: <CAKz_xw2ETZ5eyNfdWU5cF6Qy23E1NqhpFHoLT_CzUDHWTCbw4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add mt8173,smc-wdt watchdog
To:     Rob Herring <robh+dt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob

> This should be a child of some Mediatek firmware node. I assume
> watchdog is not the *only* function.

I am not quite sure what you mean, do you intend this:

 firmware {
   watchdog {
     ...
   }
}

I do not have a deep understanding of devicetree yet, can you point me
to anything that will help me understand
the consequences of that change?

Thanks

Evan
