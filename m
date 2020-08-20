Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC08C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9892054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923656;
	bh=WiomYjt9sZvDbsHFAxtIDGIRJxfXz3CVkvFJZ7f488c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zpFqMyzOvxaXrvFAay/101nefAuKu4K/BQTWJliGXMkcBiTs0FRJgmQNDBhb0gMZq
	 pTytPfEOJLThbRdPSyXfZa0q05dlsbPx6C+b3SOki/n1Xxzz0L2nk6M5GQmp4ph/NU
	 hYj3EOOOXmhobBEAqY5kblC09We8Xw1OCnmFlvcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgHTLkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbgHTKFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:05:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7E022BEF;
        Thu, 20 Aug 2020 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917908;
        bh=WiomYjt9sZvDbsHFAxtIDGIRJxfXz3CVkvFJZ7f488c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJ7S766XMm2ErCzmIMKF9V/3rdLwLTV9G9G7DbsMKeFJab/amiKZm/9ORMF4PoNUr
         VaSIGPbqLJy9E2hzs4dEKslYAnrm2+zIyEPV+1F83q/rZ/aFcCYumBJ1nCVmwMBoXX
         MorszOAZArfXpWeAszxIeXDdQ0NgUD9+6d1uIDDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 169/212] smb3: warn on confusing error scenario with sec=krb5
Date:   Thu, 20 Aug 2020 11:22:22 +0200
Message-Id: <20200820091610.925346715@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 0a018944eee913962bce8ffebbb121960d5125d9 upstream.

When mounting with Kerberos, users have been confused about the
default error returned in scenarios in which either keyutils is
not installed or the user did not properly acquire a krb5 ticket.
Log a warning message in the case that "ENOKEY" is returned
from the get_spnego_key upcall so that users can better understand
why mount failed in those two cases.

CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -776,6 +776,8 @@ SMB2_auth_kerberos(struct SMB2_sess_data
 	spnego_key = cifs_get_spnego_key(ses);
 	if (IS_ERR(spnego_key)) {
 		rc = PTR_ERR(spnego_key);
+		if (rc == -ENOKEY)
+			cifs_dbg(VFS, "Verify user has a krb5 ticket and keyutils is installed\n");
 		spnego_key = NULL;
 		goto out;
 	}


