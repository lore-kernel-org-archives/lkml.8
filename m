Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ABFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3C20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TJ10NSBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbgFXNew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbgFXNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:34:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:34:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x62so1656543qtd.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXXqtRawr8fnQBmxzOrcDn6WkbSsj6aEmLiLCLvffeY=;
        b=TJ10NSBbdbHcca9GOb50HLC6gl7+wdozNxfqkwnltyYSh6mq20cM37+I7wKa+WstR/
         SNXNJvegXmA2r1KVFRsHKluttZAls9a0TaUp64TC/yzDHFNUN6JWiPNHeYPnT9ghxXvj
         DbKJ0nWjEsBc0a3Asm0wZek2qOuGhx34ZO99Ep91EUKPB+a8XED4NboMUlQITI1DB53T
         +oWGpSHclFY7pcAetEbkTpQjJ/KBEAuQXB95G6PrhXm3OeRJAeltU/BAd3A4dO0VtyMm
         3bOWWwoy/eyuNoRLbDbG8o87hmqlWCmXW4FI3q2NZ2k4MHSywPmK52BKgLGTZGHqb3eT
         eTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXXqtRawr8fnQBmxzOrcDn6WkbSsj6aEmLiLCLvffeY=;
        b=rFf0jHMw528fkysBaUpfs4maKFZ2RX9LxTtz8G8gL6q89NccMs6QhwfzYCcVwFVZIJ
         7cY3b7mcShBTUUqNurBkGGinStnUhmSrBcSrYsyUcXpN5O3y9dX5kJT6rALQWnrfQA36
         xnJ940aTKKJMRpKjg1bggfS62JJNNNUY/StUgoBxE6J4zbP63atAI64X8tvkSbDL37/b
         78XmUgCZW4DP/AngDFlDZMKSWYJZBVEsyvlC4ekJMrnU0pzT3rQdIZLWUzWtIvCv+h4z
         DNRO0Ez9NeqsXaT1Y/4sN+wKH3wZRlOwx3WCmfx8YEPMadIDajNGtJCBlQ9Sr899IosZ
         FZBg==
X-Gm-Message-State: AOAM532jfmbXKjO0BufrA0GjmGIomk2TlXX5oZsxjbTnFya7zZbYBQuK
        w467d9DagvzffC0IM5aI0U2IwDsS0DWmiqSI5Az8Nw==
X-Google-Smtp-Source: ABdhPJyzI+feGsGkCcvsqgt0cK92naz8D48uJ/UYy8VzAdvRImzxX3YufPYSscpk5vWifQ5tQ916Cqjrg1Y3lXJVpmE=
X-Received: by 2002:aed:2a75:: with SMTP id k50mr10983172qtf.27.1593005691057;
 Wed, 24 Jun 2020 06:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-3-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-3-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 15:34:40 +0200
Message-ID: <CAMpxmJVUK6hJhY5h2dwAD74gjbAEzXvWfQxT_mKZ2_gpe_m=Vg@mail.gmail.com>
Subject: Re: [PATCH 02/22] gpiolib: cdev: sort includes
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 06:01 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Sort the includes of gpiolib-cdev.c to make it easier to identify if a
> module is included and to avoid duplication.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
