Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B962C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE932077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0n56T0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgGUKod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgGUKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:44:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E03C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:44:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so10524037pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pM7diVPVUVJFnX3JjthYlLq7pi8+2tPknNxtkHGEeQ=;
        b=L0n56T0u0TCfGUJhqs+tOv0+E29UAk68lxsMUas0btDkL7VxqLaMePegD1U5OC8nno
         Ufk6lSh8gA3i20rKPPgGpr1btdFqGU+9E0bww5FML2mTRWsNs62RXKjQ41tcaiDh5zTV
         UVmuBzuV0OdGni0S5W083vx/ir3+oauHfKFFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8pM7diVPVUVJFnX3JjthYlLq7pi8+2tPknNxtkHGEeQ=;
        b=uN9Y9HsGwkalkXjJaz90MfgBTu6SYvfNOj5u2KOYvt7zANS6ETGM6Jz0gF0MdxCyfs
         9oF86j2FhErY4awyo47vU+xcH7z2OJD25vAZOSc4QoEUGNHXVQwmAhMdpsE4jwGgwgB1
         c1wjXbUKMPzXw8ZunZaUEi/oZnspPM7QNMqKIpHRSLWT0p75qY4a/glr27I0YAxYt7zx
         BfycyhIJNvSEokY5KWBiT8LgTYPAul1WZnCUC7FkymSB9jjooX7jy9jcPtDRbF+2P0YF
         0hvGPfpO3xwuBLmFQyiJ1KcqlY3ZEhyWyHaRLAPQXMIUSumFqurP2TnNtdwjYGfZpCxy
         dNZw==
X-Gm-Message-State: AOAM533CXGfu9M7oQuzQ3gFAqTO1E0xHY3jzB0KAen79KljBWMtFOj/b
        hLiVcD0KT4Zq6T5v4t8GAEmb06kwlc8BgQ==
X-Google-Smtp-Source: ABdhPJzy2moU0arh3d1mHwle0rJ308kLKTkUSW99cDkJO2LHlDdkXjoTTq2PTxatNoI6fR9XCGpFeg==
X-Received: by 2002:a63:69c6:: with SMTP id e189mr21665505pgc.170.1595328271521;
        Tue, 21 Jul 2020 03:44:31 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id 129sm19419441pfv.161.2020.07.21.03.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 03:44:30 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 0/2] Add documentation and machine driver for SC7180 sound card
Date:   Tue, 21 Jul 2020 18:44:20 +0800
Message-Id: <20200721104422.369368-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note:
- The machine driver patch depends on LPASS patch series so it is not ready to be merged now.
  ASoC: qcom: Add support for SC7180 lpass variant https://patchwork.kernel.org/cover/11650649/
- The machine driver patch is made by the collaboration of
  Cheng-Yi Chiang <cychiang@chromium.org>
  Rohit kumar <rohitkr@codeaurora.org>
  Ajit Pandey <ajitp@codeaurora.org>
  But Ajit has left codeaurora.

Changes from v1 to v2:
- Ducumentation: Addressed all suggestions from Doug.
- Machine driver:
  - Fix comment style for license.
  - Sort includes.
  - Remove sc7180_snd_hw_params.
  - Remove sc7180_dai_init and use aux device instead for headset jack registration.
  - Statically define format for Primary MI2S.
  - Atomic is not a concern because there is mutex in card to make sure
    startup and shutdown happen sequentially.
  - Fix missing return -EINVAL in startup.
  - Use static sound card.
  - Use devm_kzalloc to avoid kfree.

Thanks for the review!

Ajit Pandey (1):
  ASoC: qcom: sc7180: Add machine driver for sound card registration

Cheng-Yi Chiang (1):
  ASoC: qcom: dt-bindings: Add sc7180 machine bindings

 .../bindings/sound/qcom,sc7180.yaml           | 130 ++++++
 sound/soc/qcom/Kconfig                        |  11 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sc7180.c                       | 380 ++++++++++++++++++
 4 files changed, 523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
 create mode 100644 sound/soc/qcom/sc7180.c

-- 
2.28.0.rc0.105.gf9edc3c819-goog

