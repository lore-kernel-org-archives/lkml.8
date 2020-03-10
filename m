Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65250C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C14421D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2W9c3ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCJQNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:13:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:13:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so12841651wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sMf7UJjQhPDyQyNdko2DnTq0A2b1XzqPnTexTsQnxfE=;
        b=D2W9c3chGO4pHTEJga8aLRQmWqJuGdTAMxPuRo4Qp3Y2eJqA5bah6lCbRiNpjFAClS
         Oz7/IKdudzvhtGb01ZnI5BLf1hPVSCx2k1XNY4HkuN6Kq/rS6IUDT8kOdnrB2Ej/8IIn
         d43kk48GzGJp2JPnPGEeVqamhqAWUneL+17V58bg0e6sACpHoEVO1UZ1DOWdaPHvisoY
         PySMsBJ0mKApokanNcCTIpKt0vP9eV/I7MNx3nJKVBu06g2K4tO7WeXzpc4kQTKTshbM
         VUjEKbAQ6MJ10LqZAq7YakDNrEjxD5TL/+XwTqzhVYJm9P676NoYQJPnnOvFhIfqsin4
         OJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sMf7UJjQhPDyQyNdko2DnTq0A2b1XzqPnTexTsQnxfE=;
        b=qYAhIOHs6d0ffNMhT+zs+g4VSx4Rpz9u52db0mlbIDXg+sYDToKpFEl4AFyxcFCHW1
         j7yqZ8caCH82G3tqBC1Dd0c5JAzdP2qTQZkOkpbCOS2zdwfQhxQDD5ZHTf42M6q6A4RN
         Ww3q1VbkIvv31ZyWE4YLUeeAYVFfEZfn9BcTCzOTmuDcpP2Whc9ORwu+2cI1ZWwfl6DN
         Ld87tDTlvdwL6OUbrj8Wf1KqfU9YKBMhcWHFa2agVX8ghnINDG7sF3S5P1xnvplyTlN7
         kXs8wGd61Tiud7W/jKcLDyKwgrwXc5R9RuI0Rg465cD/TOiu+yorxkihV4KTa6Kd/SET
         1Rsw==
X-Gm-Message-State: ANhLgQ2Z9XTOuGJawisXjWY+APidd6tcFjtYwZm3lw9phbUj+R57c46x
        r/J2ukNzlj+EabG2V5QcQwo=
X-Google-Smtp-Source: ADFU+vskBc/6w3YgvAtMo0SeQGHcenjlTB7H/HZ7Ykpj4g29XCuosetyBliTJ8fHImlqJ8ZPo3XvTw==
X-Received: by 2002:adf:ed0d:: with SMTP id a13mr11202973wro.167.1583856832516;
        Tue, 10 Mar 2020 09:13:52 -0700 (PDT)
Received: from gmail.com ([134.122.68.58])
        by smtp.gmail.com with ESMTPSA id g129sm5076120wmg.12.2020.03.10.09.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 09:13:51 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:13:30 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.6-rc6
Message-ID: <20200310161330.GA16596@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these small changes for auxdisplay.

Cheers,
Miguel

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.6-rc6

for you to fetch changes up to 2f920c0f0e29268827c2894c6e8f237a78159718:

  auxdisplay: charlcd: replace zero-length array with flexible-array member (2020-03-06 22:18:07 +0100)

----------------------------------------------------------------
A few minor auxdisplay improvements:

  - charlcd: replace zero-length array with flexible-array member
    From the kernel-wide cleanup Gustavo A. R. Silva is performing

  - img-ascii-lcd: convert to devm_platform_ioremap_resource
    From Yangtao Li

  - Fix Kconfig indentation
    From Krzysztof Kozlowski

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      auxdisplay: charlcd: replace zero-length array with flexible-array member

Krzysztof Kozlowski (1):
      auxdisplay: Fix Kconfig indentation

Yangtao Li (1):
      auxdisplay: img-ascii-lcd: convert to devm_platform_ioremap_resource

 drivers/auxdisplay/Kconfig         | 16 ++++++++--------
 drivers/auxdisplay/charlcd.c       |  2 +-
 drivers/auxdisplay/img-ascii-lcd.c |  4 +---
 3 files changed, 10 insertions(+), 12 deletions(-)
