Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1526C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01D720673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607391;
	bh=dpfyoqYK+cIid3t/XNrCEQrJnEpFdEWoOdbgFnCpj9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ufkW8X8mV4NkK2XWsq5ngOvy6gW8J6+ZjkxcTMACT0HksqAAq4D7SR9x2dsrXlQT8
	 9GTtPKBLrLvp1+iSebL4tSSmBWdGZHU7im6aYh1/Mc4njEkNR14y2+nZ5DxRxmf+8Y
	 UtbSHbCmJC890i6K1KWJ9+oV1+aU+q0To1f9t7ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgDKMQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgDKMQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB62620644;
        Sat, 11 Apr 2020 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607385;
        bh=dpfyoqYK+cIid3t/XNrCEQrJnEpFdEWoOdbgFnCpj9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueH+lVx8n4v5MHMBRB8+uwjseSy7LSwMm0PwViGH6YBdUEztiGo9KztJJh5qOy7rw
         9a9GBkPvaeGKOsU19PKDGZhr5jwLvzlQBob53sZy3FQiu8+8ntB7CyV9RK784fn0Zj
         YC6yXBvo7GIwuHnQXaepRpabJzbz/yJ30fAmzu+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Arun KS <arunks@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 51/54] arm64: Fix size of __early_cpu_boot_status
Date:   Sat, 11 Apr 2020 14:09:33 +0200
Message-Id: <20200411115513.777221979@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun KS <arunks@codeaurora.org>

commit 61cf61d81e326163ce1557ceccfca76e11d0e57c upstream.

__early_cpu_boot_status is of type long. Use quad
assembler directive to allocate proper size.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Arun KS <arunks@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -667,7 +667,7 @@ ENTRY(__boot_cpu_mode)
  * with MMU turned off.
  */
 ENTRY(__early_cpu_boot_status)
-	.long 	0
+	.quad 	0
 
 	.popsection
 


