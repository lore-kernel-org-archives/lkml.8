Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4D1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 08:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC70E207BB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 08:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sJFO8/dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHBIfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgHBIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 04:35:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8778DC061756
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 01:35:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so30913397wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nwR0cSDRK1MacipoHZSBkL1yx2DzBEYBuItL8wnBzYY=;
        b=sJFO8/dNG2dGuiR/gT54hMqO6QnQtqhcCLkM5HmWg/NVzNUCWmPXvt4Bd510UemOzm
         GN/QfXIpMzu/oAX81Bv7GBpyPrJk4vph5MByjFxysIGgsnBGEVAG5jkaX8f/LCNpOQNQ
         Vaw0z/czRYrMJOgIcPbhpJEsaLTaG8fop7KNF7PqAsJ3ho3gBkUk5x0d3uiyNe8swLTq
         2Lz70pmXu5+HB+9aa20R6jZ6/ViVkuAtWZnlgM1y7CcrwwtPis639LaCxdLFIXC6q9Uk
         b/SZz3MPXR0A24BbjHVD82xsyKT4FUSxzlVWYOlgICNrOMThzAgEtmASAbNgnv4Ut4W+
         VQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nwR0cSDRK1MacipoHZSBkL1yx2DzBEYBuItL8wnBzYY=;
        b=QBL2k3ThBE4ZFQNocvNJceYy6gaCpKWlRY6nNCTUscXnkCmLtAy3185ZXvIqjBRCzr
         ZsHcElYveT3ejKhy590uzIRiVIe+5+Qm62T1vt/s0+XnJztB6p0q/4HN2AWcYvZVfdfx
         bHDCbeAZL7s6CfH4p8tz1gs9QzvpD5f7bKEoNKUP/wM5GkcZFG4xN2dtBcGT+ikJESJt
         5vsa7IUVaJezKlakg/bAhZbRjuHeVbLgg3Rj70vyUh/Cg3KxYLRD2Es3nd5fb49FEIV+
         jZXSY+1abkL2pVf7sWJwLUgyAxtvsx9ITdRMLFKGFSFYs7wmDInXDTy8mc+COL5T0+BG
         MAOw==
X-Gm-Message-State: AOAM532udwEM4yuNlQPCmSTVPnuIqZmjZzgtYtTuwwGyS0MTLwEpUcBS
        26bEiLazVXWDmrJcgBxsUKaTtQ==
X-Google-Smtp-Source: ABdhPJysVYxzaXR2wk/8PBfHv2MvKUCCN0LllR0j3hUk2LNHkM3/+4zmSNtDZppkp6vg4/90vF9krA==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr9899567wrg.425.1596357302104;
        Sun, 02 Aug 2020 01:35:02 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id d14sm19281466wre.44.2020.08.02.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 01:35:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 0/3] devres: provide and use devm_krealloc()
Date:   Sun,  2 Aug 2020 10:34:55 +0200
Message-Id: <20200802083458.24323-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Greg, Andy,

this is a reworked version of devm_krealloc(). This time without the risk
of sleeping with spinlock taken. I noticed that devres_lock is only there
to protect the integrity of the devres list - we can assume users are sane
enough to not devm_kfree() chunks that they devm_krealloc() at the same time
so we only take the lock when manipulating the list now.

I dropped Andy's review tag due to this change.

===

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds the first users with hope that this
helper will be adopted by other drivers currently using non-managed
krealloc().

Some additional changes to the code modified by main patches are included.

v1 -> v2:
- remove leftover call to hwmon_device_unregister() from pmbus_core.c
- add a patch extending devm_kmalloc() to handle zero size case
- use WARN_ON() instead of WARN_ONCE() in devm_krealloc() when passed
  a pointer to non-managed memory
- correctly handle the case when devm_krealloc() is passed a pointer to
  memory in .rodata (potentially returned by devm_kstrdup_const())
- correctly handle ZERO_SIZE_PTR passed as the ptr argument in devm_krealloc()

v2 -> v3:
- drop already applied patches
- collect Acks
- add an additional user in iio

v3 -> v4:
- add the kerneldoc for devm_krealloc()
- WARN() outside of spinlock
- rename local variable

v4 -> v5:
- tweak the kerneldoc

v5 -> v6:
- tweak the devres_lock handling in devm_krealloc()

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 65 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 +++-----
 drivers/iio/adc/xilinx-xadc-core.c            | 16 ++---
 include/linux/device.h                        |  2 +
 5 files changed, 85 insertions(+), 27 deletions(-)

-- 
2.26.1

