Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2810C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA538208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+a6QtSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgHDQUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:20:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36498 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728271AbgHDQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596558026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=39irOBPTe9Z0kK4c/lNul+h0tOKXYZQuoF/1ateEpJQ=;
        b=L+a6QtSaN21JsxXUru8K3bQMWaLZaL5U2HDnyI292PT1MGVuO2HYUwnqRhB6SaNJWMNWFa
        I8RKRhdgShwdU0xjzO2NmJsNfJEeqKGIxhDwGngiT0BPTUPMZzkH5YWbGazbaz99chypmx
        ej+K20KiewT1oMoK5F3nUDzsdXcqK+Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370--cIYaTCtNeu-_INzFhzz3w-1; Tue, 04 Aug 2020 12:20:20 -0400
X-MC-Unique: -cIYaTCtNeu-_INzFhzz3w-1
Received: by mail-qv1-f69.google.com with SMTP id z10so5577145qvm.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=39irOBPTe9Z0kK4c/lNul+h0tOKXYZQuoF/1ateEpJQ=;
        b=c2Nlr5reW40wrcXaG/Up/zhqAD9bnXVnZ7bXx8Py8rPZD6V7UAmA3+70vktAKUmDcv
         xClVawoVZc1ZCM5193n2MnG5xy/68Gv5CF0bKQRiN94jv+9yrIymXQyUmDb002uUFWSm
         hhaOL0mMDy5Gj70C7asln4lU9QLZO7NcUK+lH6NzTCQ6Sh5IyUqmDezdp6XXNsm8KrZl
         JDoKG71ihWOCq8BP2OMmf64vJ/LjaqYC7OIz0sZgv/xinIYi1dxAISs3X0386wNqrAQm
         RvoLEK9OYljAQQOfVzJfeuSn6QLUDB+bWnhy+e1TEsWPmK16YlYS/BZp3WrKDiE1MPK2
         ArQw==
X-Gm-Message-State: AOAM530U4vyLwedEIu6RPljopZJzqG+bKi+lok+kLPZ8n0SbOl2kRPkz
        0c5Yo1rjNwU65VTn/IAj+aMsp4lsIJQkJzmuyBlsH28gooVu1uVRut+StGb9v7Vi/G5pvyw8Fzz
        /Wk9RETpCZV075GIpqZZK7CJW
X-Received: by 2002:a37:7245:: with SMTP id n66mr10663983qkc.83.1596558019724;
        Tue, 04 Aug 2020 09:20:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB2lI38hkDboBDEtEVKpNlRUIDwbzgotiwqvt2H3cRPNRNgNz0BxpvsW5JbymjJ6lMBaoT3g==
X-Received: by 2002:a37:7245:: with SMTP id n66mr10663944qkc.83.1596558019290;
        Tue, 04 Aug 2020 09:20:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q4sm21922585qkm.78.2020.08.04.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:20:18 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Date:   Tue,  4 Aug 2020 09:20:03 -0700
Message-Id: <20200804162003.19402-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

I take care of fpga kernel and userspace for Red Hat and would
like help out more with the mainline kernel.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce2737b1feb5..6fdb01776413 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
 
 FPGA DFL DRIVERS
 M:	Wu Hao <hao.wu@intel.com>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/fpga/dfl.rst
@@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 W:	http://www.rocketboards.org
-- 
2.18.1

