Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43019C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 05:02:52 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B85C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 05:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5zxFMWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B85C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgDMFCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 01:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgDMFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:02:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176FAC0A3BE0;
        Sun, 12 Apr 2020 22:02:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n10so4042409pff.3;
        Sun, 12 Apr 2020 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/mPo6D3puWMaFkzogYl4nqrkT1YpccdPa2j2f04i5c=;
        b=B5zxFMWaSGyFuBKFLrN901UcpVJkvRfyEAmL0p3xp9LQVgbQx9RqlMywCtalwK8eK6
         3ZbAUBbkI6caGcr7o5XYXisgbg/Hj/xc2QbPtWQPACWIcsvc/sT/AQm4UV/z9D8g0OVZ
         LWuRjyI/tsHiwTY0FFCyRMHJwRJNxUFR/Hj5Rn3P38b1+3x/jI0cLXIzFzgHbwrrF+oV
         s7MXdc9tSloxLOv6I6kt37javvd0+UtTfV7A9fQb4+w8/iM3Akm8pTBvhqx4xZ3Fxhx/
         HvdE5eEztN7SKqrdq91Dc7YTRmEH8ZJPjSqq1cAbqgUaBip737xrvn/WgEPM9wy5N0Ao
         Eu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=r/mPo6D3puWMaFkzogYl4nqrkT1YpccdPa2j2f04i5c=;
        b=tuef6Ok0AHzHVChlKWD0v6TqZLK60/V1IN2++RhEZJ1mI68irM61MYlQrIEg1yKTOl
         1IWOQSosNTfOkubngm3OA/nWh26N05a9XTRuWsA6GdT7JBm84hHoPFrmJ1tj6sgop9cB
         2ygjUECIWNaCpuEWoQMK6iYjNvglrJoRwnoapFeSwv13q1/BCz625wdj4sWNtYKdGHzO
         cPGmZ7bCOA1gFqOaMqqRkDYEvre39byr+jYnzIBdpev1pYBv0s8AipkITB/YWQEfRf1Y
         y5H9MDN2/JR7HMsOKSD+Ja4OLDZ2wa+h+9W0+Pxb6I8MZwqx7X0vafAJ17eLVoyWKUJp
         Hgow==
X-Gm-Message-State: AGi0PubXBy83bXlCTc6T3yoi0wkEgePuxF4xZE+syXzTOWoCKkt4Xcdw
        cR6nkwOu7dtmzMK3uf0/LVo=
X-Google-Smtp-Source: APiQypLA45AhZihZWtWdGB+xHKxJM4IPrx+3P1oZNE0tXc9KdF+I6jImqLw/+gU1etfxO7BHAae6jQ==
X-Received: by 2002:a62:7c8b:: with SMTP id x133mr15869118pfc.229.1586754168622;
        Sun, 12 Apr 2020 22:02:48 -0700 (PDT)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x3sm7147299pfq.95.2020.04.12.22.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 22:02:47 -0700 (PDT)
Date:   Mon, 13 Apr 2020 13:02:42 +0800
From:   Orson Zhai <orson.unisoc@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com, Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH] dynamic_debug: Add an option to enable dynamic debug for
 modules only
Message-ID: <20200413050241.GA5694@lenovo>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com, Orson Zhai <orson.zhai@unisoc.com>
References: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
 <20200410124414.GB2091460@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410124414.GB2091460@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 02:44:14PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 10, 2020 at 08:33:04PM +0800, Orson Zhai wrote:
> > From: Orson Zhai <orson.zhai@unisoc.com>
> > 
> > Instead of enabling dynamic debug globally with CONFIG_DYNAMIC_DEBUG,
> > CONFIG_DYNAMIC_DEBUG_CORE will only enable core function of dynamic
> > debug. With the DEBUG_MODULE defined for any modules, dynamic debug
> > will be tied to them.
> > 
> > This is useful for people who only want to enable dynamic debug for
> > kernel modules without worrying about kernel image size and memory
> > consumption is increasing too much.
> > 
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  Documentation/admin-guide/dynamic-debug-howto.rst |  7 +++++--
> >  include/linux/dev_printk.h                        |  6 ++++--
> >  include/linux/dynamic_debug.h                     |  2 +-
> >  include/linux/printk.h                            | 14 +++++++++-----
> >  lib/Kconfig.debug                                 | 12 ++++++++++++
> >  lib/Makefile                                      |  2 +-
> >  lib/dynamic_debug.c                               |  9 +++++++--
> >  7 files changed, 39 insertions(+), 13 deletions(-)
> 
> Crazy idea, I like it :)

Jason was highly appreciated for his suggestion to my RFC patch before this.

> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you very much.

Best,
Orson
