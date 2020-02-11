Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD22C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F26206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBKHgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:36:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34352 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgBKHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:36:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id r18so3552471edl.1;
        Mon, 10 Feb 2020 23:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4Z7VXCKOunamakdgxhm4cpbyrTmI1hya2jzoz0wGsM=;
        b=HKB9+pjAgcqNwYzQR3pN3Zshcs/ttsVNFpcXrtIYIZO4+3tncvUUoH5hiIK9Ga8bAH
         XCrD0caXoMyMqXMfdg9DQUEFlyFUMi0C+gWZnWG8kpozZu85yLVIFLGQ6jkxIZwPW7zH
         hr9PInWEFf+fXr/cEMPig59wHVpk2heexnpG1ma8K1fVsXBeoZoNfWlIn3nK3763RTyP
         BELKWu/VOerZqFFt6MMxu6rvMyS0/Qo1iq3y8L0u/DkAMacf2crdSbuibO8IUtmcrHoU
         orhb6QmmwdS6yJIHrn+ay0t3hzJ5Ypi5cb/M+//hombD7i0yzBOWSrHJ4diHYJpUIcTn
         dxGQ==
X-Gm-Message-State: APjAAAV8nUstxrMTr/DZ3PGYg1A7KXDXJbZqcMOY9jEuFGjvkVO+n2Up
        2O60kTkJo+Xw2UJg6yaUk9Mbgu3Kvkw=
X-Google-Smtp-Source: APXvYqzqKtBJLtgKCxSXjRGHIY1cL24AaodwYsk5ckmw1bNhBKhqvhVjhheJZGwj7yIQwaRAQERZeA==
X-Received: by 2002:a17:906:2296:: with SMTP id p22mr4812524eja.269.1581406598672;
        Mon, 10 Feb 2020 23:36:38 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id e13sm292618ejb.19.2020.02.10.23.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 23:36:38 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id t3so10926547wru.7;
        Mon, 10 Feb 2020 23:36:38 -0800 (PST)
X-Received: by 2002:a5d:534b:: with SMTP id t11mr6826794wrv.120.1581406597700;
 Mon, 10 Feb 2020 23:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20200210222807.206426-1-jernej.skrabec@siol.net> <20200210222807.206426-3-jernej.skrabec@siol.net>
In-Reply-To: <20200210222807.206426-3-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 11 Feb 2020 15:36:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Y_8r+uxqL_rCC6-_yjYjoviqW9xL68-DpcyR3Nkh+OQ@mail.gmail.com>
Message-ID: <CAGb2v65Y_8r+uxqL_rCC6-_yjYjoviqW9xL68-DpcyR3Nkh+OQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: sunxi-ng: sun8i-de2: Split out H5 definitions
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 6:28 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> H5 has less clocks and resets than A64. Currently that's not obvious
> because A64 is missing rotation core related clocks and reset.
>
> Split out H5 definition. A64 structures will be fixed in subsequent
> commit.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Fixes: 763c5bd045b1 ("clk: sunxi-ng: add support for DE2 CCU")

You should also note that this patch requires commit 19368d99746e
("clk: sunxi-ng: add support for Allwinner H3 DE2 CCU") for the
H3 clock list.

Code wise everything looks in order.

ChenYu
