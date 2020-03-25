Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD1C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB26520772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjB2X695"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCYKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:40:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51907 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYKk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:40:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id w9so867100pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DvKg2IHi3Qj70iBHg+WUL8Lkjl5cn54XoVnrEhL3Mm8=;
        b=jjB2X695zwinTyCqhhpHsSpEM1BFt/EQHCZAQkZrno2Ypr109M5Xwhg20kV0IpfCqs
         y0terG7TofI2Q9YoV1N7NVeZ74FBif6BvbIVxdnIdXBHZWnUtMGkRPfdtsBSW1RAFlnx
         CTblKpJvHFL+XYXDBQHhLGUh3VBAfgLTAF4+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DvKg2IHi3Qj70iBHg+WUL8Lkjl5cn54XoVnrEhL3Mm8=;
        b=Kjw+1Zmp/SvWIem4+JpLyRm8PG9mS1z8r65pjMIpFGDv9lL62/ipCsbU57P2dwZjx3
         fhgVnoRq8BL/82pQk4Ownj/7iqayQDzThark+JlrIgcrE4a+1fTU5S8EebZV+VdChmK0
         Vh7QuIue2qJesTNrzgUIsCF3Hr4r6vbQzQ/VZlb3Q0qKnSus0bNNnJX2vdFPJ7afywQJ
         fiGnrUj4JPFW+K1WaS92HNeiNhwgLwDg+s2Ct3ZS/S5/QVl8ekEmvCTavLZivdRr3iB5
         WMsAQmQqKkp94keDSUlgJXWfd4jy2zG//2PxUGAYtadzq1YVn6GoNPg+CXX3LW37FCtL
         a2zA==
X-Gm-Message-State: ANhLgQ2wMFC6yRHMeD9ATzrMH5/tvTO7TBZFppyUvQGDjX6mGYqtK1ib
        TyzoJpL3Z1xhvgXGKKd1QGjSqw==
X-Google-Smtp-Source: ADFU+vvXebHRwUAL4QYgPA/E5Nymgdnz5gpZduRO6NtNGffciBeXDeNZkR6KYzkdrkpatyvnsfHqjQ==
X-Received: by 2002:a17:90a:6501:: with SMTP id i1mr3013827pjj.32.1585132856562;
        Wed, 25 Mar 2020 03:40:56 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:8f:203:863a:e217:a16c:53f2])
        by smtp.gmail.com with ESMTPSA id v26sm5150320pfn.51.2020.03.25.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:40:55 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Sepp <dmitry.sepp@opensynergy.com>,
        Kiran Pawar <Kiran.Pawar@opensynergy.com>,
        Samiullah Khawaja <samiullah.khawaja@opensynergy.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        acourbot@chromium.org, alexlau@chromium.org, egranata@google.com,
        hverkuil@xs4all.nl, kraxel@redhat.com, posciak@chromium.org,
        stevensd@chromium.org, tfiga@chromium.org
Subject: [PATCH RFC 0/1] Support virtio objects in virtio-video driver
Date:   Wed, 25 Mar 2020 19:40:38 +0900
Message-Id: <20200325104039.196058-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements a feature in virtio-video driver to use exported virtio
objects as video buffers. So, the users will be able to use resources
allocated by other virtio devices such as virtio-gpu.

The virtio protocol for this feature is proposed by [1].

This commit depends on the following unmerged patches:
* Virtio-video driver patch [2]
* Patch series for virtio cross-device resources [3]
* ChromeOS's local patch to use data_offset for offset of multiplanar
  format [4]

[1]: https://markmail.org/message/wxdne5re7aaugbjg
[2]: https://patchwork.linuxtv.org/patch/61717/
[3]: https://patchwork.kernel.org/project/linux-media/list/?series=254707
[4]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1057eb620ccd3da4632c14df269d545cb9a1ccb2

Keiichi Watanabe (1):
  drivers: media: virtio: Support virtio objects in virtio-video driver

 drivers/media/virtio/virtio_video.h        |  26 +++-
 drivers/media/virtio/virtio_video_dec.c    |   1 +
 drivers/media/virtio/virtio_video_device.c | 131 ++++++++++++++++++++-
 drivers/media/virtio/virtio_video_driver.c |  25 +++-
 drivers/media/virtio/virtio_video_vq.c     |  81 ++++++++++---
 include/uapi/linux/virtio_video.h          |  15 ++-
 6 files changed, 243 insertions(+), 36 deletions(-)

--
2.25.1.696.g5e7596f4ac-goog
