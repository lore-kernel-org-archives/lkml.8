Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC92C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B00120774
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="SYXcHueu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgH2UyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgH2UyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 16:54:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A13C061575
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 13:54:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so2375760qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=j/CPzCzCNcZc4EM9Sbx1bxir7B3lrQX0EShcWmII8d4=;
        b=SYXcHueut7A7pp1eHLqirWq1qIEt/2F8f8Vq1AoqtoQwSGJGd59MVBitjFj4ACYCll
         uOM5yYt/QZeQiKmr4663HDelhco9FaJvaq3VZ3s8u2yYyKqDqmOH9eRFDYdNieCT2pj3
         OWbEwyInYPWrvD0f3/OsppkLEAPvy/v+Wt8SdM6WBVHVNTluGIs3KZtwQiFZgh74aHDz
         sklDVe9LnLJ0XnQQ9oh3ucLmK2RE0t4T87NUmDosYEOXIdn4+WnlsNqPFG3H3jSBh9XB
         qQ0k+pLY8P5QTif+YjpgqPebUxy8pOikYD3mroDduugJR/BvR2Rym8muI91w8IOLUSGj
         3BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=j/CPzCzCNcZc4EM9Sbx1bxir7B3lrQX0EShcWmII8d4=;
        b=g7+4c/OrWh8L+3gbPoaRAh1fN6VW3svD405CUlRG/8AQYsIcLOLhwNDIk3BdAvvVM6
         zQ4D0Uv6p5zs63UgdmeImLAQzVsGqUe4UkwRfwgJkbfd1Yxnct4bdjH9b1z53SOQ9CYW
         KFXuhaV+mCu1pD6AWKJp7ZDhWYQU+7a8+xAflZwnzD9969avQueevbKMYL4C5UfoN0xW
         3JWYQuiVuHG2sdQPbCyWi/nm3p16yKss2Idg/uqbBvs3WpF+JegZLxh5Mhvc++HNJ8ar
         2DA04iFqzO9TRIP5II+i4UY/9KuJ3PrCYxjY9Y+7f0hjl9228IXkxkUVikP45HStW01S
         YfLA==
X-Gm-Message-State: AOAM530/3ub2kMjId70AYndGJ5JHA3krYVIJnSy8TjsUDaBuZMxKiSfA
        YUhmYiWOYdwylaDgf1XtQKmwzzxbAWW6fEeP
X-Google-Smtp-Source: ABdhPJy67I8GvGYeO2A4p6Y9BM+ALK7/Wb+Bj0pHtj9bkPRUW0wovpgq81q1Z8aPj912wNmDYYHB0A==
X-Received: by 2002:a05:620a:122c:: with SMTP id v12mr4996469qkj.113.1598734458809;
        Sat, 29 Aug 2020 13:54:18 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id 73sm3765801qtf.74.2020.08.29.13.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 13:54:18 -0700 (PDT)
Date:   Sat, 29 Aug 2020 16:54:16 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     devicetree@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Boot failure on gru-scarlet-inx with 5.9-rc2
Message-ID: <20200829164920.7d28e01a@DUFFMAN>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch "of: address: Work around missing device_type property in
pcie nodes" by Marc Zyngier, d1ac0002dd297069bb8448c2764c9c31c4668441,
causes the "DUMO" variant of the gru-scarlet-inx, at the very least,
to not boot. A gru-kevin reportedly had no issues booting (further),
though it most likely had a different kernel configuration.

Using a SuzyQ cable, there is absolutely no serial output at boot,
while reverting the commit (and this commit alone) on top of v5.9-rc2
works just as it did with v5.9-rc1.

=46rom this point on, I don't know what's the usual process, so bear with
me if I forgot to provide relevant information, or made a faux-pas by
CC-ing too many people or not enough.

Thanks.
