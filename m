Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BF2C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B4B2071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNIfL1SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgCQJ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:56:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35464 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:56:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so4140868wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42N7VCrThrSwnkSNBM3TwhqhSUki2RBAuZUgm+K5p+g=;
        b=UNIfL1SC+aOa6Zm0P+hVXUd1/ygNCoESBkxcifAH83Cbzn36AWtIPO2KiDy93M4lZo
         Q0xehMTfsZ8yXtzsSVIoOSaLaijVy9lVIJHA0+lkrJFMUw+apKWzrQLTH+8v3ZVSCiOv
         9gCIA1EeffTbUZqYHfGEe9yXV2EBFzvD95YghA3MZE8egtxsLJI7k24l5r34B4v+6R0c
         6esTUy0MQkG+pvF7HC2Z9CMzgrEb7EGU50flb5vTnAoSTdmCZpDw2sarWESSXHva2dNn
         IUCAlTZ49e8a/iXnO49+6aecaX2j1u3M3FtSQtB0y7IvaaQNLmeqDcj31N9TngXujwg8
         qVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42N7VCrThrSwnkSNBM3TwhqhSUki2RBAuZUgm+K5p+g=;
        b=ZItcN/uapgEKWB6cGrDPbRMW55RXDTd9q95iTMlizpdVkm1Qfl3cMIXIlb3cyFNCJX
         R/2f5VPTMrVjinxyoanzHUblDLL2pa7zC/qRzBlN98JkA/rkqEIVf1P1RsTMJt8Hr/og
         CNujVYrB8pa8HrDXJLWjMjzuqT5vs8AR4TG8m5USxxvRvBESHbpSJzpJ8tZSCbv/DcOL
         5T+wTu7Mxs04EqHN0yKw5X+Yw7AAKJf2CnFhkSAXWfhbvrCfCOrmILMJC6P9cyMqjZLY
         F+LV4Ul/VkMsgCOUYyFAFASBzJarC002Lb32KZI1DTrqRl4jWtb8CwBFwKCl4/GNtAxg
         yFmQ==
X-Gm-Message-State: ANhLgQ0ww0YOqMj3CdwXwqLgz+Uc9QcM5lkOZpbPrwGSRElItGteCI+i
        UjOP++aWQpzz2nlLGr/9iwu69BS21eg=
X-Google-Smtp-Source: ADFU+vuEOv8DktK7HZpKYZKzfKWTTwJADXKyxrC6o1T4tNcFo4N7VZ+RX93SFmawI8izid9kdmDEqQ==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr4658525wrn.292.1584438970650;
        Tue, 17 Mar 2020 02:56:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a184sm3394970wmf.29.2020.03.17.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:56:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: sdm845: fix soundwire stream handling
Date:   Tue, 17 Mar 2020 09:53:49 +0000
Message-Id: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent addition of SoundWire stream state-machine checks in linux-next
have shown an existing issue with handling soundwire streams in codec drivers.

In general soundwire stream prepare/enable/disable can be called from either
codec/machine/controller driver. However calling it in codec driver means
that if multiple instances(Left/Right speakers) of the same codec is
connected to the same stream then it will endup calling stream
prepare/enable/disable more than once. This will mess up the stream
state-machine checks in the soundwire core.

Moving this stream handling to machine driver would fix this issue
and also allow board/platform specfic power sequencing.


Srinivas Kandagatla (2):
  ASoC: qcom: sdm845: handle soundwire stream
  ASoC: codecs: wsa881x: remove soundwire stream handling

 sound/soc/codecs/wsa881x.c | 44 +-----------------------
 sound/soc/qcom/Kconfig     |  2 +-
 sound/soc/qcom/sdm845.c    | 69 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 44 deletions(-)

-- 
2.21.0

