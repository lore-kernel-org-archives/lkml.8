Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED80A217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578350;
	bh=RhjwPoc66ZmSvHRjXQeAo3R4iXRTmoC+DaSed1I62OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDFgJQCzQKYtJh2ar+fHA1CdBE2RbS/et4ndb1LzEFAAkxsLgvpkMbjxMnFZCPi0q
	 f3Qqp8zTzO8GN85Otu6mwxXp/Q8JNciE/iKhgOUjQ/grKymFe9hfWbZ89F2FofwdTp
	 2nCMgQpBpIE+Y4rG80oXdJHTIRnislfxRv0UqQYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbgFSOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389566AbgFSOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:52:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2E621852;
        Fri, 19 Jun 2020 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578340;
        bh=RhjwPoc66ZmSvHRjXQeAo3R4iXRTmoC+DaSed1I62OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQnzc+JNuMI8HhDli9gakx0NB5st7Yc7vO7Ep6KNCFvNLU1zxyTql0Hd5gHnwstKC
         yc/BVd1qF9pr0cjwGqW5yBFX+evEhAXzXjp3CiT1Wope5opmSdCd8bAD5+3M4b/86r
         ogBtcM5Hl5Rg40ONOivoP8tJCXFEXesaO9tmau+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 176/190] dm crypt: avoid truncating the logical block size
Date:   Fri, 19 Jun 2020 16:33:41 +0200
Message-Id: <20200619141642.580528543@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 64611a15ca9da91ff532982429c44686f4593b5f upstream.

queue_limits::logical_block_size got changed from unsigned short to
unsigned int, but it was forgotten to update crypt_io_hints() to use the
new type.  Fix it.

Fixes: ad6bf88a6c19 ("block: fix an integer overflow in logical block size")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3088,7 +3088,7 @@ static void crypt_io_hints(struct dm_tar
 	limits->max_segment_size = PAGE_SIZE;
 
 	limits->logical_block_size =
-		max_t(unsigned short, limits->logical_block_size, cc->sector_size);
+		max_t(unsigned, limits->logical_block_size, cc->sector_size);
 	limits->physical_block_size =
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);


