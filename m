Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5010C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74B5205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="GYYbWnUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgAaDuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:50:54 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33704 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgAaDuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:50:54 -0500
Received: by mail-qv1-f67.google.com with SMTP id z3so2660139qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qN3Jkm0gYZlUyqGL/F8dUFk1CCAdKyLSK3r0nvN4n8=;
        b=GYYbWnUtwQfO5NhXtoQtIOdpWRGTqanmx2NMdisJ1Z2OvB0MzWym2ShOC6myDnEJE1
         dvf4wf71MxNTXwrOVoFu1AtrlBGXp59tArsHlmyrgjHgcrMEaEpzBSibJd7c5j+YPxik
         EFCoStio0vZ7iijEfs0lqybwFeQfRBLKKRTwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qN3Jkm0gYZlUyqGL/F8dUFk1CCAdKyLSK3r0nvN4n8=;
        b=YrLoBWHbmhYgCIuYM5qUpsb3Tlog1VE3lWsT+4dYD7upHfMFRdChdRrA5Bb6c/xNNF
         8RhuvJqCRHWRm8CRJv7Jda1JNHrs2mn9TyY9IqQfWF25IwMbe7j2fmJeIBr1T9+puZEd
         /iRDfA9Ssj+zshRBHUjnZ27U+mGAE6DpCfDUf2VKlgpZibgnEWrX+DDowJGqiwhspJVT
         gw7Jb/j/eiaUsIpT5T1m5Xjr8iMWBWxUHdEVG/w6qlRpddZl4lGWOQ+Rp29pkTxAo/QV
         557U6qJxo9dW2h+nOdgFn/P80NuAf35MtBLyyTImrObIU1Txd9i/yA3KLxHt0xkGGfBD
         ClxQ==
X-Gm-Message-State: APjAAAV0831YSOvZZ2u1rkFa8n6KsTZdIbGDGlbZ0I2fqaayuW1dpCn9
        yYUqCP5EMRfVAjJINeB3iKxAbBl6TB1z/Qp19Eg=
X-Google-Smtp-Source: APXvYqyo59audwyvjFpWO/NH0xjByce/dQsgM3qWBJcPATVAQYtk57nF5V6qfy6+FT/0tlxy9i+ozRkhjKpBUXydl/8=
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr8534021qvq.2.1580442653512;
 Thu, 30 Jan 2020 19:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-4-geert+renesas@glider.be>
 <78f934a3-ec7a-479e-9f63-4df7c4428ae5@www.fastmail.com>
In-Reply-To: <78f934a3-ec7a-479e-9f63-4df7c4428ae5@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 31 Jan 2020 03:50:42 +0000
Message-ID: <CACPK8XfUG08CmxK7_V=PGp1SBO2UE6CSyKPSi9Hiwz2td4Lq1w@mail.gmail.com>
Subject: Re: [PATCH 04/20] ARM: aspeed: Drop unneeded select of HAVE_SMP
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 01:05, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 21 Jan 2020, at 21:07, Geert Uytterhoeven wrote:
> > Support for the 6th generation Aspeed SoCs depends on ARCH_MULTI_V7.
> > As the latter selects HAVE_SMP, there is no need for MACH_ASPEED_G6 to
> > select HAVE_SMP.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Andrew Jeffery <andrew@aj.id.au>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>

Geert, did you intend for these to be picked up by Arnd and Olof?
