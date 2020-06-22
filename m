Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F329320732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcQ+0S6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFVO1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbgFVO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1EC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n2so7632386pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3GI1uGL8qRj0UWsRg1f35/N6knURd5cco/VjWV8guxI=;
        b=CcQ+0S6+v97SJO9VqZ1l3zquEMKhBkbcW/mJDEWfKfhOwMPLFJd8tfH+lqmbqz5SEH
         wJe2AxmAsInK6RWKkFdunWoh0OZpYUei2rkv+4VsjH18jzdmSoWWbzfI+3TeuZ2ZcTZc
         DyDiyAcuwI0MJxW/DCAxav6ctw9GQsLe3aQLlmFsco10yy1oVcIx4uoPm4LQBQR08cYt
         jSe7oExrAEuFqb52wL+qT6kK4ZPX7LVJXEgB3s+gcBG7h5j7YuCyw5Fg5/chnvLQfeXB
         4tYZ8jGawHQD9UufmWlaYnikek7LGVN/3/uxEjH+L1Pl74VKof4oz54ibaDXG0nahoMO
         nwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3GI1uGL8qRj0UWsRg1f35/N6knURd5cco/VjWV8guxI=;
        b=iwhPp6rc18nanE9dM9eqtwv8LjmylF5PkiNMut+LqRxPCZgTExn7tgjtXAkYmdwaiF
         AYQUzZM8lpnQGSFOWwpY3FTyLVCMSBJ6gHNb+Wrbo3/0lDCLccq/HedKKQM57Rvpwk3Q
         Rj15e4kslb0my5DXSA6eGYh5Gn0U58KjJRT5LRsngmhmHk9Au8n2nNetZv+dlmxOQ5u8
         aWoE9m2FO2UzplwTo0V3seCT6YbR7TLwAcngPK40wdGDh6au1XDguuKeEdf+f/vvS/ko
         hfzECvyrXFtXcpKtXBP3P++m3HX17CZV7VGq4hPs9v7mNF9rtmcypi0vqZ/IPBsIwLLb
         rkig==
X-Gm-Message-State: AOAM533Lyu3qtvDJc/B4N1kOnrlvHmkk5obqHKCEXEkoNUoJcbKmHDmu
        l2Y6vfz1a79JAoeknf1h35R2mg==
X-Google-Smtp-Source: ABdhPJwIWQswOm3gAoyhRJ8B6sV7a9AiL57ArtJyCd3xKaqvSlNveqUuHLc4rb86sbspHNrCNoA0tw==
X-Received: by 2002:a17:90a:acf:: with SMTP id r15mr19289807pje.171.1592836039745;
        Mon, 22 Jun 2020 07:27:19 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:18 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/7] Enable support for kgdb NMI console feature
Date:   Mon, 22 Jun 2020 19:56:17 +0530
Message-Id: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work is derived from Daniel's prior work here [1]. It has been
rebased (tag: kgdb-5.8-rc1 + console hardening patch-set[2]), reworked
to use serial RX interrupt as NMI (pseudo NMI on aarch64) in order to
drop into debugger and tested on Developerbox (using amba-pl011).

- Patch #1 is more of a fix required for NMI console to replace kgdb IO
  console.
- Patches #2 to #6 adds an architecture agnostic fallback mechanism to
  enable kgdb NMI console using serial RX interrupt as NMI.
- Patch #7 is an optimization patch that gets rid of inefficient timer
  based tasklet and rather uses irq_work.

Usage of kgdb NMI console:
- Enable "CONFIG_SERIAL_KGDB_NMI".
- Kernel cmdline modification for Developerbox:
   console=ttyNMI0 kgdboc=ttyAMA0

[1] https://git.linaro.org/people/daniel.thompson/linux.git/log/?h=kgdb/polled_request_irq
[2] https://lkml.org/lkml/2020/6/4/294

Daniel Thompson (5):
  tty: serial: Add poll_get_irq() to the polling interface
  kgdb: Add request_nmi() to the io ops table for kgdboc
  serial: kgdb_nmi: Add support for interrupt based fallback
  serial: 8250: Implement poll_get_irq() interface
  serial: kgdb_nmi: Replace hrtimer with irq_work ping

Sumit Garg (2):
  serial: kgdb_nmi: Allow NMI console to replace kgdb IO console
  serial: amba-pl011: Implement poll_get_irq() interface

 drivers/tty/serial/8250/8250_port.c |  16 ++++++
 drivers/tty/serial/amba-pl011.c     |  12 +++++
 drivers/tty/serial/kgdb_nmi.c       | 100 ++++++++++++++++++++++++------------
 drivers/tty/serial/kgdboc.c         |  35 +++++++++++++
 drivers/tty/serial/serial_core.c    |  18 +++++++
 include/linux/kgdb.h                |   7 +++
 include/linux/serial_core.h         |   1 +
 include/linux/tty_driver.h          |   1 +
 8 files changed, 158 insertions(+), 32 deletions(-)

-- 
2.7.4

