Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B091C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C172072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218287;
	bh=ZYX+Zfw+r6NhNQ/v3dQsd8zFyH2Ea9S8fCDau5E4rXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBZlKShzdP42ZS69hKO76Wz4O2Q2yo1Hc58B1qmjfILwU7X+sfluPSVHEQUk8mUPu
	 AEz6Lq9nPr6aRUPprYfE0E+GpfYQylinvywSurOF0skT81Va9Sw7xnsc05DqSeP659
	 94Hvn4KXZa9feygMd0VOWHG1BwsgsN5IkkN8i9W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbgAPXoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:44:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgAPXXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF6A2072E;
        Thu, 16 Jan 2020 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217032;
        bh=ZYX+Zfw+r6NhNQ/v3dQsd8zFyH2Ea9S8fCDau5E4rXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7fp1dsWI8BH/WDsc4nRmCHzWT+T3mjV6Qtj2BCuUkm6ibaPqJ6hgFysUu2V5NRYv
         KepT2m1klq+YOYaD10tJc/IRp3sPbTLrbHQtYR32gowRsZRSSzNIbTve/s9e0hIACx
         p27PCeYnl2ct4fygHp/yBHrUlYlIBPNvgMqRcXmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.4 104/203] NFSv2: Fix a typo in encode_sattr()
Date:   Fri, 17 Jan 2020 00:17:01 +0100
Message-Id: <20200116231754.657309758@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit ad97a995d8edff820d4238bd0dfc69f440031ae6 upstream.

Encode the mtime correctly.

Fixes: 95582b0083883 ("vfs: change inode times to use struct timespec64")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs2xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -370,7 +370,7 @@ static void encode_sattr(struct xdr_stre
 	} else
 		p = xdr_time_not_set(p);
 	if (attr->ia_valid & ATTR_MTIME_SET) {
-		ts = timespec64_to_timespec(attr->ia_atime);
+		ts = timespec64_to_timespec(attr->ia_mtime);
 		xdr_encode_time(p, &ts);
 	} else if (attr->ia_valid & ATTR_MTIME) {
 		ts = timespec64_to_timespec(attr->ia_mtime);


