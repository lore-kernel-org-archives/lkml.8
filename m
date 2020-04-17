Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA848C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B2206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzJdlxNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgDQCOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:14:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:14:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so309537pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kmkNhZu3G0do3unomqn8DH1yVKZdDHa89wb0SDM+/40=;
        b=DzJdlxNK+Sz6qQK9ivqFoQJes9OZ2dFCv/HyBuq8tc/PXPgUptHUgiSLoZ1EqjCu4+
         Czlbsq4KPMBX1QSM9jmeLw/gARjbgRGSR5a+ejQq2pK9Rib4mfFX70mG/q+142NvGsbG
         jf8rNJkxY/y7AZ8J7NyvQEgDClxs87MMDOI5lCREh7Rq8/MySwa8/xTZ6Jy5h8ThMMpw
         8h8e3iA5aj0+aiIzXCUk4+QGaBQNMjNNT3gVg9RohNIRHorizuCul4ZJbDZu2joyppFZ
         rv8YQsch2ceaxB6z1imeCYo3k/9JTljQ3OGOFdkCbE887TVFRIaV5VjLu0KfaGDMXl7V
         AccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kmkNhZu3G0do3unomqn8DH1yVKZdDHa89wb0SDM+/40=;
        b=IvcaDF1DvHS50TWgd0hzRBPxR6x8v84qHzuPLEPeFS35JTSG/dbMveVKZaqStYD3bZ
         /Kfq4PjjRY8G/86aYwfiaeT5VtG+hGNZ/Jyhdy/KkWcs2j/SujjcETx7exCZPZHPtXI5
         9CZR1TmNzgnEcM7C59m8kXGinMyiBepgffQknHOUuUt5dUZe0HJjHd3RWRSLyYR4EwU2
         618/uVFPL/0U7se6mTgk7EN6sy973jzmVs6pXpqDD3UQSboDnZQJDCIeg365+dDfqKyJ
         obr+G7dVL3zLQadGrCIo+Bcba96EqTguaEyNzvG+TSJynhvitYyoXD/Rd7xfCLGtlaT2
         sbkw==
X-Gm-Message-State: AGi0PuZW9HRqTO1vo6vH2jUCZ1hTHdbeOz1yV+qxSVypMOsIxOa+Zljt
        z+PFzhdwshnkTuifZeWL/HQ=
X-Google-Smtp-Source: APiQypLg8au2ktjjEiO44yd88dEyuSacXyxW9fC1jM3s9vvQliwyYMA9XswCIowYnMHgvPfzDt3W4w==
X-Received: by 2002:aa7:9150:: with SMTP id 16mr871906pfi.209.1587089670283;
        Thu, 16 Apr 2020 19:14:30 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id h11sm18035319pfn.125.2020.04.16.19.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:14:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add new reg_update_bits() support
Date:   Fri, 17 Apr 2020 10:14:13 +0800
Message-Id: <cover.1587088646.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum platform uses a special set/clear method to update
registers' bits, thus this patch set registers a physical regmap
bus into syscon core to support this feature instead of using the
MMIO bus, which is not a physical regmap bus.

Any comments are welcome. Thanks.

Changes from RFC v2:
 - Drop regmap change, which was applied by Mark.
 - Add more information about how to use set/clear.
 - Add checking to ensure the platform is compatible with
 using a new physical regmap bus.
 
Changes from RFC v1:
 - Add new helper to registers a physical regmap bus instead of
 using the MMIO bus.

Baolin Wang (2):
  mfd: syscon: Support physical regmap bus
  soc: sprd: Add Spreadtrum special bits updating support

 drivers/mfd/syscon.c           | 23 +++++++++-
 drivers/soc/Kconfig            |  1 +
 drivers/soc/Makefile           |  1 +
 drivers/soc/sprd/Kconfig       | 16 +++++++
 drivers/soc/sprd/Makefile      |  2 +
 drivers/soc/sprd/sprd_syscon.c | 82 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h     |  7 +++
 7 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/sprd_syscon.c

-- 
2.17.1

