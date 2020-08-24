Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACACAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815CA206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262758;
	bh=FHuqGYt9PkW0yhIUAUqjGzka7TWB2CLzxU6+I4s4Uao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nb7XFgLWOkTgJdNjIX11TMPCBgT43xEwFKH+t9/MUybWsPDHNrO54N9HkXR8TOvAS
	 AJuQaFqn0ZmNCPMAICc2VVkHf6/k7mjLxk0jSpoUac3Z9bJ4xl9SLjEKmnAcSRrVTv
	 5XB/7iFwDBGfFny7FuAEmGXbXb9oWW//EPdqovec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHXJwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbgHXIin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007482177B;
        Mon, 24 Aug 2020 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258323;
        bh=FHuqGYt9PkW0yhIUAUqjGzka7TWB2CLzxU6+I4s4Uao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJlpLk/0ovcFkFji45on960UdUCwK/FBJ7RrUnPUyW3yzxKqiVMy9x5Loq8mQpkUo
         y87Lvx/ldW4VDsHVRjz9ZbQddkJVMWJC8aLNY9yBqRtxzqqJskbdSARXcNVtzvZI9k
         JzqpqQ4so+NuZj1CbsBdQmQqsUX1hojb1u8swQ3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.8 147/148] efi/libstub: Handle unterminated cmdline
Date:   Mon, 24 Aug 2020 10:30:45 +0200
Message-Id: <20200824082421.065889947@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

commit 8a8a3237a78cbc0557f0eb16a89f16d616323e99 upstream.

Make the command line parsing more robust, by handling the case it is
not NUL-terminated.

Use strnlen instead of strlen, and make sure that the temporary copy is
NUL-terminated before parsing.

Cc: <stable@vger.kernel.org>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200813185811.554051-4-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/libstub/efi-stub-helper.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -194,12 +194,14 @@ efi_status_t efi_parse_options(char cons
 	if (!cmdline)
 		return EFI_SUCCESS;
 
-	len = strlen(cmdline) + 1;
+	len = strnlen(cmdline, COMMAND_LINE_SIZE - 1) + 1;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	str = skip_spaces(memcpy(buf, cmdline, len));
+	memcpy(buf, cmdline, len - 1);
+	buf[len - 1] = '\0';
+	str = skip_spaces(buf);
 
 	while (*str) {
 		char *param, *val;


