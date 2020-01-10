Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D815C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA220838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="xMKTwMvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgAJKGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:06:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37238 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgAJKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:06:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so780544pga.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=oDNrvMBkRQQTH00uWpsTcBSbalZCfUJLPRKuqSeoeSo=;
        b=xMKTwMvmqJqgfiqQQ1f0ZqIME9T87jrJuUXG64OuIf3O0F2zsAyp5tYi8hc2IQVYXN
         Pmd7EvnfptMa+fu7bfL/Q00xwX5C0PAQcpMa3RJBnfuaxF7+08Oa62UbVzd0VXDsgz+a
         NbskKxPRDigGHMum3n/glyS/Yb/QjFtF4SVsfLJpcNGSxT63gmSnIl6tKSlCfZjDcanB
         BiUqvD68BfBI/FhdD7M0Ol8zPFV34qqxR+VxOD86DuhHplKzFa4TC4EGYDvc8TH+kzEP
         +UD5rS0XXdbYCG5xk20Cw+N3Ismuep3KdsWfSHF3D7f3TA761m0Nb2zxOVSYvcTEUjYP
         0aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oDNrvMBkRQQTH00uWpsTcBSbalZCfUJLPRKuqSeoeSo=;
        b=eqNu5IxWUvy4RupGi1qxSqgW4okcYAPUphZsEnI4G/u5CVhdJwXgH2LwrxHnjnYMts
         kwv+X++85UQaVDcQiYS59XTP9/zlzIGfXdcWNu54w9beaC4vcT+GbrYQrGZSqMHF5HL5
         9yi4SygAU4ol1vIoZsiYx59fodAmAHsbeWrzNIvmWOsKhiYAVylKnJYI/dlk91KEEV9k
         eOgIoAYV4GQMp7rr3maF+15k6hZaZAbhb6s0cumKIngQSym5mL2soX7DUl8qkM54I+8f
         UynzHxr23TWxNPf3oQ6CRBTSJPQ5PrYFqzKrL2zLF5RxTcq6r61TnDVTSpa3farWq+rh
         lt6g==
X-Gm-Message-State: APjAAAW94TIKMwCGlyLNmf2ADtBU77UTedDpAWVUlOfLedjNgbyI44IQ
        nhZesmFSTZQ/okLvAO1pmR6AyA==
X-Google-Smtp-Source: APXvYqwOg2iZTvMq8n+lTbhfVWdNMzvGM/Qr1Rzr8smGqT5tcQE2hUGv64lEIz0XWQSSNAl6/fh5gw==
X-Received: by 2002:a63:7045:: with SMTP id a5mr3450324pgn.49.1578650801656;
        Fri, 10 Jan 2020 02:06:41 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q21sm2179039pff.105.2020.01.10.02.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 02:06:41 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pbonzini@redhat.com
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, libvir-list@redhat.com,
        mprivozn@redhat.com, yelu@bytedance.com,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/2] implement crashloaded event for pvpanic
Date:   Fri, 10 Jan 2020 18:06:32 +0800
Message-Id: <20200110100634.491936-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest may handle panic by itself, then just reboot without pvpanic
notification. Then We can't separate the abnormal reboot from
normal operation.

Declear bit 1 for pvpanic as crashloaded event. It should work with
guest kernel side. Link: https://lkml.org/lkml/2019/12/14/265
Before running kexec, guest could wirte this bit to notify host side.
Host side handles crashloaded event, posts event to upper layer.
Then guest side continues to run kexec.

Test with libvirt, libvirt could recieve the new event. The patch of
libvirt will be sent soon.

Zhenwei Pi (2):
  pvpanic: introduce crashloaded for pvpanic
  pvpanic: implement crashloaded event handling

 docs/specs/pvpanic.txt    |  8 ++++++--
 hw/misc/pvpanic.c         | 11 +++++++++--
 include/sysemu/runstate.h |  1 +
 qapi/run-state.json       | 22 +++++++++++++++++++++-
 vl.c                      | 12 ++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.11.0

