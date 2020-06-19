Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC15C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711D421548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580112;
	bh=jrnjozBuVnxgYvn8vVL4e2ymqxk65v2C3vsPq0/5cSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=13lMLsVYG4xFXs6THhINHqWW4enZtXWDvsGVgZBqxJDB5SfFS+vdubnceawa8hzHg
	 WYcIMMo7XYhxqC87ht+5FUxNAUbKDLHPmWPgm8vs4go8Jmux3fhG1+WXDjlJdCv9lK
	 lpzYxPmT9z5oPKwxJ3Sl0wmOsPw2jBhm+UA7YrB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392916AbgFSPVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392215AbgFSPQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:16:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F7B2080C;
        Fri, 19 Jun 2020 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579770;
        bh=jrnjozBuVnxgYvn8vVL4e2ymqxk65v2C3vsPq0/5cSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jY6yM97/q3+z9j/vUGCD7MuRDITudoLnDROgmPatAyYy/1uTMMA9F02nHrP0kPbq
         IBlOJ3Vug1OCUJldV/LFsw3Hoh5GDs5EJ/A8ALl1dIwJTP7ePq0LqgME+SpYl7F+Qp
         w7KyGqxOY8TCSN+PtKn3b11GMaGw5knKagfZs+0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 219/261] dm crypt: avoid truncating the logical block size
Date:   Fri, 19 Jun 2020 16:33:50 +0200
Message-Id: <20200619141700.370947849@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
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
@@ -2957,7 +2957,7 @@ static void crypt_io_hints(struct dm_tar
 	limits->max_segment_size = PAGE_SIZE;
 
 	limits->logical_block_size =
-		max_t(unsigned short, limits->logical_block_size, cc->sector_size);
+		max_t(unsigned, limits->logical_block_size, cc->sector_size);
 	limits->physical_block_size =
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);


