Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73919C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4D52072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eVoDV+dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQMcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:32:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37694 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:32:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so7450479wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=g5DFCMAiBJapRLzTIsCMfZO3t3lSrKhZ+V4rKfulm64=;
        b=eVoDV+dONYvQLQwiJwhekdTDxP4cfGNPdAjI9sDP6NRVAi86vANPOyWBWGUtx4yUL0
         kvFW/1reL8Fs3sIFwEKDWm7kfpaYl9mYgLTo3ajA4aD9qeXLapZ+hrJ9lXApx7flYzAV
         tntk/hHytxEH6LLjO0zR+V3zk6yIKeoEybock=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g5DFCMAiBJapRLzTIsCMfZO3t3lSrKhZ+V4rKfulm64=;
        b=fEc4V5t227Uu/XPmUz842V33KG3wT+635c9QeIB6yA56ghBVcMFNwQ9ojtQeA16nQt
         f8ZClSHEwlQh7Pb6UjQszB23FEeg6jEO7Y1kT0hIyGqjt/RyXmymni3IlIo49VgJx69W
         QABNLbQVtS48YvCxvZ/T665RPeG/q0lUjVvh9LowiYcgMfm7ny4DTZaSQyY3Nyg8bY7h
         GCadzV91XWJHWLoa6BH9X7lCrtdq74qtRObJWeSvFllyffA71YeAKOxxZ+oVKRaUc0au
         hsFo5cxy7E1N/agek/4MDtbsF2UaKk3PhCVApeg0/aLLHGwsnyCGMxU/Mn1HlZCzetMU
         rhsA==
X-Gm-Message-State: APjAAAV1a8DMv4memHLjnaPgEBDZp2NtcaUqzeSn/tGr2f3eviIhFnLw
        TZKlcpjRFBrHFhBYjqrWnE2xXA==
X-Google-Smtp-Source: APXvYqyC+rZ4Viq9eim4+IsFLrhTPqo65VnAf2kQZ/bQmE3Vm176tHGpzexlo/I2jEFU3kT5NDWB3g==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr4351730wma.103.1579264369055;
        Fri, 17 Jan 2020 04:32:49 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (94-21-206-225.pool.digikabel.hu. [94.21.206.225])
        by smtp.gmail.com with ESMTPSA id t125sm9755173wmf.17.2020.01.17.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:32:48 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:32:43 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fix for 5.5-rc7
Message-ID: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.5-rc7

Fix a regression in the last release affecting the ftp module of the gvfs
filesystem.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: fix fuse_send_readpages() in the syncronous read case

---
 fs/fuse/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
