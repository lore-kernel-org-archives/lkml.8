Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E7C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEEF2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="kANUyGec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgAXJSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:18:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34141 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgAXJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:18:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id f2so475412pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RcxGgdRV5d1ycPgKGQshU3Dx8E58q2RM4BSH6L50H0=;
        b=kANUyGecpiYvb2WO2ikFMEFOaN9u2zq3XlV+Z5Nw/EA8/DlRMoPGwX73EyF2cCBkZt
         pcSrQchshZZ/6y7WX2YPWRhg9sC6oKm+hohz1m9VbDg9ARdka/rVoRBDAPEiMwrgT4x7
         0hvAnZKvMXI0h46+4EY5QHhcIhncztG0rzfcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RcxGgdRV5d1ycPgKGQshU3Dx8E58q2RM4BSH6L50H0=;
        b=m4DdaG61rIXERlrLyi/6Raairu6LxAlIEbGSYDGP/BJYrFjfPwc8JvmLwNEpZXIfsu
         zqcvynm/JIkpUiTtgyG7GdaMvTAG4ECnPSB59/NDfLj75/3+41Xbts0lPY7zO/TARw4z
         i0z5IwwVEWFDsk/uOA/vu/hWOKFGFv8othoOX9oj8hCXKH7qVLltdlmt+0w1Fh8okTs0
         IahzPfHzxxW0S1GaDYaXlqDXFZyny5azv7nAU7KVEomnEc0dfr5dUkoNK9N0gIJWYBLa
         /QyOQcmXMsV409YptTcOmjQA2Al8ZWhql+U89CgDCY2/+LlLkzGThTGqxKEmlKaWRyOe
         QUCg==
X-Gm-Message-State: APjAAAW2DFcxJEXZnWBIaDcQV24lSGoWzslOJiXq3gRmYSUEhivE15V6
        ZQDQZsb32txBdlq2c12h6+tdjEbF+ayyow==
X-Google-Smtp-Source: APXvYqx1b2xzIF8PeZ6R4Bhfq1a/HDT+lOtsd1FQcTEZpaUwRHyP1m1M56OAz1kKECc2oz1uyuHobQ==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr2533438pln.185.1579857479183;
        Fri, 24 Jan 2020 01:17:59 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:17:58 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 1/4] pid: Add pidfd_create_file helper
Date:   Fri, 24 Jan 2020 01:17:40 -0800
Message-Id: <20200124091743.3357-2-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124091743.3357-1-sargun@sargun.me>
References: <20200124091743.3357-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper allow for creation of pidfd files. The existing helper
(pidfd_create) creates file descriptors directly, which cannot
be used without race conditions when there is an intermediate
step between creation, and informing userspace the fd has been
created.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/pid.h |  1 +
 kernel/pid.c        | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 998ae7d24450..70d4725cf8da 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
 struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
+extern struct file *pidfd_create_file(struct pid *pid);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 2278e249141d..2a34db290128 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -521,6 +521,28 @@ static int pidfd_create(struct pid *pid)
 	return fd;
 }
 
+/**
+ * pidfd_create_file() - Create a new pidfd file.
+ *
+ * @pid:  struct pid that the pidfd will reference
+ *
+ * This creates a new pidfd file.
+ *
+ * Return: On success, a cloexec pidfd file is returned
+ *         On error, an err ptr will be returned.
+ */
+struct file *pidfd_create_file(struct pid *pid)
+{
+	struct file *f;
+
+	f = anon_inode_getfile("[pidfd]", &pidfd_fops, get_pid(pid),
+			       O_RDWR | O_CLOEXEC);
+	if (IS_ERR(f))
+		put_pid(pid);
+
+	return f;
+}
+
 /**
  * pidfd_open() - Open new pid file descriptor.
  *
-- 
2.20.1

