Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC11C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E601A246B6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5T0pypM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCAVjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:39:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35423 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAVjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:39:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so3387802plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 13:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukz24jAlVoK0u9xc7RMDLoYCE0uHvE8+KI4d597Q+pU=;
        b=Z5T0pypMoxMHFK5bluFNozMFA/6CAuR/2UvmG/1qUqwCx3nR4vAfJVzZv6DbEBoqZ7
         Ow7cdOQAmoRdJbNdu6Pd7dFMEiWWbl+duldXVGKi9Sj2B1V/5t0Lvitve6qZGhZ+rEiy
         6eDNqWtC/hj1fJzuMe3RmZ2X28tJD5452PdhrDz8HSwcZ+eARtZLQgAL4Pqu3iL6szfe
         3rXbpo9cZguU1O3S9aWxpjug/SDGKE9+l2tAZVbzn6BZ2EnhbQjMorT+NVcX6NNrv1gk
         fVe+tgaiZmagZqkhrfV8GoxUEsUAnV9rI49VFhMB2gXC/R3hw5GdOh65k5cyASfJIYXI
         H8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukz24jAlVoK0u9xc7RMDLoYCE0uHvE8+KI4d597Q+pU=;
        b=TG1ImQX0yBrJlcD2a3yfof7hKJbMRHBgmI8tGsaL+lKIowK5sFhK4hRowaJVWIn3WE
         dt9fqfL485f9D+9PjsYDInQXzwBLvLJSnpzbpBgNkAdBjwhXCV9bMa1ta8ceLumX2LKm
         lGExESP2YHQtuXyrw4xDXwkThVBxTkjI3SFBtd/IJwaNex8v4N5obcaHfCpanTtH9ZY7
         8sSw4Qa0y5iFo2qIe3A3tZSdzKyFGXCItnWKrwkaj/LRu0fgasfKCv4fNnQf3Hy2sRPM
         4V0fBbSUSC8LvqXTByQaHbI7x+daQrrnh2o7y2IelXuP5Pvn3p7ci1Y6wFSTV9e9YhMf
         +1yQ==
X-Gm-Message-State: APjAAAVh2cpEcZNPKtM79srqgAU0XX6id+9DHR10wcO+AC0nORjZPPnv
        lg8broqwK6BfMq100Axpy8V4uDmz
X-Google-Smtp-Source: APXvYqyI+ZiCb7Ygnrtv0KxNcbuOkdAiN6ZDMxzSZwGMOdAOjFZol9+dbuyAgB13LgKHDa/zNXD9dA==
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2mr13821886plz.54.1583098749143;
        Sun, 01 Mar 2020 13:39:09 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id mr7sm5836640pjb.12.2020.03.01.13.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:39:08 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 2/3] openrisc: Enable the clone3 syscall
Date:   Mon,  2 Mar 2020 06:38:50 +0900
Message-Id: <20200301213851.8096-3-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the clone3 syscall for OpenRISC.  We use the generic version.

This was tested with the clone3 test from selftests.  Note, for all
tests to pass it required enabling CONFIG_NAMESPACES which is not
enabled in the default OpenRISC kernel config.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/openrisc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index 566f8c4f8047..fae34c60fa88 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -24,6 +24,7 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
-- 
2.21.0

