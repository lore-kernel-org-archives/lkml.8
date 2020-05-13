Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A4C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC42C2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0S4Cz3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgEMG0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgEMG0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:26:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:26:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j13so522150pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHbG9BId/8xaDiuaIj5eCQ0ALRHt+CW859scLNFLk0Y=;
        b=H0S4Cz3j/CRc40ufAknbRnu9vDXjyD2iwgXd0vXXMFJTmx05XW8kTKB2XfZJaJfO93
         EJXdpDdjdTNXsWypExRBl5hV4iDEngG7RVgglDbdkyrP0AkQ9OtsWNUGA84Da3M8S0tj
         pWEaJNFuYW2rgXjVkgmjCx+C23jNT4S5wEieJnqlZtr587WYSGUDOR2uw9LB3463v5AL
         ULne286iTVCGNDnCVTMTb3zbHej4UsA2XWSJKD5T+HnPdpy68tOhs+NFG6/727uxWluB
         Zlj7o5EGd33+uXiTyg79Y7igjgGGbuYsL//6+B8ukaQmsHmNNEvJCugZ3XZYKaCWB/S7
         rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHbG9BId/8xaDiuaIj5eCQ0ALRHt+CW859scLNFLk0Y=;
        b=T9FxtOUYGcl87DxxPIsQKvqrQPpgFAxNBqf5hqPoHm4WkSRTjmH6zmnRg9i5pBaIh9
         ew1X0xXl+8RPI9dmitFNhQQY3SBxyBwcSyOjFChu7NCixiAtiQzF6fzHcDhhErxDT0qb
         0UcNvZ62ceDAeSz1YktEvY7+XO89GgQ5uYUEeGnpui+Snkhp00SykpB77LcKJCAz1GbQ
         dZXS4I4JjnsyARgkKLjSXlafck1ndqecZgkPwAi3qtxRmuQXraHzXIE9z3HUCiYoKAxm
         LrdLjEbT/YpgOxnTRj3uGJ/8vL03eoVtsfOJJ6seZHjUk75HeUDvZA0rQdwVjlHMSYCq
         1faQ==
X-Gm-Message-State: AGi0PuaodUXD4UxoZr/6KlGi+4+AcbIeiRI7pRO+eHiL+mttxux/nvAz
        j9TSbaMmSVVGg7w9x+GIK2guqQuD
X-Google-Smtp-Source: APiQypJ6y2snWVtXsj7E87CtinRJxyOKbkx9EzBFzVNqytFAFM7fgza51F45hg6Eh5svq2w6WvdT6Q==
X-Received: by 2002:a17:902:e905:: with SMTP id k5mr23781224pld.232.1589351214642;
        Tue, 12 May 2020 23:26:54 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id w11sm12176338pgj.4.2020.05.12.23.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 23:26:53 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 13 May 2020 15:26:52 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513062652.GM413@jagdpanzerIV.localdomain>
References: <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/30 01:35), Tetsuo Handa wrote:
> Below is the default rules for rsyslog-8.24.0-52.el7 (userspace syslog daemon).
> Of course administrators can modify as needed, but notice that KERN_INFO is saved
> to /var/log/messages but KERN_DEBUG is saved to nowhere.
> 
> ----------
> # Log all kernel messages to the console.
> # Logging much else clutters up the screen.
> #kern.*                                                 /dev/console
> 
> # Log anything (except mail) of level info or higher.
> # Don't log private authentication messages!
> *.info;mail.none;authpriv.none;cron.none                /var/log/messages
> 
> # The authpriv file has restricted access.
> authpriv.*                                              /var/log/secure
> 
> # Log all the mail messages in one place.
> mail.*                                                  -/var/log/maillog
> 
> 
> # Log cron stuff
> cron.*                                                  /var/log/cron
> 
> # Everybody gets emergency messages
> *.emerg                                                 :omusrmsg:*
> 
> # Save news errors of level crit and higher in a special file.
> uucp,news.crit                                          /var/log/spooler
> 
> # Save boot messages also to boot.log
> local7.*                                                /var/log/boot.log
> ----------

Yes, but this looks like it's the consumer of the messages who
decides what to filter and what not to. rsyslog, dmesg, etc.
will have different filtering policies. It's not like the kernel
decides what to hide and what to show. If would compare this to
NO_CONSOLES, then NO_CONSOLES does a different thing after all.

	-ss
