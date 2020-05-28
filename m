Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2032620814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u6+8QPPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbgE1Nz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390608AbgE1Nzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:55:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910EEC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:55:54 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e20so754295qvu.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=hwB4H+90PXovf4SJvJe9+Rj3bMo+et+KhIqFvByMq6E=;
        b=u6+8QPPPQ1evhnU+zHhuhm+H6IU6aanMcMS3N8hvXpt7mbcsnohnFQr8PfqOqRzsuo
         sKSkl/Azd37Ky+PuLPfAPk1Q6hke/3fsvRg1YUS5wyyFnLnJWFKYU42bpZjHzRae8MJw
         iAzXuxKIWvvjrwsScr1hxlJuUnCmcKdiRoRb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=hwB4H+90PXovf4SJvJe9+Rj3bMo+et+KhIqFvByMq6E=;
        b=gWWfSq0uHEmfd8I0/CuJS8pC/lx4iiUb0OIHAFPV5YJ/03PAv/OGUcW4uWGi9kb/lJ
         mwIfCi8b+9mhXE3lueGO9jxHHvrIws05bcZusfrUve2a4WfASGt0hCcRpBPvuOpGeqNt
         +u1YVqcQmAcQmbYsdwfu15Z6jUKUWB9OEm17VNbKbMouDnxnjH2qXjXiFKfGqFXp+BAU
         k04j2GRJmVBVCJD0CTZzAxDX5usOgFHZVHIzDi7Q183OkWHzrM73ZrrbK9TEjmgRdINp
         x9yLeWEcdLlOcBG3SZz8BMTWKZTNg52iRmRsD8N/tRPx5epxIE32FbIPf9XnVVSR5l6l
         wRtw==
X-Gm-Message-State: AOAM531wZKhQtg3X1C+n0KTheVLuZGnmr5U+wzGy/DNw/syjBiDjKhe8
        0fn8ykAKraaFR/iPCEtMyzobTJlFjHQ=
X-Google-Smtp-Source: ABdhPJy70GFvArqMi2mgfoq2tY3XsrKET+a2LQC62Miw0p6xa4bHHnAdp9Xaq4fHExO9rI2jeHDbJA==
X-Received: by 2002:ad4:404b:: with SMTP id r11mr3286859qvp.44.1590674153409;
        Thu, 28 May 2020 06:55:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e34sm5186424qtb.21.2020.05.28.06.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:55:52 -0700 (PDT)
Date:   Thu, 28 May 2020 09:55:52 -0400
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        matthewb@google.com, jsbarnes@google.com, vapier@google.com,
        christian@brauner.io, vpillai@digitalocean.com,
        vineethrp@gmail.com, peterz@infradead.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Subject: [PATCH] sched/headers: Fix sched_setattr userspace compilation
 breakage
Message-ID: <20200528135552.GA87103@google.com>
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

This also causes a problem with using sched_attr in Chrome. The issue is
sched_param is already provided by glibc.

Guard the kernel's UAPI definition of sched_param with __KERNEL__ so
that userspace can compile.

Fixes: e2d1e2aec572a ("sched/headers: Move various ABI definitions to <uapi/linux/sched/types.h>"
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
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

