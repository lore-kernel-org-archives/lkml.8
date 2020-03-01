Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA35A24672
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZp+ZjEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCAVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:39:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45863 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:39:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so4529868pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 13:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6rBcEU/hFHZ/nVMjMstNChyJKPo0QHS5wUjjviEgtw=;
        b=UZp+ZjEs92XsTaviuP18FzsJR+VZ112lgNxLw2CWe6X5MOTmpucNyLP3bC8FUdF/vC
         teiz0nwKugmASxfHEGV8Gbioho6+Uc5cV/CrLrvHvqbcH/eLp3rlCGChffbwcSBLUZy7
         Xi5aYBzc3If6cXi7WY77UkNq2gwymv1euA6wKKnpF7DVVPnMkZKyUmxZ24cLIhpmcvKn
         ZQhEp0hOPacY5Ww+jzDuXX//nlZYFhaxB9/66v5XEKhfyKvQKFxDcmEJyBee93+vwhbC
         ZmemkGDIbkPl5rU8ni8I1hkoXI0mg974rhNuGzp8wGZRraaDxFLM7um+wReKr48mMiKn
         G/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6rBcEU/hFHZ/nVMjMstNChyJKPo0QHS5wUjjviEgtw=;
        b=N3b8XN0D1leCCcmKUcziMLq2e9K4DqoXcVCciw8XB1tax7DQM4DUGEDl3qPUEpA7n1
         YUBYjwuNfPA26iHjwb2quh2OMvPLrhxcavNMS/Ubd9h012O9a70WlUK3xXIodciGBU9n
         /dHunALkWoHKpv8E0/UJhs1otqmcAxnNsEHRuUt8GHDyIgtUOUb4lV+24ARDrzkKyS//
         pB71TmmvQSmBG49xoHL1jQTSVAzz0kTh0c45GHVZ+Q+tiiufdxJX8yH9vqW55UaA5CkM
         yz4n4BEfShMOAD/aW/zQ4fPe8gIk+9ksc9pTKQdQhjujd+myWpK9d2rOH+eheZGztFiC
         C1JA==
X-Gm-Message-State: APjAAAX79N6IjP4oFqRe3NERNhNVlVuXnxe9tG86P84bEKp38GFcXBU0
        35zipO8aM7/IzElkHjljLyh8a1hC
X-Google-Smtp-Source: APXvYqxzBeecIJ7TyrW8VqK0wUx5HBpQoCJ4E8Sgc1F4GZVHHBW75XU7SCjoxpPmaDFqOkFHoGNB+A==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr13002741pgc.22.1583098741224;
        Sun, 01 Mar 2020 13:39:01 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id h10sm18181632pfo.181.2020.03.01.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:39:00 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 0/3] OpenRISC clone3 support
Date:   Mon,  2 Mar 2020 06:38:48 +0900
Message-Id: <20200301213851.8096-1-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the clone3 not implemented warnings I have been seeing
during recent builds.  It was a simple case of implementing copy_thread_tls
and turning on clone3 generic support.  Testing shows no issues.

Changes since v1:

 - Fix some comments pointed out in reviews
 - Add Acks to 2/3 and 3/3 from Christian Brauner

Stafford Horne (3):
  openrisc: Convert copy_thread to copy_thread_tls
  openrisc: Enable the clone3 syscall
  openrisc: Cleanup copy_thread_tls docs and comments

 arch/openrisc/Kconfig                   |  1 +
 arch/openrisc/include/uapi/asm/unistd.h |  1 +
 arch/openrisc/kernel/process.c          | 18 ++++++------------
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.21.0

