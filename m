Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B0AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413FE2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262192;
	bh=JxS5Yum/Z+HeSk5UjQ1CcxVIHQelmqRDGOtO0+oaPj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJmOk52kvKIB1P4DqWCH5BnSHjJadI7uaAISrnpIqA1F/bu7gBXFhE6jDn5PHKIpI
	 oxoGcotgsWn22ac1ID5bVMYDpiEtQRrsiG2OjfzRL1DUyMFqlAMKE4dFjO4e+TQEnK
	 hmVOvohJaxCXeWCQEmyKD9NBm7IGa9kF1wA+NRv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgHXIoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbgHXIoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033E62075B;
        Mon, 24 Aug 2020 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258652;
        bh=JxS5Yum/Z+HeSk5UjQ1CcxVIHQelmqRDGOtO0+oaPj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSBisL9NUs0jPEHz6wADhXMevpPQMRRw1C/OizZw1zoE9THExnlY/MdvXS1xVpUA+
         q/WAsd1zHd1hkWF+bXZT/fV65MrH84Z/QJk9+s4MxRhndQBTUXWZX/lfvvIWIryaLQ
         AJQINFSkQbWULLCA1wgqJY7wjHAijxhsB4T5nOfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.7 122/124] efi/libstub: Handle NULL cmdline
Date:   Mon, 24 Aug 2020 10:30:56 +0200
Message-Id: <20200824082415.405906791@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

commit a37ca6a2af9df2972372b918f09390c9303acfbd upstream.

Treat a NULL cmdline the same as empty. Although this is unlikely to
happen in practice, the x86 kernel entry does check for NULL cmdline and
handles it, so do it here as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200729193300.598448-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/libstub/efi-stub-helper.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -73,10 +73,14 @@ void efi_printk(char *str)
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
-	size_t len = strlen(cmdline) + 1;
+	size_t len;
 	efi_status_t status;
 	char *str, *buf;
 
+	if (!cmdline)
+		return EFI_SUCCESS;
+
+	len = strlen(cmdline) + 1;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
 	if (status != EFI_SUCCESS)
 		return status;


