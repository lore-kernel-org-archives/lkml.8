Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D320823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYgLu8a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgEUSIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:08:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728455AbgEUSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590084521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CSwVUGMdm1SF/JKvVgrgcJwpikT7dcnsVODRPnenSIQ=;
        b=AYgLu8a3LIGrhE/UKpmW9DRbHM8IIjjQq9JymmflmyJiz8ddiqBlkoLskv6Sb5AhrCiNaM
        O0I5EQh8TL3cQ+y/bmWAdBD1Ev7gWcgBhn5uPabPEtoOHy/9vz5n+AiKWKQqGYvylvXfsJ
        Mggcs+Br+9tvVq3uo2swVhoSNIdyQlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-6iqFeG4lPaaJXGPxh9D-9g-1; Thu, 21 May 2020 14:08:39 -0400
X-MC-Unique: 6iqFeG4lPaaJXGPxh9D-9g-1
Received: by mail-wr1-f71.google.com with SMTP id i9so3264333wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CSwVUGMdm1SF/JKvVgrgcJwpikT7dcnsVODRPnenSIQ=;
        b=RErvBDwwzJociRnaD684UI85Cn9ol0ciAIFIapa4xW/SVON+y3gRLZ8p7Y16w9Ek76
         o4JGTJZ+mrRyN64pn3vLojQpTphL94GdAlG3hitfBEzRi+W6SOJF1LbX7Y0rUzYsnxIv
         uu4afzCG2LydBAfzpYqOrSmWm4ex5vcJhGP3RekGFi3FASpe+BMbXvgWXASuChrZsm6M
         QtbpHVx5gGb2MCJtPAvh2GSx6EwjOzkR6KfP3nabWnbz+FjPe47AhF8uQ6HtV1JjPuky
         /+qX5AhBMZqrcBE9VOLKA33N4LsE6JGM1pqtWurVKJ2cHupQU5HBA94Phjx1YYwLHbed
         RdFQ==
X-Gm-Message-State: AOAM531127TbL+oSgUQu/v5GOJ68pf1O4Xy6l/3tt+V0nK7i/EVmdV2g
        C4veIoxpDwDG/AG3rN41pGdym8vB9wjOw4Lx90RKd4tKgHc6SksaC5F9grnTrOAyiEV0E9DgVBY
        oa0HI6sZZ/rkdakyZnlwl9Pcm
X-Received: by 2002:a5d:6087:: with SMTP id w7mr10437013wrt.158.1590084518725;
        Thu, 21 May 2020 11:08:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ9o08gBH7tx0yYBsN8onaJW/OLPfFqqFDCwm2ORoSsfevxSpfrqifuC4Sj9PcOKKkhR/Jqg==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr10436991wrt.158.1590084518323;
        Thu, 21 May 2020 11:08:38 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id j1sm7269700wrm.40.2020.05.21.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:08:37 -0700 (PDT)
Date:   Thu, 21 May 2020 14:08:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, lkp@intel.com, mst@redhat.com,
        yuehaibing@huawei.com
Subject: [GIT PULL] vhost/vdpa: minor fixes
Message-ID: <20200521140835-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0b841030625cde5f784dd62aec72d6a766faae70:

  vhost: vsock: kick send_pkt worker once device is started (2020-05-02 10:28:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1b0be99f1a426d9f17ced95c4118c6641a2ff13d:

  vhost: missing __user tags (2020-05-15 11:36:31 -0400)

----------------------------------------------------------------
virtio: build warning fixes

Fix a couple of build warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      vhost: missing __user tags

YueHaibing (1):
      vdpasim: remove unused variable 'ret'

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
 drivers/vhost/vhost.c            |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

