Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8521DC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1DE2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056026;
	bh=MKwR1Ey5s9/JR9K6iEYpEMGtlvVkD6LC+UA956/m7G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vOXxe5CM/3A+0R1+UqFgMxAlkSvaGoF6RRI8ZWwL8kpLqpRk6LRm1IrAtX1zdccnt
	 OxqOco3cU2/GaPxdBUGoXNKiPcsdbgzqWPTy8JtOiEFWjUb1O7lq0HN+g1bVz5BD/l
	 XgkCtmTgqOy+zPpgAHdD/peeAhzKo5exFhOhLt9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgBRUAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgBRUAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DC120659;
        Tue, 18 Feb 2020 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056017;
        bh=MKwR1Ey5s9/JR9K6iEYpEMGtlvVkD6LC+UA956/m7G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzZdnnWeie8VgnrrW/8flQduO+mQsJWMrTmpPbucmQp0oz3zkf0qQ5GLAADokB8fm
         YWyjT4fv3nfGVRa8iI2uViZAnXzSUi0VP4d9D/fpTbxRY6yK8JSYoj7HiKisMsBXEe
         ydaN/ehfEBpCRGgeBsCXaWeWLmniuNJpCD8+IG+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 55/66] cifs: fix mount option display for sec=krb5i
Date:   Tue, 18 Feb 2020 20:55:22 +0100
Message-Id: <20200218190433.154543984@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Pavlu <petr.pavlu@suse.com>

commit 3f6166aaf19902f2f3124b5426405e292e8974dd upstream.

Fix display for sec=krb5i which was wrongly interleaved by cruid,
resulting in string "sec=krb5,cruid=<...>i" instead of
"sec=krb5i,cruid=<...>".

Fixes: 96281b9e46eb ("smb3: for kerberos mounts display the credential uid used")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -414,7 +414,7 @@ cifs_show_security(struct seq_file *s, s
 		seq_puts(s, "ntlm");
 		break;
 	case Kerberos:
-		seq_printf(s, "krb5,cruid=%u", from_kuid_munged(&init_user_ns,ses->cred_uid));
+		seq_puts(s, "krb5");
 		break;
 	case RawNTLMSSP:
 		seq_puts(s, "ntlmssp");
@@ -427,6 +427,10 @@ cifs_show_security(struct seq_file *s, s
 
 	if (ses->sign)
 		seq_puts(s, "i");
+
+	if (ses->sectype == Kerberos)
+		seq_printf(s, ",cruid=%u",
+			   from_kuid_munged(&init_user_ns, ses->cred_uid));
 }
 
 static void


