Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E3C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B6A20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608754;
	bh=6APSuzR5QQ1pD6w/up3le0id6xut3M8E7VEdJw0ul/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CI/D699doR5ReoxAUr51csluuiQ+K/CFccsNQOwP3VcABQg7R9H8cojDozYqRAKFV
	 TCPpVj96aMiUB5vCJmb7TGxbIr1vE47B2dvZNUnJOEhSIiUe03j2PzmT+i9VV1qmb7
	 MBdiw17Luy8RWww9/HTSQqULxUNxvHhbOGogN1MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgBMPpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbgBMP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:24 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC8824681;
        Thu, 13 Feb 2020 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607643;
        bh=6APSuzR5QQ1pD6w/up3le0id6xut3M8E7VEdJw0ul/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njgVF+Tz7p/k1CwqakA7gQBr3MA68JoHaKKjZNFxk85PqDOEb1puKdJKxS36jUD1x
         tRCb3r4B9nCx/zVs/EePwze2bY5p/Ep0wKElo9rFgROi20O31+r9jqvK4eclUFDS0+
         A3uwtkpzOxT73GBEoK7m+WpfGuL1cDEmn47hWwKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhengyuan Liu <liuzhengyuan@kylinos.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 51/96] tools/power/acpi: fix compilation error
Date:   Thu, 13 Feb 2020 07:20:58 -0800
Message-Id: <20200213151859.191189876@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
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
@@ -15,7 +15,7 @@ include $(srctree)/../../scripts/Makefil
 
 OUTPUT=$(srctree)/
 ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/power/acpi/
+	OUTPUT := $(O)/tools/power/acpi/
 endif
 #$(info Determined 'OUTPUT' to be $(OUTPUT))
 


