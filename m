Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFBCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A28206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364318;
	bh=FR8Ifg9rP8tzSzi0f8DEsEecajjqrvZMp0gu9VxDTkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FtDbPFrJ7Aos8KlMXGzEuzHh7IYGg/ieQsrsvn3zkRqjU+PkU43x786ov543y8JQ4
	 QhFDYHg+fE9wJclngkZJHjYbS3Fj14H0ntopBf2VLGwBwMBf3DcZsor1326ClRGlrp
	 7rBK0GYWs252swk70VCF9nXJZabnUlaveXomjciI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbgEMJqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732689AbgEMJqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:46:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FB1206F5;
        Wed, 13 May 2020 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363205;
        bh=FR8Ifg9rP8tzSzi0f8DEsEecajjqrvZMp0gu9VxDTkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cP1VEZuVVxRB8UMZfiX2oe7mjhnbF5wv3N8UVboLxibiz37jxDH6Wy8iqTCPfNfkP
         4BHCfnfzyqG1nf0VrhXx4CLjxIiveBCjqyFSg9Lw7e2yKYJGORK9Ajt3HxjqHafLDb
         j2F44J+oe7BVw0NuN3CbE4Vr0n3M51gaDP0BkSMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>,
        Richard Yeh <rcy@google.com>
Subject: [PATCH 4.19 29/48] staging: gasket: Check the return value of gasket_get_bar_index()
Date:   Wed, 13 May 2020 11:44:55 +0200
Message-Id: <20200513094358.457452609@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Carter <oscar.carter@gmx.com>

commit 769acc3656d93aaacada814939743361d284fd87 upstream.

Check the return value of gasket_get_bar_index function as it can return
a negative one (-EINVAL). If this happens, a negative index is used in
the "gasket_dev->bar_data" array.

Addresses-Coverity-ID: 1438542 ("Negative array index read")
Fixes: 9a69f5087ccc2 ("drivers/staging: Gasket driver framework + Apex driver")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Richard Yeh <rcy@google.com>
Link: https://lore.kernel.org/r/20200501155118.13380-1-oscar.carter@gmx.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/gasket/gasket_core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -933,6 +933,10 @@ do_map_region(const struct gasket_dev *g
 		gasket_get_bar_index(gasket_dev,
 				     (vma->vm_pgoff << PAGE_SHIFT) +
 				     driver_desc->legacy_mmap_address_offset);
+
+	if (bar_index < 0)
+		return DO_MAP_REGION_INVALID;
+
 	phys_base = gasket_dev->bar_data[bar_index].phys_base + phys_offset;
 	while (mapped_bytes < map_length) {
 		/*


