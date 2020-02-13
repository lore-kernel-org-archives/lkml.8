Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB0C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301262073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609187;
	bh=YWwsiAPRyvw4xteGMCEmiUmKRJ6fxQY1oH9OoFfKU2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u0sy6Fwz5FE/md8OR0NPPsstI3DWdG45xklRcO5xmevxdRkhosI5CvlyCHyeEqFO6
	 9s9TVg57vb9yVON9+OpjXTHjwff1YoIaykDDuIR06LO6Xbs4zxdYjvncM1jwhdZ+aX
	 v7eMwl0aphzp0wLCWPfJw3xA+n4vfvAUU0CMKmqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbgBMPxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgBMP0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:06 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744B2246A3;
        Thu, 13 Feb 2020 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607566;
        bh=YWwsiAPRyvw4xteGMCEmiUmKRJ6fxQY1oH9OoFfKU2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOdTDgBoh/hxV4HtZGNbcNuhtJc2nzT6aqPJlO8NRUsZi1yNKxmihm8tWX1xENxAS
         2pGxzKroU1z1yFj/38F95d75Cwz6ARSMA1+UGjpJY4En66a9cVM+GoK8fBuXmPEpTX
         V+3mmN949qeDBK24HbT93+Xykcu61BAVFB3vGFpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 157/173] tools/power/acpi: fix compilation error
Date:   Thu, 13 Feb 2020 07:21:00 -0800
Message-Id: <20200213152010.934536388@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>

commit 1985f8c7f9a42a651a9750d6fcadc74336d182df upstream.

If we compile tools/acpi target in the top source directory, we'd get a
compilation error showing as bellow:

	# make tools/acpi
	  DESCEND  power/acpi
	  DESCEND  tools/acpidbg
	  CC       tools/acpidbg/acpidbg.o
	Assembler messages:
	Fatal error: can't create /home/lzy/kernel-upstream/power/acpi/\
			tools/acpidbg/acpidbg.o: No such file or directory
	../../Makefile.rules:26: recipe for target '/home/lzy/kernel-upstream/\
			power/acpi/tools/acpidbg/acpidbg.o' failed
	make[3]: *** [/home/lzy/kernel-upstream//power/acpi/tools/acpidbg/\
			acpidbg.o] Error 1
	Makefile:19: recipe for target 'acpidbg' failed
	make[2]: *** [acpidbg] Error 2
	Makefile:54: recipe for target 'acpi' failed
	make[1]: *** [acpi] Error 2
	Makefile:1607: recipe for target 'tools/acpi' failed
	make: *** [tools/acpi] Error 2

Fixes: d5a4b1a540b8 ("tools/power/acpi: Remove direct kernel source include reference")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/power/acpi/Makefile.config |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -18,7 +18,7 @@ include $(srctree)/../../scripts/Makefil
 
 OUTPUT=$(srctree)/
 ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/power/acpi/
+	OUTPUT := $(O)/tools/power/acpi/
 endif
 #$(info Determined 'OUTPUT' to be $(OUTPUT))
 


