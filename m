Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0287120857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="GqRCXCtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbgFXNoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388933AbgFXNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:44:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30464C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:44:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so1192404pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZgyeINKrMfCmStbrdGUOQJ0+zjYNUPFNiKqRfIX3gIg=;
        b=GqRCXCtmhr790iQkLEPF+dxbbHleFa77YD/V0YQYzUF0xkVahyK4lr9xnWX3prr8Cf
         NdLtJTlvJRrZgZnbd7+o36vnEtJ4gILevM5EcFc4yHG/wsCvHuoCUw5ag2Pz4/2iHzYQ
         aFdcVntvMvsb3TeNDr+gwLRYFPXEKKZNjTDu7nYQUcluvNWHr/B+UKmb9U5Itj+/issC
         H9Mp1Lk2kYDsswb4CPVJ6FW06WUI8SmLC3wMSkaCtLTlqzDRDgDQr5RKJwUv5KKEp+/q
         uHw1LXO8Eq60nSnXsYymhUBS5Bko5b+6TOwwYPvyJd5aGkiDqIxotb4PWf/HKQd01YiJ
         X4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZgyeINKrMfCmStbrdGUOQJ0+zjYNUPFNiKqRfIX3gIg=;
        b=VczuwBNcYwu2ri4mzscbxY9KoH559ca/kqKzdtJGO92XW94yUbVDOLOY3/Mlzf5BZ2
         RnojYh7w+z6zg05FTlW4YUsgHIjd7KPW+BGcw8yzsnVJxCuXI5VVCGVpXxOjkz7OFOMR
         3dRrtQ/Wzef+0yCdHWeTGv0pgavh5PVpfsVpRBU99lKkeB1jskj4LCcsKV+migBNXN9F
         xuK3+R7ki4xS2fk0nWCocP/XhFvRXcIBhxyXoojSwgFuQ0RU8byivH2NOvz/pPrGnpHx
         gDoWaK1VAmAnzyfObIhAVgT10KQ0dch0PMNggq0kndnPUdCj+4KI3y27no8NHdwqbaPA
         yyQw==
X-Gm-Message-State: AOAM533lqlINppbRBiADDxb1TYEXiyrFszkXgNZnm/G5WmLbKxw7vPvO
        EQFyh+V92SoTMzir3Lqr3HcQ0Q==
X-Google-Smtp-Source: ABdhPJwHuWdqFEDY82SpSbQpvl6saxB8SdggovAdmogqJvxM5hnncM5n2WedOVV60UIpPB2Ie9nGYA==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr20486811pgi.83.1593006250600;
        Wed, 24 Jun 2020 06:44:10 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([2401:4900:4174:4b69:7433:bb27:35ac:b181])
        by smtp.gmail.com with ESMTPSA id f14sm5526683pjq.36.2020.06.24.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 06:44:10 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        hverkuil@xs4all.nl
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v5 0/3]
Date:   Wed, 24 Jun 2020 19:13:51 +0530
Message-Id: <20200624134354.7023-1-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:
	- Add another patch which changes char argument to const char
	in function tpg_gen_text()
	- Return const char * from function tpg_g_color_order() in patch
	  2
	In 3rd patch:
	- Check font in probe() instead of s_stream()
	- Use dev_err instead of pr_err
	- Fix errors in commit message.
	- Base VIMC_CID_SHOW_INFO on VIVID_CID_OSD_TEXT_MODE

Changes since v3:
        In 1st patch:
        -Improved formatting of returned string.

        In 2nd patch:
         - Add CID prefix in control name and change it to a more
           generic name.
         - Rename bool variable to a generic name.
         - Disable text rendering instead of stopping stream if no
           font found.
         - Display more info like VIVID in VIMC.

Changes since v2:
        In 1st patch:
        - Create a 'define' to prevent repetition of the common color
          sequence string.
        - Use 'fallthrough' on case statement to prevent repetition of
          code.

Changes since v1:
        - Divided the patch into two patches.
        - Returned NULL for patterns whose color order cannot be
          defined. (Reported-by: kernel test robot <lkp@intel.com>)
        - Made separate switch cases for separate test patterns
         (Reported-by: kernel test robot <lkp@intel.com>)
        - Renamed variables from camelcase to use '_'
        - prefixed 'media' to the patches.

Kaaira Gupta (3):
  media: tpg: change char argument to const char
  media: tpg: Add function to return colors' order of test image
  media: vimc: Add a control to display info on test image

 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 39 ++++++++++---
 drivers/media/test-drivers/vimc/Kconfig       |  2 +
 drivers/media/test-drivers/vimc/vimc-common.h |  1 +
 drivers/media/test-drivers/vimc/vimc-core.c   | 10 ++++
 drivers/media/test-drivers/vimc/vimc-sensor.c | 57 +++++++++++++++++++
 include/media/tpg/v4l2-tpg.h                  |  3 +-
 6 files changed, 104 insertions(+), 8 deletions(-)

-- 
2.17.1

