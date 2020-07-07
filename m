Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C052078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135307;
	bh=42z2M6lOvBzaAtzr0mNb6hUVSHIgchryOTQTs8f6kwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h3H+m57CDE5/UUb91wPlmhfWZOccCvQhPgCLepwiJqn9PASt+J80TtQqbNCWJ3cIa
	 77bAKQjTzK8ynL9+UW4xAGp/hVu/t/jyt8ssoqpK+93rBYwdZBwWL1uFe0h9SjoH/e
	 inFZh4H8JSfiL74ivu1xrfPwmZXe47i0RrjCgrgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgGGPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgGGPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:21:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8043320773;
        Tue,  7 Jul 2020 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135296;
        bh=42z2M6lOvBzaAtzr0mNb6hUVSHIgchryOTQTs8f6kwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GElU76MNoG1eKBJdvj+kZwKCgXDgrLTFq7OASY2gAZC3GvDeY39oHC9wPPweWcva7
         HMo+VMzeCTFWwhHywOhoOq69wJM0712SvApHD44M8fkkhHGORqvtUvJLf4he+OSn+P
         MxB7ne0k8ymwKpVS1DicXNxLFX66mc7PnnROHfwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.4 51/65] SMB3: Honor lease disabling for multiuser mounts
Date:   Tue,  7 Jul 2020 17:17:30 +0200
Message-Id: <20200707145754.927713720@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Aurich <paul@darkrain42.org>

commit ad35f169db6cd5a4c5c0a5a42fb0cad3efeccb83 upstream.

Fixes: 3e7a02d47872 ("smb3: allow disabling requesting leases")
Signed-off-by: Paul Aurich <paul@darkrain42.org>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5281,6 +5281,7 @@ cifs_construct_tcon(struct cifs_sb_info
 	vol_info->nocase = master_tcon->nocase;
 	vol_info->nohandlecache = master_tcon->nohandlecache;
 	vol_info->local_lease = master_tcon->local_lease;
+	vol_info->no_lease = master_tcon->no_lease;
 	vol_info->resilient = master_tcon->use_resilient;
 	vol_info->persistent = master_tcon->use_persistent;
 	vol_info->no_linux_ext = !master_tcon->unix_ext;


