Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF555C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D182073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lr3oxQ7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEORKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEORKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:10:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B102C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 10:10:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so3437839wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7Aj7pm0vIiZdtyu0H96D9hYnSt0UJrHRYiSk0qWGzY=;
        b=Lr3oxQ7a/Pj3O9fRDIrp4D6/zqj6Zra5xA4pHYa1RBLvoaiwIjAY/pgD9HR8ZwYIP2
         z2F38jPejUH4dw4c/TT846IL1ICaITGG+kNOBFw0MPYZScjBP42rR6zyNvzlQoxyjc2C
         9xxIBD6ASRQ+ELXcYOck4zGZcf000lTT//hSGCSyRlrIBHBNTkiJcScmbT+arSCdWJnG
         if1ZlHhY2x4lz4VJBNy9DTZ+cO0eY10AEBmvy0wo9797AtFtiU0jkRZzirp1G4zR8/4p
         BSnXTGCJtlM8MDQvZD8gcHk96H5kvyU0mB3qvkJpg2QpyMFZkMe1myw7UcpUgKCRovFH
         RC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7Aj7pm0vIiZdtyu0H96D9hYnSt0UJrHRYiSk0qWGzY=;
        b=PZvfB3ejJ3oZ+YJfvxlqDIZy6NJe4+d7mS6sYj07VI9oucMqS5wFwbPZShCgkIoF1G
         YT8HiYMn1idIzYgaxHXjQPkOVr5nGgd+0KjMsw943unijAQXMeTLYtH3V0tSfvFDg55u
         QEv+c9u2WT3mL7Bm/okXqv3vqrHFYhigQuMrZDimUTMp9d8GORDwxOG+uwkCE+l9ISzy
         0X1PKRB7LAeEKtOY4O7BmYcylSq6WOzt6Wtc8Qb0gkM6Iu48xm+1Vq9gs0GczZVwPi8M
         yRi90715+5XlRd37JS2LDm1d5qT22+LJQSkA6n/5f73+HxgIVGF2evjcGef62Fila0hv
         TIqg==
X-Gm-Message-State: AOAM530q1QIEx7jWAfnlPqI8lfZmx8Eh+xGREd/HgYmja0kBe6hU5Rkx
        LQp+Wm9CsO+zNgAoWNhjiS2Uaw==
X-Google-Smtp-Source: ABdhPJz6lBYmKIWA9SC3OBG4L5ZlSmxA4dHZtdJw/MjyFZyCRehRhjAJYuQi5z57mb8sP4wzsBQsLg==
X-Received: by 2002:a1c:dd8b:: with SMTP id u133mr4851573wmg.108.1589562607152;
        Fri, 15 May 2020 10:10:07 -0700 (PDT)
Received: from linaro.org ([2a01:e34:ed2f:f020:5450:281:8a7d:dd9a])
        by smtp.gmail.com with ESMTPSA id q2sm3800278wmq.23.2020.05.15.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 10:10:06 -0700 (PDT)
Date:   Fri, 15 May 2020 19:10:04 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clocksource: mips-gic-timer: Set limitations on
 clocksource/sched-clocks usage
Message-ID: <20200515171004.GA760381@linaro.org>
References: <20200324174325.14213-1-Sergey.Semin@baikalelectronics.ru>
 <20200506214107.25956-1-Sergey.Semin@baikalelectronics.ru>
 <20200506214107.25956-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506214107.25956-8-Sergey.Semin@baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 12:41:07AM +0300, Serge Semin wrote:
> Currently neither clocksource nor scheduler clock kernel framework
> support the clocks with variable frequency. Needless to say how many
> problems may cause the sudden base clocks frequency change. In a
> simplest case the system time will either slow down or speed up.
> Since on CM2.5 and earlier MIPS GIC timer is synchronously clocked
> with CPU we must set some limitations on using it for these frameworks
> if CPU frequency may change. First of all it's not safe to have the
> MIPS GIC used for scheduler timings. So we shouldn't proceed with
> the clocks registration in the sched-subsystem. Secondly we must
> significantly decrease the MIPS GIC clocksource rating. This will let
> the system to use it only as a last resort.
>
> Note CM3.x-based systems may also experience the problems with MIPS GIC
> if the CPU-frequency change is activated for the whole CPU cluster
> instead of using the individual CPC core clocks divider.

May be there is no alternative but the code looks a bit hacksih. Isn't possible
to do something with the sched_mark_unstable?

Or just not use the timer at all ?
