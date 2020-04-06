Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63960C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2A2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH8n09bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgDFKmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:42:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726883AbgDFKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FqGYEjIImdWTgee2fIf/zfTRdiurl1mO572U3AitAp0=;
        b=QH8n09btlsvNIiBo8OYun0AOV70jz1uFFTPafaZzw8sYLdHTe+W+OJdu1Mga0JDnqnWhuG
        lTOBku2gb29MU/EjbDUIWjKMIvYXaJf8qDJgwGVtMuWYngZDnZ7mBPCjAykE8VWFnxIgfx
        uVfzQrhOmyW4jLwCppwqhbg3Ftw0C2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-FN2cLsbfMmOquWqso60Hgw-1; Mon, 06 Apr 2020 06:41:58 -0400
X-MC-Unique: FN2cLsbfMmOquWqso60Hgw-1
Received: by mail-wm1-f72.google.com with SMTP id o26so1096351wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqGYEjIImdWTgee2fIf/zfTRdiurl1mO572U3AitAp0=;
        b=YqpJketfwxIKaNp08CuqzIjpiN66gzTQLbPeiMBPOtVtdw53zl6pMpWLcYpUU5D4Zi
         jFEhr1dMWVFfsTcuUOBQeFJ/zvZyjjfE1SYH3boNj+aY4ETXshW5EB8GCI+qKTRiGEK7
         BHPHWFCewVgukALpAaomL8SSN3FpVE3XfIPZqLh9P7YJDXLcmbr2R8/2sVbsklHDYGJR
         wWAxjdOUoa4xObw/7AFTXVXGXzcVL6CkkbuSucZPawEIKcQzs0xeFQcdGk7xlai+ey9u
         39fKxy+SxQy2P9V/K17+V3WhLHDgcLROl1Jsb2MggOsVtiHyObC0rAtl0WQFlncv0g6m
         nd8g==
X-Gm-Message-State: AGi0PuaAYY/HOS0/4U7VC4Exd88h3Ybxb8zaxOIhVAF5PIc1rU4n9Yp2
        aHgtivfDE/wU62bqjngPwONvlwuOKpPy0R/JhAOkspkup3TfrVFBy1DHPdMsQMNUPx1QT9KX4Lu
        f+uCjNRj2H41s/4DMnd0iUwXf
X-Received: by 2002:a05:600c:2910:: with SMTP id i16mr21518937wmd.43.1586169717439;
        Mon, 06 Apr 2020 03:41:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypJPzINmfQ385QW26xQbfnWPsO2PkLIbN8craOWxA1Q9iUGl6xZlmMVJwWqmHJOQT0x2ogPi1A==
X-Received: by 2002:a05:600c:2910:: with SMTP id i16mr21518922wmd.43.1586169717258;
        Mon, 06 Apr 2020 03:41:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:41:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 0/5] Drivers: hv: cleanup VMBus messages handling
Date:   Mon,  6 Apr 2020 12:41:49 +0200
Message-Id: <20200406104154.45010-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small cleanup series mostly aimed at sanitizing memory we pass to
message handlers: not passing garbage/lefrtovers from other messages
and making sure we fail early when hypervisor misbehaves.

No (real) functional change intended.

Changes since v1:
- Check that the payload size specified by the host is <= 240 bytes
- Add Michael's R-b tags.

Vitaly Kuznetsov (5):
  Drivers: hv: copy from message page only what's needed
  Drivers: hv: allocate the exact needed memory for messages
  Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
  Drivers: hv: make sure that 'struct vmbus_channel_message_header'
    compiles correctly
  Drivers: hv: check VMBus messages lengths

 drivers/hv/channel_mgmt.c | 61 ++++++++++++++++++++-------------------
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 40 ++++++++++++++++++++-----
 include/linux/hyperv.h    |  2 +-
 4 files changed, 66 insertions(+), 38 deletions(-)

-- 
2.25.1

