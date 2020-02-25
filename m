Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF8C35E15
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277D121927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plHyvHNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBYV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:26:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37339 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYVZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:25:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id q4so345900pls.4;
        Tue, 25 Feb 2020 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FPDGrkCD8XV4N0CFECk/Fo/6WIr98Mi9mTdpZPJjshw=;
        b=plHyvHNMHKMGxxSpNv9E5U1d3FvZ331qORHmu38BPZCjX3COmE3+TdlcRD9eCVT3kK
         2n/aZ62zcxjP0sujlhGfC+hzmpoY7Mq9TDd+iWdhdIlcr22DLTKl1vJ2vWb10QNkuRrR
         YpfSze2OGI38eE3tQgCt9jvKAREhizfuLDICy1q3mfHEd96XPO6OIQD71xuE/SJXDkFX
         nlWYijAfxCJmkJkKEcXdRLov0Hydsuo3qzLPfebVHQuW65Oyh2ihETcibQf2rrlTdfh4
         LT08mVFMfZr7+FgH5oVZtjqsxaj1zdvVDwalw0WgNcAofs3WRU4H2oL/2q4LWWj48XHj
         9PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FPDGrkCD8XV4N0CFECk/Fo/6WIr98Mi9mTdpZPJjshw=;
        b=C1mAJmRDENdUkYb3Ezisa4t32K5s875qxvS1mHZB2RrF1ciiH+OzYoLy7eoonBl5ph
         uyHcDPSy9FAnFis2lkhfZG4rV9WaH0QvLibILVCGRorRXhh0K6FE2e1zyW+yR/ybHQ31
         b/ROyzImTi13y4Rnt/Lkg5EHhA2al7ecCeS7TnDuGr5+xexneJyfxk1oQnw4E+C2GmsA
         BW6aY1b6k5Dz/u2bDd0fiuUILXUXnn358EaQmPs5q+DZK21f3lX7+CA7s81w1I96fmlY
         oBsF/QF41ygx5IhkIRya1sRG0aQo81scdxzP8A/nGren3uT0Q+j+VNO+FtzvzT8T6PM9
         4kzw==
X-Gm-Message-State: APjAAAXyGy+5Pom5+SDFte3myaHZwlnoCHBKnqtXK037sP+sE9k+51ez
        38QNYx/Uvjrr4kdlnhaOSzc=
X-Google-Smtp-Source: APXvYqyGMsKYokbIG/GnOn1XwZxyxhGAg5N7eX19vUHX4fyo0lGMcr4zI6rm5ULDYMj+xj/76vjqAA==
X-Received: by 2002:a17:90a:b381:: with SMTP id e1mr1164952pjr.38.1582665958752;
        Tue, 25 Feb 2020 13:25:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s206sm11201pfs.100.2020.02.25.13.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 13:25:57 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:25:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: Re: linux-next: build failure after merge of the hwmon-fixes tree
Message-ID: <20200225212556.GA31742@roeck-us.net>
References: <20200226081228.3adcf58e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226081228.3adcf58e@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 08:12:28AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hwmon-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/hwmon/pmbus/xdpe12284.c: In function 'xdpe122_read_word_data':
> drivers/hwmon/pmbus/xdpe12284.c:33:9: error: too many arguments to function 'pmbus_read_word_data'
>    33 |   ret = pmbus_read_word_data(client, page, phase, reg);
>       |         ^~~~~~~~~~~~~~~~~~~~
> In file included from drivers/hwmon/pmbus/xdpe12284.c:13:
> drivers/hwmon/pmbus/pmbus.h:458:5: note: declared here
>   458 | int pmbus_read_word_data(struct i2c_client *client, int page, u8 reg);
>       |     ^~~~~~~~~~~~~~~~~~~~
> drivers/hwmon/pmbus/xdpe12284.c: At top level:
> drivers/hwmon/pmbus/xdpe12284.c:127:20: error: initialization of 'int (*)(struct i2c_client *, int,  int)' from incompatible pointer type 'int (*)(struct i2c_client *, int,  int,  int)' [-Werror=incompatible-pointer-types]
>   127 |  .read_word_data = xdpe122_read_word_data,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~
> drivers/hwmon/pmbus/xdpe12284.c:127:20: note: (near initialization for 'xdpe122_info.read_word_data')
> 
> Caused by commit
> 
>   47555027eae2 ("hwmon: (pmbus/xdpe12284) Add callback for vout limits conversion")
> 
> I have reverted that commit for today.
> 

Bummer. My fault; sorry for that. Fixed up now.

Thanks,
Guenter
