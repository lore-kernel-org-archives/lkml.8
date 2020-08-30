Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DBC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B28D20757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnGsN+gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH3OVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH3OUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:20:37 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8877FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 07:20:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p4so4014136qkf.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCiOSennHEZukxfKuX01u3ytG0Ubl4QOaKCxwhG2yKg=;
        b=ZnGsN+gbqSPwD6yKY4E8I5NhEgfpyl1xG1Is0GLTq7HoHPJB7S9tNM/kIxazTCXVSj
         Bq5etIIUKHsNf5KmC9DWx3Zc72MzsY6JOjfPdMNzMYlP0LGhK/o6XA01Ptq8YxCEg2NZ
         9SqrRUtif6kb4bXtK6OKawUE4QMOTAe5P4MBUZ8RKgcXL6UbMKvpLwmdTRm8DRbKP0cT
         0eOVyKRBSWW8OM+e98Uaty5uSd6ssq5TdKR3wq4gFMI1RUKpYFrRjWlq+RGd8ViDHbeT
         mbA2U0tAOt94E0WXZB4NQqKBTXPdQZWvYB/TwVbQUtWmw3qQEPK5F2wzNSRqHkf+qCLA
         T4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCiOSennHEZukxfKuX01u3ytG0Ubl4QOaKCxwhG2yKg=;
        b=A2zbPjSqsEv0QvJKpC671feL0tDRGgVpGsIW4D9CVYsey798L9oIYFiMg1ogR5LICB
         cny7vLLjcje9WsAJZwi1uKtxNF6MaSjuW12ggSTNI3uZmU9edWBu7l55F27s5XfzMo0v
         uyY+x1KajjO0afZJochK3VArg/yKnyhlZ8PfXRGYVtXdeNyxFPsCodeceTSFRk/EXXlI
         kZu+fm8WP0DVXAvA5/CTIDeMLWprQLM04jTPDTrpX49Zft7otr59SZ3nOaKs6XXvuAB+
         90RVxY3LKpobT1HuO43blpv44UgHUSUrTKe80wKXrK44MOkYlV+hNLHu//rE+SPMGFDw
         ZZ0w==
X-Gm-Message-State: AOAM530TXkLLXdtoeg7UGIs0gDPfVEitqnODZnYoHYR83ENi1u3UGLIE
        yJ++TNr+XoMN+AGbAMQ7Uf5zYfC4vR//FQ==
X-Google-Smtp-Source: ABdhPJz3R6QXaB8qksylHiEc4ZYhxpg+xWEWOwkAnGW9vU9BuqB/RCzwdzI1Cw9RO8pLZN9Zu4jKOA==
X-Received: by 2002:a37:4b84:: with SMTP id y126mr6824524qka.148.1598797234133;
        Sun, 30 Aug 2020 07:20:34 -0700 (PDT)
Received: from atma2.hitronhub.home ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id o72sm5884861qka.113.2020.08.30.07.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 07:20:33 -0700 (PDT)
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     melissa.srw@gmail.com, Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        daniels@collabora.com, Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v6 0/3] drm/vkms: Introduces writeback support
Date:   Sun, 30 Aug 2020 10:19:57 -0400
Message-Id: <20200830142000.146706-1-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the V5 version of a series that introduces the writeback support
to VKMS. The first two patches of this series are a pre-work for the
latest patch that adds the writeback connector, this patchset can be seen
in two parts:

* A pre-work that aims to make vkms composer operations a little bit more
  generic; these patches try to centralize the vkms framebuffer operations.
* The final patch enables the support for writeback in vkms.

In the previous review, Emil suggested multiple changes in the series. I
tried to apply most of the recommendations except for some suggestions
which I was not able to incorporate due to compilation issues, or other
suggestions that may complicate this series review. I left some changes
for future patches for keeping this patchset simple with the hope of
landing this feature soon in order to support VKMS user's requirements.
Emil, let me know if you want me to change any other thing.

It is important to highlight that from the previous series to the
current version of this patchset we had some changes in the VKMS that
made it unstable.  In particular, our previous writeback series stopped
working properly due to changes in our commit tail.  Thanks to Melissa
working in the instability issue and her latest fixes to VKMS, I finally
could update writeback and make it work again. The main update in the
latest patch is the use of vkms_set_composer when the writeback work
starts (enable composer) and after the writeback end (disable composer).

V6:
- Rebase and tiny fixes

Best regards

Rodrigo Siqueira (3):
  drm/vkms: Decouple crc operations from composer
  drm/vkms: Compute CRC without change input data
  drm/vkms: Add support for writeback

 drivers/gpu/drm/vkms/Makefile         |   9 +-
 drivers/gpu/drm/vkms/vkms_composer.c  |  98 ++++++++++++------
 drivers/gpu/drm/vkms/vkms_drv.h       |  11 +-
 drivers/gpu/drm/vkms/vkms_output.c    |   4 +
 drivers/gpu/drm/vkms/vkms_writeback.c | 142 ++++++++++++++++++++++++++
 5 files changed, 228 insertions(+), 36 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

-- 
2.28.0

