Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD8C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8002464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055913;
	bh=qVVRBgPPkf0uH6lybJWPybIojiNichIoshNQV1Ur0MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hbR7WpmI5J/nnTeuq19R4V4MVWZJvVydsgm5eUxOMnakqld5srZPevwekXF7XtGE8
	 txbcQG9zVy+nydTPO+QJ0Z6zvh3Vvsg32EYS4hrm6DIzLlml/vSDdMPDpniyoFxx3x
	 8Ka4Bt8U2+wRfLcP0a+L4lS/PRDm2NhM/a2h7Ejk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBRT6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgBRT61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828DF20659;
        Tue, 18 Feb 2020 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055907;
        bh=qVVRBgPPkf0uH6lybJWPybIojiNichIoshNQV1Ur0MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIB/3Wj+5PUfy72CqYMj62SDu7kMDlxZw179ZhKgGSs2+8rwkKSE4Nm1/HGliKHYE
         IOl5+uMh91OgNGc55ttVYaohvD9RPIRb/TlX6BM9FqgYArRRCzwvEkn6JjCje1NYCc
         O1ZUQYLpf1zo+3tElQcplJpbiuTDU8Vv/EjEMwwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 27/66] cifs: make sure we do not overflow the max EA buffer size
Date:   Tue, 18 Feb 2020 20:54:54 +0100
Message-Id: <20200218190430.579914219@linuxfoundation.org>
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

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 85db6b7ae65f33be4bb44f1c28261a3faa126437 upstream.

RHBZ: 1752437

Before we add a new EA we should check that this will not overflow
the maximum buffer we have available to read the EAs back.
Otherwise we can get into a situation where the EAs are so big that
we can not read them back to the client and thus we can not list EAs
anymore or delete them.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1087,7 +1087,8 @@ smb2_set_ea(const unsigned int xid, stru
 	void *data[1];
 	struct smb2_file_full_ea_info *ea = NULL;
 	struct kvec close_iov[1];
-	int rc;
+	struct smb2_query_info_rsp *rsp;
+	int rc, used_len = 0;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
@@ -1110,6 +1111,38 @@ smb2_set_ea(const unsigned int xid, stru
 							     cifs_sb);
 			if (rc == -ENODATA)
 				goto sea_exit;
+		} else {
+			/* If we are adding a attribute we should first check
+			 * if there will be enough space available to store
+			 * the new EA. If not we should not add it since we
+			 * would not be able to even read the EAs back.
+			 */
+			rc = smb2_query_info_compound(xid, tcon, utf16_path,
+				      FILE_READ_EA,
+				      FILE_FULL_EA_INFORMATION,
+				      SMB2_O_INFO_FILE,
+				      CIFSMaxBufSize -
+				      MAX_SMB2_CREATE_RESPONSE_SIZE -
+				      MAX_SMB2_CLOSE_RESPONSE_SIZE,
+				      &rsp_iov[1], &resp_buftype[1], cifs_sb);
+			if (rc == 0) {
+				rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
+				used_len = le32_to_cpu(rsp->OutputBufferLength);
+			}
+			free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
+			resp_buftype[1] = CIFS_NO_BUFFER;
+			memset(&rsp_iov[1], 0, sizeof(rsp_iov[1]));
+			rc = 0;
+
+			/* Use a fudge factor of 256 bytes in case we collide
+			 * with a different set_EAs command.
+			 */
+			if(CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
+			   MAX_SMB2_CLOSE_RESPONSE_SIZE - 256 <
+			   used_len + ea_name_len + ea_value_len + 1) {
+				rc = -ENOSPC;
+				goto sea_exit;
+			}
 		}
 	}
 


