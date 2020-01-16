Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B3BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5ED20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218331;
	bh=L4p5itd9rR/UnKs+CcnjAtWcMPVupUcsYE8+JisDULg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TW2PkrGtLIrYfC5rgLclWc/gTuX8nK0fbES4wEVqDgXvqAJMiIx7rv9EInAGAiwdh
	 RmZVnWfyoFex2FOdb4diUKWLD7gcqP8YruGkNd19Bs+1c5vJwYs3hyy6WDiMfJjSYu
	 0x6eBXHM3+CaSd5v1rISjaiPKSUteiEpUNTvnByY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgAPXW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390953AbgAPXWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414D52072E;
        Thu, 16 Jan 2020 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216973;
        bh=L4p5itd9rR/UnKs+CcnjAtWcMPVupUcsYE8+JisDULg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgDEogqu6F6L06JGg7hrJMa935rD3YrO8RzmwGG5P1fAi7QtQQJEv4zhw9xRSE5T3
         gOgb6bYe7fCf87AqViEHd2lFncwcblvRJSf5WQIUGFQEEMac5yjDD2A5KrgcuKoeZK
         Kwh8BglOGecl9JelhbikvMMlfBCa1QSIx+XXhR/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diego Calleja <diegocg@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 096/203] dm: add dm-clone to the documentation index
Date:   Fri, 17 Jan 2020 00:16:53 +0100
Message-Id: <20200116231754.045692996@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diego Calleja <diegocg@gmail.com>

commit 484e0d2b11e1fdd0d17702b282eb2ed56148385f upstream.

Fixes: 7431b7835f554 ("dm: add clone target")
Signed-off-by: Diego Calleja <diegocg@gmail.com>
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/device-mapper/index.rst |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -8,6 +8,7 @@ Device Mapper
     cache-policies
     cache
     delay
+    dm-clone
     dm-crypt
     dm-flakey
     dm-init


