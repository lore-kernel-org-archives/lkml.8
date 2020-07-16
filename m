Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB8C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70A62065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3oMNXy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgGPNF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgGPNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:05:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A387C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so7029676ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruUcWHpAX25SqHSlxnSJmiPi/ZbeiW+By6HZVPnMDB4=;
        b=a3oMNXy1OxKO2GgQyHV8bNNbS8hYVv5rPh91+E+xtFoeq9TGyEN/F7Ue5vCdja5pjc
         AojJoGPXeQk1PeffZ4VS4r4pOaHCjZRh/qqNOkHOKz3l2zpYQtpdQsIHFv37AJrqkjLL
         ZOkUT+h+Cnlg2ePavbRoap5QZU0+Lt0wVVYTgWxN3O1f340VhBnm5ssUCNiizMxZs7ZY
         6PRa27fnggcVzjXMgvILAobdP/4HWUG6DRsMxVKRiEKei48JBj8sRbNIvmzy1tug7okg
         5mMJoNnNr42LyUFgIvVdDqh4vomG60mDdEBEgYcr51qMR3TVGU/1m6WsyBbVKH6Elm1x
         l1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruUcWHpAX25SqHSlxnSJmiPi/ZbeiW+By6HZVPnMDB4=;
        b=hV89Oh5zLzkDP5tuy294EdNCBd0WpLQ6SDJqTv7eLZyOrqToqQFMKNNYJ6ehL/jojN
         YSEIrqrzgJZe+enDJGYPfwS6JZTRuC2uWE8WDQu2AmuHAbdnHzwNB6FOCAUNDYHO2Sip
         QWSDTWEZfvmdp1wlIl1DYqmcZqnIhUITNxtGbP6ftmgqpnqc5rMmXxSzTae8InjPEv2D
         v/MPLIZAlzZnX42NjMuuqVPx27OBCHoC6P2VtK5z4nCwH+hKiOyqxNa0A1cKLRgZbu7Z
         jHRwfJbUcEVtTeOzITRh2EHnVERLDut5Upsi+OceIQmDmqb2M2sZnDQRWX30JpnKSdQq
         qxqQ==
X-Gm-Message-State: AOAM531ofFe94WZxCbhRulpee3ii0WOahhdf687CfgwieWR4Qvx1xaJn
        HdHvPOfbs4XY78rt4aFEcXnFAhJzFtc6BeHxZwbdGQ==
X-Google-Smtp-Source: ABdhPJwZP6ponE8O8lLi1/kuYNusEhjJ7aWp5r5MCmgf5ruim5Ya8w28a0XWndi0+Aa2FFJPlGBKsEmYX0+ShfPxZJA=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr1929957ljg.144.1594904752512;
 Thu, 16 Jul 2020 06:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200713144930.1034632-1-lee.jones@linaro.org>
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:05:41 +0200
Message-ID: <CACRpkdZ7toWRvWbw-7e7t-HEr5hdApV+F=bDrkv4vkCjGCNCtA@mail.gmail.com>
Subject: Re: [PATCH 00/25] Rid W=1 warnings in Pinctrl
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 4:49 PM Lee Jones <lee.jones@linaro.org> wrote:

>   pinctrl: pinctrl-single: Fix struct/function documentation blocks

This patch didn't apply to v5.8-rc1 so I applied that one separately
after merging in all the other patches from a branch.

Seems to work! So all applied.

Also THANKS for doing this!!

Yours,
Linus Walleij
