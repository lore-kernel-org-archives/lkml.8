Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F860C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C2F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK4/Arut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgG3TaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:30:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726779AbgG3TaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596137406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Zo62zBr05G4i/w6uOCrF5bcIwehfjUuSBLT3HlEcuYQ=;
        b=TK4/ArutFiX30RTVSeQP72Z2Gg3T069qDEa8QhEdpHXY4H9Wb9h/Q4PtRO7epGbvlxFCR6
        b7xh+gPHuedTwoEnaJewZS1w/y+Nxl6KOj3YtkbirOPQVc/+g6xkdBIucTEE8VtXApf05t
        HdtsZRI1T2jnHEfDUECFPrFB3Ys83mA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-RPmhit1TOIKjUFZFkYYoXg-1; Thu, 30 Jul 2020 15:30:04 -0400
X-MC-Unique: RPmhit1TOIKjUFZFkYYoXg-1
Received: by mail-wr1-f70.google.com with SMTP id b18so5260996wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zo62zBr05G4i/w6uOCrF5bcIwehfjUuSBLT3HlEcuYQ=;
        b=BBEzz5afBN9kIQIbcbo8MSIgk9qbeDsvFKCxezf5VJ9imtTcWa1Gvp6wObaP+PuWcO
         hqmJzwF5ULgjtbqc+/qBzqIoDODDRTZq32+/TMRMtVqTS0aDB9aGaO7yUA+p58XEkjK5
         8yxMvWHmVdUAphRDfDd7tllmLKopLt1m78HcXm458ge/9dDNuUVZ0fldmDxyxfWKdR/F
         wBxkI5QPiBSb7ouzPyXY97yvPpUBmWMCNb66Ep9csRY1HPal3xlAPSb1p2kVrujBixdp
         txM9MDZk4RZ0bPiAxcb+U4dN/qRPFELuvEAnuQiH0kqABssqmUQhbrH2IpuGBzxRe1WT
         NSYA==
X-Gm-Message-State: AOAM531xQQM63HlJPdc87OZOX40GYF2Tv56ID01tz9dlwzSXtr6QndPc
        Md/HuDRzVdgoTDeDdnXHZP8P7sC+3rlHqzrQTUwDTnJSmggc9L+0e+MlTC5DkkxzMxUhBD4ngjf
        ESCjKwY4yZAsy1S9RNjjFhc1r
X-Received: by 2002:a5d:538a:: with SMTP id d10mr267395wrv.280.1596137403065;
        Thu, 30 Jul 2020 12:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM38R/gaJ4B9lHJnwY7CoXgiuKGr1JOva2N2K51sHps4St8QHQsZSys7gU+zLzyFwcYWboVQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr267372wrv.280.1596137402764;
        Thu, 30 Jul 2020 12:30:02 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id w64sm9081104wmb.26.2020.07.30.12.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:30:01 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:29:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@linux.intel.com, chenweilong@huawei.com,
        david@redhat.com, jasowang@redhat.com, mst@redhat.com,
        rdunlap@infradead.org, stable@vger.kernel.org, wu000273@umn.edu
Subject: [GIT PULL] virtio, qemu_fw: bugfixes
Message-ID: <20200730152958-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a96b0d061d476093cf86ca1c2de06fc57163588d:

  virtio-mem: Fix build error due to improper use 'select' (2020-07-30 11:28:17 -0400)

----------------------------------------------------------------
virtio, qemu_fw: bugfixes

A couple of last minute bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (1):
      virtio-balloon: Document byte ordering of poison_val

Michael S. Tsirkin (2):
      vhost/scsi: fix up req type endian-ness
      virtio_balloon: fix up endian-ness for free cmd id

Qiushi Wu (1):
      firmware: Fix a reference count leak.

Weilong Chen (1):
      virtio-mem: Fix build error due to improper use 'select'

 drivers/firmware/qemu_fw_cfg.c  |  7 ++++---
 drivers/vhost/scsi.c            |  2 +-
 drivers/virtio/Kconfig          |  2 +-
 drivers/virtio/virtio_balloon.c | 11 ++++++++++-
 4 files changed, 16 insertions(+), 6 deletions(-)

