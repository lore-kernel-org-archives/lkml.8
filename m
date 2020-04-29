Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73927C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516A42074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cK2TC6oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgD2Aum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgD2Aul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:50:41 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1EAC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:50:39 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c24so254075uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6u3sVYzO/Ci5rYvWAGcPeyuh2kJ6IDPGvpL5WgquApI=;
        b=cK2TC6oquRyuDEIZ1S6rIu8b3VOBFMwrJQubosXZZog80NmR+y/OlKbMCRaYQhZhpm
         sWdEbha+b9pOy8AmCfTklC2xUV8b1e0VwH2uu5DoFuI05bntFwhljyerZYyRnK32Ze1Z
         pmka47TcDe2giuk2cFnHmM+QKkaEQD1W78IU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6u3sVYzO/Ci5rYvWAGcPeyuh2kJ6IDPGvpL5WgquApI=;
        b=RfE78tai5G+7VU+J6VmEsMGhBlf50ABQRZRNA2Cck4jw89TU9zZo95GPev79/CB9/U
         fNWs6YaRsqXEGWyPXsKmW7Wha8LP5d9hvTvHhqVp+ng+7YlW1+n3rJ8Kq3yo6GDF13tk
         c8H0/o8qyMqV+J6ES9qBLsI9LMFBv0QrTUaYwdjEDu3aUDYrmkUSO6SNghg0W4rpoNci
         lMeaTx2rTI0iWvprTBAsq7USzkVf2mogSA63gltv4/duwDT0UKJ+zwvU/yorN1PvwVm2
         KRa5yhr0f3EmsYzgNf6BNucDCeieMYmjbtSiz4T3dj/cr8I21L4kxfs2Y/iLBCrIJxt0
         u/fA==
X-Gm-Message-State: AGi0Pua+xBhMlAZ2oVcBLd6oGzTI8M1kIY61+sxtzla0pRk3SbHU9sw+
        VM70Fct/ZGqSD8p/bsW/Q+4ys6TYqPs=
X-Google-Smtp-Source: APiQypJnPoB9T7yYiv/d8OlLecmfamjfetfCRKMdU9/Z2SJI5opjmYoTS8JMw7k4qoh+vDPQ6En4HA==
X-Received: by 2002:a9f:2907:: with SMTP id t7mr22066689uat.4.1588121438924;
        Tue, 28 Apr 2020 17:50:38 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id r188sm4631180vsb.20.2020.04.28.17.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:50:38 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id y10so285758uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:50:38 -0700 (PDT)
X-Received: by 2002:ab0:375a:: with SMTP id i26mr1184039uat.120.1588121438064;
 Tue, 28 Apr 2020 17:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200428172322.1.I396f351e364f3c09df7c7606e79abefb8682c092@changeid>
 <20200428172322.2.Iacb3c8152c3cf9015a91308678155a578b0cc050@changeid> <a23b7a97f349e6f74b993a4e127564ad3f7d6929.camel@perches.com>
In-Reply-To: <a23b7a97f349e6f74b993a4e127564ad3f7d6929.camel@perches.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Apr 2020 17:50:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Us6LyfgeXvxnqq+KhHN1djok1y+W_xzSb-KGFy2wgEMg@mail.gmail.com>
Message-ID: <CAD=FV=Us6LyfgeXvxnqq+KhHN1djok1y+W_xzSb-KGFy2wgEMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Make "offset" and "unsigned int", not just "unsigned"
To:     Joe Perches <joe@perches.com>
Cc:     LinusW <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 5:38 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-04-28 at 17:23 -0700, Douglas Anderson wrote:
> > When I copied the function prototypes from the GPIO header file into
> > my own driver, checkpatch yelled at me saying that I shouldn't use use
> > "unsigned" but instead should say "unsigned int".  Let's make the
> > header file use "unsigned int" so others who copy like I did won't get
> > yelled at.
>
> There are a few other unsigned declarations in the file.

There are?  I swear I looked for them before I sent my patch and I
couldn't find them.  Then I looked again upon seeing your reply and I
still can't find them.  My eyes are bad, though.  Maybe you can give
me specifics?


> Maybe do all of them (and remove the unnecessary externs)?

You mean just remove the word "extern" everywhere in this file?  Sure,
I can if you want.


> trivial reformatting of the function pointer block too

Wow, I must be totally out of it.  Maybe it's the gin and tonic I just
had.  I don't understand this comment either.  Can you clarify?


-Doug
