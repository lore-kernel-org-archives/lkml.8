Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B01720848
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HmSGSlit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFJEwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgFJEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:52:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F467C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 21:52:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so452520pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62o4zuSkKEk/lqEK6BCZYnVbq5z1honlOGbIKeq6bQQ=;
        b=HmSGSlitfcOLJTWcy5a+DUJfOu4KF+p2nFfQSs61TLwjlZR7uZC0yZXNBx3TyWBzS0
         e10FLPDu8Rt6YgWhdpHXrJhlwLIS3crl/ve5HsSJkCRupvhsemu1acoqeCK+KrmC7lU4
         oaCgFR/OQoTqfFJkgpugH6CeWQOAmkWr8cqx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62o4zuSkKEk/lqEK6BCZYnVbq5z1honlOGbIKeq6bQQ=;
        b=ayxL7316J5oc4YKrrecu7FrHyc8OZ+ro8OYm0XTyzkRurc3xlIKRnYNAOo6lTKEUFQ
         rXz7+DVyP0KEwojJ3OSLzUPQ27YMYKFylQRAS9F/VTcfPCcJ26Vnclmmne8CvD4gYlf2
         gaeqkd34O3QP5VJgZ+xcP7zE2bZZUsiZeCeZYxS4ogkuIOeiotBuMccTrfwTSMWrDSvt
         uuFOfWPmvlzhPExVubYOQQIA3FHAFplT/BWVnGdf03EwuJeXJpPAZVcTlezQzzPDWuPS
         S5CYsEkm55DbswnR6ih6AzVChNV3DuE5ZfOH8ngcG4vCl5N8ddjK+9XQ7pV7ojLkgJ4H
         V6vQ==
X-Gm-Message-State: AOAM531wjB/ji1Dx3/tovSwxjwAaSSudH0vyUFL37otnkQfDSoO9YHka
        NEU/H5qncpHg40IA0jIYNUNfYQ==
X-Google-Smtp-Source: ABdhPJzyyBj41piy+zKuHU9AV3KKZZWDCXzRyq+Nnh1gfKm0UyKvsFf3aB1FBfGADti7p26pSq0ECA==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr1134095pgi.384.1591764746246;
        Tue, 09 Jun 2020 21:52:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm11550449pfd.124.2020.06.09.21.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 21:52:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Use __scm_install_fd() more widely
Date:   Tue,  9 Jun 2020 21:52:12 -0700
Message-Id: <20200610045214.1175600-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This extends the recent work hch did for scm_detach_fds(), and updates
the compat path as well, fixing bugs in the process. Additionally,
an effectively incomplete and open-coded __scm_install_fd() is fixed
in pidfd_getfd().

Thanks!

-Kees

Kees Cook (2):
  net/scm: Regularize compat handling of scm_detach_fds()
  pidfd: Replace open-coded partial __scm_install_fd()

 include/net/scm.h |  1 +
 kernel/pid.c      | 12 ++---------
 net/compat.c      | 55 +++++++++++++++++++++--------------------------
 net/core/scm.c    | 43 +++++++++++++++++++++++-------------
 4 files changed, 56 insertions(+), 55 deletions(-)

-- 
2.25.1

