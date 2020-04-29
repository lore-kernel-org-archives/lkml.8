Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD97C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1D21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgD2KNh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:13:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46467 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2KNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:13:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id z25so1174032otq.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GAfuhEzVW9yjP9v9ZyOBXMfmtyVV4v9q9d6s8nYURRw=;
        b=lHixJxVUBxW5Mjo5R1HA7G4gNQMQRSBFETiRMe+yJ0GyZ/rbN726oD4Mq5Dv1q8gAJ
         s9BpJITMztwJ6/AT0fTBNkn03X0SXO0nCIXsIcpoXBIhjIgh/jRqqpjPS0GQwxuNdhMS
         OcGOnKHbsZDDUWYth2kCaZdpQuPw6IhTsoMQQiyV6hpbSZyet8R0wNZExdAnAsIws4Kz
         uwL5VfD25QmvTGGpkP0rCyhhw9imAmdhL+K0tV1GDmekMWljFksV4W/6qUAtBX/mG5HJ
         A48cA/b13JzfTXYR9w6JqqOvpCtLsRJ3M59mjrDZK4ZEaEhC1AdDkYXr7HaXPwRmy+Z6
         x4Cw==
X-Gm-Message-State: AGi0PuYTiikGqw+jXQKY8WnN60gtnHWVQZwm0r8UAx5cpxSes3QDMBB0
        tzphW/2dWUaUlUQN6A5A041GYNlHp8+uBKTpn8c=
X-Google-Smtp-Source: APiQypLNl85RevSy0/DHCOQ/0uIL1S8p+SQGkgEw2+WUCF5vUQENVyz6mpH0BtVc15iBHXl6+3WkdKUTDOHxMtdqO7E=
X-Received: by 2002:a9d:564:: with SMTP id 91mr25989025otw.250.1588155216129;
 Wed, 29 Apr 2020 03:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <1588154448-56759-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1588154448-56759-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Apr 2020 12:13:24 +0200
Message-ID: <CAMuHMdUn357yn5s6x4KRPwSZP1pTqq1PNXW9TqBRnfOXJaxY_Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Move static keyword to the front of declaration
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:07 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
> Move the static keyword to the front of declaration of 'vuart_bus_priv',
> and resolve the following compiler warning that can be seen when
> building with warnings enabled (W=1):
>
> drivers/ps3/ps3-vuart.c:867:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>  } static vuart_bus_priv;
>  ^
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
