Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B7206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590200373;
	bh=CgZHkHy2mvXqWsg2YEuqDuXbCsXwNrmdJLxMdAttHs0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AgVa2FqVHH5PzLmLFJbQTf87zUjfenbJ+haJmDEOaJyB2rx4Zr3w88RjMdpZlQ4WJ
	 CDF0cS+nr9WH6PDVgl/hMw5t93+X9Rd5/lT7ybVltXvEzKWvJFVUin4HyO4oS71a6N
	 XXXmEf8IC5fawVWr0y1cT7oMVMcPUGsxZzbCDlLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbgEWCTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387509AbgEWCTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:19:32 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2538C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 19:19:31 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p123so2553072oop.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDW0mTtlaqSqjD3Jsg1LsTRcbiGbsYSGFRbl6IJT/6Y=;
        b=ejui8uar7rXTLRR/mjH0od/ogRK56HLuhH/EoNoOJU94vKCtt7YHfZo4DvDlaruTNs
         I1WcMzL8UGF3hfhjWP5iQfh0yVefXwtSqAdTxj2rngLZKafpAHqUXYvOENRmEyiEorgj
         2vDM6MMljJnzMiNs9Zw41MIxoITdRFXafEXUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDW0mTtlaqSqjD3Jsg1LsTRcbiGbsYSGFRbl6IJT/6Y=;
        b=LlLVSiH7yG1rXjQku4iHtEXl609G7sOg9p7KHhO4mlMUYQI3/613ICjGpOMDpmQ+IZ
         lYfRa8fuZxvfo3OE/ROlrphU5zWiEyyR4ToFqqeJtn94q9V8SgcQP58U5oL2/JArAHN1
         Pomb0176JuLQZnK8Q/E0O8eV8J0Y2xpSFPGZasdbYuyfV5s8XTWqvvMg4N/GfOvTXRs2
         cRu44LCnXo9YDRxdgAtV6I6BvtcBzMkkhFpp2a+b6jwPUnTno3ZBtp/FVnL2YjDxriDc
         pKlBp2lVdoXHU2SYXg/AOrbGqQzifdNHh7ZWVNC8BCR4VEV31Sr3QstR1YWgQqtDws5i
         rPdQ==
X-Gm-Message-State: AOAM531CDLwhfpp+dhMNxUSMIvND8a85LnCT7k+o5t6JuIlpFvnBbefT
        Fv/W8i5hOpvhKI4m+uTxOMeixR7F6AU=
X-Google-Smtp-Source: ABdhPJxPxeCQFdX3eTVyc53z5/Wd3nDdUF+HUy6OXjg2TB/g9burWWBbcKJ09LtEeuGO+pxBxV/tZw==
X-Received: by 2002:a4a:7046:: with SMTP id b6mr5350454oof.9.1590200371078;
        Fri, 22 May 2020 19:19:31 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b19sm3176624oii.1.2020.05.22.19.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 19:19:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update my maintainer entries to reorder email addresses
Date:   Fri, 22 May 2020 20:19:28 -0600
Message-Id: <20200523021928.67126-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_maintainer.pl picks only the first email address found in the file.
Reorder my email addresses so it finds my linuxfoundation.org email.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..dbad8b18bfe6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4404,8 +4404,8 @@ F:	include/linux/cpuidle.h
 
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
-M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+M:	Shuah Khan <shuah@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	tools/power/cpupower/
@@ -9238,8 +9238,8 @@ F:	include/uapi/linux/sunrpc/
 F:	net/sunrpc/
 
 KERNEL SELFTEST FRAMEWORK
-M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+M:	Shuah Khan <shuah@kernel.org>
 L:	linux-kselftest@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
@@ -17484,8 +17484,8 @@ F:	drivers/usb/common/usb-otg-fsm.c
 
 USB OVER IP DRIVER
 M:	Valentina Manea <valentina.manea.m@gmail.com>
-M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+M:	Shuah Khan <shuah@kernel.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/usb/usbip_protocol.rst
-- 
2.25.1

