Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D711AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C2020724
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwtX5+90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgGEMMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgGEML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:11:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2A5C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 05:11:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so35109730eje.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=isrInYoUXrbFffPc47IJyxGU9lKhBtrchnU6KHdwR2M=;
        b=RwtX5+900ZFC8SeHyTCdRlw3uUTyMSGBW7Q7hy8nF2oeq5HqT/Y5rxC1oKlf4+LTyh
         NpcwaASIJldFKLJa9sGubeQpgRm9FS1bAhwyZ7E1J2wX0Vh5hzKU3etEKoH+m8MRcBy4
         RUSqPUMGmFngCpVf79vVvoPXieVtbWUxevTsDyu2q4fsoIZHqE1qOofyp4FFbGsKuPW/
         B7bIi3NRRI3/u8iMOd03aTqKPpn7lhD6WOj3N76552CdNKuFS/406twIt8pORcbP1Msm
         9HL9fhDqLMlSD1OEcuC8rh1XeUGzCzVNXWOEYPK+C/9MGduuCXDO511fH5rs4S4W5sal
         +ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=isrInYoUXrbFffPc47IJyxGU9lKhBtrchnU6KHdwR2M=;
        b=bSzu2hEkzJeSaAuWNA5rFe40s7ys4Pft+oWnjjMLZzdAse2vY57CmuY4CH8h4b8G70
         H55dyRI8pTJj+DgcgF++HmHTLF2+VbHHL/xy5XyBwG+FBoWw4Wd5xUWYYy5F5MzNKHv8
         OUzjIPLXOUuAsOig5ZODK5sADk2jEMi7S0fmd6aY4fbE2Yzl4jJZb7tChW2EYuGNhnS6
         lcKut+HOF0Plb43mdhoQGkWu7m9SXGXvRgCRscCgdTFv6ZXPTocdjcYzSVv2d9lBiVXY
         T6IgJPkmUaWoGHBmpkZUywVFUyDeEzsTvzHxj9qzVIqEDmy4cGtYIZUKE6NiNEMX6L/D
         AurA==
X-Gm-Message-State: AOAM531IetdHJ084jZZaReyJCzXpPY7DmIsDRZMVaXDsbAsBpDM/2w9/
        pbXvIoyLo6A/t90hcyJ3dc/PiKFNUJpEjA==
X-Google-Smtp-Source: ABdhPJz7vzannraogjdgriWNq5/RhT6Q0BO5Oyk8QjUHuW2mXs/JhrqP+IIoHk9maSx2np3HDe1OxQ==
X-Received: by 2002:a17:906:1747:: with SMTP id d7mr31399376eje.39.1593951117954;
        Sun, 05 Jul 2020 05:11:57 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-133.ip.btc-net.bg. [212.5.158.133])
        by smtp.gmail.com with ESMTPSA id j64sm1517458edd.61.2020.07.05.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 05:11:57 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/4] Make Frame Skip Mode control a standard
Date:   Sun,  5 Jul 2020 15:11:24 +0300
Message-Id: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Suggested by Hans at [1], this patchset is promoting a standard control
for frame skip mode.

The original private V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE control is
applicable and can be used by Venus driver too (and probably other drivers).
In order to make that possible make a new V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE
standard menu control (a copy of the private one).

Also, to keep mfc driver backward compatible kept the private one, and mark
it as depricated in docs.

regards,
Stan

[1] https://lkml.org/lkml/2020/5/19/122

Stanimir Varbanov (4):
  media: v4l2-ctrl: Add frame-skip std encoder control
  venus: venc: Add support for frame-skip mode v4l2 control
  media: s5p-mfc: Use standard frame skip mode control
  media: docs: Depricate mfc frame skip control

 .../media/v4l/ext-ctrls-codec.rst             | 37 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/venc.c      |  6 ++-
 .../media/platform/qcom/venus/venc_ctrls.c    | 12 +++++-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  |  6 +++
 drivers/media/v4l2-core/v4l2-ctrls.c          | 10 +++++
 include/uapi/linux/v4l2-controls.h            |  6 +++
 7 files changed, 75 insertions(+), 3 deletions(-)

-- 
2.17.1

