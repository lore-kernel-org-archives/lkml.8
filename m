Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56389C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328EC24697
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp0qEIC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgFTVH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:07:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45552 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgFTVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:07:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id i27so15226876ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVO4PW7RZ5BkQYoJgxP0Hx8bG7QWB5MT25IV3wH9AkM=;
        b=Dp0qEIC3xllmaPI+qPS5JRYOt7p/apOAtBOyLTt1Eo2YxFQMjJ2jEQhVFIbnoEOSaj
         NpB6w3MtDNzoDH0i4Lr++i8UwMgUoUFXwnZ2E59aKaaSP08WnuMNS9jC9RzRaVICDgzs
         SD5kRCXwRnMxFkvqWluqoSxPHgFvSUTR8YLxsxV6WYAsUQXojk1Oeb3bTknFsNHxFuOy
         QphZJF78NpRAJS8CIvakBPdC3TQSQlS3lbli4gopKVVfyN1jH0RjSlgBM9Mb2j1lrE+g
         HhCvb+tP7tJpRFBLmyvSv7C76RsBv59CSQjTgluWOwInYb6vvUfG9hdzcYFenNZyN8Z1
         tqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVO4PW7RZ5BkQYoJgxP0Hx8bG7QWB5MT25IV3wH9AkM=;
        b=SO1RLTcbSWPyjEm5ZwbC1ba8A3iRxEoZcxzpJa997LEK4lkTHjJy2R/JbN1HokqpWl
         CMGw1vYpomBmOFhpQ8MK7xsb3k7K/457fjSkrw71Up5bQn9yProlvYmo0tp76IZWTlrq
         XHsjTq4nsdIMI4fKGg0XfHUIPtkhmgScT6pv06gEcI7BwBLE9t2wczd7x2Tp5oETAFcA
         +J3tOZGdYEUApe3nRSzRCg3Fh7o5woGbcwssWgb9EvJuMZbw0IS9UitPkdAIVQ606HwD
         Ot51Qd0qEAWq0YWbxu7cU7cv4xpPkDbKhTW+6iZjGIQjmM3tsSBDMv6YK1TNEbOqWmB3
         kOJQ==
X-Gm-Message-State: AOAM531N8aIRbQl1upvvEOBYz6P7nDubN5qLNQYWqljY+nrBYGcC86OS
        PFV1fTddYL2aLHZGpbUfvW+2U57It9G1ytM7W+Mn8Q==
X-Google-Smtp-Source: ABdhPJwE4EHbLLjrPuV5spgZm/Iq14+xmGwaVeLjLtulYH7lt3F+0nrvpcg5T7zJTtXYbcSJEj3/EuUpVbHXVXBXMSo=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr4720370ljz.104.1592687214811;
 Sat, 20 Jun 2020 14:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200615125407.27632-1-alexandre.torgue@st.com>
In-Reply-To: <20200615125407.27632-1-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:06:43 +0200
Message-ID: <CACRpkda6STLBFPLE-YdFCqaqqrpUPkweh4qc_OYcdC03KZspPA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: stm32: add changes to better manage
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:54 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Clocks and resets for GPIO banks could be defined but not yet ready when
> stm32 pinctrl is probed. This series adds changes to manage probe defer
> when a clock or a reset is not yet registered in the system.

Patches applied.

Yours,
Linus Walleij
