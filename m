Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA4C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A9424930
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589312597;
	bh=beE77q25hW/1loatIJdzB1aoxh+2mFYu7Ra5+rAp95o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L52SfTjs1G2HLgNMJU006E0lBTqhoGqre0oyY40FMPnVIzDjrs9jYe0wJEsaUGlzq
	 XDfptfI/l7VUwGw8SPvMa2dM8yU4U53UKNQYc3uxQoKhArEsunHkyzalq040mVXc1y
	 p26HquvNb6auGasaitF2yRpFtHVmfPsDogNg9vag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbgELTnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbgELTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:43:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A652CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:43:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w6so13655727ilg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5f4RJYDHuVh6PmC6voPvbMaVVDseoYYhjdA/uiY/cuE=;
        b=dDiHF6QcMxQj56/4jqPt4rp/TqSru+DYb5YBX3ju2WcjAsD10UHXWv9eb12IepmgEW
         HSipt/qwzbvnX8XXGO4VQkcFHihJfgqksvGWHtpRW7GbV7Y96UrZ/KWBoGTMTyx51U7S
         HfvA/sHFw2IKN+p76Lc+RXjMrhy5RLIJulFb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5f4RJYDHuVh6PmC6voPvbMaVVDseoYYhjdA/uiY/cuE=;
        b=V0JEkekaXDEt9tpdZncbGlzeIFWtvtg/0zr894zRNbIZ9gUtmKKcscAov3O1sdmgIn
         QvQpBYC3qI34Z4A+DUcRNU1B4f16ykA8IVE8ceJykmqGYAzmRtozLq4DhI8C889P/ghB
         h1WwlFUKOgdMG9yhJlf8MbMESjIy2Y3+wiNj3Kw3NE29enNfWgMGxIcnii/zQsJ1zcF7
         N2Aivxwb97UVFowZIzPGmMXc76KGVlmt+CXq38UKe1QXPrPDYDNIpqq8IC5tAZ/SSbqg
         Pa2mwRLA72XaMvxOQ5Z2cyk8xuf+hKMQVs1WVUpi/9Qqy63I076Pn/JcKWQlQSHJccOP
         7law==
X-Gm-Message-State: AGi0PubkhAGE0y7dulmu8E60I21veyxjJU+5MHUudEXLhCGtSs0WZ1M2
        wmPS3kScDaSLjryGbJVwrOt03g==
X-Google-Smtp-Source: APiQypIV9anjY93T29+evCtA4VrmEbcf4OSTA50DnDtX7FtsaM8yY0lwTkE+9nA9jpVE3b3YvOfPVA==
X-Received: by 2002:a05:6e02:c74:: with SMTP id f20mr23535878ilj.86.1589312590842;
        Tue, 12 May 2020 12:43:10 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm6177781iok.4.2020.05.12.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:43:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Tue, 12 May 2020 13:43:05 -0600
Message-Id: <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589311577.git.skhan@linuxfoundation.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags. Fix it anyway since failed fdget() doesn't require
a fdput().

This was introduced in a commit that added kernel_read_file_from_fd() as
a wrapper for the VFS common kernel_read_file().

Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..ea24bdce939d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 		goto out;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
 	fdput(f);
+out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

