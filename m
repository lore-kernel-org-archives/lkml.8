Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26872C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB71120717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGpT7+88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgGUUra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:47:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726658AbgGUUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595364449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vJQdVCFU+bbg1bLHFMdzaVvzuHDTychMnPcWRjdwPXE=;
        b=aGpT7+8865ZkJrF7639b2J6TB+bfAMJ55LoqJ6RUbGDorrqpXL4eRtkx7NTT7Cx8oASjb2
        LYojKepss3wB9ZdoqgOQXAc2UtNzr/nNZXkgPVSTefMB1Us++y2Ew7NUXEBtay/ZJj9DG2
        FrE7a587WsQ5CZc78K8aBOnVHr6bBtc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232--liEx2g3MtuW1kLRv99W_g-1; Tue, 21 Jul 2020 16:47:27 -0400
X-MC-Unique: -liEx2g3MtuW1kLRv99W_g-1
Received: by mail-qk1-f198.google.com with SMTP id d131so3845833qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJQdVCFU+bbg1bLHFMdzaVvzuHDTychMnPcWRjdwPXE=;
        b=hYeJIQlwx/yAn9W3ltXY22niEmgyQ1V6UtiHx9Y5p73eXxmlmFr7t0eSfXYSjRO4QE
         GKLw5pmL1oY6R1cgdqdnSViEmyqPdseLicxOILArwqbju6ARjmQHoUtq60gYDAv67C00
         0NfrTy9w2fG9vxcxM2eOPcd0CMD1N4eyImmRkN3Euthjj2peNCDUVRD8awKxTUyvFp7/
         Iermfr8JvQFKSHehTEwNGn3+p2ENLAwfaLO45f8rLv+pXqMQKTWmqQ7UuX4g2FxJ92GI
         EYJxZQcLymRCGWQyhtta+FR5SfB7Qfm+qPrizin9sCO6Lr/mmdrwL1elMhAytFqpNnpt
         9I2Q==
X-Gm-Message-State: AOAM530R5DBG4OGV/2gkqrqh3g/eViwZUKLKnZfo+xlVm20u+4dpcn9R
        d1cmdxFtkVxfRqbyK9wjOtp6KNUMikAoZ4kzAp6/EH8ZTJMR6UhhuwV21cvaeTyGeug4rW/xUak
        xVwEDaVMAmexQauhD22+ad5u2
X-Received: by 2002:ad4:458a:: with SMTP id x10mr28322115qvu.223.1595364446676;
        Tue, 21 Jul 2020 13:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygQOKEOiEw1Sm7Q966C1eHUbaxdV8Q8TNJehm6XP/ZzoJqq/cPLBShuRJKbZI5HehL42Biew==
X-Received: by 2002:ad4:458a:: with SMTP id x10mr28322104qvu.223.1595364446452;
        Tue, 21 Jul 2020 13:47:26 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u6sm24008373qtc.34.2020.07.21.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 13:47:26 -0700 (PDT)
From:   trix@redhat.com
To:     wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org, pablo@netfilter.org, kim.andrewsy@gmail.com
Cc:     netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ipvs: add prameter name to ip_vs_enqueue_expire_nodest_conns
Date:   Tue, 21 Jul 2020 13:47:20 -0700
Message-Id: <20200721204720.7818-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Compile error here

In file included from net/netfilter/ipvs/ip_vs_conn.c:37:
ip_vs.h: In function ‘ip_vs_enqueue_expire_nodest_conns’:
ip_vs.h:1536:54: error: parameter name omitted

So add parameter name

Fixes: 04231e52d355 ("ipvs: queue delayed work to expire no destination connections if expire_nodest_conn=1")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/net/ip_vs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 91a9e1d590a6..9a59a33787cb 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1533,7 +1533,7 @@ static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs *ipvs)
 
 void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs);
 #else
-static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs) {}
+static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs *ipvs) {}
 #endif
 
 #define IP_VS_DFWD_METHOD(dest) (atomic_read(&(dest)->conn_flags) & \
-- 
2.18.1

