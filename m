Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89897C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28260207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsYiEwdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgIIQNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgIIQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:09:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E88C061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:09:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s12so3559181wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqvVgirpM6FcpEhiJW0dwGOjpamDWw9ATf2Cobutv9Y=;
        b=bsYiEwdDCWH1+GY6Ya0Vfsj5+3/XLdf5eYSV9fRyVeH/V5maqQl5klvHrG/A2oQO8M
         MEIdycn++NwTJFZMuZ5fxMC99J9HRbk7O2kqaTZYhzq/1mxsGo36p9rXDw4o4epQn3er
         E+r+rqsuqwgidI0Zpcyn22P2aafSY+07e4xsFGNy0/N13L4+dkUrlw+s71xlTXTBxk9v
         GZC7R0e8wmysObKn9KNxYEBLsxPCY7y4FfvCblKXIv6Ju6KgAEBkhFxNoumHyhXULkZK
         /5wz5rSCP35sVq2Foz7t6K0zJlpcCXT6leCycutIyiyPqaZq2LjG1z6MziJI6RKE1y4P
         i+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqvVgirpM6FcpEhiJW0dwGOjpamDWw9ATf2Cobutv9Y=;
        b=f52RzMGZcsZMmfGJc0wdQJ7/P1ISym1kS4zuYFWfl9kdm71rNCjxCfR1ryNO6d1mvr
         ZPX6wJ4UqUp98BfUTuGvLCpg7Ir+COmx6gNI9jCQCVXEZ2hn3dweDWyUGC4Qp/WvhRXs
         X+EOy1VBb/1Yp8c8xtkp0vc6zIjd7ETgugX9iSOif1rfoA/2Ri1LTkxhIaFtQkN/E3D9
         t5o70JLu0Mqva8Z9BzX4BOF07JxemPHqVdNGnMdCFy+V2Q7oueODoQKmucqJs8Ysob15
         le4IviKt/9EeNxC4GRFhihsddJRnUK2KG69qJKBzJN5o8IEP/O8Kg45q0svvX3niEy3Z
         zHeQ==
X-Gm-Message-State: AOAM531BwS6jAC/Pb6OtZm7yITp+YAQPiygiX4h+QmXfcu0BQT8NIpy9
        wonZ8uvu2p1+a/r4E4wwvt4j9Q==
X-Google-Smtp-Source: ABdhPJzpMD92uBIiFbI1aAqFUlENX3HPsLiUOaHzzQvuLF521tmKbIz/BFC6EEhrwIgeeH7NHVKN8Q==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr4535198wrl.401.1599667761040;
        Wed, 09 Sep 2020 09:09:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k22sm4900824wrd.29.2020.09.09.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:09:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] soundwire: qcom: fix IP version v1.5.1 support
Date:   Wed,  9 Sep 2020 17:09:10 +0100
Message-Id: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing Qualcomm soundwire controller version 1.5.1, found two issue,
Firstly the frame shape information configured vs the bus parameters
are out of sync. secondly some ports on this ip version require
block packing mode support.

With this two patches on top of https://lkml.org/lkml/2020/9/5/220
("[PATCH v2 0/4] soundwire: qcom: add support for mmio soundwire master")
patchset I was able to test 2 WSA speakers!
This patchset depends on this above patchset!

thanks,
srini

Srinivas Kandagatla (2):
  soundwire: qcom: add support to block packing mode
  soundwire: qcom: get max rows and cols info from compatible

 drivers/soundwire/qcom.c | 68 +++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 18 deletions(-)

-- 
2.21.0

