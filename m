Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84451C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2C2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699723;
	bh=Ts68ShsdzOG9Fa9chgZq5ppLdpZ2ie9mY1mXFf7rshs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BRP6PFG9AOYIi6gbxwvFFwkxzh+jUha2UMhPAnOE7dEL75Ocj5zXxpK4mmSYUwp+/
	 f7arm9mtWrbXZ4XxVFyNY4goMo6UPvHxMjd4ai1+o9PbZ1fg9NyYFL6sE2bTHGxB8p
	 3/KBXtr8hmB0voT6PIL+mUbi4JNd9R+vbqkC8xEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAVN2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgAVN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:28:33 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D2F2467A;
        Wed, 22 Jan 2020 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699713;
        bh=Ts68ShsdzOG9Fa9chgZq5ppLdpZ2ie9mY1mXFf7rshs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RadIwp17JNhM8cx9IS+tEeP/q1+JVFSO7KqELEuUxpDhKfrgUYLUFcsyYVQm3mGOJ
         9TIdgysz97l/jjiByDoU8wW4J8sKTZAJxfkUqBzW2c8qmBI0CdeArjMrXMHcjekmXa
         NOSBJIqktrrY6zd3MUxHwu4Adjd1rHfSv5qxpAbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 5.4 194/222] mtd: cfi_cmdset_0002: only check errors when ready in cfi_check_err_status()
Date:   Wed, 22 Jan 2020 10:29:40 +0100
Message-Id: <20200122092847.592021002@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 72914a8cff7e1d910c58e125e15a0da409e3135f upstream.

Cypress S26K{L|S}P{128|256|512}S datasheet says that the error bits in
the status register are only valid when the "device ready" bit 7 is set.
Add the check for the device ready bit in cfi_check_err_status() as that
function isn't always called with this bit set.

Fixes: 4844ef80305d ("mtd: cfi_cmdset_0002: Add support for polling status register")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -136,6 +136,10 @@ static void cfi_check_err_status(struct
 			 cfi->device_type, NULL);
 	status = map_read(map, adr);
 
+	/* The error bits are invalid while the chip's busy */
+	if (!map_word_bitsset(map, status, CMD(CFI_SR_DRB)))
+		return;
+
 	if (map_word_bitsset(map, status, CMD(0x3a))) {
 		unsigned long chipstatus = MERGESTATUS(status);
 


