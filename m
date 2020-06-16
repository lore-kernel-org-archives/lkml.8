Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C60FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3FC2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJwhOaQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgFPQ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:29:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729167AbgFPQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592324971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ERS+2jm6G8eP/qULDs3m7N2SVMVdN3wgBEZ1bGF0bCo=;
        b=GJwhOaQikhXtysH/NS7mbXP9OfTntFuj1SJnUQRfI4GDpXUxFW8wMghEkv/mtyEXMbnkW6
        XQHY2uBiYm1NgD4YpTjR6giU8bP//agf6gouM9YjV0kggyqLi8RFOSpkSFTJy70jTJzGMK
        YyQssgs5enAo+J2EPi3v4z6l+6d2K8Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-zNuL0vdFNUqbkyb_V-IyEA-1; Tue, 16 Jun 2020 12:29:28 -0400
X-MC-Unique: zNuL0vdFNUqbkyb_V-IyEA-1
Received: by mail-qk1-f199.google.com with SMTP id a6so17229786qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ERS+2jm6G8eP/qULDs3m7N2SVMVdN3wgBEZ1bGF0bCo=;
        b=Ht1updz+t5OkFY3Wg7VvZGvBpL25TU4uF1KQZnz+9t61ujY5v7rFVVc6X9OmisJ2qd
         KPQHcU0Z/5NA3yjVs+0AIs+56qkDxvOm4isOzAxS7qL0XhU/IbPWGluggd8As9ehhmmT
         74w62XOZTElnRNzm7FN4AdxUPAsfSXqDa0LcVdRAtWmErW3Mll5r34eqKag31IrDsMG3
         4tLDaVDs8W00NHfO6ZtCcmJ5apXK6mpfLlGqw/8dOrV1dyPCzZr2jDo0WOdd/WfvHKxZ
         uvqL46usTgTNHV93y/qbgNH/tEecUDPijTvbklg66TSWvVNJoIJHB/2aW7R4VsLdIIQE
         2DKA==
X-Gm-Message-State: AOAM533lkGrqzHf7seZHvkbQ+Zlj0LwMXcs+41ZtUhhXXI7doTrL/Mp0
        Si/bgdchkovYeicoYU+DXnbsmDJEKKjMlZd7YVMbO4HdstTkDpGWVW1DsNyr9yvuky7zlCoUMa9
        l0BkZe9z6EdQJZ3DWT7DDfPCp
X-Received: by 2002:a0c:8d46:: with SMTP id s6mr3143588qvb.241.1592324968288;
        Tue, 16 Jun 2020 09:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPiCjs+KhSMorb/vjtXy68V8lc6ZAVuWB3rMp3H4SFEqGWmHFi/pfLbhMXeynTHXZQduXSUA==
X-Received: by 2002:a0c:8d46:: with SMTP id s6mr3143579qvb.241.1592324968089;
        Tue, 16 Jun 2020 09:29:28 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s42sm16386942qtk.14.2020.06.16.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:29:27 -0700 (PDT)
From:   trix@redhat.com
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] fat: add a check to fat_add_new_entries
Date:   Tue, 16 Jun 2020 09:29:22 -0700
Message-Id: <20200616162922.26168-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports a possible null pointer dereference

fs/fat/dir.c:1255:9: warning: Dereference of undefined pointer value [core.NullDereference]
        memset(bhs[n]->b_data + copy, 0, sb->s_blocksize - copy);
               ^~~~~~~~~~~~~~

This is because setting of bhs[n] depends on the inner loop executing.

So add a check that the inner loop will be executed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/fat/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index b4ddf48fa444..3eea540486cb 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1228,6 +1228,13 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 	do {
 		start_blknr = blknr = fat_clus_to_blknr(sbi, cluster[i]);
 		last_blknr = start_blknr + sbi->sec_per_clus;
+
+		/* overflow */
+		if (unlikely(last_blknr <= start_blknr)) {
+			err = -ENOMEM;
+			goto error_nomem;
+		}
+
 		while (blknr < last_blknr) {
 			bhs[n] = sb_getblk(sb, blknr);
 			if (!bhs[n]) {
-- 
2.18.1

