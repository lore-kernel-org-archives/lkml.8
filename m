Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ED020848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607465;
	bh=34JpyfKjva3rhXTyg4I/8Ci1RhB0a4u9w93euC206PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lpTT7AFxIC64l3TUUinva0Yg6USHMB6diwn7EssuSJG5QEq/Wuh2jIHCSyBwj+KJ9
	 IL5Ypi76pFG4mS3CJKdFt3OGYRL3Cfl4zUh6HMi8G/LpV6B6XL0GcdEQE+fFe2OSfm
	 0b7xnKXhtFCHTZQ4kz9Fdk//mMd5QVUTJhKjoyBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgBMPYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgBMPXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:15 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7904A24699;
        Thu, 13 Feb 2020 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607395;
        bh=34JpyfKjva3rhXTyg4I/8Ci1RhB0a4u9w93euC206PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dd+iV0wPL4lqFPSjL2FdTnCYzOY5dT4ddr+01XDa7DPGDPsqHAPvOpoYj3yW/ZQFN
         80trYdEZD3cczkB6zJNmDpqcw2QDLW1gb/y0pye4VOtkbsIwBv1gauP9SAQBmBeyh3
         C503O2JA9fd0dvxFaSfK190dOaA8y4wz5R0zb1Ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 76/91] cifs: fail i/o on soft mounts if sessionsetup errors out
Date:   Thu, 13 Feb 2020 07:20:33 -0800
Message-Id: <20200213151851.774679691@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit b0dd940e582b6a60296b9847a54012a4b080dc72 upstream.

RHBZ: 1579050

If we have a soft mount we should fail commands for session-setup
failures (such as the password having changed/ account being deleted/ ...)
and return an error back to the application.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -250,9 +250,14 @@ smb2_reconnect(__le16 smb2_command, stru
 	 */
 	mutex_lock(&tcon->ses->session_mutex);
 	rc = cifs_negotiate_protocol(0, tcon->ses);
-	if (!rc && tcon->ses->need_reconnect)
+	if (!rc && tcon->ses->need_reconnect) {
 		rc = cifs_setup_session(0, tcon->ses, nls_codepage);
-
+		if ((rc == -EACCES) && !tcon->retry) {
+			rc = -EHOSTDOWN;
+			mutex_unlock(&tcon->ses->session_mutex);
+			goto failed;
+		}
+	}
 	if (rc || !tcon->need_reconnect) {
 		mutex_unlock(&tcon->ses->session_mutex);
 		goto out;
@@ -286,6 +291,7 @@ out:
 	case SMB2_SET_INFO:
 		rc = -EAGAIN;
 	}
+failed:
 	unload_nls(nls_codepage);
 	return rc;
 }


