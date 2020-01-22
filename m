Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4128C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9497520678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koNXw/fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAVM6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:58:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAVM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:58:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so7084495wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 04:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=dHe7Uw+KSQ7ok647ZtHPz0AWKdV1HTTdLE26ujWRi0w=;
        b=koNXw/fT1qXhYi99gvLLfGHaOWJ4X1GLHcgnLo9AxrzAfEViIa/hCr7L6NeuWZo5T/
         k4rypq+YXhFGuwzzpAGg3Ujn2z6F496kr3xEIlHOPXPj7dcdZVALQ/kddUmvmgCQcqxq
         L9goGVzim1hyzMKrL4/IHLztZuQXq0/73x2c1udUm3jp1uZ/s4bgWLCs6KTX418aJ1Up
         lOwgKfmoXxAPXNIHyN+3211Bqgwng1g+dQFsqYWoUIdk1FUWfjWBQnEpjwAzGJFTdZ2Z
         KMcax1aBYDczdVF5FUv3vGb1sN8PJzLW4biyzSHVlRQjch1l9mbv7j+lwa8t9ALvtPkT
         mxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=dHe7Uw+KSQ7ok647ZtHPz0AWKdV1HTTdLE26ujWRi0w=;
        b=DZZJ6ZZPsnj+slYsD89g1XtOeUwTXB0b7R7avI1+XdVY+3Y/VcRgpOgx3Hz2frrJre
         xPCRHCEgyrS0eMtRX3EUgjdVtr0+ZsI21QEg/Mu+KBD6B2++UcOy3FtHW2Mqfsr2Y3KX
         rY1FjGiBFixlJThwyTqoqY2CBFb/55NjI2D/c0REp4tLZ8ZRKbt1t3OhwN0MprNTKKjq
         g6MDyrdUG15yOq3Akm5L5y9gFjmYSvouKDykGcyVOJQeuHDkvyocNtLD0/Wg6yo4G+/M
         3q3jKIdLg/NWWcS0Pc8P4Z76D39qSM3bJ9kRGTvFsQ9VHYfKlfRqz430PwpNWqcSWpDv
         yCzQ==
X-Gm-Message-State: APjAAAV58kcYux5XtAhctrFo21ZWYAcFNGbuM3K8xwtAGe0eJYXyqj/+
        rhW7+gEzoxNwZHQTq8V9CVc=
X-Google-Smtp-Source: APXvYqzMqFi2hCE+U3hNwqDJ7/7SDjvjEEzqZ07PGG/u5ER2xBAIr7LZfUSYrSk12fCbB95BymfZEA==
X-Received: by 2002:adf:a41c:: with SMTP id d28mr11659150wra.410.1579697878272;
        Wed, 22 Jan 2020 04:57:58 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id p26sm3736109wmc.24.2020.01.22.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 04:57:57 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/i915/gem: conversion to new drm logging macros
Date:   Wed, 22 Jan 2020 15:57:48 +0300
Message-Id: <20200122125750.9737-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a part of the conversion to  the new struct drm_device
based logging macros in drm/i915.
This series focuses on the drm/i915/gem directory and converts all
straightforward instances of the printk based logging macros to the new
macros.

Wambui Karuga (2):
  drm/i915/gem: initial conversion to new logging macros using
    coccinelle.
  drm/i915/gem: manual conversion to struct drm_device logging macros.

 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 68 +++++++++++--------
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 60 +++++++++-------
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c    | 56 ++++++++-------
 4 files changed, 110 insertions(+), 78 deletions(-)

-- 
2.17.1

