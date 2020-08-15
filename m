Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F55C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816BE204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="g4DTmlN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgHOVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgHOVwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:44 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE20CC004584
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:24:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so10053103oic.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WD7gDl+XCmPqlIM7nO2KOimmNxRDcsCujVimXn1HcY=;
        b=g4DTmlN0AX+cftqo1QEpMKcjQk7ZLxWak6EyvPZavjAmBIk8W1XU8uNdWZCTLi1DW6
         DVT6Hhi6wWp4aBdUSYuGixUeEKS0TAC+Cttb3icJugW6uKVYJcwIWLbU6HY9ZpjqRk93
         TJivnlGJ5p2LOhQabFmwvkVDTnN1kZQuXElbRNiIA5/Lq7bimj65Y2kxx92n0v/XcQzc
         KJXsSBW1G4fZGw+G4fxmPBgSuBhW2sI2qFaeni0qQfISXO6Fpa8oJwoOnkwr2xdukwJj
         q88RPcEN0CeiSwHbpisoTCWPyghNabqi4ZRUUqqVtogrSGbuGQKNp61Y5oEZSTC1KHEJ
         dVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WD7gDl+XCmPqlIM7nO2KOimmNxRDcsCujVimXn1HcY=;
        b=FR7i+DJ1hSD2AQx/LZxv7oxX1bMRyggyE5txvd52pkDVTGrYdEByJ8P6JAT0t2h6Wt
         q9rR8Er5UsJwMyyLW01k5U90ZxY1wOptg5/2iT/4j2ZRCBnpPQQ4PUyZG0MiOABa2kAU
         ATRN28ItrKhv9ZBsdp8QkckJW+MK5RtstI7YxEvPG1p8YFJNDsAy1DDg5sbx/vUtXQaD
         gkGUKfqtUAZ2bv9h7Fh6cJYOPwXqIB8Zg1lAQ2euKjzbdmfit/NyRuGBygOY2W9Tc5xj
         HcD4AqH6o4HVsKXYr8Z2eNmmM0A/h4LMHk/Orzd9HK30HIIxq2luzIxV4Gy9OxSxLZo6
         sRzw==
X-Gm-Message-State: AOAM533GaJnKH9sMOKY8ZK8IaaYoANwWN7qA2kMKJsbiKQ5zeO87kdGE
        WmTp1icD06YbBQ9zKWKaI6OPEGKBBqhnZHp0lCA=
X-Google-Smtp-Source: ABdhPJxqwP+YD3muYShKpb0m6VaIwQRrEiPMwvh26QMq87kIaKeWCvE0KzX/JwlMmukEVl0cU0TLwg==
X-Received: by 2002:aca:e144:: with SMTP id y65mr4848449oig.101.1597515841901;
        Sat, 15 Aug 2020 11:24:01 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id z72sm2397820ooa.42.2020.08.15.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 11:24:01 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Pascal Bouchareine" <kalou@tfz.net>
Subject: [RFC PATCH 0/2] proc,socket: attach description to sockets
Date:   Sat, 15 Aug 2020 11:23:42 -0700
Message-Id: <20200815182344.7469-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking to see if this could fit in struct sock.

This goes against v5.8

I tried to make it tl;dr in commit 2/2 but motivation is also described
a bit in https://lore.kernel.org/linux-api/CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com/

