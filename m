Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF92C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214C920787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="SqTtYT0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgCaW3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:29:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46253 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:29:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id u4so24932861qkj.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPoi9s3rBPglRyVbK9MBhYyYu13c18TXPi71CbVQVpk=;
        b=SqTtYT0zo8AT/7bG/6GBA7zmIQtZBva52UjWxHaBAFH+zgmuU7kyBugY6NFUaXrBeq
         6bpLplZ/sxNgCTGS+92/8O72wVE4sZk5JnRE9hviebuKNpjhvwB07/IFgkJDaRcJQy7h
         fuhNwVf929ETl+0pedmNfaLjcE6gQCPgmNiYbyEEOvQyyMjEEB/NnyIgd22LFEw/AZuN
         7C2/gDHepVW/RV9/LAVFXDS38kLVjNqCvWrmXNQPg96IRpjg4M3rcDYuAGn1ZPpKPhDp
         HEqFoAo+D/1O//ctK/ooKx2E1UughUQcITILG4SUJTd68YfHP938m95dYQPDW5HDg/uJ
         Y/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPoi9s3rBPglRyVbK9MBhYyYu13c18TXPi71CbVQVpk=;
        b=J2zh9dIDz/nS2f08wsQdovg9sOWYBObnjRjxP5dHqbzxmFRp3dYzoMkASq3dtuWUdw
         MZb/vqrsEhggCk9qz6B5HgpL3xi1xwN5BcmFfrxACb9sTmEGpvOgmAWfAAiNIRwnc+Bu
         kWpga7n7wrW1MV6AGeG+20cVZ7qjVJM1FBhG/EOQYsiGgbBFtEIL4woLAdSUEU86SsVG
         2EXIHi+Gl/g4PeTiDzyHM5JbDHgc6XG+A8Ntq2uFHHpDnWTQq1VHSkmJ2XXboUVYgw+j
         eLJpEjikhOcUKIf0YJm7tLSGxjswDsw9sJHsh85/msn7kueMRLK/PjwSGpM3CAvOhCsi
         1Uxg==
X-Gm-Message-State: ANhLgQ2fGQ/uZYRmiN+wlFJZs7AVKIJeBS61VPVMYa+33+8oI8u+x3fE
        yLhzpLE2fCbhQi5hH9szPdTpJQ==
X-Google-Smtp-Source: ADFU+vvCu4qHgFR6s5NfZIjtIf9WjNDoQvgV9EeC0cyylVFte2B6Dnv4zBvDYTCKukRVjzSX0xo2iQ==
X-Received: by 2002:a37:9b4c:: with SMTP id d73mr6568366qke.242.1585693741416;
        Tue, 31 Mar 2020 15:29:01 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 206sm238659qkn.36.2020.03.31.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:29:01 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/2] Documentation: Convert sysfs-pci to ReST
Date:   Tue, 31 Mar 2020 19:28:55 -0300
Message-Id: <cover.1585693146.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitor Massaru Iha (2):
  Documentation: filesystems: Convert sysfs-pci to ReST
  Documentation: filesystems: remove whitespaces

 .../{sysfs-pci.txt => sysfs-pci.rst}          | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)
 rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (81%)

-- 
2.21.1

