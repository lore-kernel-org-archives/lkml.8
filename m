Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2170C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53D220781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WvzRhMuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgHCXCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgHCXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:02:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16428C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:02:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so3034740pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V/+z/hxKFgTteJODvKkcx/ojBZuakxz0j5YHjVIKU/I=;
        b=WvzRhMuo+Bhq3EFBZdXi/SgHsTe8rpKDUkQkc9iu++WXSNIDqmVy3dDn8sRLN7T/eO
         I5z/tJlNF/CoQPYbXeY4zyQgcBzx/NK7gKR3VSmsCWbt4a63wjrorNpU5oK7/o9EZOb7
         GbPlkTi5doGkvngQDeNHiK7aW320dZCIeL6HC7a4lnD8VLxmcvn2u4EPPsXE6V8IUM3m
         rPVkbrqrwSUqWpNEvZvM+Kf+klqLwtyeqrppMj6Cn+IIGyxakTB42svkyBYmfeLCtMtf
         tqEgDHKaHqyaEZ2+YlffH0DefvxZ20+vvWxiUoEvuAKYotl5pPF6eEfaTbizpQyCOlUy
         97SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V/+z/hxKFgTteJODvKkcx/ojBZuakxz0j5YHjVIKU/I=;
        b=fiO3xpeTXtMIAvyxUsC4TO1dmaVXbyiBZMuXEXmM0KtD/NL4AckCMVL4CpAIlHfC0R
         YRgrWzUTMfFLTlmvASzSjz4fNxlkIHxPgSFtzF91Qgl9v08Fgw5sLDndIfqxNsGYb6ql
         n5xajHnKd+XpJj+1JZBJKTvlWxC2p5AC+ep5BzzPaYeNw90z0iHF4ooOWugL9w0pQ+nH
         ekeMj2B2XHd9mKVv8+wKlXYbK04JP2O7LlTPmjb1eeIeAyDs8o2tnsTvDgWgLyRKy5n+
         KDT/aon7GA0JKJ4oONN2kCO7c4liV9VvOsKfXBd2jp6YPt/jzSB0kiQJoJKRDYi+q3LN
         afAQ==
X-Gm-Message-State: AOAM531jcuhs/2nyeVA8U1PFa8sRBxtEcSHuWnlGjK+RefkzaZesjOXd
        7qR2UlOpke0nSEF6F9/q9X0A1j5Pe7U=
X-Google-Smtp-Source: ABdhPJxYaNOzfp7Coaq7/S3GFzQRaWKpMjthMCF1MVEAbgu6MXquqj4sTaj7nUYP30nuW+UakDmt1Q==
X-Received: by 2002:a65:438c:: with SMTP id m12mr16411217pgp.373.1596495733364;
        Mon, 03 Aug 2020 16:02:13 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r185sm21403864pfr.8.2020.08.03.16.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 16:02:12 -0700 (PDT)
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Date:   Mon, 3 Aug 2020 17:02:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ext4 uses generic_file_read_iter(), which already supports this.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Resending this one, as I've been carrying it privately since May. The
necessary bits are now upstream (and XFS/btrfs equiv changes as well),
please consider this one for 5.9. Thanks!

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..1e827410e9e1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -839,7 +839,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
Jens Axboe

