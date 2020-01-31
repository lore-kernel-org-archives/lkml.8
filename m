Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91972215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580504837;
	bh=TQ7spiB0UlsKRXXxe/jZUsbYZ+dOt+uQIN3RmoQGBBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Os4PSOVC/SKYsXDN5GpWiNcM5u25EPkXg2KZ+gJiOkjx1eBm1oNgIg0m41BgbEAWg
	 UXWDCdbzcfSkZWplDTTvEUAbWk82ifafQHcJTweP2N6j2JA61gpfJh65bRPX1SI715
	 /Uv94x/vhuP4bGrGsAw+r1TiVGIIZaR5olW9WDPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgAaVHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:07:16 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46786 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:07:16 -0500
Received: by mail-lj1-f181.google.com with SMTP id x14so8463801ljd.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxJROTyzT1jYxa/uxoScWfBiu6dpk9l0ypZI0WlHElE=;
        b=Uy3tV2J2BamqsqPl3OjfFMuPDQw1a7LvD1NegqJHrZKqw2pDUpBwIALE7PWnkpdtjM
         wuW1b49rvHSCuYNQTAL97eOkQcnhhTDSSv+yl0niZqmRr0uSi2kzPSoIK/Y3qQPCfoou
         bnzaZtIP05jjNLSSsdHzkdYc3mT2Ju03Dhar8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxJROTyzT1jYxa/uxoScWfBiu6dpk9l0ypZI0WlHElE=;
        b=GYwUiRWPb9sqzbKOXnzttyewhHf8GwQB+NzM/k0LPqmKuTuPknPPX3EtKXuNgyWSwm
         7D5ZHaRDpmX3QRqNOOEAJizmTD53OyPmVSRJsY2eoFmNcKcw9WQRK63efOBLmGU8wa5N
         j5iJSuBnbyM4gMNYBWKHHrxPBmoyS/74aZHEuGHiN+hJ1lL5MSns46O23Q+wEoVacvo4
         aW20mRL/Dfedel3J4gJUsh9O8s0yIf/+YaiAP/AHVv5xKHeJ6b8jE8wtV5XToKrqlYky
         sbpel8y5t6I9wqwZk5kvdUlE471wxuelsXgS8uAaMPdb7aADDHMd2u5p2VUYJhBhRsuP
         3tug==
X-Gm-Message-State: APjAAAVLnYOMDVJuzF/IicXXBnLvYW7WDYyrdr5wnuaojuw3ZcgO/hde
        +GxetctrRvIkR/XRqqFA3cnWPnr4HWc=
X-Google-Smtp-Source: APXvYqzprb/BH0J0LEyKJuKd/f14PDiPeWk6FdF41CkUMTg5LqzBQXubRWrXt6i/rdHo2YDclh1Kbw==
X-Received: by 2002:a2e:7c08:: with SMTP id x8mr6929566ljc.185.1580504833741;
        Fri, 31 Jan 2020 13:07:13 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n23sm5087198lfa.41.2020.01.31.13.07.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 13:07:13 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id q8so8539838ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:07:13 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr7090112ljb.150.1580504832773;
 Fri, 31 Jan 2020 13:07:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dd68d0059c74a1db@google.com> <000000000000ed3a48059d17277e@google.com>
 <CAHk-=wgNo-3FuNWSj+pRqJEG3phVnpcEi+NNq7f_VMWeTugFDA@mail.gmail.com> <CAM_iQpUO2s2j0gbjYp8J3Q7J-peLChxL71+tzR0d6SphMZ7Aiw@mail.gmail.com>
In-Reply-To: <CAM_iQpUO2s2j0gbjYp8J3Q7J-peLChxL71+tzR0d6SphMZ7Aiw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jan 2020 13:06:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4Vc-SVMzFE5fKy5AP1P0GTozP_vmDOCJuspcu9wxpjg@mail.gmail.com>
Message-ID: <CAHk-=wg4Vc-SVMzFE5fKy5AP1P0GTozP_vmDOCJuspcu9wxpjg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ip_add
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        Marco Elver <elver@google.com>,
        Florian Westphal <fw@strlen.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        jeremy@azazel.net, Kate Stewart <kstewart@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Netdev <netdev@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 1:02 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> It is supposed to be fixed by commit 32c72165dbd0

Ahh, thanks, I missed that. I actually looked at the current code and
saw the bitmap_zalloc() and it all looked fine, and assumed there was
some other bug in the elements calculation.

I didn't realize that it looked fine because it had already been fixed.

Thanks,
             Linus
