Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C022C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8B8206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtWAzvRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHQJC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHQJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA79C061389;
        Mon, 17 Aug 2020 02:02:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so7802441pgc.8;
        Mon, 17 Aug 2020 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZC0KgckbobKMVj5LNskgiWBvLB99vw6xXyp7G4nHwHs=;
        b=LtWAzvRHRo/hDVkht4VwT9on5IaPKV6420lBfPnZOTHiGZkzNZbwY7MOrf34k0vLZj
         CUJPCkbSKAgOTAy0inWwOrrPkUwXbFem9JRMgQyDbKVc5akH+Rw1vRE70gdDQdozDpuX
         d+US6nIjO7b88t9dfb4JimOv7nj6R1oJ1Y8dAc/zXUl0dEhT9CgGujDNXReqnJKt87ab
         caIoCpfJOpafH+Bbw5LpRB+rtMW8Ymfq6w0AUHTrWUJcJNBUi/V0FZRirPY066djDKTV
         9aXCo13AgbnDmu+oy1jijiDv3yUFKW4VI+vjtwJ13gZwX5/iQiPn1BVihJSLLEA5lXuP
         WhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZC0KgckbobKMVj5LNskgiWBvLB99vw6xXyp7G4nHwHs=;
        b=KQbo7PGEZJKY2PSpXxhncIYdXYIKEX1CCLkofNPn7QbFQ8SZQL426YyJgRn1ahAlYu
         yxKAqVPMvctSlsfD7+0hqT91n180VgdX7uKTZ2SLNNXsqXEfuQ5Oy+vWfh5dYF0O9f/0
         QMcHdZ9/W9wdcaclcFuKcLkshGEttpNlCLdMHYjslFxAcPRm6AF3MgSRIQ5TLkVgwnVa
         IF0ankAmDsAsXcol4But45ekPSOtiYANUeJAutoAMRN/An2OdZiZjzutEjiE1N5koieU
         VONZKODLtmS9tnT27kUf+a2BLTPqzC+N2j2PJIFJ6uZMa+Jcnqn2vqpiZk+m88DXg262
         BQqw==
X-Gm-Message-State: AOAM530E9BLMeGi83e8lR7sAGPD1nmBDw7lEONX7P2/GyYYdvL8fRIgZ
        uc5TIfWAtVx9qARujoBIZlM=
X-Google-Smtp-Source: ABdhPJwTF2ujS4X+LZ29MIz5ofATMmQi3CNS6pxXN5INk7X1POpIv7TjyTdUGld9toMU2mDPaJ+atw==
X-Received: by 2002:a62:9246:: with SMTP id o67mr10339722pfd.249.1597654941674;
        Mon, 17 Aug 2020 02:02:21 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:21 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 0/7] usb: convert tasklets to use new tasklet_setup()
Date:   Mon, 17 Aug 2020 14:32:02 +0530
Message-Id: <20200817090209.26351-1-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts 
all the usb drivers to use the new tasklet_setup() API

Allen Pais (7):
  usb: atm: convert tasklets to use new tasklet_setup() API
  usb: c67x00: convert tasklets to use new tasklet_setup() API
  usb: hcd: convert tasklets to use new tasklet_setup() API
  usb/gadget: f_midi: convert tasklets to use new tasklet_setup() API
  usb/gadget: fsl_qe_udc: convert tasklets to use new tasklet_setup()
    API
  usb: xhci: convert tasklets to use new tasklet_setup() API
  usb: mos7720: convert tasklets to use new tasklet_setup() API

 drivers/usb/atm/usbatm.c             | 14 ++++++++------
 drivers/usb/c67x00/c67x00-sched.c    |  7 +++----
 drivers/usb/core/hcd.c               |  6 +++---
 drivers/usb/gadget/function/f_midi.c |  6 +++---
 drivers/usb/gadget/udc/fsl_qe_udc.c  |  7 +++----
 drivers/usb/host/xhci-dbgtty.c       |  6 +++---
 drivers/usb/serial/mos7720.c         |  8 ++++----
 7 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.17.1

