Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C17C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D197A20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AqggFN8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGBVKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:10:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D5C08C5C1;
        Thu,  2 Jul 2020 14:10:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d15so25465805edm.10;
        Thu, 02 Jul 2020 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMMZeMekPlUSX+JF9c7HvEacEENZnsooe/NRWDvQrAE=;
        b=AqggFN8JiAsoOw0r39Vxw52DZOe5atKToV2hkLgLPMIZLV+cZC86GBHZfZSoWMQG7P
         OpE3NwNDUvkR//PVAyDevl4x56U3PMrYPLBCn4D8Lh0Dezu0qfD8yf0yA3i+3RbaJqnQ
         uaiaLdjKaXalII6tcWFtEiqgzrbyxEgtrUhfVmHx0MhHb9q/IM4ySNLB+n0R69oB56uq
         EnB/4MK27TBG9yHQIMLK0Y7ByhzG0I5vQmUC4UESSARIKccDtrv+QkV4GRaTdQGvisAY
         Jnw5/Fcr3KsBEzBt3SVCAIVPbsxKsSS2AaPbT7yWYcCjcDRYK75UVXm0tAaWwJLe3nYf
         DkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMMZeMekPlUSX+JF9c7HvEacEENZnsooe/NRWDvQrAE=;
        b=F47VR3Hopg1FOTP4/liVEVLoIQvxJ++1yXmrfvaNM9UcP7NP+1Ck8zq0itCDBUgU36
         dGVb6G+HX/NBLNPllM+e8BZnP1dEawK4W72G6Qf4XVxCAPVATltxHD0Dp1/QHPIC9+I2
         Hz/WvpbGWqKnQia1Imo6PRXx9h9Z3FSp39JpRkHyoMrcYvbFFiHOQS/54Oar2GQFWh6h
         wHEdu9ccd04Lh5yVhliKITjHfKb+O2M4cCDx90u6RiajDpMxS8eyFgnC9i4eKs1J6kcj
         ENH2869suifJJyeVa21gF5UfI7FBvo7/a31fKnNlp3GHAjjFmcJ9qkVDpjY9ae7m2H+e
         /AOg==
X-Gm-Message-State: AOAM530p7AM9rtNLuUpS6+yqQUDZ9hXdAG40lDr/yw2y0KWKFmibBex0
        aRd2FGc3kJm/OCTGOYX+zLU=
X-Google-Smtp-Source: ABdhPJxFez8jo3It6BcvPbEYW2ZMkYn0/KgPNFMjPxmDvd1xIfuEwnJdVxxm1e9l7PGa5nU7Dim1pQ==
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr35587454edr.381.1593724229470;
        Thu, 02 Jul 2020 14:10:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:bb9:bc00::fc])
        by smtp.googlemail.com with ESMTPSA id x19sm10176353eds.43.2020.07.02.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 14:10:28 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] regulator: Add FAN53880 support
Date:   Thu,  2 Jul 2020 23:08:44 +0200
Message-Id: <20200702210846.31659-1-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a regulator driver with dt-bindings documentation in
the new yaml format for a power management IC from Fairchild (now ON
Semiconductor) named FAN53880.

The chip was found on a camera sensor board which will get a v4lsubdev
driver in the future.

The FAN53880 differs a lot compared to the older FAN53555 which already
has driver support.

Changelog v1 -> v2:
 - rebase to current linux-next and adapt by
   s/struct regulator_linear_range/struct linear_range

Christoph Fritz (2):
  regulator: fan53880: Add initial support
  dt-bindings: regulator: Document bindings for fan53880

 .../bindings/regulator/onnn,fan53880.yaml     |  85 +++++++++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/fan53880.c                  | 179 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml
 create mode 100644 drivers/regulator/fan53880.c

-- 
2.20.1

