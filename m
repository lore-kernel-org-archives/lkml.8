Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDAC33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498F2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uZapQ+by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgALAQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:16:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35215 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbgALAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 19:16:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so5206647wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 16:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjUv0l8hskCQu/sfhTW+zT+JFalMEnxaLpHc5wjsSrk=;
        b=uZapQ+by1rty3HyhlkQGQkL4kSQRFma4TxmcNEsHnvBp7pkpTBMBX3vgVUMG3/IClu
         IdHTMtYLKZeVzzvg+Qfdyi/l7s5XskJDnMxZRuZsGRBMoTHlDD+YnLEQHQ5eS3CFXphI
         HIDuL1wMXLwd/+ib2+jlhodUqkboDBpYVhCZ5GkTDadamEcaOfwQJfCx6JGEM9subtBS
         xfJqEWOS4NkPl+/XTRZ0RgtsvZMJu96IjLswacwCUb09BNsTfFjIpPpEW6Fjh+gXEaQ5
         2Sm1qgWUR++mXkO7AZvhOE5GSRKeOomTQo9+/4P8ZcgDTlCPaCdNAgc4uKiDO5BU5VQB
         r3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjUv0l8hskCQu/sfhTW+zT+JFalMEnxaLpHc5wjsSrk=;
        b=Gm4o+wp6povyfSH2SqCT1zUjnU29LTkVTINjS6BUHUwyFrNiopMHNGHwPCeA5QLYBs
         ozufWLvcYoAxHE2Gd7plYzEfGKbNX4OirW57TolGEc5+GNsUXNufzEtKNNgdPlr0di7b
         zYzBKbqN7uFGOo3wVC01z4OqPbB80Ta4iQGUlvVB5z2FSi/AINOB9y22EfsdIZ2XyEqT
         9b4C2J+psGTBcp4sVrAGDJyOSfU3q8hBH20EZpsrvBEnkzKuaUGdCD7BwURdgY14qO86
         Ndp2V8mwGFp2pk+zKgNhW5qbMHo0NhoorTc4acDPATenYbR0WguiX/uGne/S2FvvEnCl
         VR/w==
X-Gm-Message-State: APjAAAWbxvMYtxbPJGtvhhWxq/BUqhiJ6ZKJDTeO8+M1pSCmIy3IjeIS
        ZKrnP4tC4F6sfw8CY+AF2e6ThgIG
X-Google-Smtp-Source: APXvYqwxgbwC6cX6oTmsyFU5iWJhMbjSDPZ+lTlZ+fPIHUdsXfTc9BQoIDqOEKQOSfKrzV9ga6hutw==
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr10795278wrr.104.1578788203919;
        Sat, 11 Jan 2020 16:16:43 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id h66sm8575535wme.41.2020.01.11.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:16:43 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, sudeep.holla@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v2 0/3] devfreq fixes for panfrost
Date:   Sun, 12 Jan 2020 01:16:20 +0100
Message-Id: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a bunch of devfreq fixes for panfrost that came up in a
discussion with Robin Murphy during the code-review of the lima
devfreq patches: [0]

I am only able to test patch #1 properly because the only boards with
panfrost GPU that I have are using an Amlogic SoC. We don't have
support for the OPP tables or dynamic clock changes there yet.
So patches #2 and #3 are compile-tested only.


Changes since v1 at [1]
- added Steven's Reviewed-by to patch #2 (thank you!)
- only use dev_pm_opp_put_regulators() to clean up in
  panfrost_devfreq_init() if regulators_opp_table is not NULL to fix
  a potential crash inside dev_pm_opp_put_regulators() as spotted by
  Steven Price (thank you!). While here, I also switched to "goto err"
  pattern to avoid lines with more than 80 characters.

Known discussion topics (I have no way to test either of these, so I am
looking for help here):
- Steven Price reported the following message on his firefly (RK3288)
  board:
  "debugfs: Directory 'ffa30000.gpu-mali' with parent 'vdd_gpu' already
  present!"
- Robin Murphy suggested that patch #1 may not work once the OPP table
  for the GPU comes from SCMI


[0] https://patchwork.freedesktop.org/patch/346898/
[1] https://patchwork.freedesktop.org/series/71744/


Martin Blumenstingl (3):
  drm/panfrost: enable devfreq based the "operating-points-v2" property
  drm/panfrost: call dev_pm_opp_of_remove_table() in all error-paths
  drm/panfrost: Use the mali-supply regulator for control again

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 44 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.24.1

