Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE903C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617EC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JugjIFo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbgEMTDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390021AbgEMTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:03:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:03:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so827872ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Chzp3tbyXEmpa9DZODCBT8j/RcyA+WHDHn8SKIYvqlo=;
        b=JugjIFo8e41xcj1mBh50Kv4JJdwWswQdosSkw2SGo25NkR8diJgzxmSmAimUoPFy0g
         UqtufzWVyYpztDyGgk4HCi22Aw09xlnezrYm4PHhCJi+H8Ei8/tmkqX+byilYh/qSlsZ
         kQ2oFBqHEcL+58tiDWHOiXYpFBIpD7JYaeHj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Chzp3tbyXEmpa9DZODCBT8j/RcyA+WHDHn8SKIYvqlo=;
        b=P7gfDAqBgwFaW1EiX1FVMQawX7+FOzjjs3IMtdXcxw17cV/3baYE7P7A2rOzy1NqyH
         usnSGUxsZAErk48Xk5lL4pnQPyH3RR4+e4BnmRApBKcxM+xL6gxkMkzLHnoCxXraAcAS
         IwrkwmmMYdpDfydl1wWcZxoH7XqcGlM5dnt20Z1rraXyG6dJdv6nCBQRHPGiVzkzMIEH
         mwV1UlthmXDKUVcxtkl1xpMGPrussdKH1bzgZ0sUGzmkW+yDx1viYsByvLPiL5Al9lZb
         1wrcYTMkG5Mo3xEJAIwRrU0ZSvSvOdtJXW9F1kJ8pCqP7rN+LYsyH11ZKpDTX4Chv6+O
         dlgw==
X-Gm-Message-State: AOAM531mHTScR1f8QoELtQ6CSQ6USINhI0l4QWTRPxPdmc5wxHWtsatQ
        79oiOlNA7wmOg+UZmFUkxnrFJxv+5DY=
X-Google-Smtp-Source: ABdhPJwSn7Z+wOXHS1X/l2EkN8eKWZyb41AW45qTfOsh7+x63uI2QFzd45On74DQrMgw+imY5cS4bg==
X-Received: by 2002:a2e:9984:: with SMTP id w4mr320713lji.286.1589396583222;
        Wed, 13 May 2020 12:03:03 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g3sm221578ljk.27.2020.05.13.12.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:03:00 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u4so445004lfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:03:00 -0700 (PDT)
X-Received: by 2002:a19:ccce:: with SMTP id c197mr619201lfg.59.1589396579890;
 Wed, 13 May 2020 12:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185931.19288-1-navid.emamdoost@gmail.com>
 <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com> <878shwtiw3.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <878shwtiw3.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 13 May 2020 12:02:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
Message-ID: <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
Subject: Re: [PATCH] ath9k: release allocated buffer if timed out
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Actually it's already reverted in -next, nobody just realised that it's
> a regression from commit 728c1e2a05e4:
>
> ced21a4c726b ath9k: Fix use-after-free Read in htc_connect_service

Nice.

> v5.8-rc1 should be the first release having the fix.

So I guess we have to wait until 5.8-rc1 (when this lands in mainline)
to send this manually to stable@vger.kernel.org?

Brian
