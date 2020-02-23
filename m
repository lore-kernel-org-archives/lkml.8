Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B5C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C870420659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBWDW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:22:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35811 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBWDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:22:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id c7so7564413edu.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 19:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dT0CO5fK7JyW8ZIyZLXNtY5kJzym374Kxy5Vzfqx9NU=;
        b=C1RHXIngEDn+Tve91leRtkbp0bKj4zsJVSQ8IuCo/ncxZR6Z0frBxHIqk6ZVLk3ytp
         i2ll0jf2OtK8Voi1aADO4X+HixjNiJ1pSZPS9yi+xeeGksDDnI1HHqHuHwhqSMdINq9f
         a0jyMFrelS9+kGlOh3kb81Ovh3dHJrad+RJYYnc56+j4CMNh1qWnsZLuCVmDjAyk1t3E
         IoOkDVlh9TqUl8eoFlNa2YhqfIb/Y0tm0GxsFfX66vhxEVWKGeTO+iFOS8e4qbNNHwBC
         9xKKrWGevAMFPuqXUk1VTum8TXFwQbswyKCY/tSpvrsxIqpsmu3Jb17GWEmsNqqUOeQV
         crXw==
X-Gm-Message-State: APjAAAVzoSpUw66g2pj4lXci/jZLJvugFlkJWcGekg32FNA7PKRbOjBf
        SGTBoa2gNJ9iCJXTfwkWRA/W5REgfvs=
X-Google-Smtp-Source: APXvYqydvA6TSaXoFYTa95lUvVgzffToarM39FlIXjP5Tc35MlJfKFZ37HBO7irfjhnBMOX4SI2biQ==
X-Received: by 2002:a17:906:aac3:: with SMTP id kt3mr22966585ejb.22.1582428173700;
        Sat, 22 Feb 2020 19:22:53 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id u26sm589573ejb.34.2020.02.22.19.22.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:22:53 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id y11so6361262wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 19:22:52 -0800 (PST)
X-Received: by 2002:a5d:640d:: with SMTP id z13mr55697508wru.181.1582428172667;
 Sat, 22 Feb 2020 19:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20200222235634.243805-1-megous@megous.com>
In-Reply-To: <20200222235634.243805-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 23 Feb 2020 11:22:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v66RkdKAB2enXCmiWhYKPiV+g2ap9+rz5eZb_gVEDk0-nw@mail.gmail.com>
Message-ID: <CAGb2v66RkdKAB2enXCmiWhYKPiV+g2ap9+rz5eZb_gVEDk0-nw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] regulator: axp20x: Fix misleading use of negation
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 7:56 AM Ondrej Jirman <megous@megous.com> wrote:
>
> It works incidentally, because AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN
> is non-zero, but the false branch value really should be just 0.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
