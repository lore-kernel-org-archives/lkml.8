Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB49C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B20520737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lebqEwzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHZRCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgHZRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:00:49 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:49 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r13so2427792iln.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26QxbXjs0m3B0fkeAQyxS9wdKxVZQIc+uM+Gzg+WrxE=;
        b=lebqEwzMhnmkswoxV6vONuwriIJ3JbLyvJdUMvGSkvk4rWMzuvlc611vQT6UXue4kb
         wuvGPZeBJwakM8I+RxywGmWpCfcM1xTEyQ69vOl82tWVJTod2B3ns3KNvKkqCrpgFY0l
         eiy0e08N3NHS0uzIhvheHSOD5J5U4Y3SrC/Xd+VWhXW4VYZ7Nx+YHN8ue885Go737b5S
         J9/7dQKzUKx6X5CmRhetUxkGMx2GuQpeLCzw3P9S7xWkqAUoLbFRkmIegcs6bMSm+bcq
         DmgxmVlJbAyb9mGkZXT9lfX/0VEwS2S8sIPEldJiY43Zcb0JeubJsLM8DZoGErATcX8M
         aK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26QxbXjs0m3B0fkeAQyxS9wdKxVZQIc+uM+Gzg+WrxE=;
        b=eAR+EOZMYbuKvdK/OogPULPevH+sDNJ3VFPvpN8B+LXslSd2C9ygpXuzIhJdR4DzQl
         ioyLmU+MAcs08xoMCksa7ReuHOc0qlX/pZvzckmZk5jSNH1D3hTq+tdX0YKhCrcWPljt
         bsQtSZkXKbIgsYgvdd+EpO0tLQJxOm/PlVX/DBjHWfC4aS5V3gX5AFSO1HBIVnQUjWkB
         i7VPww7C1zQehD1wblQIvyKLWQ5rAnFoy4qxKXzbpLjBjEqqwI/NWOReY5qKP/OwIb6W
         YuWWQolHsIAL2Y4dVZ3crqxVTocktfP2grvlDmUDaApPEABWtv6qJuTjdj99GfnJPt4u
         StXg==
X-Gm-Message-State: AOAM5321Oz7xQCOssVK0jV63TFvD0zeKK7rBKhjxJ0TJy5bYnN5IM6f8
        HYSpz7rdoJXXnkxg5j958AYiU4ZofkJfWg==
X-Google-Smtp-Source: ABdhPJzXNx08f0nZ6xcJw6hnAsHg+EfmelTxJ3ljsr5xDxklbhFCTqfDudRRdcHUuI/h2miSh0PL+w==
X-Received: by 2002:a92:c74e:: with SMTP id y14mr14195110ilp.251.1598461248027;
        Wed, 26 Aug 2020 10:00:48 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id p78sm1479606iod.0.2020.08.26.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:00:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/4] dyndbg: POC use dynamic_debug_exec_queries in DRM
Date:   Wed, 26 Aug 2020 11:00:37 -0600
Message-Id: <20200826170041.2497546-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tests/demonstrates using dynamic_debug_exec_queries() to
alter 2 drivers' pr_debugs without a user directly using >control.

For drm.core, I copied drm.debug module parameter model, adding
drm.debug2 as a POC user interface to control 2 pr_debug additions to
drm_printk:drm_dbg,dev_dbg, allowing both category and >control to
work in parallel.  This patch makes no attempt to integrate drm's
category mechanism with the "format=^class" callsite selection; thats
the "theory", but it needs testing.

For i915/gvt, I repeated the pattern.  I focussed on gvt only, because
it had the most compelling use of format strings as pr_debug classes;
~120 pr_debugs in 9 classes.  These are mapped onto bits of the param.

bash-5.0# echo 0x0 > /sys/module/i915/parameters/debug_dyn 
[ 3137.044185] set_dyndbg: result:0x0 from 0x0
[ 3137.044185] 
[ 3137.047370] dyndbg: query 0: "format='^gvt: cmd: ' -p"
[ 3137.050302] dyndbg: entry, buf:'format='^gvt: cmd: ' -p'
[ 3137.053331] dyndbg: start-of-word:0 'format='^gvt: cmd: ' -p'

These patches were the test/use case for-59 fixes:
https://lore.kernel.org/lkml/20200825173339.2082585-1-jim.cromie@gmail.com/


Jim Cromie (4):
  drm-printk: POC caller of dynamic-debug-exec-queries
  drm-printk: call pr_debug() from drm_dev_dbg, __drm_dbg
  i915: add -DDYNAMIC_DEBUG_MODULE to i915/gvt/Makefile
  i915: POC use dynamic_debug_exec_queries to control pr_debugs in gvt

 drivers/gpu/drm/drm_print.c        | 54 ++++++++++++++++++---
 drivers/gpu/drm/i915/gvt/Makefile  |  5 +-
 drivers/gpu/drm/i915/i915_params.c | 76 ++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 8 deletions(-)

-- 
2.26.2

