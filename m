Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468B420838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597259828;
	bh=BzmzId5AAb4ksq7DLSeagK9Nqrd2DOKYmQjY4/krZS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kg1bJnxbGi7uSTHSbsQTB9kXA661PDCyfW8ld5+Wy0wrqRyyVTE3uhuuhCnPhv8Ef
	 ugZ9B3yXbPGQzMPtrmUGyE28cuJcdxI/R0SDei1MUTVoKAz4j0uwRNy8qYFKkLMQr2
	 YDr/RVXQh4swRW6TkZR2XapG6LKKCRSOQKIlfF0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLTRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:17:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC7C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:17:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v4so3527940ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSmnZhkgZc2K2B2dOvBAaXvDwu8XCKi+d6y2dc7rvlw=;
        b=ZItR4oeRihZpKcu5WsHEsPJMHZ65VZAGF8XJSrwDi/q4wF0ssjNFUgAW7rhUj9h03J
         TNGyzlqAs/1MEKevuEjvBi4OiTP1sulXlsSn9Th/B0LY7pvL0YYZfwYNHwhMn1VO9Nn2
         yj6I4btwtXU7yZ7LUsrDgOV+jE4KyBOSpnQWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSmnZhkgZc2K2B2dOvBAaXvDwu8XCKi+d6y2dc7rvlw=;
        b=SydM62Xc/GiBdKRMrwxLX7Z1Q4Pi8kL5yzYAiCR4Vabmn1/HhD8R6jG5ks+ZqmsJm8
         mEEzRpyjXPP97BUFJACvxFngvDq6Hld+yhUmpBqGet+kM7BdGrZymPAUuNIrDSI82/dq
         GCH80zbBJCcfbnZD5nIx3eeKbsePRTNEwI3F+dvt6+9bpRFI3WO0K3BM7kN6TMJuzPJf
         vQdLlsiYSfArRlUSoxF1s/cNvd7IsZ2vnj2UIB1yExaiBXkWvDZTpEPR8NCABptPo3NY
         VtfA1IDH3XwSNL4C7NU1mBaMOwEtVyX1UfiPzXTTiznPCf0Gu1KnXxHR8TI71znkvBze
         avUg==
X-Gm-Message-State: AOAM531kznbs3KAZ7wIbOBx/F4bIhibEDinI1iYxrv+07FjKnUx27q4U
        VESE/Z/84uUXT86jPPxGJ5GX8YxbL88=
X-Google-Smtp-Source: ABdhPJwoCOa15SoWaDruXtAH1qF5Om67vqzCC05mnVA9rf+CZtPd0BBVvUij4Bj0/071Nw3sHbPVEw==
X-Received: by 2002:a2e:b4e5:: with SMTP id s5mr296682ljm.153.1597259824748;
        Wed, 12 Aug 2020 12:17:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n29sm685025lfi.9.2020.08.12.12.17.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:17:04 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v9so3501328ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:17:03 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr309685lji.314.1597259823585;
 Wed, 12 Aug 2020 12:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200812113903.GA14481@www.linux-watchdog.org>
In-Reply-To: <20200812113903.GA14481@www.linux-watchdog.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCnTLcBWO57bedR2uKyGk3YK5rGQf8N70Lx6QTy2J17A@mail.gmail.com>
Message-ID: <CAHk-=wgCnTLcBWO57bedR2uKyGk3YK5rGQf8N70Lx6QTy2J17A@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v5.9 Merge window
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bumsik Kim <kbumsik@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Krzysztof Sobota <krzysztof.sobota@nokia.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Martin Wu <wuyan@allwinnertech.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Tero Kristo <t-kristo@ti.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Timothy Myers <timothy.myers@adtran.com>,
        Wang Qing <wangqing@vivo.com>, Woody Lin <woodylin@google.com>,
        Xu Wang <vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 5:38 AM Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
> Please pull the watchdog changes for the v5.2 release cycle.

Spot the cut-and-paste from an old email.. I went back and see that
the same thing happened in 5.7 pull request too..

Pulled,

               Linus
