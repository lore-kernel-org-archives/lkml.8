Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94125206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607773;
	bh=FxYiCaXQskh90KrwG3iV7GTqM8cjabD5+J+amsqs1UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLJbtU0b6TOl0Ga5H3EPl6BVJIZMPiCFrMUEyI8TtcvrEeCPviviHSpHdSK2iHekB
	 uNpWwVkFIW/sUbeCCqZu7hE0VCK1Lbv0Hu3og3JhXv8rsEaXsCVgjbyN3UpCPXANS8
	 x6nNsR1VrKFNrtS1CzKrm1THR54vpn4gyNjrGcHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgBMP3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbgBMP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:42 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20040206DB;
        Thu, 13 Feb 2020 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607602;
        bh=FxYiCaXQskh90KrwG3iV7GTqM8cjabD5+J+amsqs1UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFuAlbqXc3IDlOuKChBcDYjfnXK9OXaYMPx0TjZ5APSZpL/X6lLj199f/rX7Eas86
         PNXnR46mQ0K7gYFbUkQ4h1TLrnVq59+tCYe23/5NlwTBSI7tAn4DMP2cAZZ2Xf1WDa
         Mh89IxhrUDnBvRDuU/g2c9Q31YLayZL7xLzK0rAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 12/52] nfs: NFS_SWAP should depend on SWAP
Date:   Thu, 13 Feb 2020 07:20:53 -0800
Message-Id: <20200213151816.036795353@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 474c4f306eefbb21b67ebd1de802d005c7d7ecdc upstream.

If CONFIG_SWAP=n, it does not make much sense to offer the user the
option to enable support for swapping over NFS, as that will still fail
at run time:

    # swapon /swap
    swapon: /swap: swapon failed: Function not implemented

Fix this by adding a dependency on CONFIG_SWAP.

Fixes: a564b8f0398636ba ("nfs: enable swap on NFS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -89,7 +89,7 @@ config NFS_V4
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
-	depends on NFS_FS
+	depends on NFS_FS && SWAP
 	select SUNRPC_SWAP
 	help
 	  This option enables swapon to work on files located on NFS mounts.


