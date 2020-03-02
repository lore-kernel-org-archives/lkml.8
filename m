Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C375C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD41B24677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+H+SNwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCBScW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:32:22 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:42852 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:32:22 -0500
Received: by mail-pl1-f177.google.com with SMTP id u3so108678plr.9;
        Mon, 02 Mar 2020 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XOGS7l9HvCLkL/Ca6VaW0Z7YxhyZD65Hc+/iXSNMm1w=;
        b=D+H+SNwyOb1uwWqOXYfe7Vtlqu2lIMmc7cX4+rAUVwDV7J1QBn6WGg3Cp4LqKykkpo
         MrS0MNDfk8lf5p+n3aYjYGu+twinmiJ4dcW8ZRmXF9TEmvPn5/q9Xu4fWUGS8c4SY5Yt
         CQMGYGSnQ9bdB7fEaioP055eJjQNLPpgryEN9QdeC0li+Riwm3VpzxHZe255zBo3PVrS
         uVAj3XiYUi3cdkt9ZVAgh8XkjL5BkwEWTlbuys3om9ppynclGKObWCCVpRoIrwvelEn5
         V9qkX1hH5WCSSiWN4Udt77Z5/a7VLvXGx4rmmBg3G8zWKzdccT6iyoMRlU89aW63ahJx
         u5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XOGS7l9HvCLkL/Ca6VaW0Z7YxhyZD65Hc+/iXSNMm1w=;
        b=bnQObX0pI5Yf4mVfpd5z0r41mpvDIZlHkoPp0jKmBSdgqCzDDnpDYGm1eAFvCe3mvb
         3RotSwkFjAlIfaMspBrREsyaE0Btbz1LLks8qnJ5SItYMyqOBvAm/7AA0C48OWqUc9V7
         g+po2rOLxyN4K6fruOyqNg2e02AWLygBcWJ6F7K89oK65LX8MelwrxCwRMfTKXJAFMa0
         R/3QJ155z/E3l23LfezM7uOmepBVAl+Kd9Z+aEI4Qzw/oogfZrzitR0ZAA1lL3Lsq3Im
         v55sCmXTbmrdI1HtXLS0y4GgI9Q+0T9A6m1kQI2zMgxAMlExhykB7BRaRSOn1jl5VMnv
         +XCQ==
X-Gm-Message-State: ANhLgQ3yHiSwoCx4iVh4sA3pYFfnsyoLEKIu6uX9VzlB3YQtSfEYeJCn
        Jvub+G2Vg5DMoS2/0uiLDQo=
X-Google-Smtp-Source: ADFU+vvCJhg7ByUBJicumo+sQEK+AtxZa+87yFru/+XH2ceA0BHAgSoyhCDHgrpxzoCh9u2hzFwSgA==
X-Received: by 2002:a17:90a:fa93:: with SMTP id cu19mr254565pjb.166.1583173940626;
        Mon, 02 Mar 2020 10:32:20 -0800 (PST)
Received: from localhost.localdomain ([2405:204:800a:15c3:b0b0:78ba:d728:349e])
        by smtp.gmail.com with ESMTPSA id r145sm22508484pfr.5.2020.03.02.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:32:19 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 2/2] Documentation: Add io_ordering.rst to driver-api manual
Date:   Tue,  3 Mar 2020 00:01:05 +0530
Message-Id: <20200302183105.27628-3-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302183105.27628-1-pragat.pandya@gmail.com>
References: <20200302104501.0f9987bb@lwn.net>
 <20200302183105.27628-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add io_ordering.rst under Documentation/driver-api and reference it from
Sphinx TOC Tree present in Documentation/driver-api/index.rst

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 Documentation/driver-api/index.rst       |  1 +
 Documentation/driver-api/io_ordering.rst | 51 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/driver-api/io_ordering.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index e9da95004632..9335412e3832 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -80,6 +80,7 @@ available subsections can be seen below.
    isa
    isapnp
    io-mapping
+   io_ordering
    generic-counter
    lightnvm-pblk
    memory-devices/index
diff --git a/Documentation/driver-api/io_ordering.rst b/Documentation/driver-api/io_ordering.rst
new file mode 100644
index 000000000000..2ab303ce9a0d
--- /dev/null
+++ b/Documentation/driver-api/io_ordering.rst
@@ -0,0 +1,51 @@
+==============================================
+Ordering I/O writes to memory-mapped addresses
+==============================================
+
+On some platforms, so-called memory-mapped I/O is weakly ordered.  On such
+platforms, driver writers are responsible for ensuring that I/O writes to
+memory-mapped addresses on their device arrive in the order intended.  This is
+typically done by reading a 'safe' device or bridge register, causing the I/O
+chipset to flush pending writes to the device before any reads are posted.  A
+driver would usually use this technique immediately prior to the exit of a
+critical section of code protected by spinlocks.  This would ensure that
+subsequent writes to I/O space arrived only after all prior writes (much like a
+memory barrier op, mb(), only with respect to I/O).
+
+A more concrete example from a hypothetical device driver::
+
+		...
+	CPU A:  spin_lock_irqsave(&dev_lock, flags)
+	CPU A:  val = readl(my_status);
+	CPU A:  ...
+	CPU A:  writel(newval, ring_ptr);
+	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+	CPU B:  spin_lock_irqsave(&dev_lock, flags)
+	CPU B:  val = readl(my_status);
+	CPU B:  ...
+	CPU B:  writel(newval2, ring_ptr);
+	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+
+In the case above, the device may receive newval2 before it receives newval,
+which could cause problems.  Fixing it is easy enough though::
+
+		...
+	CPU A:  spin_lock_irqsave(&dev_lock, flags)
+	CPU A:  val = readl(my_status);
+	CPU A:  ...
+	CPU A:  writel(newval, ring_ptr);
+	CPU A:  (void)readl(safe_register); /* maybe a config register? */
+	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+	CPU B:  spin_lock_irqsave(&dev_lock, flags)
+	CPU B:  val = readl(my_status);
+	CPU B:  ...
+	CPU B:  writel(newval2, ring_ptr);
+	CPU B:  (void)readl(safe_register); /* maybe a config register? */
+	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
+
+Here, the reads from safe_register will cause the I/O chipset to flush any
+pending writes before actually posting the read to the chipset, preventing
+possible data corruption.
-- 
2.17.1

