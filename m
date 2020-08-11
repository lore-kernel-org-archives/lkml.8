Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4538C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B9220772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxy7bKRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHKHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:01:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728142AbgHKHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597129278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TEG2fDTMrT9CyNXx3j58WMIBzVoaSf9PoptkoEoE8fA=;
        b=fxy7bKRch+AtDqFCDMFZw1TB1p0a+nGTBvCV1OQ9SXj2DBjXBIFBCS708hpH9nSkmtEbcu
        8vOk7GnYvBI3AtAW2qz7QXI1vGF1r/nNo8ooyywgCpnm4/8l8lGP09Z/xTQX7mNuIEWioQ
        4cLRnhTOqBCV6Mq2/pWfJmgO2XtQ9LE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Gag3b5agPze19uFDepiZGw-1; Tue, 11 Aug 2020 03:01:14 -0400
X-MC-Unique: Gag3b5agPze19uFDepiZGw-1
Received: by mail-pl1-f198.google.com with SMTP id b11so8420671plx.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TEG2fDTMrT9CyNXx3j58WMIBzVoaSf9PoptkoEoE8fA=;
        b=uLgt6XawWonTMt74uUtf/O4XOrBrwCJ8LlnS1SJEpY2yEpHGtjpCejX6euj9PbHryi
         wCAzmQMvwLPpdzu4DOzBAnWUdmTX4y+gIehyE2NHRvqRlaEAdc3NsNbyrvCEypAwPm5G
         tT+iZyMiN5uGWQWjwhqRSUmz1hM6L3OwnN/oxlL2gqfC2H4SAJ/lcH+hi1tHZEDqBYk8
         EqPIAdH1lyO+PrY/8AG4ZIUbPxc7SO0Pk/eeoWtAf/Sh5CuYWh4WeoKW1oPg27jow2JW
         jAdYcrAnOtL3FfJm1xhHz3DDYWspFAp5RCnWIqOe9CeSPSISTwHKVVc18QCuKeSGSQ5f
         IsAA==
X-Gm-Message-State: AOAM530QLVVqBX6eTWosH2GehsnaE7ZDOtz0z8Dt3BLi06uvSCCVBdbp
        qlg2RWb/REwMZ4jexvtcK0LEXI8WGRs1kw7OI/Sjk85DDRdMXp7smjmEJokac5xY14ik4ObVn8W
        QAubSmsqPZZzwdS1Abr/7eb8S
X-Received: by 2002:a17:902:b417:: with SMTP id x23mr25968237plr.231.1597129273223;
        Tue, 11 Aug 2020 00:01:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/PxAh0tVI6Za7raz5oYvg/ytWr1qauzk4b41fv1H/5Mxa/CRU1ZHv8AgkFi0j4qdCop3bmw==
X-Received: by 2002:a17:902:b417:: with SMTP id x23mr25968217plr.231.1597129272976;
        Tue, 11 Aug 2020 00:01:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y19sm24098541pfn.77.2020.08.11.00.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 00:01:12 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Hongyu Jin <hongyu.jin@unisoc.com>,
        Gao Xiang <hsiangkao@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] erofs: avoid duplicated permission check for "trusted." xattrs
Date:   Tue, 11 Aug 2020 15:00:20 +0800
Message-Id: <20200811070020.6339-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't recheck it since xattr_permission() already
checks CAP_SYS_ADMIN capability.

Just follow 5d3ce4f70172 ("f2fs: avoid duplicated permission check for "trusted." xattrs")

Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
[ Gao Xiang: since it could cause some complex Android overlay
  permission issue as well on android-5.4+, so it'd be better to
  backport to 5.4+ rather than pure cleanup on mainline. ]
Cc: <stable@vger.kernel.org> # 5.4+
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
related commit:
https://android-review.googlesource.com/c/kernel/common/+/1121623/6/fs/xattr.c#b284

 fs/erofs/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 87e437e7b34f..f86e3247febc 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -473,8 +473,6 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		break;
 	case EROFS_XATTR_INDEX_SECURITY:
 		break;
-- 
2.18.1

