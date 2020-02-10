Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B723C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480F420714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339227;
	bh=OXiUvrVzIJ7XyIE+fQLd2qgJDI8aMUNySP+I27n7S5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLviSxSl4gz+pN2A+A33FizgOXmxD4UmK87bSZUevz20aTwUGqTmvIoGaEui1ZN/k
	 Zy+mzKdACwWOQygitPY3pA3Ie4eV6FVNCIDcJQAP0wslPdDHS+RIT86r56TYtGWBAk
	 Tb9dx7ih4g2qM0mHLtFPQ+KGru9BvRqhQh8rpLDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgBJMmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgBJMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:07 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F77220873;
        Mon, 10 Feb 2020 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338346;
        bh=OXiUvrVzIJ7XyIE+fQLd2qgJDI8aMUNySP+I27n7S5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsOug/SW+Pg4xtns71Q2AxvhUMFo913CACU259w9K21ou8UdJcap3uhelU8rwMk3h
         +xqaYUOtKv5Q1xJe+2dVdOMCkTp3Xug5ioG/G+KmVw6/NGQDmXGi9wXTfDRwwbpJj0
         xpwQE4AeDPr9yfnJ+sjuV4wXUkszIbD9JwN2eH7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 302/309] cifs: fail i/o on soft mounts if sessionsetup errors out
Date:   Mon, 10 Feb 2020 04:34:18 -0800
Message-Id: <20200210122435.937231452@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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
@@ -350,9 +350,14 @@ smb2_reconnect(__le16 smb2_command, stru
 	}
 
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
@@ -397,6 +402,7 @@ out:
 	case SMB2_SET_INFO:
 		rc = -EAGAIN;
 	}
+failed:
 	unload_nls(nls_codepage);
 	return rc;
 }


