Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB5AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB7120829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826151;
	bh=CxSv7JTE+Z4S7Ced+QnkcXxppRq20djSJS8RXlB++b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rivi8W+5/CULXzMGGcbD6x+90x09MaNqsMF2huBT2K+Voq/asyr4zEanC3UbUkeud
	 jeqEpp2uMsLQpMb0OOEv8abQMfDXqJoiVtGkVRqPY6yJyJ82v0PSv1Zrw5YcF0OPSd
	 pTIqxSSjXRHeATmj5ptLVXbTtJaFFE/YecNZrzwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgERRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbgERRuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B4420674;
        Mon, 18 May 2020 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824222;
        bh=CxSv7JTE+Z4S7Ced+QnkcXxppRq20djSJS8RXlB++b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv49LDpLdyX0vmCX3/MCCRpdXgvPKNNpP3GAV15AbqRN1niNfeSaTGGT79yvHp/1r
         yO1nFOo8o8wiAngRGijLTPmL5DClqn565kFe9V62ZDjNz6r/2JhYcItvjal9MeA+KF
         VnfnHJBNFtdDuReOHvzfdqvwHjeO94HdvmurPN7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 074/114] gcc-10: disable zero-length-bounds warning for now
Date:   Mon, 18 May 2020 19:36:46 +0200
Message-Id: <20200518173516.213881860@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 5c45de21a2223fe46cf9488c99a7fbcf01527670 upstream.

This is a fine warning, but we still have a number of zero-length arrays
in the kernel that come from the traditional gcc extension.  Yes, they
are getting converted to flexible arrays, but in the meantime the gcc-10
warning about zero-length bounds is very verbose, and is hiding other
issues.

I missed one actual build failure because it was hidden among hundreds
of lines of warning.  Thankfully I caught it on the second go before
pushing things out, but it convinced me that I really need to disable
the new warnings for now.

We'll hopefully be all done with our conversion to flexible arrays in
the not too distant future, and we can then re-enable this warning.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -800,6 +800,9 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # disable stringop warnings in gcc 8+
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
+# We'll want to enable this eventually, but it's not going away for 5.7 at least
+KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
+
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
 


