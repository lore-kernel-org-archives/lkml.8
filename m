Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515FC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC3D206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otmr07/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAPNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:09:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPNJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:09:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so19127676wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcItPdhL/JalFkp3Ip4EGe5eqFJ7VNZbWjNyuI8ScQE=;
        b=Otmr07/+6j7fwW5MD+CXlBdMdARhRZ+vKYvPzbw0bOy8BUk0nSylWpd2+cFFhlLXEH
         6vRL1BQ6KiBaLAptxCDTk8hgQ/KHELi0+Sqv5IoCZdBAx2ScSKmdti7JXftm3Cp9XAgb
         tKrKyyvF5lDhDpFpE8F1LDSwcIkj0o9eYwl1BlXAXx9xKyLU2TSqnvgAje2USTbciiYZ
         o6vX2t/4Q4p+5F9aU4Ow7PVeDtHyoyDp8fdG92ZiPbFr7upBK1eNI0xjYCF11/TjvDdC
         mClokLZKNGPmjIkbmUR8iVf219lzz47t0tGiXThWs+OEwKnIj093sWyiT/Czn4Hmn+u/
         RFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcItPdhL/JalFkp3Ip4EGe5eqFJ7VNZbWjNyuI8ScQE=;
        b=r3zNuC4knb+JAPyvWJcht3YjXDysieaPn0ZIjJgmm8QT/A+Vm8ohExSa3rjgyEbLrS
         8YEzPZXonepMxlDrkNfWamjLaNcobS1uzUyyvr6FKtN2YfNQRyqUn4SY/MUnV6hxz2h5
         hu8IOyQh8yLLk/TESXRrYJgjUA/p3bh1iFFY55u1PPJ8pBnID6T1BIexnbFBqxz9/d8i
         YKX77syGrGFmbqbg/OPnontOHavN8gd6yrNcFM3ilW/+yx+howiPBlZ6SCbA4aWIGmgh
         SkSEJ3AcXLIR3LXtd3kfY1/rPF1gCWqC94YESr2WUF5DPyAtQedV9Y1r7HMCsHQDgS3e
         jfqw==
X-Gm-Message-State: APjAAAU7lOX5CQ95NXhd3eyoTkKs+9xgvKMiK29pK6iRV9eVftLstlW0
        w+2lKfT19JJWoBSlCOwPcag=
X-Google-Smtp-Source: APXvYqyd+bmwbAfoi5v6f3Yv/PNCpEEqYXePUaVWryA2IIiJiVtUQVptXyPFwD2bK55zj/zuGGdjcw==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr3358657wrw.246.1579180194422;
        Thu, 16 Jan 2020 05:09:54 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id k8sm29087196wrl.3.2020.01.16.05.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:09:53 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/i915/display: conversion to new logging macros.
Date:   Thu, 16 Jan 2020 16:09:43 +0300
Message-Id: <20200116130947.15464-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the printk based logging macros in
drm/i915/display/intel_display.c to the new struct drm_device based
logging macros. This change was split into four for manageability and
due to the size of drm/i915/display/intel_display.c.

Wambui Karuga (4):
  drm/i915/display: conversion to new logging macros part 1
  drm/i915/display: conversion to new logging macros part 2
  drm/i915/display: conversion to new logging macros part 3
  drm/i915/display: convert to new logging macros part 4.

 drivers/gpu/drm/i915/display/intel_display.c | 1021 ++++++++++--------
 1 file changed, 596 insertions(+), 425 deletions(-)

-- 
2.24.1

