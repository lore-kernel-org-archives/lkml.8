Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4109AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861C2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="r+BCuOqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392529AbgAPSjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:39:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34684 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgAPSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:39:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so23843133ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NkxS1dJ4///PjDnpw3zqOnAHEcQBbdtsaoyImvFWzw=;
        b=r+BCuOqk6DerwPHy3jM1T4vB+EtBpq4eqDuj5WdCTLhucLb9mR75gLvie4tcMoZ+2D
         i+3VQyNa2eU4BZsH/70szQZkzCdCrYxrqyjlgBEOgH7uAus+pGgjIXiN7vvVCHrfO9Q5
         9qhy//XHIa+yYjpT2/nnrYrzxPrBC+lxIH5VeNgkFUR6SH9DHxGO+v4EeQfEGKt+bNs7
         ay//+Rz0Z6TZIaVm7dxqzkdC/5oA21DwhzKNoxFngX+gJbhZDOEiqcpmED0KG4wLVb0W
         UNn7KBzcZvoPOdyxxMEFwQC1cFYQIZlRlxVgqquhyiMFYNoVvBNO6Wt7syx0eTMJZA9I
         JVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NkxS1dJ4///PjDnpw3zqOnAHEcQBbdtsaoyImvFWzw=;
        b=NB5puHLinrPNHg41Of+1Em1L7qzhx+qaudjgOBa/gQaLZfKTUrn9ECa4H31XvkAP++
         ZYetStJyMiYpJtr8r9kY89X4P+JnmQGtUbufmNEHBQjp/yV2rCtqVd0YW5i1sffCC1Rk
         f4KTqCVYQlaONuaDynt4AoR0Jx+R4oLz5wFryKqcI0TP3Utmb1ZlIIeyQCT5znSsQuB9
         OMuQc2+8Ri8lEQva4OjqZj8C72szFZoFeFfeKDtVzuTKPF9LDJTF64lqIyvjHwVjM0Lw
         Fsah/0HO1vFUEFTvTDv2G4L4WSwzU1GM11EQ9T6psrOsDbUO1sakNzCOwRagjQHqFYYx
         E6Hw==
X-Gm-Message-State: APjAAAVD9FXpu8D/xH29ce30i1SN31ymk+uAWANOy9xUYXq+gkGoZYvx
        XzeDInYUmmZvq1VvcuvX4cCXCA==
X-Google-Smtp-Source: APXvYqy1r4axnNLypvtxCDCBusTSJPvQ5bBth2V80eQ2aWR3SDteItjF5tjp00AcOpEuhWvIgDGEAg==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr3077169ljh.192.1579199982123;
        Thu, 16 Jan 2020 10:39:42 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h10sm11007576ljc.39.2020.01.16.10.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 10:39:40 -0800 (PST)
Date:   Thu, 16 Jan 2020 10:39:32 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: Re: [GIT PULL] soc/fsl drivers changes for next(v5.6)
Message-ID: <20200116183932.qltqdtreeg4d2zq7@localhost>
References: <1578608351-23289-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578608351-23289-1-git-send-email-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 09, 2020 at 04:19:11PM -0600, Li Yang wrote:
> Hi soc maintainers,
> 
> Please merge the following new changes for soc/fsl drivers.
> 
> Regards,
> Leo
> 
> 
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> 
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.6
> 
> for you to fetch changes up to 6e62bd36e9ad85a22d92b1adce6a0336ea549733:
> 
>   soc: fsl: qe: remove set but not used variable 'mm_gc' (2020-01-08 16:02:48 -0600)
> 
> ----------------------------------------------------------------
> NXP/FSL SoC driver updates for v5.6
> 
> QUICC Engine drivers
> - Improve the QE drivers to be compatible with ARM/ARM64/PPC64
> architectures
> - Various cleanups to the QE drivers

This branch contains a cross-section of drivers, including those who are
normally sent to other maintainers/subsystems. I don't see dependencies that
make them a requirement/easier to merge through the SoC tree at this time --
for example the ucc_uart driver updates are mostly independent cleanups.

Am I missing some aspect here, or should those just be merged through
drivers/tty as other driver changes there? At the very least, we expect drivers
that aren't merged through the normal path to have acks from those maintainers.

Mind following up on that? Thanks!


-Olof
