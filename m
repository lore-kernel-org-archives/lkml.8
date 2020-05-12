Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173ACA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B1A20747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589312591;
	bh=mZZPLqmAMssLxtZnq6luxoXdb/tt3ZXVpQomvggWRDI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J8KwhgvKbk/nP7FvZVXhtAw0V/Tn9BDOqJiokkXbivfc1cDCG7KohAq58bFTPnpZN
	 xQ6ZR9yIMnZDkStyo5HLYYMSWTvBtG3dWULHiFd+p4ymHFuFUg0BpyVJBVYyT8FiVr
	 KsNDnOSeWNA7iS91ce0ppDTH7wB0yTudbw1fRwQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgELTnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:43:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDDC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:43:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f4so9047281iov.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbleye/tcK1271rZA5Esc6+UJ+CAeRD5kNKc6nTEvCM=;
        b=hgWwoDIuKQrPHvpd9vLJmSCo/BP1E7oj+ZV1RVrMJ5fHVPk0RWubYI8cOU+XZuaQb3
         6RZdoAFgWjKDU/G6vOFiDZlblDPxZM7fyi0h9Qn5bogfcGcCxEXvyvxfd6Gle2aD71nE
         6n6FvGwme4j81i5XsD4F16we04NDcPjPT3cl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbleye/tcK1271rZA5Esc6+UJ+CAeRD5kNKc6nTEvCM=;
        b=XcgT8qTj/ocKoTNxut1lgsdkM1zI5H5aZIzJxM26IS/P04aOkDNnjTRUFa41RX7YaP
         J2cI9KTVUG7KgW5RfVtwYlxaPfwsskiL1gHZRa91D00L07wT5aj/6cRAxt4cavGdpL7w
         9OoKcr6DmEXloHxCO8HHmN4KXWygXD2PIiHzptw/AYR30VWfg9f9ygjZ999AT809J55o
         QVoXa7vINfvdzIR99Gy8VRwZxmsQdSmZ37d82F2IyI8Pvcg2ZuBMOxsy/Bn6iQG8xkOe
         oOs2ePmoReXa27WtursvN6j1HmJ7BZDaMcTAOCAwNqicu/mt4RV6RcUpwvQijBD4k65G
         zW9A==
X-Gm-Message-State: AGi0PubqZiASAKpGN6S3kF8+fKN+JtWirrlf38Klc2KruQWE+kbPZfjw
        p15PnTillHdLBt5UHyu6bwDPWA==
X-Google-Smtp-Source: APiQypLU+z6PjgsLK15waPZJZlD3EpwMHYfleT6Sjp5XNU88pf4SIqHkEeBpDSGsRQmSdBq4ZcjuSA==
X-Received: by 2002:a6b:e517:: with SMTP id y23mr816204ioc.60.1589312588662;
        Tue, 12 May 2020 12:43:08 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm6177781iok.4.2020.05.12.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:43:08 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] fs: avoid fdput() after failed fdget()
Date:   Tue, 12 May 2020 13:43:03 -0600
Message-Id: <cover.1589311577.git.skhan@linuxfoundation.org>
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

 fs/exec.c |  2 +-
 fs/sync.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1

