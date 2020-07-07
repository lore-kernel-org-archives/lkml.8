Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14BBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982882065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134651;
	bh=fsv8QM8PN/qV2fuRTlCXCxViKXQXGi/PJgSr0V0TKIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F7LOTM6zTbg3ucEfZzZHI1wVEyUHwg/cNC0QNryjWbK4gHwMUUzsjcj4pstWNF3OZ
	 r8yT4Egw4c0SPFjVWtJvpupKuf8QNH3y1ScTiCAZ9GEyn7tZ+xm21TEcdjHru97qDE
	 u3hb0zdXF42ibqWwpioumKyCno7IbGLY9LzWO9Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgGGPKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgGGPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2E520773;
        Tue,  7 Jul 2020 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134645;
        bh=fsv8QM8PN/qV2fuRTlCXCxViKXQXGi/PJgSr0V0TKIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cb1INGGg1eVkzfH6Up7QS/YsQgIm1R8iTPPJ1XLjW/9HobXr7kB73mdW8iKTDY2k5
         unw+O+SH6HB4ZXcO7eKcCRZ7gI0voYn/M57QE5rvGEL38dIj5L7aJ+x3L1BfRQx7M6
         6yK0tLcbyE/1kGL6xmqI1hzmzQ6eeXN+zQElgwOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.4 16/19] SMB3: Honor persistent/resilient handle flags for multiuser mounts
Date:   Tue,  7 Jul 2020 17:10:19 +0200
Message-Id: <20200707145748.310362283@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145747.493710555@linuxfoundation.org>
References: <20200707145747.493710555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Aurich <paul@darkrain42.org>

commit 00dfbc2f9c61185a2e662f27c45a0bb29b2a134f upstream.

Without this:

- persistent handles will only be enabled for per-user tcons if the
  server advertises the 'Continuous Availabity' capability
- resilient handles would never be enabled for per-user tcons

Signed-off-by: Paul Aurich <paul@darkrain42.org>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4203,6 +4203,8 @@ cifs_construct_tcon(struct cifs_sb_info
 	vol_info->retry = master_tcon->retry;
 	vol_info->nocase = master_tcon->nocase;
 	vol_info->local_lease = master_tcon->local_lease;
+	vol_info->resilient = master_tcon->use_resilient;
+	vol_info->persistent = master_tcon->use_persistent;
 	vol_info->no_linux_ext = !master_tcon->unix_ext;
 	vol_info->sectype = master_tcon->ses->sectype;
 	vol_info->sign = master_tcon->ses->sign;


