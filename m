Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88847C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B81D20825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DmsE28c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgEVNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:35:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:35:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p12so8217331qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=654C6HMAJavjEr0S4/IKvBvbc+mHWyzBMrpEJYlc/nQ=;
        b=DmsE28c0J4Ygt6MtPOMJu6De7QbehaWK0RU3Yt0kC42y6Vc7yki+njWWBM7fLypkG/
         UEXTDSBaYM3HFOvM8cVvl53RjaU6IhdSf0zLQ0DUHW4aXXe5/znsiuC1r0m6VIenhnt/
         8+yupTCx847h5bTOXDYzsIAHc6vXTr9aNLSGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=654C6HMAJavjEr0S4/IKvBvbc+mHWyzBMrpEJYlc/nQ=;
        b=HYQAhqHVdD8dGPuGTDW+uPIuU1LNvskqINO0fbWOkSJ+mpReMp6lXc/5J7go9eAGDV
         w8h77Ml2+bVZJZfNNl9a3AmQlUBU640y2LRCM8SUVZgS/kfxC7Ugbuo8d00/38Rajgq4
         xIlUM61H0/er1dxU9SlvVxsWwXaCcW1F5ZAEmBcRItHBluwofdWrOQ/+8GbsckUhr2Jv
         IghftLm5GHijo+nZhP2gWUDwULKIz2wHQ57K2lPMESNR4Lt5rwmC+ZSeBN6CoeWrl7/r
         JvqDAcCd7139kzAlOe8q2iqeEh/WQXkccN/kD5mAd7pbQo4pDbLhhZjicJ2LgncGw3Ui
         wLZw==
X-Gm-Message-State: AOAM532Y3waJi3+c4baLnU5DUMHksPfCAwqRYDS/SvAZfZwxhrQoxSgS
        ++3TX013oC720L/RUT1oKg7dL9sb24s=
X-Google-Smtp-Source: ABdhPJz1FUSjDoLtfHJN/Zeql66rPIzcdUtptDSzo52IvftehA3efMQx/T0H8ocig9sAnzaM1pbAfQ==
X-Received: by 2002:ac8:71c1:: with SMTP id i1mr7363784qtp.320.1590154529140;
        Fri, 22 May 2020 06:35:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q46sm2013046qta.79.2020.05.22.06.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 06:35:28 -0700 (PDT)
Date:   Fri, 22 May 2020 09:35:28 -0400
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        matthewb@google.com, jsbarnes@google.com, vapier@google.com,
        christian@brauner.io, vpillai@digitalocean.com,
        vineethrp@gmail.com, peterz@infradead.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, libc-alpha@sourceware.org
Subject: [PATCH RFC v2] sched/headers: Fix sched_setattr userspace
 compilation issues
Message-ID: <20200522133528.GA210175@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a modern Linux distro, compiling the following program fails:
 #include<stdlib.h>
 #include<stdint.h>
 #include<pthread.h>
 #include<linux/sched/types.h>

 void main() {
         struct sched_attr sa;

         return;
 }

with:
/usr/include/linux/sched/types.h:8:8: \
			error: redefinition of ‘struct sched_param’
    8 | struct sched_param {
      |        ^~~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/bits/sched.h:74,
                 from /usr/include/sched.h:43,
                 from /usr/include/pthread.h:23,
                 from /tmp/s.c:4:
/usr/include/x86_64-linux-gnu/bits/types/struct_sched_param.h:23:8:
note: originally defined here
   23 | struct sched_param
      |        ^~~~~~~~~~~

This is also causing a problem with using sched_attr in Chrome. The issue is
struct sched_param is already provided by glibc and is in POSIX.

Guard the kernel's UAPI definition of sched_param with __KERNEL__ so
that userspace and the kernel can both compile.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2:
With the chance that libc needs resolving something, I'm resending with
libc-alpha added as suggested by Christian, and minor commit message fixes.

 include/uapi/linux/sched/types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153ddb0d3..1f10d935a63fe 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -4,9 +4,11 @@
 
 #include <linux/types.h>
 
+#if defined(__KERNEL__)
 struct sched_param {
 	int sched_priority;
 };
+#endif
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
-- 
2.26.2.761.g0e0b3e54be-goog

