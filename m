Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F16EC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7046320708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339586;
	bh=xp5AfYsg5Lg7c8CdywzoLdQcyf/BrBlzYmWCtroqw9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oO/4OfEHhPXsnBlH7a03v5GBJY5/KINtxJmTKzTVZRFcBRdCFamEvyUkgPJnp/q4g
	 l9i8FZNqmxeQufUFBv/JWL8y/Q1Vk974UQxBge4rVgLLAKbahBV74Un02gDNvmShbc
	 2YJ4VfqCW0y6EMSSaXWjAf+GzaMhH2UqHpBlfIFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgBJMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbgBJMie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:34 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039CA20661;
        Mon, 10 Feb 2020 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338314;
        bh=xp5AfYsg5Lg7c8CdywzoLdQcyf/BrBlzYmWCtroqw9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P70ajd8VcBkwMLvg+b8EUTYbSx186B8n+N/sY5oEAPRmE0VfHi6INcNbHyH/avWKq
         cllSyi1MeTVFUNB17Hc5Vi2cVm6WIkH8+fKCHz7M7ySeHwYEoBcJWU/lJrE7gsmB11
         wyi9kK77i2sj5MtofbJb0/PmGSsXOmeO/6GI2pHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 239/309] scsi: csiostor: Adjust indentation in csio_device_reset
Date:   Mon, 10 Feb 2020 04:33:15 -0800
Message-Id: <20200210122429.487533261@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

commit a808a04c861782e31fc30e342a619c144aaee14a upstream.

Clang warns:

../drivers/scsi/csiostor/csio_scsi.c:1386:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
         csio_lnodes_exit(hw, 1);
         ^
../drivers/scsi/csiostor/csio_scsi.c:1382:2: note: previous statement is
here
        if (*buf != '1')
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this
line.  Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: a3667aaed569 ("[SCSI] csiostor: Chelsio FCoE offload driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/818
Link: https://lore.kernel.org/r/20191218014726.8455-1-natechancellor@gmail.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/csiostor/csio_scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1383,7 +1383,7 @@ csio_device_reset(struct device *dev,
 		return -EINVAL;
 
 	/* Delete NPIV lnodes */
-	 csio_lnodes_exit(hw, 1);
+	csio_lnodes_exit(hw, 1);
 
 	/* Block upper IOs */
 	csio_lnodes_block_request(hw);


