Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9EBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C220709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589578134;
	bh=+B+i9IZ8iiOWzw0QyZOrto8VImF8oTTUAFC409VwDfE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rNZARaJ5XOnufv0qXuQcH53ubQwxDznPXwnWFQAugvuIA4S7KxNCKwt37BvDqPbwK
	 OdL4/zCVCwAUg+JG3mxaiPs2MkfmQy45NAWT93FHxLUtjSPEjhDgYswrQOCi0+0e6C
	 BAjCgLixRjn3j1QN3w+a53UKefHSewvXaDry+vKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEOV2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:28:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgEOV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:28:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id x13so1585790pfn.11;
        Fri, 15 May 2020 14:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTmSl9YKaCNsjNOb3IxfYRfZ8mYTIU9PqjhjQ3pwCHQ=;
        b=pvi61G0tenHADSVeAhRJTUB3h3TQgw4sMzyBeyDHS5zn/LCK9kPMaFOpUdXHVh7lra
         6azvZ5jqspA/P53SNZmeX7kbbEiOa+Q4ZtKlysOZZZuGAQ6y34W9HiWql3H0tWtlH5XM
         68jnA85GJTVNPhhrZvifvTPn0M0UswW9O4KO9rn/XJAc8ZiV/SQiXPC+vhp7cAwE5vBd
         Mc+VRTQZbY4mzGUdoFBtmC03e/nrVzByz30d37/10OzuGbVEGkChp7bLqtHd7WWSxDiU
         JJXOwMoQ9OHHQ9vqBb46KVV5zIwy/PYHfIhe3WC62lTWvj35nYlxs37TaQEnUVQp9EnS
         ig7g==
X-Gm-Message-State: AOAM532VeATTR5MuOgkw0m8kZKaxvMTbAZfQwvXMpedjhIDXnxGdOi4t
        PuFagbrWaXK7fVgiaENEkiU=
X-Google-Smtp-Source: ABdhPJxoObrFR9/hE3BjUnP3mrM4U7brESyb9fpeRUL8eqYMVEEJRCS47aT3uJzomgc7mmmQoQYn0g==
X-Received: by 2002:a62:7c16:: with SMTP id x22mr5785765pfc.267.1589578131633;
        Fri, 15 May 2020 14:28:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m14sm2375614pgk.56.2020.05.15.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 14:28:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 79EA440246; Fri, 15 May 2020 21:28:49 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 00/15] net: taint when the device driver firmware crashes
Date:   Fri, 15 May 2020 21:28:31 +0000
Message-Id: <20200515212846.1347-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this v2 I've added documenation over the taint flag, and updated our
script which parses existing taint flags to describe what has happened
when this taint flag is found. I've also updated the location of the
taint flag on the qed driver and updated the reviews.

The changes are based on linux-next tag next-20200515. You can find
these changes on my tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200515-taint-firmware-net

Luis Chamberlain (15):
  taint: add module firmware crash taint support
  ethernet/839: use new module_firmware_crashed()
  bnx2x: use new module_firmware_crashed()
  bnxt: use new module_firmware_crashed()
  bna: use new module_firmware_crashed()
  liquidio: use new module_firmware_crashed()
  cxgb4: use new module_firmware_crashed()
  ehea: use new module_firmware_crashed()
  qed: use new module_firmware_crashed()
  soc: qcom: ipa: use new module_firmware_crashed()
  wimax/i2400m: use new module_firmware_crashed()
  ath10k: use new module_firmware_crashed()
  ath6kl: use new module_firmware_crashed()
  brcm80211: use new module_firmware_crashed()
  mwl8k: use new module_firmware_crashed()

 Documentation/admin-guide/tainted-kernels.rst       |  6 ++++++
 drivers/net/ethernet/8390/axnet_cs.c                |  4 +++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c    |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c   |  1 +
 drivers/net/ethernet/brocade/bna/bfa_ioc.c          |  1 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c     |  1 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c     |  1 +
 drivers/net/ethernet/ibm/ehea/ehea_main.c           |  2 ++
 drivers/net/ethernet/qlogic/qed/qed_mcp.c           |  1 +
 drivers/net/ipa/ipa_modem.c                         |  1 +
 drivers/net/wimax/i2400m/rx.c                       |  1 +
 drivers/net/wireless/ath/ath10k/pci.c               |  2 ++
 drivers/net/wireless/ath/ath10k/sdio.c              |  2 ++
 drivers/net/wireless/ath/ath10k/snoc.c              |  1 +
 drivers/net/wireless/ath/ath6kl/hif.c               |  1 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/core.c |  1 +
 drivers/net/wireless/marvell/mwl8k.c                |  1 +
 include/linux/kernel.h                              |  3 ++-
 include/linux/module.h                              | 13 +++++++++++++
 include/trace/events/module.h                       |  3 ++-
 kernel/module.c                                     |  5 +++--
 kernel/panic.c                                      |  1 +
 tools/debugging/kernel-chktaint                     |  7 +++++++
 23 files changed, 55 insertions(+), 5 deletions(-)

-- 
2.26.2

