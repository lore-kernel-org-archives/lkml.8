Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5053C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D220717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDNONVZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbgGUVbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbgGUVbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:31:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228DDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:31:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u12so142989lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nu6TKgtV3qURpGjBvNFV6IMyJvIIBzCD7ImtPQ6thtU=;
        b=QDNONVZQPw1ixumkJyQEWmNEfSatUjQbSQ8D3NJFNgq+4HuF65m2fLcvaplwjBJpVQ
         N1Lj7refGZWfqX3ijDeM5tJLcbUmpr3Ji8MLMSnRESQsDP7TVka0LloXDC/EM2qCJ9/2
         HC1zMTOCqiMFBCZR8obJXWrCNi/Lvtz7ZEHQRVUndSEgtNDT5KEEXVsS4ac6KcsyOIIh
         qvTbX8FbMv24IXV/eP1THWQly1XhuIy0q9K0TnRvRKTMDmjZwIQwHODXJ4jjclzfoZir
         RdDpUmZJKFSRiZJLABmGogt7dNQXnn+Y36jY8IWvB4Q6lqt3IshxFObp3i/H2RBQ0diI
         yKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nu6TKgtV3qURpGjBvNFV6IMyJvIIBzCD7ImtPQ6thtU=;
        b=XThp7DgWlws/lor7ArJrNzb87vS9ZeAQpkvh6uv60MwTauESdGB9uL8lQtE6L/KOA0
         uwki+59LYEkd0riy2/Mp980Xw4zofWmUzLcQ2JB9HEYRFxbBXlP738R+zFIYHBb+bI2K
         KrGkD1Rus4+uNUABCj+eljmIzJxIYhS/oWge3ukYTwENoBr4m2BAVpSo2o6o35wDg+BZ
         FySZT1neh/tMhDbeuJEqoGVliS7ptEZFyPUgOeqzQ7IAHIJPmclH+H5IOCTVS7M8rpGL
         bEn3Juc0hRzh1UyUtOZrrJ60Z51sIwgWJ+i84use32Cv2HGYuP85ejYYzS4oaG6OD7Il
         ty8g==
X-Gm-Message-State: AOAM5302s262s2FO7Qxv+KlgT9oUjsYQ7XKT5es0No3w7imdwot01Jd/
        nTH+cA4ka41PG4WWJNE38/fELdr2kp3cJylqnw==
X-Google-Smtp-Source: ABdhPJxRUPCn7QVQPYQTpZEek1QRa7tTIJXfeMRdTQvJRUNy18l0SEweV6EwNHaocu0MlgNLtXFzGREmss9Xlw9o/KQ=
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr4307530lfo.31.1595367060496;
 Tue, 21 Jul 2020 14:31:00 -0700 (PDT)
MIME-Version: 1.0
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date:   Wed, 22 Jul 2020 03:00:49 +0530
Message-ID: <CAD=jOEYzbemo=WBev97q36578h5VA7jYVAdewgf5vKycGP1y+g@mail.gmail.com>
Subject: Regarding bug in phantom.c
To:     jirislaby@gmail.com, arnd@arndb.de
Cc:     andrianov <andrianov@ispras.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is regarding a race-condition related bug found in phantom.c by
the Linux Driver Verification Project.

dev->status is accessed in phantom_release with dev->open_lock and in
phantom_isr() using dev->regs_lock therefore there can be a race
between updating dev->status in phantom_release() and phantom_status()
and reading it's value in phantom_isr().
I don't think there is any particular lock protecting dev->status
(like open_lock and regs_lock are for dev->opened and dev->oregs) and
also not sure why exactly dev->status is updated in phantom_status()
and just after that updated again in phantom_release().
It will be great if you could look into this bug.

Thank you,
Madhuparna
