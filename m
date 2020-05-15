Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB21C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CC720758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQepBCDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgEOKdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgEOKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:33:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B397C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:33:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9so765732pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+XVj7Vn4q7UWK0rXA2mfb7XaH4le6Oj5JDX0rkTcjv8=;
        b=QQepBCDYSozWfCOr/eFEkoIrW01LVBw3ONlO+lac/N4lGJUp/URE0OM0R9XXbLQIJ3
         YYf2/4K2rm8OLRPVubTJZFyO50CLzcAWr8nckIRaOLY+1f/vjSs2lR+Y5Y9bYDVQr+pO
         Fnas1I2V70MShXTLQFzApJ2ybjosMrusIzmosj5ERNkD0FNvl2r7xEpN3u7aiDcdK0tr
         JLoFrbFbEqVnmjAqh84lWcO60Bmd564ZmkSBEo0e8Y39SfjqK2Z8OgAUv8FeW0UIIq7Y
         6HRB59wBCV00RZ4X9L92ig7LTwJGuZxKJZFNvgtQjZp6S88j5dMkuyDY9bSxQbZ/13/F
         /JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XVj7Vn4q7UWK0rXA2mfb7XaH4le6Oj5JDX0rkTcjv8=;
        b=qpALtZVVHyhnxdR8erxrpZ/GB3XByRrj1qz/TVNuuDPs6wg2fqAHVC7qguqL8GYH0k
         2wFUQdOy6fgdktEQMbOqu4LAp4PTxEOfZyOcFAtZrSANESzSzJNm3Y+oZiIj6cujpBtX
         HwmFWFwi12ZirvsZvgGgMg5dRXq1/ZegbpekdfcASEOLRkbHiW1X++P+1vpGVf5W6rKl
         nSMPw9Gr+doaZOsLTSKZC3D7rrBqlVKMdM5xhAoVDvIqqiMu191tChz/wLcpLhzpwrsl
         Qvn57TmuYHda4sRP0fjPIMFrnc+cZjadnB/4n1RCqDWdEIH51uMjEj4AjjAJo/bipWIe
         Vz9w==
X-Gm-Message-State: AOAM5327nl+9CZHLOMlafkP8Ie3/WM4iJ6ioS4JfYaegLx/RRt4INMd/
        iaQ+tP77urJ+U5xa0kbJ6/g=
X-Google-Smtp-Source: ABdhPJweTKamypY9HN33QeOPRzMIehLxFsMWkxcut7xNXPUoTEgrKmllHE13oLf4hSc73mfTruAatA==
X-Received: by 2002:a17:90a:1aa2:: with SMTP id p31mr2625068pjp.233.1589538791105;
        Fri, 15 May 2020 03:33:11 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id j23sm1316378pjz.13.2020.05.15.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:33:10 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 15 May 2020 19:33:08 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200515103308.GD42471@jagdpanzerIV.localdomain>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515085021.GS17734@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/15 10:50), Petr Mladek wrote:
> kdb is able to stop kernel even in NMI context where printk() is redirected
> to the printk_safe() lockless variant. Move the check and redirect to kdb
> even in this case.

Can I please have some context what problem does this solve?
I can see that vkdb_printf() calls into console drivers:

	for_each_console(c) {
		c->write(c, cp, retlen - (cp - kdb_buffer));
		touch_nmi_watchdog();
	}

Is this guaranteed that we never execute this path from NMI?
If so, can this please be added to the commit message? A more
detailed commit message will help a lot.

	-ss
