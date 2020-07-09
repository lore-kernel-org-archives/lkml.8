Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463CB2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqrgBYRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGILHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGILHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:07:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0230C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:07:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so1879684wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dj6DLJ5JhwDTZpg1cYa8Jkc5nI2WU1SZemCOoY6JQX8=;
        b=OqrgBYRSXu4WOjIThWIY9Klk6Hlc6dgDpPB9PYoq4FN8And4dQWC6+puoCGj3yaq75
         j9q0lGCyqBZQAkZwJg6iiss5/kkNG0TMRYOMDn2LRE9RL0Fe4cbltQomN4Q6xNZ8XM1y
         re+ahL/J+J6C2CSXl1lvfk3EanLYT8zGvPefqudhF4HJ6ITNyEid5gMvuSetJy9BPj2p
         3GgCPuRygIdzH8PlHJiavWAC7FfCR4oIxpqWyH1ppd0AiZBBPlD9OJDYggTka8+Dn1Gi
         U9VYl73QdCyTZ7t6ZlYL5H95Kky8L+P+kd+nXkQdlWraeb6wVviZK9S6pqLqQjH6EMp4
         hu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dj6DLJ5JhwDTZpg1cYa8Jkc5nI2WU1SZemCOoY6JQX8=;
        b=b/iewPC1Zs7SbqFH4jpE0GrVsFHY1Gf+jWhsfbu9u72p+AykLBmGVmxUM1tfEwLszf
         RzDznIzMWA7bPQowgJ3CFwLk+SQpgNSeeMEu8ylaCk7iWbN+ez39UgpMXS7Z8qRxfc7n
         +6ecKpXltyF6X8W7yvZCB2UV3Rma4K8NxdmQCEqrMkBrfawAL7viiHnOSFFfXGWb18AT
         OsYlX+cpq9/3qFjppyXc5pauD9HFt62s74U4NuyJzfmNgkYVFCV0MWjJIwRErACK+X4D
         dZq4Ntzpe27ctQOkZpw8xSSZQbe7l3UcZczIKPwx/h5IqjcKhRBsYDTdDqSBWrDkVylc
         qo+A==
X-Gm-Message-State: AOAM530Gv49tTdHXVHKBCdBq00sUnBlj/UTPTZWebFYz6PH/29lHlcqH
        6Vbo8jhVLiD7q5DexbsmJd+Bsw==
X-Google-Smtp-Source: ABdhPJw0n0b9xmJ1DTGx8Qu+06hCLhlnCq+s0l6b+Go1hvpg1cmoxac2TKGjZrYL69bFn2sVkH5Nbw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr61842492wrj.273.1594292829308;
        Thu, 09 Jul 2020 04:07:09 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q7sm5375578wrs.27.2020.07.09.04.07.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:07:08 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add interconnect sync state support
Date:   Thu,  9 Jul 2020 14:07:01 +0300
Message-Id: <20200709110705.30359-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bootloaders often leave some system resources enabled such as clocks,
regulators, interconnects etc. We want to keep these resources enabled
until all their consumers are probed. These resources are often shared,
so we must wait for all the consumers to come up, before deciding
whether to turn them off or change the configuration. This patchset is
trying to solve the above problem just for the on-chip interconnects.

The problem is solved by allowing the interconnect providers to specify
an initial bandwidth value, which is enforced during boot as a floor
value, while the requests from all consumers are being collected.
Then the sync_state() callback is used to signal when all consumers have
been probed, meaning that the floor bandwidth is not needed anymore and
the framework is ready to re-aggregate and process all requests.

Georgi Djakov (4):
  interconnect: Add sync state support
  interconnect: Add get_bw() callback
  interconnect: qcom: smd845: Use icc_sync_state
  interconnect: qcom: osm-l3: Use icc_sync_state

 drivers/interconnect/core.c           | 57 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/osm-l3.c    |  9 +++++
 drivers/interconnect/qcom/sdm845.c    |  9 +++++
 include/linux/interconnect-provider.h |  5 +++
 4 files changed, 80 insertions(+)

