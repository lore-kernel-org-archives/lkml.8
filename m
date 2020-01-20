Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2843DC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9CB2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY/+ZPmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATJcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:32:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45636 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgATJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:32:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so12931432pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aYFm4/s+2pPZgUedHyLZ6sgk19OhHj39x9yUFgU2D/w=;
        b=AY/+ZPmUapl07w/XCRlIciVlq6izF6iggpLCp+a1cZYOgUbI516Cix7+9YSlvEDPcx
         rYqI4pKCZkZrBDj7Vc0wSrXX5f8eeDHfaR7l2E5oBgq/BWVyCgfKFWZW/lVLEN+Y7Nkz
         v5eRZCisXN+zIlrtSnfh0hWMklsI4m2Nn6d71WaMbqEGIzxmKum0Bhkg9bHLTiAfT6v0
         u4vUXfyv5PKp6YrjKEg5zy5Ggn5cVEVfTKQwG/DSDWdZUqndcaj23iEZw7skdgZV7WZu
         mgGYbtZaJpt1TnU1f0d9EY4ZFJTafjdeB6NmQHnU0Bh0UtDimMdHK4hDug7yrXhFJxoq
         UjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aYFm4/s+2pPZgUedHyLZ6sgk19OhHj39x9yUFgU2D/w=;
        b=dgY/tqf9KW2nr5Nbn+FDqIkiRfNoOOVZB6i98kP7rTIKAvZwCc86I4L/WaXH3euW6x
         lyxOIjCSmihf8YxU5f1fDx8zJLFQYPp+vjJ0VmJAmV2UsUSQTec+GFEUnSDKxap0GFZE
         Bw6FBn7s4eZSGKamANCiE14Ep/XUgemkRCJF5ai8iZjNjAi+wbLJxTBuM0aMFX3quZMy
         J9/nEEH0Sm6Pe1W0sne2kAP+VnrRH5vUgNU76qrnAdrmb/1NQF5vzg3KOQSfjISrTyUq
         RSetk+41MG/7baMzQywYxHzCADTiKKuJIsPikWEqhxrj/7Ncpr34OGQc3CMYYlIJFPjp
         /Ozw==
X-Gm-Message-State: APjAAAUmsGiVUhMv0rWRy84ZxXo6kusJF8YP6/q+p6YhGI9ysRyF8V+F
        xBRp5pmYoxoB7ai0J2J7oC1pAg/2uLikPXMo7YE=
X-Google-Smtp-Source: APXvYqzTMdPcu4wzozbNryTA/0vMXkIkBT2q/Rcg46yNqTdHCoZ50RpTkZWYLQ7+SgzjHYXcxFwa/pl56nILHo/PZCI=
X-Received: by 2002:a17:902:d20c:: with SMTP id t12mr14393621ply.18.1579512741065;
 Mon, 20 Jan 2020 01:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jan 2020 11:32:12 +0200
Message-ID: <CAHp75Vei9_xqxiiAWBrcMp3yOWmMNmdRmNEwO=Ht+URsnoD4Pw@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: add support for %de
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:57 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> this is an reiteration of my patch from some time ago that introduced
> %dE with the same semantic. Back then this resulted in the support for
> %pe which was less contentious.
>

> I still consider %de (now with a small 'e' to match %pe) useful.

Please, don't spread the extensions over the standard specifiers. The
%p* extensions are enough for my opinion.
NAK.

--=20
With Best Regards,
Andy Shevchenko
