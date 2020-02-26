Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDEC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FC220838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkAS2Lib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBZW4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:56:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40902 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgBZW4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:56:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so279653pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiLNzuKoNpmSSMsekoBiTZOvmxk/Fk1cSyWxPDes24k=;
        b=PkAS2LibF8nGBE7kOw/nIg5UIC/FXMPczwVekRIvfhB7rUBWGMRSlZlf7AO23V/srR
         KljEl2JIt1cw5MbmVoTgOvWNqV1H4wGwWybYAVLukAt0dRTjpY69SQWDJZRJKt5QYcRe
         yNilz1ceMYGPvAjMCyT3+ymLRwiWReWmTinIkLda5XtRsyPgTTCx0Ytp5zPPL8P7yv2m
         HRr86gbdh2Z+08ohUTLaWQo7M7BGAmUjFejZ+SSU7jqYnnHGoUtSyVCsRfSCh4Xz9xe6
         5Jk2ziTv7lFhGJupEv+xeI/IfE7TQld3SWaCZCBiNzRDjoatJS9vtmWpzjAQnZEQCMJz
         Yjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiLNzuKoNpmSSMsekoBiTZOvmxk/Fk1cSyWxPDes24k=;
        b=p/u0CputGPREunH/ofrlhDW64cCULtbZn7ksLViUUVcqt3tHiaI+HtCHvEPjEJS5+3
         JrjvZwdakaMX6E6rKv6Z6HYJdmttCkzmpelAum2MZjZUFnhlegH6kqDkNjyqxaM04C6T
         KThHNoeibZxmOeRajd0VRS3uzBtdMgqPQcpqQn9oHiQUohO4kHuszZD/dDPFg2DTERzd
         sMAR4v8Nk1LoNur0OQuTlmNR4Rh/ZVE6Zz/qsGa3lzV7FsKgWTKuoTNvc9zWhPK7szQS
         WHh6bnDu/DzRUMscm/CN0qgwLVhSdKvSFJUc01sx2MtCzdtXOAOb1OjVVvNxTxCSDXiT
         e63w==
X-Gm-Message-State: APjAAAX8Bbm0e0Bcs5JesS1N12i9Gk4iYfIsOFKyzlS8LPTDaexb7a8R
        quoQmtSw3q2uRdbjDBEE/IpqJfZB
X-Google-Smtp-Source: APXvYqxRTsSns9M+laGOofu/n2ZniTZtPLbcngj+wyAad/4XN9eJO6exghhjHFYZNNbFEuAiaKoCEA==
X-Received: by 2002:a17:902:7c88:: with SMTP id y8mr1566253pll.321.1582757799580;
        Wed, 26 Feb 2020 14:56:39 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id m12sm3838889pjf.25.2020.02.26.14.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:56:38 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/3] OpenRISC clone3 support
Date:   Thu, 27 Feb 2020 07:56:22 +0900
Message-Id: <20200226225625.28935-1-shorne@gmail.com>
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

Stafford Horne (3):
  openrisc: Convert copy_thread to copy_thread_tls
  openrisc: Enable the clone3 syscall
  openrisc: Cleanup copy_thread_tls docs and comments

 arch/openrisc/Kconfig                   |  1 +
 arch/openrisc/include/uapi/asm/unistd.h |  1 +
 arch/openrisc/kernel/process.c          | 19 +++++++------------
 3 files changed, 9 insertions(+), 12 deletions(-)

-- 
2.21.0

