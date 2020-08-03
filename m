Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FB32075B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XG70c2Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgHCEBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHCEBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:01:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD2AC061757
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:01:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so17491695pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yUG9PDflOauUKzeZLQPLk7LHLARUNdO3mRXIHJ6GORg=;
        b=XG70c2DzrXSTp1PgC2bTrPGff/xoNe8pEiCz7UiDz9MjZ7Y/JT47wKDfmfgEUueSkL
         qwMeZhxghrcqQIHtk34wJDKqi8XNeEX3B+7D7x6fwzEE/WEqk/1lVJK6/K+rGCNbzqhI
         6XIpXpR2j5TlclO8OuWLugFNhNGwqg45eVJ50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yUG9PDflOauUKzeZLQPLk7LHLARUNdO3mRXIHJ6GORg=;
        b=TunID+r8i4CS++72ijZvIe2g0v3cCg8nBAEx8NT0eATzNlSQbD/BIoD3jQK4FyK0P9
         gmM89CUvwaOdgRG7dd4FaFp1kM7K1ueB+cj/ThjPz/U8aOrEj1e4YW1yXc5IyrbnUOCc
         srJ69ZlrvFyAAS1KyZgKYuAzZg5vdDEMnFFGmihIcXdbj7RMc7vPeTio6vHKRLP+DpPs
         BsEh4EH4BIrVEfKv9YddnbCJI4XgazY2UF3IEu8tbySiczHQghBBkPzlhdWqme+R5O9x
         lRNNs1mg5w6BL/lAxvon7LnfwUk76jlmLogj3A76DPWd33LuR7+/XUaBm4kzrliafQQL
         DZKg==
X-Gm-Message-State: AOAM531XdVThohknYYR/ikeZriN/ucC3NiOR4MyfBqmqvqzBmJg6P+No
        wqGBx+Z0E5ZzosGor+07V25Ocy2iu+p1vg==
X-Google-Smtp-Source: ABdhPJxP+lh6ND1hcM+YIlREZCHSyt0Q+gl1D1E1/uP+/wpTAUIj2z3wimskpD5Puv5muq8X44ygHw==
X-Received: by 2002:a63:1116:: with SMTP id g22mr5535601pgl.257.1596427291773;
        Sun, 02 Aug 2020 21:01:31 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id r6sm10440146pjd.1.2020.08.02.21.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 21:01:30 -0700 (PDT)
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
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v4 0/2] Add documentation and machine driver for SC7180 sound card
Date:   Mon,  3 Aug 2020 12:01:20 +0800
Message-Id: <20200803040122.2063634-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note:
- The machine driver patch depends on LPASS patch series so it is not ready to be merged now.
  ASoC: qcom: Add support for SC7180 lpass variant https://patchwork.kernel.org/cover/11678133/
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

Changes from v2 to v3:
- Ducumentation: Addressed suggestions from Srini.
- Machine driver:
  - Reuse qcom_snd_parse_of to parse properties.
  - Remove playback-only and capture-only.
  - Misc fixes to address comments.

Changes from v3 to v4:
- Ducumentation: Addressed suggestions from Rob.
 - Remove definition of dai.
 - Use 'sound-dai: true' for sound-dai schema.
 - Add reg property to pass 'make dt_binding_check' check although reg is not used in the driver.
- Machine driver:
 - Add Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

Ajit Pandey (1):
  ASoC: qcom: sc7180: Add machine driver for sound card registration

Cheng-Yi Chiang (1):
  ASoC: qcom: dt-bindings: Add sc7180 machine bindings

 .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++
 sound/soc/qcom/Kconfig                        |  12 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sc7180.c                       | 244 ++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
 create mode 100644 sound/soc/qcom/sc7180.c

-- 
2.28.0.163.g6104cc2f0b6-goog

