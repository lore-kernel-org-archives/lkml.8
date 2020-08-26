Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C219C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D7C214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4SObXwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgHZN2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:28:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730214AbgHZN20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598448502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=i67+aNF8QtmkXbZ+5JSUQwpOse6+0MGUqtdEKnlOGYo=;
        b=Q4SObXwIqXhBVDXo5ddCXC0ao/UUQJinuE+m/FsbGLI3qQ9NO3KPWnr+UxBSYRZFjuvx0K
        CEKj815+pBPfN0ZM0xRZB0cT7U2oACkXsfZPc4ACCZZVagm5/G2ZFYV/XnU1LXotHbzTUZ
        jtfJhKTkM72coH1njWVDRfX95WmHkGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-CjVIsumeN4-uOraGDqCZcQ-1; Wed, 26 Aug 2020 09:28:20 -0400
X-MC-Unique: CjVIsumeN4-uOraGDqCZcQ-1
Received: by mail-wm1-f70.google.com with SMTP id z25so770223wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=i67+aNF8QtmkXbZ+5JSUQwpOse6+0MGUqtdEKnlOGYo=;
        b=bHY0sn4eTpw3s+vrDDJb1UEPXEJOqYZJlUxyFXsxD0l2L8j+2YR3Vrep5WMVh4XQ7f
         F8k2duvuIIAjGHSzcCUic8dz+NMl0QMQ3AI5eT74KtO2FkOpt8Z2HMeNdrbquRxusSBs
         q0b/5QrKeTUkodngj1r3WQR8BPokXdygrvvPeVyXoG3DMgdv+2ayS3PaCT7vpsS+tLoL
         rqDhpNP4tys99rGDIVmth+R4O6oxxF3OqqTZIs5vTkig3+QOc+NymEUdpqDPdGwKFKx5
         S8MrA6HcaPeOX59uugOz1CzhUMKsezjT6evSxnmjXFJehSHlzyTwymMI96I/aGbaVY5F
         A2SA==
X-Gm-Message-State: AOAM530MnqqN9k8EZsmB/bC7ZxC/R3FV7ItZh3jKRtO8LRGTU3EmbNeS
        DNceDnKE36XEjStDikbT5FAJ46TxwBGUeNv0jLJ7aZo9gECft+XJBfKpyjDTHOUHXNLp9HmbcC3
        YCTwg/dSFCXJdNV8Rrlc6+1jy
X-Received: by 2002:a1c:105:: with SMTP id 5mr7557743wmb.83.1598448499407;
        Wed, 26 Aug 2020 06:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE5CXik9B/yf7SlhoMl9P+rB1tllMpEuE0RJnSmFjwzWrgc4RXpHi+O77/0mfTHMtg2dZEVQ==
X-Received: by 2002:a1c:105:: with SMTP id 5mr7557705wmb.83.1598448499198;
        Wed, 26 Aug 2020 06:28:19 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
        by smtp.gmail.com with ESMTPSA id g62sm5158616wmf.33.2020.08.26.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:28:18 -0700 (PDT)
Date:   Wed, 26 Aug 2020 09:27:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, jasowang@redhat.com, lingshan.zhu@intel.com,
        maxime.coquelin@redhat.com, mst@redhat.com,
        natechancellor@gmail.com, rdunlap@infradead.org,
        sgarzare@redhat.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20200826092731-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cbb523594eb718944b726ba52bb43a1d66188a17:

  vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms (2020-08-26 08:13:59 -0400)

----------------------------------------------------------------
virtio: bugfixes

A couple vdpa and vhost bugfixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (2):
      vdpa: ifcvf: return err when fail to request config irq
      vdpa: ifcvf: free config irq in ifcvf_free_irq()

Nathan Chancellor (1):
      vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms

Stefano Garzarella (1):
      vhost-iotlb: fix vhost_iotlb_itree_next() documentation

 drivers/vdpa/ifcvf/ifcvf_base.h   |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c   |  9 +++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 50 +++++++++++++++++++--------------------
 drivers/vhost/iotlb.c             |  4 ++--
 4 files changed, 35 insertions(+), 30 deletions(-)

