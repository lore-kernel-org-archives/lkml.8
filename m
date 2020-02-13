Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7F6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608121;
	bh=tC9cEW+ryI8p9lRdNHxjFGOCMp+uK5CPyG52NOUYjkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDebO1MpSTP4/SRsivi6Gu6Koq+5iCnmWpOC/dKbx6TJ+NgKTmPTg607UrvWfaS/Z
	 RWIhhi+3wyF7R3lZbfuKXYrxA3fbW+ujWqF6RjaxTELmF9bUVqeaqbi3KGQj3dHGE+
	 4u3fpARfrITOxIz1ChAISsI1HT2u+s8ibxJQ2Vrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgBMPb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387452AbgBMP2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:11 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74524206DB;
        Thu, 13 Feb 2020 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607690;
        bh=tC9cEW+ryI8p9lRdNHxjFGOCMp+uK5CPyG52NOUYjkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TswAhUV1yFxFLVeiRDVOLeyFG/Sh0kRQ4UT9LMtXVIgKPI12f2kBtiRRDf8JeI0J9
         OhV8Bcxr45IEfH8zrI6CmLkWepBoo+XK9kANUqk4rg1APWx2uTfGcf6YA5sRT5My3L
         fr1Gh65ErxHgqIldwEn/dz3LPF8wxJlEjoEKZp7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.5 028/120] nfs: NFS_SWAP should depend on SWAP
Date:   Thu, 13 Feb 2020 07:20:24 -0800
Message-Id: <20200213151911.616830861@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
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
@@ -90,7 +90,7 @@ config NFS_V4
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
-	depends on NFS_FS
+	depends on NFS_FS && SWAP
 	select SUNRPC_SWAP
 	help
 	  This option enables swapon to work on files located on NFS mounts.


