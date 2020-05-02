Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8525CC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E1620757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMJcy3JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgEBTbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728052AbgEBTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 15:31:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D1C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 12:31:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq3so1723852pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wvT5J/+zQU/yp3V4lBTm3O+Ggu6RBwVxWEg4ET38uo=;
        b=AMJcy3JRRlcpKW+Nke02DnXLT1Da/OxBx2A2FV6OGIyBlAHuiPXtW1syQooRst/Nz4
         7Cm0aD3DkQkkkiojz+eiXZkeW2vNEHFkcdToxCrLjxORkin1B2gBR/WmPgE9urQb2KNP
         VCSnykMjNPO3+KcwEQ76Ap725jVhJuzBh/sP2qjrh99bRiDAvrJBrEIN8Pux8IInyza3
         +ojZcHYMLF1g7y6jgivnWPiRCpgnMrpP6pXeouQZ6+XT61vzerhP21UR+MMX3MJmcjg3
         ZmpvIWsrCQ7JPZzNMuDYgMIH7DKC7UG/USybs5rFCFPIhVK3cb+KFNcwXveBWQuG8Pdq
         BRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wvT5J/+zQU/yp3V4lBTm3O+Ggu6RBwVxWEg4ET38uo=;
        b=d2oOhhD2x2qS2ekxJfnSk4w4RiUR3HjJenvhklAtwaR9Hr0HgmCW8ZqgzsaQz8GAGy
         nsE1B/vUA3E+GGW4OVkOCgtzbLFpz4G+RRwLLccThHpd4pJBuBGrnmkx0ku15el/s9u5
         FaJ72x2mYUZ7TWC0w2ZP0cbSi8F1/tb+0oqSgilE11kAJz9evL6TxmO0ZcGbzqTOChQj
         EhytT7HRz+Y7r7t/g6u6YW89naJ5bzT43u0CLswtFB5s5sUn9iKsoKZQOaL47d9QuIKN
         kcgzFceGKfJ3oSLK1G7RoNP7WtpgWbVFBxwN9jlrfZ9zUHlc3VeJa+Pvy8VBQrpjUyUW
         AEUQ==
X-Gm-Message-State: AGi0Puah4QDih2v0zZd7T9gXzZAS7K7tpdLM2g8HJRGpUvrgFkjwhDsi
        Ow2VYwkhEXIkGBjdV3ESqHNCKCYFuNA=
X-Google-Smtp-Source: APiQypKenahJwklXT+P+kKvZoiQs6hLV191e2+BtChueiWITQoX4qTFW7t2uAZKRN2TO3YYttW96bg==
X-Received: by 2002:a17:90a:e2c1:: with SMTP id fr1mr7459366pjb.124.1588447905115;
        Sat, 02 May 2020 12:31:45 -0700 (PDT)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id 138sm5034358pfz.31.2020.05.02.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 12:31:44 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 0/2] ALSA: line6: hwdep: add support for poll and non-blocking read
Date:   Sat,  2 May 2020 12:31:18 -0700
Message-Id: <20200502193120.79115-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for polling and non-blocking read for hwdep
interface. This allows apps to listen to HW events without using busy
loop.

Example of app that uses hwdep interface for POD HD500 can be found
here: https://github.com/anarsoul/line6_hwdep_test

Vasily Khoruzhick (2):
  ALSA: line6: hwdep: add support for O_NONBLOCK opening mode
  ALSA: line6: Add poll callback for hwdep

 sound/usb/line6/driver.c | 20 ++++++++++++++++++++
 sound/usb/line6/driver.h |  1 +
 2 files changed, 21 insertions(+)

-- 
2.26.2

