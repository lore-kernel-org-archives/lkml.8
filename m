Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4852C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B42074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+gOK5e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFJUv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:51:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40935C03E96B;
        Wed, 10 Jun 2020 13:51:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so1506191pgb.10;
        Wed, 10 Jun 2020 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BBQ0kH7eFUEzdi1aOvEKWX8Td5hf8bU8NRtY72Z+54M=;
        b=D+gOK5e5N4uDHgaJEiVzXMr6VuyH27uOIfpnVLZCy5Svn8efbO2h827R3C7PSG9a6K
         nSxI9rCKBM4+edb+ob89dSUUXQZZWJrsEl8UC/4RkIct10qQ6WfwWd8slAvfV1/HlK/4
         ykKf76IVM/KVIwnVtOcQc5SFY3uoVQV1mOixWR7kBTjfcGeM6FFil+FjQMvZX2lH6/fD
         gHslJ0At6A3/MekYWNpXmXm3Vi+6i8d7T3bOXM0tia17DDU08MIcYxt4wKKuf7x2IHoS
         KvHq6vwU+GQ2TNficbOEiCmyrVYunxWWsavQXQOZAWvXa7y+sW3BAUPx/QOpU3y9HdG4
         aA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BBQ0kH7eFUEzdi1aOvEKWX8Td5hf8bU8NRtY72Z+54M=;
        b=feUxUcRZDO0V8V2Ri9KHuLXhJsMS25TlTQpCqqgdDzzub3JQclq77b7HileB6BFH1b
         PInBTWJeKdPHVc7LqUAH6rjz5isTqESF4mCfGagf+RRla7uwto1QojPiSTzAaeBUb2X5
         WQdTVn6XJlL0mIzqHjZIOEKisDwBuMFuhuKi4Dn7DQ5WpjaMzDwkIgnz4bcUprBKCKgh
         1Q6WFluAxsIViN4D/deJ4swnG/eEw0oVVqKXHSo+7BU3jADsz9dErwFSwcpvNvtqd6Vz
         3tQC9/rYIPRIy4OnS4MGEAMSqlpdF9UnwQu2DUg82crwo+Qee2Rmqxv4c3bLiIUFK2GN
         CClw==
X-Gm-Message-State: AOAM531Kqp5F170BMz16+QvaIwKchDe4ZMBrzLh3ejOoc0VZyfmJh8f0
        1CfJkURJOAmgWuj6m467m9Y=
X-Google-Smtp-Source: ABdhPJxKo0OgffPzJUXcMIqo8lFX22kcJRM0lWIv/TfEFZDqsYln/aDXLO3H4Aw664SDq8TfeoQ80A==
X-Received: by 2002:a62:7a89:: with SMTP id v131mr4254293pfc.38.1591822315664;
        Wed, 10 Jun 2020 13:51:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x19sm793349pfo.96.2020.06.10.13.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 13:51:55 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:51:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 01/11] tty/sysrq: alpha: export and use
 __sysrq_get_key_op()
Message-ID: <20200610205154.GA14854@roeck-us.net>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:43:41PM +0100, Emil Velikov wrote:
> Export a pointer to the sysrq_get_key_op(). This way we can cleanly
> unregister it, instead of the current solutions of modifuing it inplace.
> 
> Since __sysrq_get_key_op() is no longer used externally, let's make it
> a static function.
> 
> This patch will allow us to limit access to each and every sysrq op and
> constify the sysrq handling.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
> 
> IMHO it would be better if this gets merged this via the tty tree.

Still observed:

Building alpha:defconfig ... failed
--------------
Error log:
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/alpha/kernel/setup.c:434:13: error: initialization of 'void (*)(int)' from incompatible pointer type 'void (*)(void)' [-Werror=incompatible-pointer-types]
  434 |  .handler = machine_halt,
      |             ^~~~~~~~~~~~
arch/alpha/kernel/setup.c:434:13: note: (near initialization for 'srm_sysrq_reboot_op.handler')

I did not see a reply to the initial report. Is this being addressed ?

Guenter
