Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B212EC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BD72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkykLhU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgAMNWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:22:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41799 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAMNWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:22:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so8532474wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 05:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OvYQMaM+qpSXl2Z3EMu15jl+wVMWjq32vRPQAxhLSk=;
        b=ZkykLhU+OsnUN1GehXkbcpCYyeCOdnKd6x/WUPP3MD7JgzvICS+iQxO5b8v3hai3el
         6csFmPQpBEG5gLRECVAbPYdSQWgHWJV4mx3muHf2Di63wKiTAtxdTkpaSK8oaS91gqgL
         xVjlm/ZHg1TCJn2v5LcMNBB5Fy3uhp03mZkWQX9FAslcngPp5JdivcZWcMbMnhJH4iQn
         4ro3iEPaHKYI6XUuzEezt4ZvlcsU2I632TQcFZte2y6dk9i4XmRSwL+CCKqynPSQprmQ
         av7iDcqh4ZD8Gv6Lq3yZQwaKREtwAUy5NDSi/iYXGgntSp/t32wlkcj2cgy96neiOxas
         yBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OvYQMaM+qpSXl2Z3EMu15jl+wVMWjq32vRPQAxhLSk=;
        b=FeWgFLAyol2QHBZmDQHReQMrTGi43YI94h6wxdwsdHz2JFp56mSt82gcNvzhIS0Pb3
         o2bXi3p+enipDYmSr8CNJ3YuHuuLVZuTfYVPmlSvpvncqhqWY7hljqhRTbDg9X4UIr+U
         B4T4WfEy7wFXA2GWH43QxegJZw54WqZnOImhPqzzeCy+ExHXx7T8jQa+VTzJExIAZ+Pb
         a3QWXct1S0SayLhF+DZ+qn6SKjGVANLSo7UX8eSLC1cpbJqlpJWxj+jDjRLVpSFPVnpD
         muqnM7SS1BbadavK08Wk/ksI7oZZejdiQzOwbZatl3KBe6w3KM4sG8L0Iy6GJ1TIBCMc
         X9sg==
X-Gm-Message-State: APjAAAVjS2069GnmDpUPCx7DVAXQ/xGlpBSx0xkCFYfRwFo6D38t1Wj3
        BgaK96xDmLho4gkD5bxNdlmaow==
X-Google-Smtp-Source: APXvYqxdcQ2PDL0YCpFyVPDf3ql9zwKH6H5+6A68p38o4+HfpXHoYJM/8izNu9mByQSMjK7151oWMQ==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr18140793wrn.351.1578921725612;
        Mon, 13 Jan 2020 05:22:05 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u18sm14692987wrt.26.2020.01.13.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 05:22:04 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     robh@kernel.org, bgoswami@codeaurora.org, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 0/2] soundwire: Add support to Qualcomm SoundWire master
Date:   Mon, 13 Jan 2020 13:21:51 +0000
Message-Id: <20200113132153.27239-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v5 patchset.
Here is new patchset addressing all the comments from v5

This patchset adds support for Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
SoC and Lenovo YOGA C630 Laptop based on SDM850.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Changes since v5:
	-No code changes.
	-Add extra comment in interrupt handler as suggested by Pierre

Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 167 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 861 ++++++++++++++++++
 4 files changed, 1041 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

