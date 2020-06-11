Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C873C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D571520792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRl6+zW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFKTil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:38:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgFKTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591904319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=u8/OdraxV9Bf+mXB4Fs4dcRV8raf0sIOF0iql8UflHo=;
        b=VRl6+zW+mdR3IKuBdR1osCo/QKLbqK+7fsON1UdP3BXUsczbca7smXgHkSSRqpZzc5tjRs
        UbivgrvoSKPW6JyRY/STuaN06VBKWVgKLHUT1etcj62iD/vpQfzhXVrv33m9aEgQPlnVoh
        JlT/Z4Tzv88Dh9NWKyRPQLrT+k1JUC4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-K1cATqYxNMm7TLUG_sBLWA-1; Thu, 11 Jun 2020 15:38:35 -0400
X-MC-Unique: K1cATqYxNMm7TLUG_sBLWA-1
Received: by mail-qk1-f198.google.com with SMTP id x22so6019129qkj.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8/OdraxV9Bf+mXB4Fs4dcRV8raf0sIOF0iql8UflHo=;
        b=HCiE+nI3xIOA/rzNy460zJqxG/TO7XNLRGY+hKncaccY80uxkKiqWRWc5KJvVMccP/
         oQkMwQdG1klZakNz58Y77J9ayhjD2BJqjaXQBIbYtzu8m6Ac58rBOQJ5Yx1VzMQm4vYy
         H5Om8cNGEv7P3+62zMUWOPyso7g7rMfSUR4oy2UyLpEzFdgSDyC392+pFwb9tsFh5OP5
         qTREqTKsZrLgSdWIQzaB5KnQH/DrD00AiTvY53TzOJxuKuYbPvHKGQW0C/1779ZH9hwg
         uZS7atC5/WaVeThQ4Lr3XFAHskWDQWm85HVpD0NEAB6y7U1x7pI3jckSm4aS3yVV/TrK
         KTuQ==
X-Gm-Message-State: AOAM531857K5Bv5UAJ8rAI1HRdraK/5EFp6/2rXP0VVZrT8MFFagFOlb
        WFtUVKlbXHbnk64K5fkE+Y0CxYper2Unpurcy+EUW7/eG/mCXENHa/bj/oO4dk0oJxQJm1+Bj0v
        DT0vgogCbD4M6t1rgCVCnXcib
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr10196337qke.450.1591904314732;
        Thu, 11 Jun 2020 12:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQtwswsTGgRQ9rrZiZRxCAHbWdA8cWacLl6m7dxpVA5zy7jW4IXrGz/yV8yRp3gYQa1DE2tg==
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr10196317qke.450.1591904314480;
        Thu, 11 Jun 2020 12:38:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j22sm3020783qke.117.2020.06.11.12.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:38:33 -0700 (PDT)
From:   trix@redhat.com
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/1]  selftests: fpga: dfl: A test for afu interrupt support
Date:   Thu, 11 Jun 2020 12:38:26 -0700
Message-Id: <20200611193827.8302-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200611

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.

Change from v1
Use ksft_* functions for reporting

Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1

