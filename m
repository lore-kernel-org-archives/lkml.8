Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C56D207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXPbcL+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgIAV7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgIAV7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:59:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A8C06124F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 14:59:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q1so1297978pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rnwj2YW6I8HLfDh0uPTOzbh/3kFrbTfzm4Bn/WyYBA=;
        b=RXPbcL+/x/0/MCRLgV/vAAejfDzweAhJZwltTuPOwujDYS6sVTZv6LcDC0toDGfsR5
         27pTZsYznoxtJo9BWxj3FqS06iQt+BCkzz4EzmAtE+kXFe26jaN7/pwok/7gmxRtKHfG
         Pu6xK0H/CaFc3L4FSKt022kwlnRYfZVf6g/HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rnwj2YW6I8HLfDh0uPTOzbh/3kFrbTfzm4Bn/WyYBA=;
        b=H7tQ9Ct7K606z3DNnhvOwfKcaPWaT7sc7mnOpWPfHHtB4S9R8OdC7RStgscW9I2C9e
         hng7e9EFV0x6tGsbY3/f7E87ZfhfUTA4+e8DQKI/m3jmdz4X76uyzmTyn5Z9O8srmmSO
         Gqy/nJ+EVx5irKPgOjvbPpq+9UD5kn2OWxr/6Y8YJh3KW/PkSb+Z2vrl9y74S6L1qiht
         zJ3D9SCfmmdpAMpw4YCsD4I3OB6PPfbMcVjsaub7iJ/Km4HnNx3/w+zfqhYt/GhdXHDN
         kLuSka9bpdxRkj05zEEw94CDFINBiIEWJLZtFLscGySlUc3S9t6zgfM77rTPLLPExnL2
         /CDQ==
X-Gm-Message-State: AOAM53345H2kRkSp61c1eTHTcOsp2DXtcAdlKFrfkUmM4d/SVkSVRfiI
        O/akwxG19W1VpJL28gvlCUpxzg==
X-Google-Smtp-Source: ABdhPJz9RPfwEsuY9az8y012sHdT37924RbixUIVrrwiv3YuNEPc599qRWWZD3WwDHJJOHxIT49HpA==
X-Received: by 2002:a17:902:7b8a:: with SMTP id w10mr3245995pll.145.1598997583989;
        Tue, 01 Sep 2020 14:59:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q5sm3044037pfu.16.2020.09.01.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:59:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/2] A couple drm/msm fixes
Date:   Tue,  1 Sep 2020 14:59:40 -0700
Message-Id: <20200901215942.2559119-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small fixes for an UBSAN warning and to make debugging a little
easier.

Stephen Boyd (2):
  drm/msm: Avoid div-by-zero in dpu_crtc_atomic_check()
  drm/msm: Drop debug print in _dpu_crtc_setup_lm_bounds()

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
Sent by a computer, using git, on the internet

