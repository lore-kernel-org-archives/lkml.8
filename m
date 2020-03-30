Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE65C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="uvhF8YAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgC3NPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:15:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34641 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbgC3NPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:15:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so21597452wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZQnIrBoKCgs92w3hNfMCsInikuP/bVMcMVhva4azg=;
        b=uvhF8YAYlaWcb+Y+7upihHc8bDD/FpGMOeawBave0BhPERJH5qtiMwvv9QzfUuByC5
         RXZjIrD8OFm32S6i65UVrrq8kTZ1xDt79rxiS1PU9R78mBjqE9IS2XS7G34GiindmcZ1
         0p2aiRYVc9SG7Ifj/TTZqZvz++BLZkIXz6CDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHZQnIrBoKCgs92w3hNfMCsInikuP/bVMcMVhva4azg=;
        b=oaEB6X5RW2q2jtiNLovG6vjCAGfavVXSM3HqziYj5Vv76Htz0alzorgHzo7muDhYju
         WMatu9bpmChbChXXLbKnULYjnR7OsD99ez+i0qUNlLO788xIf1mt18PfeVRxn/sILQQo
         ybQRgouZTW9wkCr3vB7C/VCcjCaEiS+mxXwNWLY7KLb7xlCpMviEFZuTeAkk224cUp6k
         VaNzvKzMH6J2ckpn0zrW13a2sGNHADiGcQsf5rD/Tq00K29azcZFH0hlnU5QQMu0wRtx
         2pxfEZ5WyCTgqmqH5Rw0F46xAgFh7KYFyAuS5a1Gd4VP/vittxPAceuHQIKQoOXi0TeI
         4m+A==
X-Gm-Message-State: ANhLgQ305s3OMnX7SIT1bdfc19nhOTkkhjR13e7DxcRH7+8oLVPhZMBD
        3ZrFepeEJoA9ikAFQiO59tfECQ==
X-Google-Smtp-Source: ADFU+vt5jI1y1/93TjThJ3hiaNjyt/yfegQ0yf9I3Lm/dg7PTPfNSBO5dV7JehIJW2ukxFJRU316wg==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr15376642wrn.144.1585574120836;
        Mon, 30 Mar 2020 06:15:20 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id f14sm21135398wmb.3.2020.03.30.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:15:20 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH 0/1] an option to place initramfs in a leaf tmpfs instead of rootfs
Date:   Mon, 30 Mar 2020 14:14:38 +0100
Message-Id: <20200330131439.2405-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting [1] with a more verbose commit description

[1]: https://lore.kernel.org/linux-fsdevel/20200305193511.28621-1-ignat@cloudflare.com/

Ignat Korchagin (1):
  mnt: add support for non-rootfs initramfs

 fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.20.1

