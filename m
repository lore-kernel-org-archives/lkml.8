Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF816C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3261206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmELALbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgFHIao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgFHIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:30:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AFDC08C5C3;
        Mon,  8 Jun 2020 01:30:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so5698847pjv.2;
        Mon, 08 Jun 2020 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G7NT+IIMlEpev8mMIld6zg2khxnR9LKx4QWnMSa761g=;
        b=YmELALbkitxP2ggbooUEURujMSINXmryqerQhxXRvVK6hlFggjqe6vjydN5E/hscIs
         ew1S4hSJF0H5QNibJbvP5ZZQVzfbxfT6ZWE2VGHUwUZ/5r2MjtsMn4Wi9gD0v5zWBYjX
         /BRG23DsNHZGYdn4ji4uba2IFP66yOE+UuP5whqQn3I5qHMBV5AUdtWXtQsXfBUl+DYw
         myfg/t3rN2flP3HLisi5oI0ljM/WBOisQVl5L7VqbL8HJIEnnwrRlll0TC4R+avIrDOL
         cP7JQa3ERxtbpid31OYGSdlRGxXXvm6sjzsquzBA1ywHqLWwcE4V8rPbMKBPITJ1gVN3
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G7NT+IIMlEpev8mMIld6zg2khxnR9LKx4QWnMSa761g=;
        b=gmb7a9J5jhbbGvOadTdv9zQWAu+RInSHZvOBaWxBhpnKObpkJNTP+Jh0Ebwa7+ej68
         aNeM3TnspqOwVNQTbbr2gGB8JR2C5FBrKSsfR23+NxnhYtVpCf1MimmoVUYuCksEk/NP
         NLTMMV5F/DiTY+LIxMxFKt3C0mfkcgDIqRODscnlGFEWVRQ4UO4sxVycabxDSfdoCllI
         C504Fs7xGZXjMqxiUFtjdke8um2HLW3fn7/gRtcL654dYnPEwYD+b7T1P4HuQO3jQK3k
         HpFVljWUAX/fI0CRz3TUAa05BH4SXnL1HyWW2Xl9aCfcSz75ocVsDUK7e3TerhdFBdNa
         7mWg==
X-Gm-Message-State: AOAM530RALdgHp0+KTrilrwAFQknFxQsfYKXKitfws4gjWCJIelQfIyv
        TsXzXpuAFsEuEaeMualKm0w=
X-Google-Smtp-Source: ABdhPJxObPDhvUNU2fgGSyXqPnus/jX1jjU6Fcb/mjYz/7uwefMtlM+VUAjOyTj6a7++QyGKeDXCqQ==
X-Received: by 2002:a17:90a:886:: with SMTP id v6mr15165288pjc.161.1591605043466;
        Mon, 08 Jun 2020 01:30:43 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.42])
        by smtp.gmail.com with ESMTPSA id 27sm1210829pjg.19.2020.06.08.01.30.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 01:30:43 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux@armlinux.org.uk,
        vladimir.murzin@arm.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 0/2] Use 'arm_nommu_dma_ops' to handle dma memroy if device offer consistent dma memory region
Date:   Mon,  8 Jun 2020 16:30:36 +0800
Message-Id: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

when do mmap on /dev/fb0, we will get -6 error on cortex-m3/m4 or armv7m
platform without cache support, this is caused by following reason:

on armv7m platform, if no cache support, we will use dma direct mapping,
but, this is not support on !MMU hardware, just return '-ENXIO' error

so, add use_reserved_mem() for these armv7m hardware but no-cache support.
eg, stm32f429/stm32f469.

verified on stm32f469-disco board, mmap frambuffer to userspace.

dillon min (2):
  ARM: dts: stm32: Setup 4M bytes reserved memory for mmap
  arm-nommu: Add use_reserved_mem() to check if device support reserved
    memory

 arch/arm/boot/dts/stm32f469-disco.dts | 14 ++++++++++++++
 arch/arm/mm/dma-mapping-nommu.c       | 28 +++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.7.4

