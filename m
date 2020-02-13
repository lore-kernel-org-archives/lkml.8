Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACCC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26909218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607681;
	bh=QU5hlEcn8A5qyauh+f5DdOPlzw74Il9ZLeMFavcEx8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2DdkG6pUo9IfnD4W3aiWDv2K5pMJuTQpWfo0shiHYSeFl3vZJu2NeiYYaFukBDTG
	 xciRRWcvYMlBh2VzH4yYsZ86Vvv/yYW8xVdrEFr3FPdZI1Fo6/Lw9blGec6n7+JQih
	 Y0AwR37QMnKBr6l+Wx3VrCGEVrAj9TYCgMEQprOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgBMP16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbgBMPZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:40 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C5F24693;
        Thu, 13 Feb 2020 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607539;
        bh=QU5hlEcn8A5qyauh+f5DdOPlzw74Il9ZLeMFavcEx8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiHcqdUr9OTviKbiQSWHnqTR9HzmRE59Df2WkGe5DhBADZlL+x/3Wuy7IS9ki/jgr
         LE9uP3Hzyf90drwACldYYL1GnYZHop2RMfDpNq9PhhXrdvU0B9OOdE7qDDUfy0SL1n
         1fNuc9FSgC2rFooNDGam+t4XCCAAI/bXH7VC928w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 108/173] ubi: fastmap: Fix inverted logic in seen selfcheck
Date:   Thu, 13 Feb 2020 07:20:11 -0800
Message-Id: <20200213151959.862589401@linuxfoundation.org>
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

From: Sascha Hauer <s.hauer@pengutronix.de>

commit ef5aafb6e4e9942a28cd300bdcda21ce6cbaf045 upstream.

set_seen() sets the bit corresponding to the PEB number in the bitmap,
so when self_check_seen() wants to find PEBs that haven't been seen we
have to print the PEBs that have their bit cleared, not the ones which
have it set.

Fixes: 5d71afb00840 ("ubi: Use bitmaps in Fastmap self-check code")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/fastmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -73,7 +73,7 @@ static int self_check_seen(struct ubi_de
 		return 0;
 
 	for (pnum = 0; pnum < ubi->peb_count; pnum++) {
-		if (test_bit(pnum, seen) && ubi->lookuptbl[pnum]) {
+		if (!test_bit(pnum, seen) && ubi->lookuptbl[pnum]) {
 			ubi_err(ubi, "self-check failed for PEB %d, fastmap didn't see it", pnum);
 			ret = -EINVAL;
 		}


