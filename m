Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A66BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A35D2068F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xmo2RnOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHIRGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:06:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31331 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbgHIRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 13:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596992804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1xpCCi2TXdu3ztpBsaGa670KVrz6stqe+QKsz2ylU9I=;
        b=Xmo2RnOI3jis4sc05CKURO1xabCpf3dEzADQd6bNex/6kVyu4WECLBASlUilczvEtID2Ld
        oX5iMwtcdyQgZ66j83e7ao8wg3wPvhixBhrtPeoHooI/PvcN7fhJpBQP4+neXdtE6a501r
        TvK3nSJBBcTzA2PVmRaEh0GhsTXJM9g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-X4RdnwyQMTm00UboEk6l4A-1; Sun, 09 Aug 2020 13:06:42 -0400
X-MC-Unique: X4RdnwyQMTm00UboEk6l4A-1
Received: by mail-qt1-f200.google.com with SMTP id u17so5908659qtq.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 10:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1xpCCi2TXdu3ztpBsaGa670KVrz6stqe+QKsz2ylU9I=;
        b=HnNjFCiLf8nHJ5W1qneVVr7P1p1LicJgKtARU9V1XGl6Fk8ptM8jaSLvAJgeq4xF+G
         M65iIC6EnJoy36lisNs1qjHj/jqTwcIzyfqU5CmWsJ+8msjUAaCMF3ubeCahWHUszv3e
         +kavMvAjT2RJQ4KpGd8MVoQ2rZq1qYTxEPERRQOaKQIKTT4SKAtCQ2JyURLTY55uZdcJ
         msHDQx5whkcdMQMbF7qR1KnJE0wM6+4G5RSoQmih+b6q8stEht2finmviZFZoniQE/uu
         gTHsvNYeQ/WkMJVezG3tV5vcyFu/sgHTKd4GEchnKpwIcOw1yDaQdcUg/q6Gh651CKhr
         agQw==
X-Gm-Message-State: AOAM531UUM1u3WndAuFNJomeLk/dFA5B7q6rj0gdVghwK1zBSrXjQK1f
        Bs25bxPWncxmyKY2movnqNWQts8etu9GJcsFu5FzpQx1a1Jd/u4rAqZdLOpWLPIVhG64pzz/HbM
        Dn2fwVpuccCGVL8d6V3GWmmSJ
X-Received: by 2002:ac8:7c97:: with SMTP id y23mr23346072qtv.273.1596992802030;
        Sun, 09 Aug 2020 10:06:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjy/kDWX1VISmUkGtqzwfiHR0zyP380jeAWYop2Ijk99H3I/dI393bwdpPc8/jHOvECU8cYw==
X-Received: by 2002:ac8:7c97:: with SMTP id y23mr23346054qtv.273.1596992801827;
        Sun, 09 Aug 2020 10:06:41 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p33sm14774061qtp.49.2020.08.09.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 10:06:41 -0700 (PDT)
From:   trix@redhat.com
To:     dhowells@redhat.com, jlayton@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] vfs: samples: fix memory leak
Date:   Sun,  9 Aug 2020 10:06:36 -0700
Message-Id: <20200809170636.22133-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this represenative problem

test-fsinfo.c:615:3: warning: Potential leak of memory pointed to by 'r'
                memset(r, 0xbd, buf_size);
                ^~~~~~

r dynamically allocated in a loop an increasing size.

	for (;;) {
		r = malloc(buf_size);
...
		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
	}

The problem is that r is never freed at the bottom of the loop.
So free r.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 samples/vfs/test-fsinfo.c  | 1 +
 samples/vfs/test-mntinfo.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index aa122fb555b6..d669201d03ac 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -622,6 +622,7 @@ static ssize_t get_fsinfo(const char *file, const char *name,
 		if (ret <= buf_size - 1)
 			break;
 		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
+		free(r);
 	}
 
 	if (debug)
diff --git a/samples/vfs/test-mntinfo.c b/samples/vfs/test-mntinfo.c
index 40125ad81f17..54a6abf4a8b0 100644
--- a/samples/vfs/test-mntinfo.c
+++ b/samples/vfs/test-mntinfo.c
@@ -105,6 +105,7 @@ static void *get_attr_alloc(unsigned int mnt_id, unsigned int attr,
 			break;
 		}
 		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
+		free(r);
 	}
 
 	return r;
-- 
2.18.1

