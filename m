Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D2C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A88206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387365;
	bh=HFt2cNSRVwRrNyRATsHeOZAVGfis+zFjOerb5zwBaPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cOlknt8zI0J9d1VYmFksjweFdsAw2+2sH8rYSZUIVowXI6XVYYbHIVGimegMMAK4v
	 X6QzfBFoAk5otwlEZduvEybfQjGvrNxXcbb1+S3VtIV7znZQigfbCtZeLIREXAhxf1
	 Gt9F371NL7xIbMXKoaG173FegR4VZ3vv0007VbNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgDTMpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbgDTMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E32F5206DD;
        Mon, 20 Apr 2020 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386716;
        bh=HFt2cNSRVwRrNyRATsHeOZAVGfis+zFjOerb5zwBaPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLQkEofgu/UP8LlHBJKk5k1FryDwdNGwmMWTrQJ9JuI6peWGWXJtm7h0CWd2vO3xT
         p7vJs8V8VXd4FIpBLkbNPuBLka5aggvmvaOYbKHWJsgHN8iD7fdHKxsopQyAEeceAX
         MPEok8tM/WAFaUv6058LcWMYUpWhloEl/4YbeuKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Allen <john.allen@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.6 70/71] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Date:   Mon, 20 Apr 2020 14:39:24 +0200
Message-Id: <20200420121522.713922830@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Allen <john.allen@amd.com>

commit bdf89df3c54518eed879d8fac7577fcfb220c67e upstream.

Future AMD CPUs will have microcode patches that exceed the default 4K
patch size. Raise our limit.

Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org # v4.14..
Link: https://lkml.kernel.org/r/20200409152931.GA685273@mojo.amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/microcode_amd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,7 +41,7 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
-#define PATCH_MAX_SIZE PAGE_SIZE
+#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
 #ifdef CONFIG_MICROCODE_AMD
 extern void __init load_ucode_amd_bsp(unsigned int family);


