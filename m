Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925E9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD1222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="DbReMlTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgB2RNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:13:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgB2RNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:13:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so7132213wrp.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=lhgf96iPi0z9MS616zvm8BxTU7hkNPCLBHb5E9MSaLA=;
        b=DbReMlTPf8v4zoebQMV9Q4jcMDs17/+H2dim9YM0PQdcUdPKPTQutsDEqXtL91ebJ/
         eE5ra5zCOnMjL48DILr73yKJLgYk+Vn307TgJyGRxnLT6DqE1ZviBcSU2OBikV8XaVYM
         lEiOn3BlfCf6QBRFce+2Autd1o6405+VvUk6edJXjSwpxA/+ieoMyZEoxyHRIfr7TUrc
         TOVWn+Tskps6xilAmn2BJoF88xm6sROWZYCPiZcIhSPUZSgtQ5x+A5iRSmBGFpdsz2Hr
         Ifzfyqq77Bvkpxr9Xm2tkDPI8FjXV2Um0tu9+clpmpY3k1XH8b0yHIA9WvADJ8uBMeWC
         mlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lhgf96iPi0z9MS616zvm8BxTU7hkNPCLBHb5E9MSaLA=;
        b=mHHugcTVaXN4RlyTrpPTkOO62yMaJhbx+RaaN5/j5LSjv9dPQw6elzNdKheqMr4ceA
         fFcmUfBCID9FjXzGyZ18aX0Q3Sq2fglxo2x6wJRlQr5R+46Gt+vsXLqR65LU3g9C+uPn
         v7QEO1+gR5RVUJ51PFMrvvYhInkY3iQ2htG0PzRtF8GnJlV3HwpenILiqxr7QJ82kob1
         oCXzWPs1gStWfrLkZnvw1j5GBAhRgzXM0rxC0FNs+ZzvsJK4CbMps/aIBQNZBy0McnD+
         CNXV4pTW7/rDb63E5AHFMu9yDNm7lKkvbx+kZAERpbWEzCSsRt1UU8ju/23cvjkS0JPb
         8d2Q==
X-Gm-Message-State: APjAAAU9xhfb6hxO1g4P1N8UMa6RvpzsBXI7pRm5jhUBgfcxFkAF22I0
        RP4wMh4LXFXPvkpN0zt5ba8IId2uaDk=
X-Google-Smtp-Source: APXvYqz7m9YX7xQZrnvv30a7ZslEIm+zbd+LGJiBeWVQEX9iz9R0frwgZcHGTt6u6MMlzGIMPb840A==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr11337891wrw.400.1582996388632;
        Sat, 29 Feb 2020 09:13:08 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id r1sm17045046wrx.11.2020.02.29.09.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 09:13:08 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH 0/3] virtio-net: introduce features defined in the spec
Date:   Sat, 29 Feb 2020 19:12:58 +0200
Message-Id: <20200229171301.15234-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.

Yuri Benditovich (3):
  virtio-net: Introduce extended RSC feature
  virtio-net: Introduce RSS receive steering feature
  virtio-net: Introduce hash report feature

 include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 4 deletions(-)

-- 
2.17.1

