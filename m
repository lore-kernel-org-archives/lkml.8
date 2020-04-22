Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E0C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A1D20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552387;
	bh=1hYHRaf1AmAgr6p0nm1Jb7dX/9yL1Mu0Pg9f+92y26M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SwwN9W4cQlLYeZ30xz3AGaz2g2T0g0lAisyQpd/BBWQCcafkcj1WfJS0RQfa90bnH
	 3yZGT3EztlsWn+uVYHjeY33OGrJOuvJMCVfBWaLSMyXygEPLxlpd8WRbDXV0kw8GgF
	 chQyctwACVxx5hPIMZ3rtXFd+EvWUg/VVZjgsWLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgDVKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDVKRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279E02076B;
        Wed, 22 Apr 2020 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550620;
        bh=1hYHRaf1AmAgr6p0nm1Jb7dX/9yL1Mu0Pg9f+92y26M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QewzIikIwrAX2GUQfe6F9zFtqtvKYG1mjjEqZiR/mhmA3L71yhpznTp0pDZY6dmga
         KaJS6PJx4NkOpDSVZuqwOfL1KeQA3mX39KAuhtHJjPV4RyjYtva8gtc953e5y5OnmI
         rGba/nJ2SYonFaYIa6mcJP3NcBg7KTXapmYxbJzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 5.4 025/118] afs: Fix decoding of inline abort codes from version 1 status records
Date:   Wed, 22 Apr 2020 11:56:26 +0200
Message-Id: <20200422095036.037669270@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 3e0d9892c0e7fa426ca6bf921cb4b543ca265714 upstream.

If we're decoding an AFSFetchStatus record and we see that the version is 1
and the abort code is set and we're expecting inline errors, then we store
the abort code and ignore the remaining status record (which is correct),
but we don't set the flag to say we got a valid abort code.

This can affect operation of YFS.RemoveFile2 when removing a file and the
operation of {,Y}FS.InlineBulkStatus when prospectively constructing or
updating of a set of inodes during a lookup.

Fix this to indicate the reception of a valid abort code.

Fixes: a38a75581e6e ("afs: Fix unlink to handle YFS.RemoveFile2 better")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/fsclient.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -88,6 +88,7 @@ static int xdr_decode_AFSFetchStatus(con
 
 	if (abort_code != 0 && inline_error) {
 		status->abort_code = abort_code;
+		scb->have_error = true;
 		goto good;
 	}
 


