Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F38C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F839206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DepxCFxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGPIIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGPIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:08:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04568C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:08:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a24so3316155pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q1NMSOrdmEBAoODvtBeWiT8XzpHbNfB6Y0FWPWAR6Ao=;
        b=DepxCFxm7ID3zD8asyMdeo2OHoYRep9fEEaBt1u31Rm+EkGIlRUZHG4m6dn/vzgXW4
         xiIdufe9s4RSt9eu4RvFRP6695QDvAHkwzRU2s2kQxHGdNF+TSccMFln30QwHjpjZCqn
         Qe8+9x2GOXHdLcV4zcQ4EcgLapnlyT9M6/CWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q1NMSOrdmEBAoODvtBeWiT8XzpHbNfB6Y0FWPWAR6Ao=;
        b=LdSfzB3z/MsTdab34c/KTt+NZ45f+OwsfstTBQ/6H3K/QjqatFbMvTv96O+QlGfSGY
         KuZpDFfFL9Cqnc+68GFK0qA0AC41N9lI/Bbc1ysBwXBZdotNJNWLSUStJtYcpnV7Q6+e
         kMTvGlEojizC1rP8jrMOc5YzGH0WGrmd9/8AedKkwMiF+4GyeUIEmtkwY8O/phKhrVUP
         5eVbMalQG0hhcYPS9SLsszoHviUh5Eo6J+XWQAEmBN6beQ/lkJGzmA3W0FfHWK2NBYU3
         nLZQSyQlHUbi2oFljOEXzRv8WU6Nu9LGSTX8vEqFe+4SgWX4F31xZ3FnISxKwpYS81Xs
         yFtg==
X-Gm-Message-State: AOAM532iP8nYKNqWtC4D/++JMhbzu48dBRWR89rNYcksAVE4zUgbPs0i
        3oMA3eab4b7F/oeR7jS3JExM8Q==
X-Google-Smtp-Source: ABdhPJz5dxnbGGR/Zl7SKoHACsCiYpWWIE1uv3TQqThSvMRdNM7XbkWBeI+Zu8/IQX1kEz+mVF+SqQ==
X-Received: by 2002:a63:725c:: with SMTP id c28mr3198841pgn.156.1594886927693;
        Thu, 16 Jul 2020 01:08:47 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a3sm4353085pgd.73.2020.07.16.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:08:46 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH V1 0/2] add PEC support on slave side
Date:   Thu, 16 Jul 2020 13:38:34 +0530
Message-Id: <20200716080836.2279-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for PEC on Slave side.

Rayagonda Kokatanur (2):
  i2c: add PEC error event
  i2c: iproc: add slave pec support

 drivers/i2c/busses/i2c-bcm-iproc.c | 50 +++++++++++++++++++++++++++---
 include/linux/i2c.h                |  1 +
 2 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.17.1

