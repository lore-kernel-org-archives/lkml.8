Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA32C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3C020734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOuc3PNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgFPMbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:31:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3543C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:31:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c35so14125468edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/1r7CkWYB3PvqDAm7Ot1fK+BdMOnYVR/V3utAsyrDz0=;
        b=aOuc3PNIXOscLHviWkmoerLaHV3t0vKE4OF+G+AsWn4rC9b6olH2lm6AItsGUbKi/e
         Qzelbl0GduFV1NbJPGME4+loz08IxPVRkUH1xpD4JrgFlmHcaVGUwM2yAM3R52OLybtF
         AJVq5Eiv9mPIPfNpHuY0o242bSrKMv7yzzPZyBqYTSQ/LApa/njqHNMD2JXQb4wlJN3+
         aTLfGbnILz6HCmPbJtPqHK2We/agFZqzcbUkP7Y+Gyy9po2YGEDFCH8f9RPe3aG2Ak8H
         oHX3AQbe7oQ/qyRukBnOKPINVdsAWs+xEbGe6RatIhDl69YPNnR4g1I3TY+BUWJxuJyJ
         7wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/1r7CkWYB3PvqDAm7Ot1fK+BdMOnYVR/V3utAsyrDz0=;
        b=bNFQo2EtPo4fdCiK6Jbf15t+/j/dTVn4FVUEFnLlejQFsEYnNFFRAUBCzRvRhkVLJ/
         CcGTu2AlO1E7GXu688KhnQaxsuiYS4d9hCZbTT3Rqdcb2+Is3jlB+5gGvsxXtl7KFZFs
         Z81Yz3iZenzv2wO+7mipixhbcWhfhHBXdoMQm0AKRG1ffqCM0eJq7QUPBZHkY/6Bj6EY
         sQYBWrB7xhyaJ04d8RiiaS44ftdzwUc2Px9ETs7meTrHTt3VLccfMlbgklA24DQzfBSN
         bE2r0NhNuQCdpKAoCnFSVoOb5P0x4rNFDR6seX50n0x6jkc86QLR2j5LKGmiUPc0bJOY
         JIAQ==
X-Gm-Message-State: AOAM532WfEX0/BdkZCIR4Y5meCKagfd53aP4DDiTD2nxfNIadspFzaE9
        A956Py6IIda1JnBVrCP8dWsaCQ==
X-Google-Smtp-Source: ABdhPJzmX15Wn6UYFFsYF7DAkg/UYOnitBPHj6tHLVHQjeJ3Qti/lxHyPAuPlMdMfPP80Lw50X1wzQ==
X-Received: by 2002:aa7:c6c7:: with SMTP id b7mr2324483eds.213.1592310690397;
        Tue, 16 Jun 2020 05:31:30 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.gmail.com with ESMTPSA id p6sm11071983ejb.71.2020.06.16.05.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:31:29 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/4] Add two new v4l controls and implementation
Date:   Tue, 16 Jun 2020 15:29:57 +0300
Message-Id: <20200616123001.11321-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here we add two more v4l controls:
 - V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY for encoders
 - V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY for decoders

and the implementations in Venus driver.

The original patch for CQ from Maheshwar has been rebased on top of
current media/master and the comment from Hans has been taken into
account.

Comments are welcome.

regards,
Stan

Maheshwar Ajja (1):
  media: v4l2-ctrls: Add encoder constant quality control

Stanimir Varbanov (3):
  venus: venc: Add support for constant quality control
  v4l2-ctrl: Add control for intra only decode
  venus: vdec: Add support for decode intra frames only

 .../media/v4l/ext-ctrls-codec.rst             | 19 +++++++
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 49 ++++++++++++++++++-
 .../media/platform/qcom/venus/hfi_helper.h    |  4 +-
 drivers/media/platform/qcom/venus/vdec.c      |  7 +++
 .../media/platform/qcom/venus/vdec_ctrls.c    |  9 +++-
 drivers/media/platform/qcom/venus/venc.c      |  4 +-
 .../media/platform/qcom/venus/venc_ctrls.c    |  6 +++
 drivers/media/v4l2-core/v4l2-ctrls.c          |  4 ++
 include/uapi/linux/v4l2-controls.h            |  3 ++
 10 files changed, 103 insertions(+), 4 deletions(-)

-- 
2.17.1

