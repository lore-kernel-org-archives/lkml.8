Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118AAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD6421D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050145;
	bh=Yh6gZjfyX6QP1J55zaEdH+YpizqUockH6mB2K0kyNj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tv4u81jnmWyAbbPe+QP5u1Lwc+GsFBgeVXaNWN3nutYpzpQCfolPE1N0TIlrrf1em
	 p+mjk7JJjBWofiVaDAJvPVwAd18XiCGY7MKYRQFGIznlmx870QV6mcr5h89k12XRmd
	 PM0dvA2Sx3LN7dsP2ItW/aB0hELFyyx74PSFiEDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408894AbgDPPPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441571AbgDPNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A920921734;
        Thu, 16 Apr 2020 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044958;
        bh=Yh6gZjfyX6QP1J55zaEdH+YpizqUockH6mB2K0kyNj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVWZvvOQQ2lS/pzF4P7Q/pod//hbCB7tZrS5N+mutR5UPyBjr9VwKxUqmqQ9k5p9+
         WBLYxlaozJPvbqyanVJqTsShJ+i66vCbE0XyNmkSq7LmOphJHCW/RIrzIUZIlepPnT
         KM6/iRzhxpyqokb7AzcRTxRx3kXTu1u0qDdGSqIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yilu Lin <linyilu@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 5.4 134/232] CIFS: Fix bug which the return value by asynchronous read is error
Date:   Thu, 16 Apr 2020 15:23:48 +0200
Message-Id: <20200416131331.755418580@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yilu Lin <linyilu@huawei.com>

commit 97adda8b3ab703de8e4c8d27646ddd54fe22879c upstream.

This patch is used to fix the bug in collect_uncached_read_data()
that rc is automatically converted from a signed number to an
unsigned number when the CIFS asynchronous read fails.
It will cause ctx->rc is error.

Example:
Share a directory and create a file on the Windows OS.
Mount the directory to the Linux OS using CIFS.
On the CIFS client of the Linux OS, invoke the pread interface to
deliver the read request.

The size of the read length plus offset of the read request is greater
than the maximum file size.

In this case, the CIFS server on the Windows OS returns a failure
message (for example, the return value of
smb2.nt_status is STATUS_INVALID_PARAMETER).

After receiving the response message, the CIFS client parses
smb2.nt_status to STATUS_INVALID_PARAMETER
and converts it to the Linux error code (rdata->result=-22).

Then the CIFS client invokes the collect_uncached_read_data function to
assign the value of rdata->result to rc, that is, rc=rdata->result=-22.

The type of the ctx->total_len variable is unsigned integer,
the type of the rc variable is integer, and the type of
the ctx->rc variable is ssize_t.

Therefore, during the ternary operation, the value of rc is
automatically converted to an unsigned number. The final result is
ctx->rc=4294967274. However, the expected result is ctx->rc=-22.

Signed-off-by: Yilu Lin <linyilu@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3778,7 +3778,7 @@ again:
 	if (rc == -ENODATA)
 		rc = 0;
 
-	ctx->rc = (rc == 0) ? ctx->total_len : rc;
+	ctx->rc = (rc == 0) ? (ssize_t)ctx->total_len : rc;
 
 	mutex_unlock(&ctx->aio_mutex);
 


