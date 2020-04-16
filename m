Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650CCC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF232076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046329;
	bh=yJIkyK8GkRpK/3XpjVDYAwzoCs2uv8iHW55ZABuRjzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFuRKBcf4Ol5a9yCjPevGkRwgBOtXauChLQ6uzCsfDkxV+tQ+Y+iI4q46qj8R+w4W
	 gDhWsYxdqrBtpYQhew84D58YTWorOpPZdUodQyeJCiw5HfaTZsleVsqsQRgm3v6Z66
	 wVqPjjcqb/1nqCyLTnPEvFUKH/xGEbHlH6wJepMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgDPOMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898704AbgDPNrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:47:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8251221744;
        Thu, 16 Apr 2020 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044865;
        bh=yJIkyK8GkRpK/3XpjVDYAwzoCs2uv8iHW55ZABuRjzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofug4PuU7O0mOMkYOMCeBhcH/QdqlJ2TclwRa32Ysmf4eHFg1XnhTcPsyOW13JsWd
         3oNZn9uPtJV7xljRjxbWmkYhWIcwV+q+QUI8FcjtSnDYt6jalVwee6S0ntCmb1JPFj
         0DSlaDTcGwS8/+ko3yYmQc32jc4uOKMgM1Hi4i2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 092/232] acpi/x86: ignore unspecified bit positions in the ACPI global lock field
Date:   Thu, 16 Apr 2020 15:23:06 +0200
Message-Id: <20200416131326.512697971@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@inai.de>

commit ecb9c790999fd6c5af0f44783bd0217f0b89ec2b upstream.

The value in "new" is constructed from "old" such that all bits defined
as reserved by the ACPI spec[1] are left untouched. But if those bits
do not happen to be all zero, "new < 3" will not evaluate to true.

The firmware of the laptop(s) Medion MD63490 / Akoya P15648 comes with
garbage inside the "FACS" ACPI table. The starting value is
old=0x4944454d, therefore new=0x4944454e, which is >= 3. Mask off
the reserved bits.

[1] https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206553
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Jan Engelhardt <jengelh@inai.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/acpi/boot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1740,7 +1740,7 @@ int __acpi_acquire_global_lock(unsigned
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
 		val = cmpxchg(lock, old, new);
 	} while (unlikely (val != old));
-	return (new < 3) ? -1 : 0;
+	return ((new & 0x3) < 3) ? -1 : 0;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)


