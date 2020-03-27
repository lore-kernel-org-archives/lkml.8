Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF734C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5B720774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpJUbkIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0P25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:28:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25054 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgC0P25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fwXwWjgfvFpCa/LXnsDpuKIOaaCZRr+v9HmG2ULDTA=;
        b=ZpJUbkIs3PkP7aS2CsD08hbnuLdhp1EdWQYzzTYrwRBwC9x0SHYXoy1625+nD7YUcwRetu
        qP0Yi+U3Wsttn7wfdPPwY0CvePtz4uZmVFRBhs7zdiUcfymcaP8ySVC3N/PQusrQddcMDl
        qQKEOeAKEghPp0c4MF+1MGQkVl4rWgY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-JIM3mFVUOZeyxpkPluDayQ-1; Fri, 27 Mar 2020 11:28:55 -0400
X-MC-Unique: JIM3mFVUOZeyxpkPluDayQ-1
Received: by mail-wr1-f72.google.com with SMTP id t25so2353195wrb.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fwXwWjgfvFpCa/LXnsDpuKIOaaCZRr+v9HmG2ULDTA=;
        b=bnU+dRUpYALm9G9CidvNMQ7AVUM8Ur6KNIHaKTFjN8POXVjWIE9YsHNH/eTjZgF0+s
         ookm7DcrczS6PZ65IGlXHyu5dpsrq8RqXty299MGwiaz0oTG1GX7oPSz2Qv7A9FPM5QQ
         tLxCWvpfX5b8Ci0bwqA8AdCoRAyYtcwM8IVscDnQRyGcTA1S27+goo28HRhbeKlV19rE
         KReRCXD//pz3ZcDVGOiROlbe5WiI57EiZ7O4utiK3mh35lnVabjq1xRQgwV4/eLozb45
         +/2Ac5DlNRm8lXtKOjdNDdbMRzY6lkIar3PvjvHtVZbart8sBqs2CFUFtq5SZENblcv3
         KTuw==
X-Gm-Message-State: ANhLgQ2trCO9UEcaptZ0iiI4vbwrnkbX1Ve5ils3IMtsYbxaZFKfZ3sQ
        M7qP2IE8R038viixjhB2aV2mL4S5EVOlBE7Qug4Zkd0khKN1yQHM3HLFlj6bpMRCdkOwyZkA8Mv
        PU3KaNZNbOWI92AxArfIPptXD
X-Received: by 2002:a5d:474b:: with SMTP id o11mr4687210wrs.391.1585322932703;
        Fri, 27 Mar 2020 08:28:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvo+PWvlHdCVU7OdbER3iSWk54TTZJyUSBxIDE8POWxDcb0SfAkXhI94CDkivUyyDs3kopsHg==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr4687194wrs.391.1585322932487;
        Fri, 27 Mar 2020 08:28:52 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:28:51 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 01/10] objtool: Move header sync-check ealier in build
Date:   Fri, 27 Mar 2020 15:28:38 +0000
Message-Id: <20200327152847.15294-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the check of tools files against kernel equivalent is only
done after every object file has been built. This means one might fix
build issues against outdated headers without seeing a warning about
this.

Check headers before any object is built. Also, make it part of a
FORCE'd recipe so every attempt to build objtool will report the
outdated headers (if any).

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ee08aeff30a1..519af6ec4eee 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -43,10 +43,10 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
+	@$(CONFIG_SHELL) ./sync-check.sh
 	@$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	@$(CONFIG_SHELL) ./sync-check.sh
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
-- 
2.21.1

