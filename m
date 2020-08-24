Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF68221E2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258306;
	bh=68+uDGRHiR1o4sreSUC+OlMMQwX6A8IQY+k1l9Klt4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Dbe1Cau/tI/+j+OUbjunaSuQSD66lDH7mJyzEoZhcxUKxkXZPGBFZOpC7I4/oyjN
	 Hx5Jnqx9ZOtNQe33ei+HmajFCdvBrzlp9qkQpxxUcX6hEF4FtTuJwrZLE4LOwgYKOo
	 vtpsXlEqh+GFLBbUDRA/6mbOJiCZzJVX0KTGzkbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgHXIiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgHXIiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01B722B47;
        Mon, 24 Aug 2020 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258298;
        bh=68+uDGRHiR1o4sreSUC+OlMMQwX6A8IQY+k1l9Klt4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gf6CI+qWcRocvSmHUqeKc4dmLq7Jg1whnZYG98+eB9wpcs32YrH0sjkudByeVk3q1
         ZYhAwXNMIQbH08gV1FEwx+Xw05+7yLOB918bvbzUynVZLPBNeiwQkBTIu3PYSX5VpL
         WjKyL0wv7kPvWtKe/Zfj2JUA489HNio3gzVcI8w0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.8 146/148] efi/libstub: Handle NULL cmdline
Date:   Mon, 24 Aug 2020 10:30:44 +0200
Message-Id: <20200824082421.017949583@linuxfoundation.org>
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
@@ -187,10 +187,14 @@ int efi_printk(const char *fmt, ...)
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


