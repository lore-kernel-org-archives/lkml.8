Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC5C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678ED2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5fy0ysL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgA0GkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:40:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39094 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0GkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:40:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so5744217wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 22:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1tyNXZnWhuKKfdLpziwLlgtEEQ38chs7QgWhMTIIMxo=;
        b=K5fy0ysLQv78fv8yhna7SHiSvLP/KCLZdQi3RAL1GtXEScncngW1GXqv05lQVq21s8
         MdQFZquFhRil+oL2do78LD53QLEs5IKgAAn57A7yCHrQ02DSpWyMZJE0S7bvjhbrYG1n
         npu9sq2R5vRKl3KEdeeEyEqZtmDtSiVwpF+hyUC456Daap4psnoWOnE+NWX30fj5RkiZ
         o1/FOB3JRW/cNEXb7Bbwr5vIQBNu7xfxEeexr8aag9CqHZHj4HxCRUEBYxxRU2GbVdfH
         NMhOFlYEv9yLge8X8FBYKY3FNw9vkIdgdlfhFER4AVF+hytQdBV2KPVCguzHjZGZxlzM
         X9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1tyNXZnWhuKKfdLpziwLlgtEEQ38chs7QgWhMTIIMxo=;
        b=fV+QgtkRCJvq25cfXOMmnoQGJD19rsK3lY5BbFOq/0sqnut6YY703yPlnog3QrCYPw
         kz2Un2UixuZ6Zi4v15LzkJ7/G8Sl9TrSsw8gVigvyiBWUdNlTAI0tBoZKmKFZsHv/QLh
         ACIjNiy4q8XZ8GZ6Vvb6RnLWwG3G3lizmHohME2Frs30K1G7BM/guDvKGbtudj/0X/gz
         /asL05PwfMSc0IKmudsTZQwuiNLnWlM2FzT5qwkjgNEm4dyjVF5Ehm3TR5m9JWc5ZOeK
         VhaRkxG6eMXhk5xvwwD6hnI9otbDS69sktIdfAddc+m1hQpKhDThzAQAov+LGwZ5xsUK
         34uQ==
X-Gm-Message-State: APjAAAX+WSAEcvvFwFR65jp8uE4tK529H3KZNbykmP2fc6+AKYnn4iAR
        dVB4KSSny+cNzWOiiVNEBzu++oaZY7w=
X-Google-Smtp-Source: APXvYqzJpwtGrFQ+kQjl+fqMQ5YG71h3qxR0k9EB840BXnp2/x1n9RT7T4GBMRB16rxYitsKAaLdnw==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr12442357wmg.38.1580107210206;
        Sun, 26 Jan 2020 22:40:10 -0800 (PST)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o129sm18066885wmb.1.2020.01.26.22.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 22:40:09 -0800 (PST)
Date:   Mon, 27 Jan 2020 08:40:07 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.6
Message-ID: <20200127064007.GA12713@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver for kernel 5.6.

It's a small one this time and mainly contains improvements to MMU and
reset code. Hopefully I will have time to work on upstreaming the Gaudi
support code for the next kernel, but it may be postponed to 5.8.

Please see the tag message for more details on what this pull request
contains.

In addition, I got my pgp key signed by Olof.J. I would appreciate it if
you could verify it.

Thanks,
Oded

The following changes since commit 0db4a15d4c2787b1112001790d4f95bd2c5fed6f:

  mei: me: add jasper point DID (2020-01-24 09:33:58 +0100)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-01-27

for you to fetch changes up to 31579364e1478eda9556adc90168c11dc6bac150:

  habanalabs: patched cb equals user cb in device memset (2020-01-27 08:23:39 +0200)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.6:

- MMU code improvements that includes:
  - Flush MMU TLB cache only once, at the end of mapping/unmapping
    function, instead of flushing after mapping of every page.
  - Add future ASIC support by splitting properties of ASIC capabilities
    regarding mapping of host memory to regular and huge pages.

- Fix bug where the driver didn't halt the internal ASIC's engines before
  doing hard-reset to the ASIC

- Minimize writes to H/W during hard-reset by skipping coresight disable
  code (no point as device is going to be hard-reset).

- Fix bug where we did an extra refcnt put in the memset device memory
  function.

- Small bug fixes and minor improvements to code.

----------------------------------------------------------------
Oded Gabbay (3):
      habanalabs: halt the engines before hard-reset
      habanalabs: removing extra ;
      habanalabs: patched cb equals user cb in device memset

Omer Shpigelman (3):
      habanalabs: use the user CB size as a default job size
      habanalabs: split the host MMU properties
      habanalabs: do not halt CoreSight during hard reset

Pawel Piskorski (1):
      habanalabs: flush only at the end of the map/unmap

Tomer Tayar (2):
      habanalabs: Modify CS jobs counter to u16
      habanalabs: Avoid running restore chunks if no execute chunks

 drivers/misc/habanalabs/command_submission.c  |  47 +++---
 drivers/misc/habanalabs/debugfs.c             |  21 ++-
 drivers/misc/habanalabs/device.c              |   7 +-
 drivers/misc/habanalabs/goya/goya.c           |  89 ++++++++---
 drivers/misc/habanalabs/goya/goya_coresight.c |   4 +-
 drivers/misc/habanalabs/habanalabs.h          |  39 ++---
 drivers/misc/habanalabs/memory.c              | 222 +++++++++++++++++---------
 drivers/misc/habanalabs/mmu.c                 | 110 ++++++++-----
 8 files changed, 346 insertions(+), 193 deletions(-)
