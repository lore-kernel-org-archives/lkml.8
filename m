Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C573720657
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 19:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTFOmEPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgEQTm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgEQTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 15:42:56 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38196C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 12:42:56 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j145so7249622oib.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=k0Vy2JKz3hLpstsmuXUIcjAr4k7iKphhSMu0USzZSkY=;
        b=lTFOmEPeQBUHyds+RZPBW9juqTXl0B0Y5WugRQUSEyJ23nhG7W0SPHOFVjApu4s4Fn
         oxhJP7YX7J/SS+x1iLLW2SWN+JLW5ItTBEg7+VOJdrNTk49d4IWukEPV22Dn4xRe9hj3
         DdaVdGST/HhbtuwFXYVbpkVj/H4CDTbfmpNol35xUzhnqCPnBeZyY6PKVEbjTKsY440q
         olbHjXLcF/slyiwLLokyH4OKBcYzSxSI5/o2wx9/JybxJPPxHt0+XWewH14IlR7asMCD
         1QJTNDj6oKFKoDRMSk9XubI1EANdNvyVPOYIpkTZw5DyVTlIcz1h/wjF64EZuRu5F4ng
         oAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=k0Vy2JKz3hLpstsmuXUIcjAr4k7iKphhSMu0USzZSkY=;
        b=EaTHcIvV2qqQTGrt9B8PxLF/p/8n5OvM6/gAF53+0MbDzS5AsR3HYDgdu+9M0NdMZM
         3wnp1J60jT96ga1M99kPvzYcOKRem8DSkX/o7JkT1T8s5PLEeq0StBhAqHf+8AkZmw9P
         QvMPSGhbt3qSd5vc9OofxmqSCimsNNo/P22dcwsSBPymyk2XAt7xmc3TvE/imasASBqo
         Z5voHJvZaZafqwqSXOplHjImDZ487Dh7XWQjI7I0ibbi6d+kHmVp2AKgNaxnucvx6K59
         IWj8MZ9iOF8OyPO5tl1Tjj/CGAoyfYvJexJpUwv/nVXA98muVjwAK0cIbveIjSrLV7MK
         Pbiw==
X-Gm-Message-State: AOAM533yo+o5cfccKJotSnEl6PBOvBaNUV7NiT34O0GcuMzKt2eFbZAT
        jlxPkBemZOHI1qdshD0a3jeO4HA=
X-Google-Smtp-Source: ABdhPJyArA5KB6iogMf407HCCcXuxvQ6zH0jioB/vjiAMRBjrUm2MkRmAgfSqWYYgPXtdu5lLIBM4w==
X-Received: by 2002:aca:318f:: with SMTP id x137mr9104312oix.4.1589744574980;
        Sun, 17 May 2020 12:42:54 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z63sm2354213ota.55.2020.05.17.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:42:53 -0700 (PDT)
Received: from minyard.net (unknown [192.168.27.193])
        by serve.minyard.net (Postfix) with ESMTPSA id 81008180050;
        Sun, 17 May 2020 19:42:52 +0000 (UTC)
Date:   Sun, 17 May 2020 14:42:51 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL] IPMI second update for 5.7
Message-ID: <20200517194251.GD30085@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.7-2

for you to fetch changes up to 653d374771601a345296dd2904a10e6e479ad866:

  char: ipmi: convert to use i2c_new_client_device() (2020-05-14 15:37:31 -0500)

----------------------------------------------------------------
Convert i2c_new_device() to i2c_new_client_device()

Wolfram Sang has asked to have this included in 5.7 so the deprecated
API can be removed next release.  There should be no functional
difference.

I think that entire this section of code can be removed; it is leftover
from other things that have since changed, but this is the safer thing
to do for now.  The full removal can happen next release.

Thanks,

-corey

----------------------------------------------------------------
Wolfram Sang (1):
      char: ipmi: convert to use i2c_new_client_device()

 drivers/char/ipmi/ipmi_ssif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

