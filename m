Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D537D24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="iq1+IOT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgANMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:24:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46238 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgANMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:24:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so11910672wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 04:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mSoKlTvMJsvy/aWRaeQ2pQkJgO/oDfhepfqApYUWHY=;
        b=iq1+IOT0TSlUk5bWsYYbaKhXsd8S3JjZHsCYS/tkRtbI4ywzBvUpEU52kcoNqC61SK
         9rKM0kn99StxumghVrT/mXaVOEwXX/QBt1h0+vx61hihI+gx7v7+7Kp5TBSOna/LkAam
         n9ZBC3EUmYB0j8BLWInMbsRO2reicDCaW5jSIZL5JbWoUtaF11kH8dlYiS0dxOMOXuLN
         k3VbLXBYx/xYvWkt5wjThwQhEvfU+zdbcuYFX2IUtTBl6Ds8YCv3N+Ga/FaPydwTOvk9
         4BBCdr+KdYFp390biCT/5eJBKlVtnFDymbAc/0sXEK9tt/j4sz+hA0g4BzHbay7EPRfl
         wS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5mSoKlTvMJsvy/aWRaeQ2pQkJgO/oDfhepfqApYUWHY=;
        b=SbFsSKFQOItZ8AHnuvCjmE2FksNNBrQz9Y1v8x8jTmoO3BxJVGpWdorir3J+EQDYHi
         gVMa0PhCm27h10Pr6wxP/kWBOKHZXZ4IC01Er47OJrloJur7eveb625VHIMz9Ns004bS
         z4sWktM4lJmFrGUeXVtOGKK6D/jwSOUoj3Ztg7AePTcNXD7MVsVa5A0uIEWBzw2BVAig
         dbFHG2GwXCSGTfkJ6Hyhga9TdSPFBqOYRG/EVrLd1F+OxZudUwQa2/uV2dVzWlP075cc
         1FP4ZUQtIe9vMZKBdeGOimdfNyb9aAqZ3oZpf73jba9xDq48KHhD79CQw2cXdc0brELb
         h+iw==
X-Gm-Message-State: APjAAAWvVAs935WUAs26KjrCKgGyzdIsuKhs18OVTXQccOo5T9GNXpCk
        1YgGtnHtcGrPTptnZzy1UVWhiTcr/2cl5Q==
X-Google-Smtp-Source: APXvYqyqUluW7UuOqo2cVVnIaPGVRw5RC1I1zsAWEnAALlO7VICIDKAAz4ujBRY5BJTHLDIQjGN59g==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr12029783wrv.108.1579004662239;
        Tue, 14 Jan 2020 04:24:22 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v3sm19257860wru.32.2020.01.14.04.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 04:24:21 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Subject: [PATCH] microblaze: Kernel parameters should be parsed earlier
Date:   Tue, 14 Jan 2020 13:24:20 +0100
Message-Id: <a0f1570686e4cb99025d0c0b571f07a84d6467d9.1579004658.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel command line should be parsed before mmu_init is called to be able
to get for example cma sizes from command line. That's why call
parse_early_param() earlier in machine_early_init().

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index effed14eee06..34a082b17a01 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -54,7 +54,6 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 
 	setup_memory();
-	parse_early_param();
 
 	console_verbose();
 
@@ -177,6 +176,8 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	/* Initialize global data */
 	per_cpu(KM, 0) = 0x1;	/* We start in kernel mode */
 	per_cpu(CURRENT_SAVE, 0) = (unsigned long)current;
+
+	parse_early_param();
 }
 
 void __init time_init(void)
-- 
2.24.0

