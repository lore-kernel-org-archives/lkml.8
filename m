Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB02C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A73B20732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623105;
	bh=Q4ze9RNhPw9/2gdiRhp0T2htBiBYKR/rd4T7I4hwO2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ideBEFrJLpl2sPJhaQKyaRrH8R+UvazkJZ54q3A4zNLvrfLCEkoo+jUCaxcBgwmvc
	 /PEmG5OKNGJ0jcQvbqT7jw4OOMuKYP7FDFEwxO1F1vgb0+hTkYt6mwFNYGrRcK0Fx/
	 tupEaZqNVT8Tx5MptomT0+0nj/KFzIC3C6hBEzyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCSNFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgCSNFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C539D20732;
        Thu, 19 Mar 2020 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623103;
        bh=Q4ze9RNhPw9/2gdiRhp0T2htBiBYKR/rd4T7I4hwO2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YW3gveMFKcGrpk6c6PIGRx63PGVpz/OvqvOlqOLzHhDBoI/h6EvUvGplZ6F0IUF/o
         sB65Vs0qJn5RkqIcA9ZjgA5mb2k6aFP/XGTXF2nOZB+YC5Vc2ueYgeahQyvvgYlq9t
         RgZJMlaBIkAX+QBYGCtisCGKDGkSH18ypf9jnViQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Malat <oss@malat.biz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 01/93] NFS: Remove superfluous kmap in nfs_readdir_xdr_to_array
Date:   Thu, 19 Mar 2020 13:59:05 +0100
Message-Id: <20200319123925.195750467@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Malat <oss@malat.biz>

Array is mapped by nfs_readdir_get_array(), the further kmap is a result
of a bad merge and should be removed.

This resource leakage can be exploited for DoS by receptively reading
a content of a directory on NFS (e.g. by running ls).

Fixes: 67a56e9743171 ("NFS: Fix memory leaks and corruption in readdir")
Signed-off-by: Petr Malat <oss@malat.biz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/dir.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -657,8 +657,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir
 		goto out_label_free;
 	}
 
-	array = kmap(page);
-
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
 		goto out_release_array;


