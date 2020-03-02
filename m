Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4842086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="flXngT8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCBLv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:51:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCBLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:51:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id r7so12214063wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/rHHl6KiQFstCbJm9Q4e8qxVTuasj3sB26DLZAjgwA0=;
        b=flXngT8rwKOxE5BOh/O+vL0l6yqTuAsuCvysZSvRb3FKN8FZWnaXjVnUS/DOjMcn/Y
         4eTchIL2gM+FUZAc6D0uA2Wpvj9M/YpKCRJepV++nwOB8Z2WtM1L2UVvwfrYX7DkVJaK
         sMTSftsb0Qn3ncNHw6VQDYbZgQQKuDsocuv8vfSebWtaiBlmnu4Ixcuj+t9gaxtO4KD+
         69814S+OhRkjFIvJnVVjnXpEVUHqbDboHUd+hTZcpG/NiRTnXwoRU3tpf9uyEOua0/Yg
         tA51r/6uHH4OlcwlTANqoTzuIW2Lnyc1ed0w54wAqmeAvHXsgDEtHRdoG3fA4ya6xzPv
         Mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/rHHl6KiQFstCbJm9Q4e8qxVTuasj3sB26DLZAjgwA0=;
        b=NGKLA6awEWU90rG04fnp4v5TUM7uyUbUYjVue520m+rXAsFnyawJWMOxChWFM7z2LP
         H8i3Z9h0YP+GdOoSWts0+JFBkVjJOI4NqN4AIbILvxhljDFIMqti5F1OOsh/udeiYy0d
         8ycHDZydU/Cn/OyJlR4XHcPN+z0JFPHTY3luzb1ns/WuVepGBn2649hYVOxqZdg3Cm9S
         f/rtJi2ZhafXlexjF4nZ9J4tmJDXOOPoQcvxecZhctfjba4g1PUbOhmgqTD/SZe0ruew
         OMncv0CYKyLG37s0mxGEVgxNJZyNZGEtZv6ZKqiHqGH/+FmPbxF+BoDwYb3lRhY1VSxM
         kaGQ==
X-Gm-Message-State: APjAAAVVQ9MNl5mDNgpTAMLL8Bc4PAzqDVjCE5Cua/ZbLwUb87yNZMEd
        3+yW54YAqFswJ3e1xD/LmhUl0Q==
X-Google-Smtp-Source: APXvYqzOtVclswSZyIGBO1O3Bre1Sv8RV3Hy5Yj/o+23zB0EGZ5TSdI7NZOfUNuDS4YtUDwvWO9dTw==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr21894695wrw.400.1583149917331;
        Mon, 02 Mar 2020 03:51:57 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net. [79.177.42.131])
        by smtp.gmail.com with ESMTPSA id f17sm16840364wrj.28.2020.03.02.03.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 03:51:56 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com, virtio-dev@lists.oasis-open.org
Subject: [PATCH v4 0/3] virtio-net: introduce features defined in the spec
Date:   Mon,  2 Mar 2020 13:50:00 +0200
Message-Id: <20200302115003.14877-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.

Changes from v3: reformatted structure in patch 1

Yuri Benditovich (3):
  virtio-net: Introduce extended RSC feature
  virtio-net: Introduce RSS receive steering feature
  virtio-net: Introduce hash report feature

 include/uapi/linux/virtio_net.h | 102 ++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

-- 
2.17.1

