Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96114C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FA9206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0ofS/aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406161AbgE1TGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406145AbgE1TGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:06:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11A3C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w131so1175634ybg.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jNrkMDSm2a3g9KtpLe7KgeCtzc8cowZQZq1lrqvPxzY=;
        b=C0ofS/aAa22h17L1LGSxrKfq/1l9+vUVjrPSSB6cCF2MHDvMhYo+cUPQItkxSsEdBv
         Fwh64qEPBurjme4nTeCUUSos8M+bEggtIDWr1E6Q+SmWjjnpGV9xVrPW1HZK6D7oTjIT
         WV1ZllvjMt01FMiyDPrvUHMPj1oWDtExytKfmXYjBc/NUTqRUBBlubkOhOSMbaYSGcGS
         yxCPtVf1ajGIudq+OvrH7MS2Vj4lXsk6aK7EclNT5HxrKqgy2j1uGzL29ye43dBT+oe9
         JOiJVqJ79+sNTMr+dnLkUhvwCIqGsgxu/xANldqFiUtvpvxgRNA9BmKrVGZbU0c9hN4k
         hBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jNrkMDSm2a3g9KtpLe7KgeCtzc8cowZQZq1lrqvPxzY=;
        b=XY/W6m6V9dof0WaMfqksFRkb+Mm7my6TDA+V98s/wXwyw6RJoLRU9G02HSmJxmYcKe
         NT+aFvbcoBW5qNBHz7P81aiMUl3hAC1be3WoblXKvoq0piEaDFSlkKpsYl1PPXq3zrQ8
         9dJsjFq8WjHlJrAurPNB36R8g40iHUkqW44dtyWvrUWND4LvW47HvVZoi0phZkW1yYMZ
         inR+k/w6OivaS0QFv62JtAFeN43rb2xi0YiSz+E9oFq74mUI1nBqQMP1uLFI+DVZhXCT
         QxQq8+D8O6dBWvzsltSFs9xcNfFB3ZVAhvk32OWfgMeUI3k2zObkX82zbO6HJ1OvaI3+
         /HEA==
X-Gm-Message-State: AOAM533g+1Zxo4O2eq0TUuv0nUg7cTpbwXnW9wophqpazCaWSGLgJLea
        45p0vyRGTYxOAwE63xj9VCKsl9kZqZDuwc0=
X-Google-Smtp-Source: ABdhPJwJostfG0a0MlQP/CwQMIt8iKPpvOHvaOGlgohs1ifcTDs3afH+1n4nFeicMMZyxnHBbCG5KzE3gdUDe/o=
X-Received: by 2002:a25:13c1:: with SMTP id 184mr7168782ybt.259.1590692773882;
 Thu, 28 May 2020 12:06:13 -0700 (PDT)
Date:   Thu, 28 May 2020 12:06:08 -0700
Message-Id: <20200528190610.179984-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 0/2] regulator_sync_state() support
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Poorly worded subject, but patch 1/2 should give more details.

The simplified explanation of the problem is, for regulators left on by
the bootloader, we want to keep them on until all the consumers are
probed. This is because we need to protect consumer-A from turning off a
shared regulator used by consumer-B. Once consumer-B (and all the other
consumers come up), they can do it themselves and the regulator
framework no longer needs to keep the regulator on.

So, this is not just about module or device probe ordering between
suppliers and consumers. Even if we get the probe order prefectly right,
it still won't solve this problem.

We can eventually extend this to also cover voltage and other
properties, but in this patch series I want to get this right for
"enabled/disabled" first.

This patch series also has the additional benefit of turning off unused
regulators that are probed after the 30s timeout that's there today.

v1->v2:
Patch 1/2
- New patch that might get dropped based on review.

Patch 2/2
- This was the only patch in v1
- Made the late_initcall_sync timeout a commandline param
- If timeout is set, we also give up waiting for all consumers after
  the timeout expires.
- Made every regulator driver add sync_state() support

Saravana Kannan (2):
  driver core: Add dev_set_drv_sync_state()
  regulator: Add support for sync_state() callbacks

 drivers/regulator/core.c         | 112 +++++++++++++++++++++++++++++++
 include/linux/device.h           |  12 ++++
 include/linux/regulator/driver.h |   2 +
 3 files changed, 126 insertions(+)

-- 
2.27.0.rc0.183.gde8f92d652-goog

