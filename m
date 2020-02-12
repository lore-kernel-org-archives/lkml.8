Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A344C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6C206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Sh7V73s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgBLH4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:56:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44504 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgBLH4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:56:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so943154wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mh/8xYu3na/XuIHxJYOKLx0KWfaSmuY/BtV5RYFiydk=;
        b=Sh7V73s2HCgjA2mpcb9wP02CQlv60DcI3k1hkDQS1zYQn9hRo4iIwgh19s2QQgLOvj
         fu8x6CMHjDS4Gn2+sVPH5FrhdCz45E6Qo96+82sRAxZ8bV3c0mf6Hj6EXqQP/fLZPIRc
         fZLs1x8bm5xl33kmKPAsIUAkAwRrZxZKWxncKeLeYdb/5KE9WBUvyXfHc9dk0Fnfqs+m
         I/5LZ45W6boGSTajkxdvUCKKucZ0H3vV2xbdhznknJKWo7akjoRa3Ao0diYsug69Zfsi
         DWXcIg+5e85SEnLqRBpsiH03JgxoOm+pPgTn6cZ5CwhlVEzDFvlDl8ZZsSENtRHNy6oS
         Beqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Mh/8xYu3na/XuIHxJYOKLx0KWfaSmuY/BtV5RYFiydk=;
        b=RY9ToPfY9raA3hQ1om/3pNnOUQXAHzxdvWSt12+OHV5qzMRt8xXTlnRH81r9flfM4k
         BfHfvvi10zYPMkPiWdGid20DeKf+UnhZBLsK8DVi7PfvxhA2SB13ALoQOXkGCzL0dWCc
         HzVD59WgNvVwWjybcFs4lVvjEIAvSePnM1KVZ6044XZhydUtCm2ZqPyvO5k+WfH6Tt79
         51/hboPjv2QAzY6BKkEmOoynIA567piA7IDuzJ0o1z+TyonlKhnkHkC8ZgyLO6/5dNPX
         Twi6cYF/QelI9gfRLb0Vi9o1a6iDHo0Vig59JxP3aJ8FwrQZXjAgXCiFueCMjAqvEk5U
         wycw==
X-Gm-Message-State: APjAAAW0A7fgynccZ8azOEN24pW8VGKRg+uOg+B0lWlYHWMadv57vo+F
        Ouh00GsTJ38rlTYLKUGekhMkkK/e/esItg==
X-Google-Smtp-Source: APXvYqzncDAIDRUCeEgCk8x4JD/DKIAZGw2/1utqDYALARNMGncwZWcxUkPjuvA9YBcHFqCG/OStHA==
X-Received: by 2002:adf:e686:: with SMTP id r6mr13827086wrm.177.1581494182042;
        Tue, 11 Feb 2020 23:56:22 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 133sm7840228wme.32.2020.02.11.23.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 23:56:21 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Firoz Khan <firoz.khan@linaro.org>, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH] microblaze: Fix unistd_32.h generation format
Date:   Wed, 12 Feb 2020 08:56:17 +0100
Message-Id: <fe6868726b897fb7e89058d8e45985141260ed68.1581494174.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generated files are also checked by sparse that's why add newline
to remove sparse (C=1) warning:
./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
warning: no newline at end of file

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/kernel/syscalls/syscallhdr.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/kernel/syscalls/syscallhdr.sh b/arch/microblaze/kernel/syscalls/syscallhdr.sh
index 2e9062a926a3..4f4238433644 100644
--- a/arch/microblaze/kernel/syscalls/syscallhdr.sh
+++ b/arch/microblaze/kernel/syscalls/syscallhdr.sh
@@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#endif\n"
 	printf "\n"
 	printf "#endif /* %s */" "${fileguard}"
+	printf "\n"
 ) > "$out"
-- 
2.25.0

