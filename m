Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC9C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C2121744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YKc6V6rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbgALSzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 13:55:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46528 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbgALSzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 13:55:18 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so7227236ioi.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=sjiTupl1aH/Xahl3/v7jqT3OgaZIdxBQzCtu8/taQU4=;
        b=YKc6V6rnCIh8jlw1HnXQdZTe5E7BjaVQ+2tTcpm0NWICfA1JJ6qf+wPaDMeaY89SgI
         MwanU2+jL+7YDSourly0RgJs5S/22gHruKhMEO1d8DNL9rN7aQWtQo7ebON6AmqmL99d
         izAJOVNnODZGtoH7ocCqblcnR4TWvq3S33cEGvGL5xXIdpVB+CZQGmQeNPAdv8AUuG8s
         zWleISAn1U3XYz1bakWuvaEoiym1ghFE8ih9bVSdpOGhCwstJmg93ZCP+MsEt3F36uh/
         xdKdnuyd9dSgnsmnC9TJEqYgcjbj5EUoVdCeFK1DjhXYZfoEkFWnTs/yrYS3FMJJnO3X
         dE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=sjiTupl1aH/Xahl3/v7jqT3OgaZIdxBQzCtu8/taQU4=;
        b=PQ82GHFm0Coqvyz3rbUV3QoN7la3P7nyGRrfvI40tBugw8XFwrbNnyQxzXa6Koolum
         rC3TpnSh/6Y6Srm4M5oa3ac4OiiJU6ZRKz6gQ1D9EHLWEP6XLKRRrGxgHjEUGtZgMQSb
         zGGjvQSQbYfFtHYbrV38svA11TfFI9JlNJTsuZnMvP8eKOAKHM4ggaD7rf3tRkzSFuWx
         86gqaBjy/iv/Xk8VRSQbVTeRv0UmvRQbphSVi+dplXHhMoZOlvcFyI14s3I0lzeU3Uwm
         11TMtXbwF3VhCs1a79SOoGCssn3lbbk7oVe90IYhOxdsKAHO3kr5unBQ2qwjUjjZqQjc
         flKA==
X-Gm-Message-State: APjAAAWRjJn30mDJ2Snq+i14ShiL3UmUKsYVMT4dgVNHsgUjQ8As6PgD
        /oF0Dgagx4K1Kqvlbc63dbV69VBTiOs=
X-Google-Smtp-Source: APXvYqyNYVO5JlpupDx8axRh0GheIzuQdYAl9vGdMJvb7YVqpCJ8z+SRzowJbs+SjHag1Un9ZgKBeA==
X-Received: by 2002:a5e:cb4d:: with SMTP id h13mr9490916iok.92.1578855317541;
        Sun, 12 Jan 2020 10:55:17 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id n5sm3032645ila.7.2020.01.12.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 10:55:17 -0800 (PST)
Date:   Sun, 12 Jan 2020 10:55:14 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.5-rc6
Message-ID: <alpine.DEB.2.21.9999.2001121053560.205587@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc6

for you to fetch changes up to dc6fcba72f0435b7884f2e92fd634bb9f78a2c60:

  riscv: Fixup obvious bug for fp-regs reset (2020-01-12 10:12:44 -0800)

----------------------------------------------------------------
RISC-V updates for v5.5-rc6

Two fixes for RISC-V:

- Clear FP registers during boot when FP support is present, rather than
  when they aren't present

- Move the header files associated with the SiFive L2 cache controller
  to drivers/soc (where the code was recently moved)

----------------------------------------------------------------
Guo Ren (1):
      riscv: Fixup obvious bug for fp-regs reset

Yash Shah (1):
      riscv: move sifive_l2_cache.h to include/soc

 arch/riscv/kernel/head.S                                         | 2 +-
 drivers/edac/sifive_edac.c                                       | 2 +-
 drivers/soc/sifive/sifive_l2_cache.c                             | 2 +-
 {arch/riscv/include/asm => include/soc/sifive}/sifive_l2_cache.h | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename {arch/riscv/include/asm => include/soc/sifive}/sifive_l2_cache.h (72%)

Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6896663	2329920	 313920	9540503	 919397	vmlinux.rv64.orig
6896663	2329920	 313920	9540503	 919397	vmlinux.rv64.patched
6656922	1939060	 257576	8853558	 871836	vmlinux.rv32.orig
6656922	1939060	 257576	8853558	 871836	vmlinux.rv32.patched
1171746	 353372	 130024	1655142	 194166	vmlinux.nommu_virt.orig
1171746	 353372	 130024	1655142	 194166	vmlinux.nommu_virt.patched

