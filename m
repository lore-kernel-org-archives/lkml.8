Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81692070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfreDYex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgGQJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:34:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1CC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:34:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i3so7090642qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oaIzGEEZveiQMSCkbwAGqZZaFN7FoxKI0NJhSLnSxgo=;
        b=IfreDYexttjDRrewc0RYE9lq7aazBU/R2omgHuWTbaf79JnAfFQZJPOFT5OWCui2P1
         vDeAgnuWQSC0xrF0Ibvu5pl29Kx9uzh5OIJqiF0TmErFIKu1wYyR1c8uhMd81JENDowh
         8YIM+mgiveZAk2Y8ZavjEG4/BmTxDsSqZ5z/gNTYjIldbE6RXNY+8kYIm8MVgh4CHbFl
         RUYnV/igj4RhyBkbS57Nr2G350bnmidKA2MVXcNJUv5A7icxBcZCob40G4v/7CMXCz2G
         SVMPNIxIsKELIOAijkVhqXUfNAJyGNgETPcGtu1I4702Tghr/8cj7Y5Cgyy9ZkCvPqY+
         2zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oaIzGEEZveiQMSCkbwAGqZZaFN7FoxKI0NJhSLnSxgo=;
        b=QkXpZOx4N/vGOjdLWUE6YqfHi+n0K0GWl4q6RgFt7vLGr2hj1dII2uzfMPaHwQLHtj
         sIzcK3xDKwHT4v8eEN2PWGA6QYPROR7lLUClLRWp+Tzky07ZlostEN+KNirRAc1f+9yy
         6xbrxxRfp8LyTafvret3gqgO35iLwuC9/fEqLsgRtis9QOQy9k4LLK+eukro3EZSYVHd
         J0XXbkQ8MMK00VSmJyLZNJy9WOSjyvyvBbRnjHAGwmQqUZqEIJtfq7UskZawxdZKjE/c
         0/DSJ3NaJmkqyopxaDWmQCuWPE4GP7mDcjtx7QgkQN5Ws/KJAqzcDyQJJbujmCFYB9yx
         YMvQ==
X-Gm-Message-State: AOAM533ucEuu5ghzcTTVq1TPKs1BfUW1e9hW1VKSlniWvz2ibBim0xCh
        ekybbzy4tW3r5SCSxGdzxSmg3Hmg8ZhWifuHTZ0VfPI6
X-Google-Smtp-Source: ABdhPJySCAN0NDoe+64zDko0ftOX/eJD+mZVx8LwI7HLwKZcDOmmqbPwsbkSuD91zaMwzYBOqnpjf0iozCgNXBU2LVk=
X-Received: by 2002:ac8:1b3b:: with SMTP id y56mr9131471qtj.94.1594978498056;
 Fri, 17 Jul 2020 02:34:58 -0700 (PDT)
MIME-Version: 1.0
From:   lebon zhou <lebon.zhou@gmail.com>
Date:   Fri, 17 Jul 2020 10:31:54 +0000
Message-ID: <CAEQHRfB2f4x2r9Sk1+ixAFjUTcFQArv9wtWfjq3igGfUgZBhXw@mail.gmail.com>
Subject: [PATCH] Fix memory overwriting issue when copy an address to user space
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When application provided buffer size less than sockaddr_storage, then
kernel will overwrite some memory area which may cause memory corruption,
e.g.: in recvmsg case, let msg_name=malloc(8) and msg_namelen=8, then
usually application can call recvmsg successful but actually application
memory get corrupted.

Fix to return EINVAL when application buffer size less than
sockaddr_storage.

Signed-off-by: lebon.zhou <lebon.zhou@gmail.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 976426d03f09..dc32b1b899df 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -229,7 +229,7 @@ static int move_addr_to_user(struct
sockaddr_storage *kaddr, int klen,
         return err;
     if (len > klen)
         len = klen;
-    if (len < 0)
+    if (len < 0 || len < klen)
         return -EINVAL;
     if (len) {
         if (audit_sockaddr(klen, kaddr))
-- 
2.22.0
