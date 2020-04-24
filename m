Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB6C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3354A2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxJM0E4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgDXRjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728838AbgDXRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:39:39 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431ABC09B047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:39:38 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id n128so2970564vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVNykiux2SS49dq2HBWn7JsqkyYB+CbvxiXAjFY5utg=;
        b=VxJM0E4h1WDU8yB5zcqRbndKTW6H2EPOMb4z3Kzl+8RsCCnjpf98olSU3A618vQhny
         iTX3M/4OnwJYdl9bCDghHxyIHB1q+tDNhPf/9sFsROnEB2ep1LdyftyWzZ30bF4cy9nZ
         OZ+VNTUPCf9JsY//tM6/EwcSdNYWqogiVXSuKp2LmyhdTUC++hhw01sZCikHupjdvJAn
         F9Ln48Ahv+9/jXW+ANsRz2BKeo4CsXh5SKDzzFOvoN7PDj3YqRV0cZVMoUzwriv5biW7
         tHjkAlf9g6plEEyqWSFL3kQ8W5kkAVr9O9QghKRRDkLYeRojzx4/ZPkDW8HILIG6l/Kb
         h2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVNykiux2SS49dq2HBWn7JsqkyYB+CbvxiXAjFY5utg=;
        b=V/3I2nHvR89nHOBg7t3jYhZ2Im08XPbSwb1ySu8aWslMnylz5PioT82CDso+xjfbEF
         nMhmlH0UNu5u7ZPRjpHh7TB379+kTUzSWYRdW7ct+/ylJrvo9GV4oDIsvyW+7WHjup2O
         6S2sTSixpZxyg+6IGTHhuTPkTgsjGIRSkJRmsV3W8EvFdwIUP6IV/nUX40wL6oe68oTJ
         Z49oIiUc96p5nJ0I0iIwfUos6N6cunP6SrCu6Kw5/OK6z+8utT1IaiRwvLbLEeXMN3v5
         rTHZDB8MYfTXMvrtt0jtCJ/ddZYpeelkBxDnKiIGibQeL7S4dD8Yc+XCuEdh5L5feJmt
         wAUQ==
X-Gm-Message-State: AGi0Pua8ytVpj9rWetWutAuDNPdGgis0y+HnAvSnhnVHC6Q+Z+IGHHsM
        EDhQLYBX4T+GUrYrct5SLWwJVKaEOGM1zN71cg==
X-Google-Smtp-Source: APiQypL4bmtRtO/YcTxs3lS+V2EvfAlKlZUC0+uB+6jVx22DifGDKNum6YkWauX3Ba7XcbY2CQwsyHIFJs7LaHLVLtE=
X-Received: by 2002:a1f:ce83:: with SMTP id e125mr9009637vkg.10.1587749976655;
 Fri, 24 Apr 2020 10:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
 <1587715859.28179.17.camel@suse.cz>
In-Reply-To: <1587715859.28179.17.camel@suse.cz>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 24 Apr 2020 18:39:25 +0100
Message-ID: <CALjTZvb_nzOXd09VXJDECu4b7xuS3tduQ1SXJ0BrpCMBp4qcRQ@mail.gmail.com>
Subject: Re: [BISECTED] bug/regression, x86-64: completely unbootable machine
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, again,

On Fri, 24 Apr 2020 at 09:11, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> The problem you encountered is due to a bug where the code doesn't work on
> machines with less than 4 physical CPU cores.

Thinking about it more thoroughly, are you sure that's the bug I'm
hitting? I'm asking because I have an i5-6200U (Skylake, also dual
core, dual thread, like the i3-380M) laptop which runs 5.7-rc1/rc2
just fine.

Thanks,
Rui
