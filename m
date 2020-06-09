Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23C52067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVaClwYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgFINCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:02:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728120AbgFINCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591707750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QvkO2PPp+zFnnylyA9/RHaMuHI9iwBcF6vd6fIsDp3k=;
        b=SVaClwYm0zORDj4ov+0isWCF8Jccvx59p8gca4W79Y5/T0L4TvQe3dyFyFD8KCHcmfCGBx
        0kxEs+qZS3er3Ba7t/Q4YDx/yXrwvdirVXluB9pmt+8giyUQh7W833ZyVqQdsRxeK/FBUs
        Zi1GlaVQ+Q64tpcT9F7SK6WyiJMUpcQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-Vq6HKD_9PQGm74fuGIJoFA-1; Tue, 09 Jun 2020 09:02:29 -0400
X-MC-Unique: Vq6HKD_9PQGm74fuGIJoFA-1
Received: by mail-qv1-f71.google.com with SMTP id h30so12793508qva.17
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QvkO2PPp+zFnnylyA9/RHaMuHI9iwBcF6vd6fIsDp3k=;
        b=UFHUlIMWsJIOln3kB1aYo9O9qJ0Avl9YukWrqakUaAwZmRMim45Gg98pYGINOZ7Q6I
         nTXbcI1L2JGKhZuL2lzTYCrmXgGiAwltnToP29IMMeN1zUmC5J7XMAwDJ5AqCu+l9aUF
         gf2+u3vD3a+gYjYtaphnYrzjJ22BbtuZKVvE/CwwpYWVK9qB89y9cEyXoJKjAULpdeqQ
         hyjMmtLQy5ZjI9siIChgs7pfeAKvN/+So+ZE2ODmACm1Yo5ulaBCTy2cP+S8xOQmIYoy
         YGJqCWZFMyI1te8/Dt+qW6x67udfQCQLoH0CRRrevydJtRM+1htrA9vvASwHdtgByrac
         TdcQ==
X-Gm-Message-State: AOAM5310GAdm2n5WmvemLGQfqm80BqC/qBJ0ZXxLdgTl9w3GkCrmokTS
        adeiLeba5hXRT7G+xHw5ZyeBBq+gf+qRx8svudlzVLrjO7Jl5qLSMVKT6NFz65/vZZ8PX50nn7R
        j1S7CLWmZm+mWELYulpcuI81P
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27677245qke.381.1591707748761;
        Tue, 09 Jun 2020 06:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeetGPEU0xF9HLprMg4MvSdl54Lp4Jsvbf7QFI0FFyJ0mJJTghbDKHUiCqj2qRDoXcVNxScQ==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27676931qke.381.1591707746339;
        Tue, 09 Jun 2020 06:02:26 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m7sm9635939qti.6.2020.06.09.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:02:25 -0700 (PDT)
From:   trix@redhat.com
To:     linux-fpga@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] selftests for drivers/fpga
Date:   Tue,  9 Jun 2020 06:02:07 -0700
Message-Id: <20200609130208.27390-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo : linux-next
tag : next-20200608

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.


Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 38 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1

