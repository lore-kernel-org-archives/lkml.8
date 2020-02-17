Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7294C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71382067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baE06W5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgBQJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:09:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41273 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgBQJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:09:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so18687448wrw.8;
        Mon, 17 Feb 2020 01:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gC9lstFoxEbX/zQZl/VGhuG//7pDVMBu6cMv3ckvkAU=;
        b=baE06W5yq08EjZh19JkBU/yIxabzuvcrk/fS7nJ2NCYTeBK/X4EGFMJV63kxKi7jTJ
         PZrVmMnxEAme/EWJ7BDAsut41LJWRVYRubKAduXkegmWLDydGVwCnMyDbPIM6TtWf5H2
         8M/fcF1DRAotpclQ+BARtqmv2DXgCUgmX9zFbOoFA8qAgV5uqCIvct2b4+PVPvICSJca
         pJMldZE/U/e7zpkkGbqQWZ0bRcEM8bZp+TjnHQLJ2rTL+i/4VglTEbcNd7yhWvIUIgax
         JiH94SZL+m+Xp/Mt3GU8JQwrlH/1WRgnKZ4u2VPUQalUl7kF5x+Sbf1a7JTxjgyuoO3K
         GEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gC9lstFoxEbX/zQZl/VGhuG//7pDVMBu6cMv3ckvkAU=;
        b=MiUy6yZfYlYtlcuhdKt6MqEbIZvKB0GcCLPtqfDheHLku7GvBJK7QqOxaNxdG5/olX
         MKF8SXVhKe+SSk/KQfrTGn4/ZpmcySVa20YPfhxz/Rvy8GngWNcWb19pOF4P804DjK67
         d7mQDCvjxLVOof65PgreS2xBf0mDRsXSIB6ubz+PYVwtOUkw87oH4yYUuT/7WimfwsIb
         5MJvVmbvQB09E9O2t9fZeu9ORnpZ5AW+Pvdr0s922rXNta5sUSSn+5c5YT77MCNoK5ee
         yRykt3moNwxU3wu0JIPkvEEuREX7agioYJ2deRUAcqCaX9ky3UUhzJY2YB3rQ+qqdbif
         MaZQ==
X-Gm-Message-State: APjAAAWKj+p/NIwSX4/jZQekBMldBGTMUqsVhJfR4vdDyWR/CmHfFUR1
        VG76BJkLmsxSioNsdekB6+8=
X-Google-Smtp-Source: APXvYqz4xI89JvqJoHrYysoNhU4UT5wcGoXD2k5XjMzR8Zm4M/6JUP2fvA3Un3j/9tUBTSy7QLesBw==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr21184055wrr.83.1581930593493;
        Mon, 17 Feb 2020 01:09:53 -0800 (PST)
Received: from felia ([2001:16b8:3888:da00:b474:2167:8661:27cf])
        by smtp.gmail.com with ESMTPSA id q1sm38417wrw.5.2020.02.17.01.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:09:52 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 17 Feb 2020 10:09:45 +0100 (CET)
X-X-Sender: lukas@felia
To:     Anatoly Pugachev <matorola@gmail.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Pat Gefre <pfg@sgi.com>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
In-Reply-To: <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2002170950390.11007@felia>
References: <20200217081558.10266-1-lukas.bulwahn@gmail.com> <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Feb 2020, Anatoly Pugachev wrote:

> On Mon, Feb 17, 2020 at 11:16 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 9c860e4cf708 ("tty/serial: remove the ioc3_serial driver") and
> > commit a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver") removed
> > the ioc{3,4}_serial driver, but missed some files.
> >
> > Fortunately, ./scripts/get_maintainer.pl --self-test complains:
> >
> >   warning: no file matches F: drivers/tty/serial/ioc?_serial.c
> >
> > The driver is gone, so remove the other obsolete files and maintainer
> > entry as well.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Christoph, please ack. Tony, please pick this patch.
> > applies cleanly on 5.6-rc2 and next-20200217
> > only sanity-grep for filenames and make htmldocs, no compile testing
> >
> >  Documentation/ia64/index.rst  |   1 -
> >  Documentation/ia64/serial.rst | 165 ----------------------------------
> >  MAINTAINERS                   |   8 --
> >  include/linux/ioc3.h          |  93 -------------------
> >  4 files changed, 267 deletions(-)
> >  delete mode 100644 Documentation/ia64/serial.rst
> 
> Can you please at leat leave in tree serial.rst since it has generic
> nature and not describing only ioc3_serial driver? Does ioc3_serial
> the only serial driver available under ia64 ? Or can we please not to
> loose some docs? Or do we have a more common serial driver description
> somewhere which has info on ia64 serial driver/ports ?
> 

The description is about situations on very outdated kernel versions, so 
the whole page needs a general update.

I see there is some general troubleshooting hints which might fit into:

https://www.kernel.org/doc/html/latest/admin-guide/serial-console.html

Feel free to include what you think is worthwhile to keep long-term as a 
patch to Documention/admin-guide/serial-console.rst.

I am happy to support with that, but I am not the serial console expert.

The documentation is not lost, it is just not in the documentation of the 
latest kernel version, when we do not include the driver anymore.
The documentation is still in old versions, which you would need to use 
anyway for that driver support.

I do not know if there are more ia64 serial drivers, but the MAINTAINERS 
entry and commit message suggested there is not another serial driver.

Lukas
