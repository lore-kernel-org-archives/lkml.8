Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C4EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81B2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR/NFJmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgFHOi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbgFHOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:38:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64EC08C5C2;
        Mon,  8 Jun 2020 07:38:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so6099519pjb.5;
        Mon, 08 Jun 2020 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHVYkeIA74fsa82ThfKsW3dCbekWTk6QgoIVYqEvnVM=;
        b=rR/NFJmDXm26CdXkCHmyqaovvj3YmyuK0TZIZX2y8lBhWId9hpWyfXiPIGaev1NnOp
         0/OMshzfj6wI5lAFEgTWH/Jo3x6w6yiXWi1M41vux7OklTuiMz+Db/dM92egpXTWyvhi
         gpUxQ6TGCuKTiIJ4Nr/9+TdtaVqu25FX4vU3JX1aEURxvWP7gKtEjV/tDro0Vog41RTd
         UOeA3gccNDwS6Rr3EBPjKbQEsXiGgZ3aow7DFH2DMvyGDjSlTDURRk91+oxBKBhbdkA7
         CNPDl6R9/IcvSXM/OVXKlxwZM0WO1UrkMV/REcYe4o3/yWj5F13XYlqlLamZr0V6W704
         KTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHVYkeIA74fsa82ThfKsW3dCbekWTk6QgoIVYqEvnVM=;
        b=b6KIgo1zfhQY5cddYXiVga9eitr7Y1SsNoAU59+ZeaIanMiHu70xRvEf5BLWM7J+qm
         0t0TalQW51zAe6fblIp16AQ0NU98jcyFvhohhAto5xcUcgmyoFjte6GunEYcVqLwuMaS
         5BR7kdpZn3EATeh7T8FwkBPyHe7QaoKtwR1UgCny2wdZ+r2ILAjcMy7VmIy6nCqEMCMz
         Cx84Oq1Br5gItGxuxZGee6oPaJ4cmf6UZJ6Xrynhj5m/cpbzWT5QfzDhwqwzEkDf2QAE
         nIFSLio8uz5YoDBcSD73umYs4hiXTVYWk/SSLSqC0t19EGdx2Rj9e9hzrQDr2ri1X3yt
         Yp6w==
X-Gm-Message-State: AOAM5331nZM2xNNCpmXmuSoIDM1y+qPlys+ltVFz5CqxtNuvjoEeJZ5w
        8VF+IU1oMRv1/4v6LO+sUek=
X-Google-Smtp-Source: ABdhPJzjPn6qRrfjuaQzpcUUixUTc/hW5I1F4tToTMD663azYOuhsVML95fB6yTMmORG56y3ZPsx3Q==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr16725297pjb.56.1591627136540;
        Mon, 08 Jun 2020 07:38:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f14sm15765562pjq.36.2020.06.08.07.38.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 07:38:55 -0700 (PDT)
Date:   Mon, 8 Jun 2020 07:38:54 -0700
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
Message-ID: <20200608143854.GA140781@roeck-us.net>
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

This patch results in:

Building alpha:defconfig ... failed
--------------
Error log:
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/alpha/kernel/setup.c:435:13: error: initialization of 'void (*)(int)' from incompatible pointer type 'void (*)(void)'

... which does make me wonder if it was even build tested.

Guenter

---
# bad: [af7b4801030c07637840191c69eb666917e4135d] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
# good: [3b69e8b4571125bec1f77f886174fe6cab6b9d75] Merge tag 'sh-for-5.8' of git://git.libc.org/linux-sh
git bisect start 'HEAD' '3b69e8b45711'
# good: [77f55d1305c11fb729b88f2c3f7881ba0831fa6f] staging: rtl8723bs: Use common packet header constants
git bisect good 77f55d1305c11fb729b88f2c3f7881ba0831fa6f
# bad: [f558b8364e19f9222e7976c64e9367f66bab02cc] Merge tag 'driver-core-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect bad f558b8364e19f9222e7976c64e9367f66bab02cc
# good: [ca681aa49200422a4144ee376a2079a9f717bf11] Merge tag 'usb-for-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
git bisect good ca681aa49200422a4144ee376a2079a9f717bf11
# bad: [a1b44ea340b21c99b34c93acad233da727cb88ba] tty: serial: qcom_geni_serial: Add 51.2MHz frequency support
git bisect bad a1b44ea340b21c99b34c93acad233da727cb88ba
# good: [e0a851fe6b9b619527bd928aa93caaddd003f70c] serial: 8250: Avoid error message on reprobe
git bisect good e0a851fe6b9b619527bd928aa93caaddd003f70c
# bad: [57626ff1c9135211b92dfbea1923333c7b6dd12c] tty: n_gsm: Remove unnecessary test in gsm_print_packet()
git bisect bad 57626ff1c9135211b92dfbea1923333c7b6dd12c
# bad: [675cacf11462f112ab13d57e1163082161ef8708] MIPS: constify sysrq_key_op
git bisect bad 675cacf11462f112ab13d57e1163082161ef8708
# bad: [0f1c9688a194d22bb81953bd85bd18b0115fd17f] tty/sysrq: alpha: export and use __sysrq_get_key_op()
git bisect bad 0f1c9688a194d22bb81953bd85bd18b0115fd17f
# good: [7b668c064ec33f3d687c3a413d05e355172e6c92] serial: 8250: Fix max baud limit in generic 8250 port
git bisect good 7b668c064ec33f3d687c3a413d05e355172e6c92
# good: [beca62c4212ade1516a526784adf7f7d99c7f3d9] tty: mxser: make mxser_change_speed() return void
git bisect good beca62c4212ade1516a526784adf7f7d99c7f3d9
# first bad commit: [0f1c9688a194d22bb81953bd85bd18b0115fd17f] tty/sysrq: alpha: export and use __sysrq_get_key_op()
