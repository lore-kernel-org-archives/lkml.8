Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75D7207DA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhsfJG4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgFBUQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:16:14 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3DC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:16:14 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k13so11419vsm.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=KhsfJG4oCqsoI9GIRhKRpIjrp+9Zk74mdmmp8aCuq2a1hgIQ/UEuenme9wTW2SXfXm
         1/XPNUzOuTTbgBxplftFl0LAjy45v8lJBqTnN2qMlWRC6O+QVF3q+VGOlS6VSxtm8DBB
         qv8HQFKA8f/Dkn6T68mdKjvpc314PmcVLN85M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=GdihLX/dHYMtDh+4xkjDTnPLxW21CN72aq9NzG4sAQv0MGZPKubtsjhHsoLB+F1EXN
         gwkSW4gJltI6QOuyGUHb0QNiSTVG7PwrP8bb1heIUGGCHNMajAGbSN9EpqWUSx16kkHw
         Nj1giqmnSb8KojNfRntXrPc3yMUjvA5IMVO/6Gc67PgRsV2RmPMgNdU/hKtF68sHx9dk
         U689LpIDsxpEPthuvMQJ1KepES640rq7dzxMlLqFJtvOaDtHSP8O8/kqDJ2NwWuYYmq1
         1yBTnbzaaRCAnZUucrVZAPJSbqGPrJDQe59vVV1hxp8unMu5Ma9i7aso57V/POvTPT3P
         URdw==
X-Gm-Message-State: AOAM531KCwx7wYMy+6a4FWpvRjS6heSjGWWMYbA1/vfT3aQ3l4bSJ6rV
        vqxx9wbttH6Ph83oYfclyJAkJEW/NYzJtnHa0qmgkA==
X-Google-Smtp-Source: ABdhPJwWxSm48xu2IYedE3HjBxqBh3jhrLAkDus9F6Z+pbc6ymhCS+e1o72yry/mjVZJVupAG6T+jS2ABjv5v1psG+w=
X-Received: by 2002:a67:22c1:: with SMTP id i184mr6737005vsi.119.1591128972715;
 Tue, 02 Jun 2020 13:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200602052104.7795-1-lukas.bulwahn@gmail.com> <828311d2-61ea-42cb-1449-a53f3772543d@roeck-us.net>
In-Reply-To: <828311d2-61ea-42cb-1449-a53f3772543d@roeck-us.net>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 2 Jun 2020 13:16:01 -0700
Message-ID: <CAODwPW_oxDxF_5-icRs0eaRVLgtP+bDc_OSKa=EcfeSp=c6Fag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry in ARM SMC WATCHDOG DRIVER
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>
