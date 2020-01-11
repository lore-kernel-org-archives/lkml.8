Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CBFC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE132077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736966;
	bh=x46ZqZekimlPN+R+iky3j2yxrRSHk+gskssGOu7DI3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JbW25QGPSOyhhsg4e6OWqzeUdLNx5vH8SQ/8XKOWlfrDinS9lzsmmcQocz7pFT4z/
	 F3LY8ri/Rvbo8r5BMmMmoGnjjyPW3KDGABZtl+iTajmdTWlT4gSerlPwlrXkYA8RwO
	 rw2Vvl6r1mSXtoVnO8y577PctTEcLp3jkj54+lq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgAKKCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgAKKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:02:44 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4BA20842;
        Sat, 11 Jan 2020 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736964;
        bh=x46ZqZekimlPN+R+iky3j2yxrRSHk+gskssGOu7DI3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mieM/oC8o8mTXs8/+tEOxYWMgm/5sGb5Rc3JmB2P2dAppJNpaea6FziN9dxuPGJ7u
         5mBldILUGuf/IELXiFfkcJqOvz7VTrwg8FIyVPzOfgzYVnDfm0PSWy9dBH17p6CImu
         93UZ3joWutnbO1+NZQ/SOxGUy+m71b62NspBWjKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Nikolay Merinov <n.merinov@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 56/91] pstore/ram: Write new dumps to start of recycled zones
Date:   Sat, 11 Jan 2020 10:49:49 +0100
Message-Id: <20200111094905.956540988@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksandr Yashkin <a.yashkin@inango-systems.com>

[ Upstream commit 9e5f1c19800b808a37fb9815a26d382132c26c3d ]

The ram_core.c routines treat przs as circular buffers. When writing a
new crash dump, the old buffer needs to be cleared so that the new dump
doesn't end up in the wrong place (i.e. at the end).

The solution to this problem is to reset the circular buffer state before
writing a new Oops dump.

Signed-off-by: Aleksandr Yashkin <a.yashkin@inango-systems.com>
Signed-off-by: Nikolay Merinov <n.merinov@inango-systems.com>
Signed-off-by: Ariel Gilman <a.gilman@inango-systems.com>
Link: https://lore.kernel.org/r/20191223133816.28155-1-n.merinov@inango-systems.com
Fixes: 896fc1f0c4c6 ("pstore/ram: Switch to persistent_ram routines")
[kees: backport to v4.9]
Link: https://lore.kernel.org/stable/157831399811194@kroah.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 8b09271e5d66..a73959e6ae32 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -321,6 +321,17 @@ static int notrace ramoops_pstore_write_buf(enum pstore_type_id type,
 
 	prz = cxt->przs[cxt->dump_write_cnt];
 
+	/*
+	 * Since this is a new crash dump, we need to reset the buffer in
+	 * case it still has an old dump present. Without this, the new dump
+	 * will get appended, which would seriously confuse anything trying
+	 * to check dump file contents. Specifically, ramoops_read_kmsg_hdr()
+	 * expects to find a dump header in the beginning of buffer data, so
+	 * we must to reset the buffer values, in order to ensure that the
+	 * header will be written to the beginning of the buffer.
+	 */
+	persistent_ram_zap(prz);
+
 	hlen = ramoops_write_kmsg_hdr(prz, compressed);
 	if (size + hlen > prz->buffer_size)
 		size = prz->buffer_size - hlen;
-- 
2.20.1



