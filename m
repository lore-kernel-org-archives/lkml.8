Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB297C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946A220774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnHPMiKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgGIL67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgGIL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:58:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967EC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:58:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so2013979wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gHgWXTMGTgSJ9NzYNTwxkcCv5i1cvCfL1OrkN27Xvho=;
        b=tnHPMiKoFwJCftAE8SCg0kw8XH99fwSKXcvrjclQk5KumZPLQx8iVZbjVHV01m5o31
         b7Ajh+U/4PD7rAc6ZOhSWoQaHUp9f97KeTfDZIwK2Ty9dTc+62IYRmUPf22orpGpxm0a
         eXacwtRdXeteEBT6ljePIFJsgtXHM8COLkEXPVSwQxguBgqaK0rQBlEouxg7ow+ob0rW
         /zD4eYoi+YVEJOsQrJXLKPGMUYpSxrZqEHXbEMBeX7FoGShcixB86bnOVYpMQoX9jFXt
         AjayRUt9ET3KIFz1nMOa8WLOMcCuILTPfTiS/uAMBAumBNj243HdfpxuGlSL0OTT6MQF
         okEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gHgWXTMGTgSJ9NzYNTwxkcCv5i1cvCfL1OrkN27Xvho=;
        b=P4LM98XMM5O0FBbjNBBqTAwCgHgER1IdKKcs2Vi+ttehVE1xvyZnlTWdUYrnliEyc6
         vxnu1AZGq9H/tgrcm0URqvwLu+12v6pNDQIqYhf60YxggOwXnd8Ss8cMyqIFAbtKmzYq
         Fuj+BYOkyJ14jEikNgiDjbbBIwDQKyXzmplg+9Nf0QcQv5vRuGHx9p81FNGQNKrw1hrJ
         F9D78/wia8wDcy8xXwpB7fyF4ShY5bqHUmE4t8wByHzgHqXdcviuuhc/bh/H0LWllKon
         BZ+GCegrxFF5tVxAZZdqay7vjSo1WzxDl566LF23qQdUQTDhgUbxRvh2OV06G8ZXHdCT
         TCZA==
X-Gm-Message-State: AOAM531kywdI//ILrT88qYNTaM8mvM4XTbOJXx34VddAVseTNQDd4twT
        tOhP4EjLn4A4pmItDiyTzt6Y6w==
X-Google-Smtp-Source: ABdhPJyCuhps/FwjgEGCNRrbS5o38e0SWuvhsNtaS+uo0Brld9JdD09WDpyF2aDUN4l3vMi+qlU9vA==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr59987094wrm.141.1594295937009;
        Thu, 09 Jul 2020 04:58:57 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-112.ip.btc-net.bg. [212.5.158.112])
        by smtp.gmail.com with ESMTPSA id v7sm5140737wrp.45.2020.07.09.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 04:58:56 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/2] Venus - fix firmware load failure
Date:   Thu,  9 Jul 2020 14:58:27 +0300
Message-Id: <20200709115829.8194-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These two patches fixed the problem with "failed to reset venus core"
seen with various firmware versions (including the one from linux-firmware)
on sdm845 and sdm850.

regards,
Stan

Stanimir Varbanov (2):
  firmware: qcom_scm: Add memory protect virtual address ranges
  venus: firmware: Set virtual address ranges

 drivers/firmware/qcom_scm.c                  | 24 ++++++++++++++++++++
 drivers/firmware/qcom_scm.h                  |  1 +
 drivers/media/platform/qcom/venus/core.c     |  4 ++++
 drivers/media/platform/qcom/venus/core.h     |  4 ++++
 drivers/media/platform/qcom/venus/firmware.c | 18 ++++++++++++++-
 include/linux/qcom_scm.h                     |  8 ++++++-
 6 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.17.1

