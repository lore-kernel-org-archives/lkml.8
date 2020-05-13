Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5377BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4665720693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589412806;
	bh=To9Yoi94bEPQmPx2gVzZTvirL9XpdBbjsGrGmQCA8js=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wg9snw1nEgRDtdmGSw1C+2ZyIdQBbpI9qfT9JSyS+42v7dHL3RqNrvB3TNoqWLC6G
	 qAZTnX8qbf/HrwKr9odccTNI/xhKvEZ9P+JO8MSWO893RU2hzwKLwPjaIoYCL1q7ZM
	 aj0JB3S7Rt4I9m8jTrSD4qk3NPir0M70GN8ZCqy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbgEMXdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732523AbgEMXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:33:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j3so1441061ilk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFfNmewz/mfCHMNh9XV194PnShatk6k9H447JJUGz6c=;
        b=CWlvd078GIR1ibZh6d8sahfhrI+/49floa8rvRRu809XIw7S/8SbgeF4DBpC7fIQSy
         0oZ/igGCFgfu7HSisKnk3pUfXmzQbB5wcfcyIpnwL7XjjUwwMfk8AI+JPTNPS2/kbtfY
         kUyA+XkxSys6iB83dmwD8RALiGFE1YjV+LxKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFfNmewz/mfCHMNh9XV194PnShatk6k9H447JJUGz6c=;
        b=jvPVKlV1FotFcQoy2Xk0GToxiNKHx1ut6w2VZ4DHGUyXcVzk06iiLLaKZt/4A7avXW
         YxEjYJyeoDF5migCjeQ1kclyH4nYwbOj4UiWDk+cFxi+Fa79yTpmaJVVgaHOISGcraep
         Su2mtXzvK5VxaHXy1KN2AUxrHwMPeYN5B2f7npPF4b6IfmPEEbNOyHwY3yJgLy1K/DNO
         KxCYAvDscjnYMWP7HAHMnIserqjVVAICWgu3hOk8rxJohz3qp42biejc0i/cOXE7Rxgv
         GSczscVOahEmQ7qfNQUoIXR6aNLrTdf6gkGP8t4VFOG0LWBOIiBPujtqhMMCa6xE0ip1
         cQAA==
X-Gm-Message-State: AOAM533m8/KxU9K1MczKxrXDpD0kkeMeUfj2Ayhl3E6Jmi/dYEFCiDAG
        VyubTfiWLJtIoV/JiOIV0JCNOg==
X-Google-Smtp-Source: ABdhPJxUwwRpGwbnaEJPsLawzpT73ikpudZeKLQy0f/z7118JbmJJ4IwYR6fXfE67wE3QRnF1kkUSA==
X-Received: by 2002:a05:6e02:4cd:: with SMTP id f13mr2022503ils.300.1589412803580;
        Wed, 13 May 2020 16:33:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm398072ilr.23.2020.05.13.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:33:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fs: avoid fdput() after failed fdget()
Date:   Wed, 13 May 2020 17:33:19 -0600
Message-Id: <cover.1589411496.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging an unrelated problem, I noticed these two cases fdput()
is called after failed fdget() while reviewing at all the fdget() and
fdput() paths in the kernel.

Changes since v2:
Patches 1&2 changed to get rid of goto.

Changes since v1:
Patch 1:
  Changed to address review comments to refine the code for improved
  readability in addition to the change to avoid fdput() on failed
  fdget()
Patch 2:
  No change to v1. Including it in the series to keep the patches
  together.

Shuah Khan (2):
  fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
  fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()

 fs/exec.c |  6 +++---
 fs/sync.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.25.1

