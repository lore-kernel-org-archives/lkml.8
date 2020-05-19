Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD4FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BB6206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXzgSz2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgESNNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:13:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B3EC08C5C0;
        Tue, 19 May 2020 06:13:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q2so1470264ljm.10;
        Tue, 19 May 2020 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiBhfRe0O8z+Axm2vMfGqvyp7JPaYqiUq9QQWtYRNd4=;
        b=fXzgSz2ehuJEDLmyRKqrosO1Y8vOovGRSmfob7lDlHAKTKwg5HWy/Imym9qi6UizFY
         ziqTt7zgvdaHbYouo9o54Dl2iPpgjJI4zjDtwAzn4UC+ipuB4HZ27838aRvPTudJ8oda
         GgQW0/yF7SIOMRMYg/8FjbVSk29pPFanyDjdD1vy2pdiijNBTsJ/6Y7DPCFUBIcZgEit
         F/ePmS9AmRE1hTmDrGPDmvaUfoOPMZ5dZ2rjjr47vYN84dTt1Q0tOZYAuORbdYkJIBWV
         6hizaSjhRjZrj5ixj03upr3xzzJQaeVGfbUnIWYsJZQvag/te3ku1ovrDi0vEB1Q67ZP
         VWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiBhfRe0O8z+Axm2vMfGqvyp7JPaYqiUq9QQWtYRNd4=;
        b=W13NL2MLcbDQH9xrApwi7Cz5V8YdgDY+dHjBTjNedlTfX6uyNdofPPwDOphGFiMi4Q
         j7jsoj//DmpEAJAj+wOqxzFGKjsBHXzFsbe1SY6sN2QY6FzvCVoKhlDusfCy/Tt929rH
         qXnKWD6XXDrjRz0lPEoZy/CTYzQtFvn04idd4PPj9LfSSRmrT46CCOEQ+FEcyb/qBHna
         ZRbPtEYPoOJsKQ18b+zuLtjj+3Nud044Ib1sV2j1aqAt7gEJT46k80RKftsirW8WntOz
         owU7je2pzyA3xSEapFYHPyhY00tjIwBVqqfbNziFknWbY5J3xh5nbBqD6arIlUr9yb2C
         ykJQ==
X-Gm-Message-State: AOAM530fZNIJKKL+grLjJf18bPBt78kzjul2YTaUAWY+UPcQETvHNsrM
        nVlKtij1LA04CiBhaLEGqoYgkVv1NxrLVPGhDLk=
X-Google-Smtp-Source: ABdhPJz8QNjOdhwBE+X5ouHMRX7eiWIWw/6IuqAGZdCg/0ugMZIHG2gf36xBIhqHR0BKBmY2lUx4UEapUX4J1C/OWM4=
X-Received: by 2002:a2e:601:: with SMTP id 1mr5498021ljg.126.1589893992637;
 Tue, 19 May 2020 06:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519030036.1785-1-zhang.lyra@gmail.com> <20200519030036.1785-2-zhang.lyra@gmail.com>
In-Reply-To: <20200519030036.1785-2-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 19 May 2020 21:13:01 +0800
Message-ID: <CADBw62oep+5n+9d5Qmzj7HR4u5JXTp2qSi2ipDHFAemK5Wcjpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: sprd: return correct type of value for _sprd_pll_recalc_rate
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:00 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> The function _sprd_pll_recalc_rate() defines return value to unsigned
> long, but it would return a negative value when malloc fail, changing
> to return its parent_rate makes more sense, since if the callback
> .recalc_rate() is not set, the framework returns the parent_rate as
> well.
>
> Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Looks good to me.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

-- 
Baolin Wang
