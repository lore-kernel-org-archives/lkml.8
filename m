Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254A9C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A3620736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTmw5SUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbgCLCWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:22:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34258 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbgCLCWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:22:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id g6so4007540oiy.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=QDfEy2KOrmUWhesuf+lQpYADP8RXEp5zI9wZ50uQ7Yk=;
        b=vTmw5SUc8ejOLwyQuz78a+gHP0+hcPEIGgwM//iGnKqtg49IfDJCEjiTN3B3Tfby6j
         iLRVzS8T6NU9WAqWzRUUVz3pXio78rDw/Alb4Hzio/Zo4c5sbBnPUhIhg4l0qxgRVTKo
         MCnJr1BLr4nngGfCadm9Wst9/8SpBoCXt20mYV+6wXOG1fx8drdEBLO0rA+QGN80na9q
         1IbBHHk5DWUv/Us2Szy5EIrmckUhZBHLhs2oR927EfsvEWCCcZIToXwXCNhsmR4WyPEH
         JJdt/q7UEDvEqelPsl12rtHA8F3KL39CLYdyG3P0vXmris8hLe/mQjfGeGQ7rrUdu3wS
         kKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=QDfEy2KOrmUWhesuf+lQpYADP8RXEp5zI9wZ50uQ7Yk=;
        b=YuxCszPf3jvAlQRfCQHf1PiFltcPQVKNV8Gcum2QZrPjO+hxe6DpGtmm/L0rtxg1GI
         sPNMTn8V5hsmtr/k64ciijEZDNv0a1K7MpsT2RoKCcloR8X0CXNw12D94WdkEboE9ItB
         V+pMo+PUoyMMsadzSrb+TIetqDdaHVfPbqL77xdK68Cebr22QOBma8RSW7/KzCPaAxuz
         1fxfSnOYr6C2uC4eHO+W2VZ9aGIL7S3U7DZ6WjROg2LGzesTkoibE0tVXbE1/f3cDiel
         q44mncYNyhqyu2ZiHDzNaDTZfa+6x8aXns2ULIS41bBUkrkh6xsvsT1QBIRt6E6FeSEU
         0qnA==
X-Gm-Message-State: ANhLgQ2A8tyGX9E/H12Dsc/VcAvYrqLTGbO2eXVXccbVr8T1s81hX18N
        NcQIhS3aUkEoUhSyBd6gOytbb8Q=
X-Google-Smtp-Source: ADFU+vtlgwvaCigi7XW+CZdEW7bqs/N8beI0ckfUhBWeMJOvjzcm1suhobv5PWyjIj6wEt3i0lUlkQ==
X-Received: by 2002:a54:4099:: with SMTP id i25mr1106085oii.129.1583979731384;
        Wed, 11 Mar 2020 19:22:11 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id b16sm878469oov.1.2020.03.11.19.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 19:22:10 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:7426:b01e:9a0e:899a])
        by serve.minyard.net (Postfix) with ESMTPSA id 9C72C18000D;
        Thu, 12 Mar 2020 02:22:09 +0000 (UTC)
Date:   Wed, 11 Mar 2020 21:22:08 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        John Donnelly <john.p.donnelly@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] IPMI bug fixe for 5.6
Message-ID: <20200312022208.GH2822@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2:

  Merge tag 'linux-kselftest-5.6-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2020-02-19 17:22:10 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.6-2

for you to fetch changes up to 443d372d6a96cd94ad119e5c14bb4d63a536a7f6:

  ipmi_si: Avoid spurious errors for optional IRQs (2020-03-11 21:15:19 -0500)

----------------------------------------------------------------
Fix a message spew on some system

The call to platform_get_irq() was changed to print a log if the
interrupt was not available, and that was causing bogus messages to spew
out for the IPMI driver.  People have requested that this get in to 5.6
so I'm sending it along.

----------------------------------------------------------------
Takashi Iwai (1):
      ipmi_si: Avoid spurious errors for optional IRQs

 drivers/char/ipmi/ipmi_si_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

