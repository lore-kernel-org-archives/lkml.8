Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1271C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B4214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="B/fT3fVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCAOdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:33:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46768 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCAOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 09:33:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so9127330wrp.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HtofGd4kToXQ+7hP6afMC/zniJHqraZJ2UCvihc7Z5g=;
        b=B/fT3fVokUh7pBXtAfdkJ19LtYzf9ubc4q9ekSdBwzHdPi7ORgmw4lAH4fo2L1OnW9
         eKco266285xxfB2ruqo2fqTYiIeZbT4kcZ/QvbqWDvfwmSkPFsbjDlLqDJ6WmoLI+q5w
         7NhoWo1bTWeaSCjCyVDVtKOrjjdp4vkuWRYgEUMj7XFrmItH69CPjwVEby9+t7CZD0pp
         WFJckq28RneNlzHSbV2phVqfObKZ03+YWAtCyTP3cCDja3E53+8OWQUyVI+lmiZ2h85N
         ILYBJ9IAxfzsq02Cz8a51EljWBBLPMkbldCXc1VTpC16Lh+Ckhs/wUx7kXSTQtc3hj9H
         Sjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HtofGd4kToXQ+7hP6afMC/zniJHqraZJ2UCvihc7Z5g=;
        b=A1va6chLuNUoVbJcZHIvf8xzRtqhJhM1J94xEWSaE/rgCbVOrbOeUqDYCbtj7meJUH
         YwwYxFN2PsvEK2qdsXz/bt0klDUCaZchQbRFoxTTAEOFfLUZfog38W+zk48ndRZdkaw1
         hEPEVrJe/Ze9r/UrRVvgALtKAa73ybAov7iut/6xtnxcrsL84dxsjwLk2WU3Yl0piQF3
         8ewJTZ+GjKYbrFv7bJ22WwVJytkev/JlfR7fvxY4gbjor23mjIwYSnPo0NJbPXuGwsie
         w3OffVCmgDcaT5x8eQ6ASYiYXS2S7Gd8RQ96FOfp0+s0cR1kMXT+3f5++VEXHBf9i9M8
         S5fA==
X-Gm-Message-State: APjAAAW4JnU2IYeG0nds/rUUdYxs5DB71dB+JCRUljvxLmySXxg9pZjq
        FIFrruuZQUp7u0l5udGQ1S0YMg==
X-Google-Smtp-Source: APXvYqw5YSvUliTyulbl5gq9KLJISDZM/NrbWMGqG+5tngtPZw5UPPomyCVnbwEy0I7UFlE0eioHcA==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr16348178wrk.407.1583073188777;
        Sun, 01 Mar 2020 06:33:08 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id l4sm23617241wrv.22.2020.03.01.06.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 06:33:08 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com, virtio-dev@lists.oasis-open.org
Subject: [PATCH v3 0/3] virtio-net: introduce features defined in the spec
Date:   Sun,  1 Mar 2020 16:32:59 +0200
Message-Id: <20200301143302.8556-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.

Changes from v2: reformatted structure in patch 1

Yuri Benditovich (3):
  virtio-net: Introduce extended RSC feature
  virtio-net: Introduce RSS receive steering feature
  virtio-net: Introduce hash report feature

 include/uapi/linux/virtio_net.h | 100 ++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 4 deletions(-)

-- 
2.17.1

