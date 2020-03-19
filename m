Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB1C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295520663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624994;
	bh=AdNahJelzRheswR/YE75fk2oSiEMrLk9h64N1vmKkcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vebfqPL3xGLJVv+K6/58+3JzxIWOM2WQpUebkK9tXMrf+1UmkHmRMGLv+Juh+mGK4
	 vMGhWkuWyDQ4/8lxiTGc1ukXrcZZAeAnLKLaBzeHiY+z5A9hdUEOTqXIEul12fSWMJ
	 7li+4JtM2ulA32HaV9JuRY+2jV1ZW8qDs9qSvH7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgCSNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgCSNJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:09:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD69C208D6;
        Thu, 19 Mar 2020 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623385;
        bh=AdNahJelzRheswR/YE75fk2oSiEMrLk9h64N1vmKkcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xt5AoCHOg8w+tpeD8Yzk9srjjHhbiVQnBg82BRkNWG96JYw5WOCQqP+dQFzXlEe+m
         fynT4A5jXn7KoOgcR9vOda7m4AizfjZC/X8RaTTnTTfrPlni5561XQzql0Fmy7gatF
         6Isc8ItuPlTAYCy4v3AXEM1AgaSVUJHeSmjFvCfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Malat <oss@malat.biz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/90] NFS: Remove superfluous kmap in nfs_readdir_xdr_to_array
Date:   Thu, 19 Mar 2020 13:59:23 +0100
Message-Id: <20200319123928.955435028@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
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
@@ -678,8 +678,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir
 		goto out_label_free;
 	}
 
-	array = kmap(page);
-
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
 		goto out_release_array;


