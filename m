Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A43721744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596566311;
	bh=NcAl94aDwei2riTHlnAcdNv0Rikrs1LRpYSWa7wOP6s=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:List-ID:
	 From;
	b=rzJ0psVBcHn6IrPUFRuRJVZB2TyBfSMaYxzy9bZcwCYuGUo70P/QsItd5FzqHFEaz
	 Yz8oFb4aiu2HU91tMi+97GZqvylddS11walfqz+H3gbOq1peLvS8c7KVBo1sHA3xMb
	 46vTP6wsZxIE0vWKQnh8rVYMHvNMUOoTg4bjUggE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHDSia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHDSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:38:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:38:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b11so22934840lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMA2j9yQTk3w310DnhDknRZNg2QP1O/2Dv3qHm0WbeI=;
        b=K2GOscX/WlwdNLdrx7M4y89Nutz4YdOSB974IrnGyj42OxbxTjp5S8LsXZaNgEM4r6
         K80zLUDgl81Xy8gAfi7z5QH+fcTZLlwTi0zxiqJ0/4mskLpACvEmK+5POMTQmmM1luBi
         QJlr/bwjnmu2KgmZMKRi2Yj4nZh3q/Bw1flBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMA2j9yQTk3w310DnhDknRZNg2QP1O/2Dv3qHm0WbeI=;
        b=pHhDYTlfHIDF8xA3zGdUHbzEZcNpAV5pM5XEMGostr242Hc70tUDV26o7r7xJoeyhJ
         pdfIU1OkU7M8tw8dUmjco3nimPPSHKtQ0Hx/pIRvKe0Xp8xu7mPDcXxQc5UulGkuo8jZ
         PUBh9cg8bk0PcpyRKyhF4IIwbgO4dJfkt0aVJy+b7AzVWp1Xf07gMJpNmjzF7wHne/6t
         HOGw6mOSH7wR+FHS6hDX/Ymiz0aZbhFOJYkK2eq3xaJB0Igd42TgOrGK5freC/KuPNB+
         kld46saVTXxLTJrTVqB3n7FRF3ClWYIP1tGZLmQ+WFEDkG09Cdqt0EnrizvJzkvRNQ4F
         imbQ==
X-Gm-Message-State: AOAM530HhpVfVTVPNnQVtUIPztwBMf6T19Y1ndPByTyaoBdW/n6OaZqy
        2QKn141HTjKQ7MVViFWqXYDAeBsXXZg=
X-Google-Smtp-Source: ABdhPJyfXbfJT9s/pc6KqFNC+Vgak7C1VCYWvxHQ+ATcUyeroZ6+eAy9dh1pHVXTMgV3XvgWs49NpQ==
X-Received: by 2002:ac2:5ec8:: with SMTP id d8mr11519009lfq.169.1596566306734;
        Tue, 04 Aug 2020 11:38:26 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e17sm1362729ljg.85.2020.08.04.11.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 11:38:25 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id g6so32105803ljn.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:38:25 -0700 (PDT)
X-Received: by 2002:a2e:9252:: with SMTP id v18mr6917688ljg.70.1596566305268;
 Tue, 04 Aug 2020 11:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com> <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com>
In-Reply-To: <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 11:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUg-S20ywzUv7nB+5AQc1tDh9DZ3wL4oLNpT3sW=iFvw@mail.gmail.com>
Message-ID: <CAHk-=wiUg-S20ywzUv7nB+5AQc1tDh9DZ3wL4oLNpT3sW=iFvw@mail.gmail.com>
Subject: Re: [GIT PULL 3/5] ARM: SoC changes for v5.9
To:     Joel Stanley <joel@jms.id.au>
List-Id: <soc.lore.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 12:02 AM Joel Stanley <joel@jms.id.au> wrote:
>
> for_each_requested_gpio isn't in Linus (Torvalds) tree yet. It will be
> fixed when he pulls Linus Walleij's GPIO tree which has the commit:

There are too many Linuses in kernel development.

For the next in-person kernel summit, I suggest a Highlander-style
"There can be only one" deathmatch.

I will start training immediately.

                Linus
