Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD5C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE42220A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LXPAvTOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgDQSll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgDQSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:41:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36927C061A0C;
        Fri, 17 Apr 2020 11:41:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a25so4233880wrd.0;
        Fri, 17 Apr 2020 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fCasJ2C+JC/HUKeTPHMgTsMvggIkNTYgPJZjR55RsU=;
        b=LXPAvTODuV1mrN7GJOFr+aeOYLH/I4yhHZmBHhlvtFZi3pHvCGkvG371ONKh08DYBs
         0EQYOXKOXY6VDC87dCc0DQkR6gdnRcWmQ6XzatNBI9cibBQEWj8xf1hoAjfjqP2oTccI
         OtNXrfTchRt7BQmA6d15v0lzSaUxgkdEV0JUgEYnoMLlqSFqhZyDaY0sGVR9+RHKZiKK
         jXaIAbiV9NnrssX/9tq9BtOzZulYgXZoFTeTP57WOSNgeAZPHyXpKX4bhpUa8lplaueX
         SnirzxJglgw3QODNUjEkIplsRTLIE4VSx/R3SSid24vAn+i/CnAZo5l3ETMRXla5SLwe
         YkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fCasJ2C+JC/HUKeTPHMgTsMvggIkNTYgPJZjR55RsU=;
        b=sAV4BE9R3n7cB3vTBrgSJ472tc1Riidm4YDs8yst3ESm2jMG5reAQEntlFWCl2pcM7
         p650J5BciI7v5NRHHFI63QHFTOQVlEAX10O6MkF15UzwsjmVy7qCvP5bdenJicn0UnF0
         gq4N7fpCeX+orcbud9uoLtPZnQqt0QCKlq3U5gx5LJZFR0sVMQ++KTzEzCFLAM8ssmwU
         0/vSMDgGDst3uSdSlGBLrWN/NkQ5JUbVoKohTw1DKpZ+m7EJWpj3CrzWX0hVMspmTSr3
         G3oCJi+bnqCNSlMu0wX+dKJxDXYmSCI3sGin/sdz9RspYq/pQlHYwxOAkduETZYTt8kM
         p4eQ==
X-Gm-Message-State: AGi0PuZEukYrjW7hY6iINaUzKFlFcnt6y84g484+IUenS/1GVVU3d6xW
        pHyWDE6k2aZcBRogSocpDA0=
X-Google-Smtp-Source: APiQypIIGUhAdLJvQZMeRku+d4KFp8njsgQOIbIzXEqczaUyWySh9fX7lU1ILP8NotRqPUayjCIXeg==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr5298149wrv.314.1587148898835;
        Fri, 17 Apr 2020 11:41:38 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c17sm33237391wrp.28.2020.04.17.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:41:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] clk: meson8b: updates for video clocks / resets
Date:   Fri, 17 Apr 2020 20:41:23 +0200
Message-Id: <20200417184127.1319871-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first batch of fixes and updates for the Meson8/8b/8m2
clock controller driver.

The first patch fixes the video clock hierarchy. Special thanks to
Neil for providing a lot of details about the video clock tree!

The second and third came up while testing video output on my EC-100
(Endless Mini). This board is special because u-boot does not enable
the video outputs like most other u-boot versions do. However, this
is very useful for development because it shows (the hard way ;))
where the existing code is buggy.

The last patch is a small improvement for the VPU clock so we
utilize the glitch-free mux (on SoCs which support it) and avoid
problems by changing the "live" clock tree at runtime (with the mali
clock this resulted in system hangs/freezes).

In my opinion all of these patches - including the fixes - can go to
"next" because the relevant clock trees are still read-only.


Changes since v1 at [0]:
- updated the description in patch #1 to clarify that (it seems that)
  there is no fixed pre-multiplier for the HDMI PLL (like on GXL for
  example). Spotted by Jerome - thanks!
- simplified the logic for the active_low resets in patch #2 by
  shortening the if ... else. Thanks to Jerome for the suggestion.


[0] https://patchwork.kernel.org/cover/11489079/


Martin Blumenstingl (4):
  clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
  clk: meson: meson8b: Fix the polarity of the RESET_N lines
  clk: meson: meson8b: Fix the vclk_div{1,2,4,6,12}_en gate bits
  clk: meson: meson8b: Make the CCF use the glitch-free VPU mux

 drivers/clk/meson/meson8b.c | 105 +++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 32 deletions(-)

-- 
2.26.1

