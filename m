Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A9DC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9520715
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1/CNSDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBKASl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:18:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44639 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgBKASl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:18:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so11085190oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 16:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=UhxPcj6/40TrfxQ8X9WmhGzj5RubLTtga5je0QqGKtU=;
        b=t1/CNSDasjvg213eVPV628rx/NqyicZ9MHL3nZV9iyRb0gnoDGAyk3zo2CbHrXMmUl
         WFvhDLBN1hBcGYvlgHjIs/vG4BS/ytAYuojaB6RCLOVzXa2Tm+GoJk8yREM2gpGS8rad
         6ytY2A+Ek+kI5aA4FUBNcCPGjW4ZjNxbaPQ/OCdyP9+S/o+cMdtK/JKqbp9+6vzzD8vX
         rDntq7w+1rgHOGeB5wwpBBDVQ2vQaWYcKSpSjw7syD7i4O00HiWDx8WYrL6JGkY9BC3n
         g6A3TEldiQH2H+5/bufsQFXEln8xfTcdA/4B+Pp2Y6pgpFb+DN6dcVKT/XxYvOpE3HFG
         OPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=UhxPcj6/40TrfxQ8X9WmhGzj5RubLTtga5je0QqGKtU=;
        b=Y91gICEvaFVcg6hvVNUPcov1FsPyiYuYsIsfv3rX/+6J1DVUkjj8ccaGaTwCAc4F4S
         2RSR0d6i/vcREZWkStJVXr4sGHQqfhNQwkmvuY3vHH+Xo/V79ytNqPYPmNX5gDkGJNSb
         EyhDgiwzUKGJMvyL2PUTUDWN6dWyTbe0uES3qw/I0JVja5ovmgcOAmB6wsnbStymVBlM
         +Wz1UDG9xLOoUl/Z5F1Q+uVYnuv3p5M+3V/WC4ymhI+auoPe4BYFGIyEFd6xUILt8r7Y
         25DcqVa7l1YEG4gPGLcbzRA2FVTcXiyYgp730/ZSSviCDD+soGK2TDUYyRIpZy/k4blL
         DBmA==
X-Gm-Message-State: APjAAAVwoouUvYslNxo2kfvgzebvURk+oCXqkYZMabwLWop/jW8X3BEf
        CtUSN+w1FKRuXkHk77Olgwhsi1E=
X-Google-Smtp-Source: APXvYqzo0+ahUj2sFEaT94kJPwXL9G3Uy6b+rEKAM/F/An1bpHkf8Zo5HWsdpCGERzDKdO4w+fT8YA==
X-Received: by 2002:a05:6808:358:: with SMTP id j24mr1223199oie.89.1581380319211;
        Mon, 10 Feb 2020 16:18:39 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m185sm606084oia.26.2020.02.10.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 16:18:38 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4d7:9d24:84b2:ef45])
        by serve.minyard.net (Postfix) with ESMTPSA id 4A338180046;
        Tue, 11 Feb 2020 00:18:37 +0000 (UTC)
Date:   Mon, 10 Feb 2020 18:18:36 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.6
Message-ID: <20200211001836.GI7842@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6794862a16ef41f753abd75c03a152836e4c8028:

  Merge tag 'for-5.5-rc1-kconfig-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2019-12-09 12:14:31 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.6-1

for you to fetch changes up to e0354d147e5889b5faa12e64fa38187aed39aad4:

  drivers: ipmi: fix off-by-one bounds check that leads to a out-of-bounds write (2020-01-20 11:01:00 -0600)

----------------------------------------------------------------
Minor bug fixes for IPMI

I know this is late; I've been travelling and, well, I've been
distracted.

This is just a few bug fixes and adding i2c support to the IPMB driver,
which is something I wanted from the beginning for it.  It would be
nice for the people doing IPMB to get this in.

-corey

----------------------------------------------------------------
Colin Ian King (1):
      drivers: ipmi: fix off-by-one bounds check that leads to a out-of-bounds write

Corey Minyard (1):
      ipmi:ssif: Handle a possible NULL pointer reference

Vijay Khemka (2):
      drivers: ipmi: Support raw i2c packet in IPMB
      drivers: ipmi: Modify max length of IPMB packet

 Documentation/driver-api/ipmb.rst |  4 ++++
 drivers/char/ipmi/ipmb_dev_int.c  | 33 +++++++++++++++++++++++++++++++--
 drivers/char/ipmi/ipmi_ssif.c     | 10 +++++++---
 3 files changed, 42 insertions(+), 5 deletions(-)

