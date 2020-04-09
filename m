Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CCC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793B920730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgRZyxiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDII6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:58:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33647 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgDII6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:58:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17so4703477pgo.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pFn4OMnDDLKgXIP5nx2xdBewzGyuxCTnvHNcK/l63Co=;
        b=rgRZyxiGRReNfcQhXzvTpaRnHsy9eJajInQtX7EkOxSOmx1M39WdAbF+Fq0mwigk2o
         6ts80SIi33sfi/mrOBsTrHxypz2K5Ki5vTWCsbzWcJTRRGBlLdUKaaRuPC2X7YPS/tLG
         UEMfN2ZIvF9ZYZKbxkHCdOlKqVOGLaFHyo8ANPvc7cNJXw9JZKys9kavmgFWWxyXwdeD
         caehXiqEt897fjcwKCX6yZhO3T00pQwGOpfxqmgIwPTBowjBrPVpMXvT/kApytTpgRDi
         rkMHM5aWE8BomFudyUKcLeor0BXq2TD+3Drf9hio5xjT8pmOutMUqXtLFvasXvMKRg6k
         UVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pFn4OMnDDLKgXIP5nx2xdBewzGyuxCTnvHNcK/l63Co=;
        b=lj59mdS5pGxZg5eP7y9/spBXzlsQ4HB8RdZYP0SWmsTR1iXHBR2a/q9hJUKLYbIVWE
         9qSMnPqkbBx4NrLiLPcmiBHcOP23ly9FZQ1hr8mG6bljO4HCpFlSSsedwQcaAojEHPq9
         mcx2xw3MuQg6JDDNuFTjoWXHjk1bMlG8/ow1G8xAgJRkzrTaiuxedwc8kUmNI1cPP/mL
         4Q9MTqMw2YRs8WB1abmVcrJV8Ia+roHResfsqm5YsuY3+PijUBhpy5+UZ31P1CKWb/B6
         ux03vEjwkAq0b0jAryyD3UJo1PZzqC2XHOJ2tkoY+4dqw7nkD6lo95pB5IeiHEhNOo7p
         bQTA==
X-Gm-Message-State: AGi0PuYuRKPVLKef9KqPKiU9ELeyjCUHusem9P5OQrcTAqEdU0jcuxgw
        rP2lwrrTYkbrNqVeWFIAhrY=
X-Google-Smtp-Source: APiQypJOmGzkuHU/YaoCEAsdmObtSJ3dSROFsuLUgk0C5Ix1nKLezGXi18pFmcaeRExIjWmq1kvLyg==
X-Received: by 2002:a63:5716:: with SMTP id l22mr11039119pgb.164.1586422693333;
        Thu, 09 Apr 2020 01:58:13 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s9sm1561712pjr.5.2020.04.09.01.58.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 01:58:12 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Add new reg_update_bits() support
Date:   Thu,  9 Apr 2020 16:57:56 +0800
Message-Id: <cover.1586422035.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum platform uses a special set/clear method to update
registers' bits, thus this patch set introduces a new reg_update_bits()
callback, as well as adding a helper in syscon driver to support
this feature.

Any comments are welcome. Thanks.

Baolin Wang (3):
  mfd: syscon: Add reg_update_bits() callback support
  regmap: Add reg_update_bits() support
  soc: sprd: Add Spreadtrum special bits updating support

 drivers/base/regmap/regmap-mmio.c | 29 +++++++++++++++++++++-
 drivers/base/regmap/regmap.c      |  1 +
 drivers/mfd/syscon.c              | 10 ++++++++
 drivers/soc/Kconfig               |  1 +
 drivers/soc/Makefile              |  1 +
 drivers/soc/sprd/Kconfig          | 16 ++++++++++++
 drivers/soc/sprd/Makefile         |  2 ++
 drivers/soc/sprd/sprd_syscon.c    | 51 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h        |  8 ++++++
 include/linux/regmap.h            |  4 +++
 10 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/sprd_syscon.c

-- 
1.9.1

