Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA777C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA5D20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpkrPCnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCIIsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:48:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37278 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgCIIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:48:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id d12so9026708lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLiM+hSWr4Lb1eqaNyxdBe8Br5UfdpHmR3SxiPso4DI=;
        b=wpkrPCnIOZgbAFro5+M6HVkK0yq0WYD4JuqQT61zirDikgtKd/PG16EY8gWXN1krz4
         0DFMXUMQjCmq2BoQ2LE9EdT/IKtceHN55AGnfs8ZmKyI7gH2kSaPihenqRshV5Hrfut0
         CXgYxZggt+e+Vv0dF0KP6svs+sCgXHPYEOkdidGQ6BfIbQynwqq6WfonnUzkJ8smhyMf
         LQFTW2WETHEIw0Br9aQAAwNWy54xteN4no0y2b/SjSmHUXZ2VDkOOQE/kRO+b+tl+2GW
         49A9lKkzindwYXKBUJku2nu6js568D525XC5r+htW6tDUD4GxjfC7hjWmj+YrTehjUW+
         zuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLiM+hSWr4Lb1eqaNyxdBe8Br5UfdpHmR3SxiPso4DI=;
        b=bZ3VXw2fY8tsU3R54+ElsrIBS6lVsUezTjPlycEHdsPfQubYHsg2rISljQGJONnUeF
         3TgHbwTlZkFWqpISeotPvVOY2rLWYKpvg3n30Uufti9UChQSfbWRjPz0XLfX+Lcrvzpd
         rCO2nr6f9Vs6Eo0zdx8Tc2I6DnInl1czpXtGYPo9DuJvKFnLQeUxvy9Pcvx4lyGvaWol
         5JPZhDzXKWXJCI1B290M6n2nceo8n6tc6x1kxAlHm6IyUdAKMsmmXRmFGyF3cxHLlAH4
         i9T11bcPzd4Z97LnEzXkualInEmzQLNGZSpsiWLpePdSP794AacVrjK4auur5IBc10Jb
         gDlQ==
X-Gm-Message-State: ANhLgQ26qyDzV9VzhJw0t6tSKc79zIlLe/J1UhzlAOhnIYntJ4yeY8ol
        Pl/XEzHdFmFGxS8RSCdNeOv1hLYOtt0kbnTqwp2BAw==
X-Google-Smtp-Source: ADFU+vtH2nDhDJr8Ck7Ll+58DSvBZ5oP08xhPRwQFBizww8E448l5vDM4bjcByJIbCvYH5p2d7ueSs7f8oS0Ep0SdVU=
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr5845876lji.277.1583743731615;
 Mon, 09 Mar 2020 01:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583182325.git.Asmaa@mellanox.com> <1680de9eb6d2b8855228dde9a2dd065f0dcbe1fb.1583182325.git.Asmaa@mellanox.com>
In-Reply-To: <1680de9eb6d2b8855228dde9a2dd065f0dcbe1fb.1583182325.git.Asmaa@mellanox.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Mar 2020 09:48:40 +0100
Message-ID: <CACRpkda_8Y6FOM=KokOD=p5Nhrqfw6MdOmcem3JEh+8ERiP0hA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 10:04 PM Asmaa Mnebhi <Asmaa@mellanox.com> wrote:

> This patch adds support for the GPIO controller used by
> Mellanox BlueField 2 SOCs.
>
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>

This is now a very nice driver!

Patch applied.

Yours,
Linus Walleij
