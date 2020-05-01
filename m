Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B8C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6910E205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340536;
	bh=7ACioUpGvxF1j7icMOqHMIk8C56G4vDbxmfYP/7Jros=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwrC3G5m1AAV9j7WD1yC2JTIyduh5g+/qgwEtD5zoSvjzLNJl7UMXCAIS6BolwSb0
	 0yPcNfgW2BYc1IJpQwfww6Vk86yVBBdoenHgXhO+olvxvrsWQRyQ0ftc9fcMcB3E85
	 dbgG7kgbnbBJIlt0FD8d4RK+OJZNKus4RRkZeLY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgEANmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730702AbgEANmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:42:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042F9216FD;
        Fri,  1 May 2020 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340526;
        bh=7ACioUpGvxF1j7icMOqHMIk8C56G4vDbxmfYP/7Jros=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZ4jUS+tG82zRCRSCWXqAtv1jsEgfD9XKt8oQXg99bTYbKwP9u1MpxduhZ4rgKUZx
         PncGlVjB//DoIyLcsxRwI65KOVh5nCyg3y6+F8/IY0D75I5YI44p/FXhw8Gfgj+w7B
         isFHvieXad96ZwtN2mY0Kr9YqDAhuVjtNbvAZF28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Rorvick <chris@rorvick.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.6 018/106] iwlwifi: actually check allocated conf_tlv pointer
Date:   Fri,  1 May 2020 15:22:51 +0200
Message-Id: <20200501131546.357715759@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Rorvick <chris@rorvick.com>

commit a176e114ace4cca7df0e34b4bd90c301cdc6d653 upstream.

Commit 71bc0334a637 ("iwlwifi: check allocated pointer when allocating
conf_tlvs") attempted to fix a typoe introduced by commit 17b809c9b22e
("iwlwifi: dbg: move debug data to a struct") but does not implement the
check correctly.

Fixes: 71bc0334a637 ("iwlwifi: check allocated pointer when allocating conf_tlvs")
Tweeted-by: @grsecurity
Signed-off-by: Chris Rorvick <chris@rorvick.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200417074558.12316-1-sedat.dilek@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1467,7 +1467,7 @@ static void iwl_req_fw_callback(const st
 				kmemdup(pieces->dbg_conf_tlv[i],
 					pieces->dbg_conf_tlv_len[i],
 					GFP_KERNEL);
-			if (!pieces->dbg_conf_tlv[i])
+			if (!drv->fw.dbg.conf_tlv[i])
 				goto out_free_fw;
 		}
 	}


