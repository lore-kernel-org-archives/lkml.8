Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A942420775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRDJKmAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgGHIHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgGHIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:07:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51FBC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:07:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so1862886pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zgzFBfd1L8gIswoLsa9e4bScB/4Us/z7PKgKE1kxKk0=;
        b=TRDJKmApQQAgV1F8yAcsr7qqPMqF9bluQIsXh5qPLmghCHbJ8NP3OAnDdlEjEIdfrG
         PuchHLjwb6SA3djTfP0AbHhk8YSQvR/V8xt9XIDmVqnhChRLS6aFQChmOIxvLioQlZkU
         mQ6L0FHn9yT4CciTyXmcQ/VfHL+2dM7Ek0smfDoOlMc6mLQzum00ZRqPUrdtpeBPHB8H
         qDpIgtAbr/EDZV6f4fZlgJ+hCZlGud51Jc2M59ypZhlrMjFa66XYFHe73lOBHFFjSFrV
         VrDGE4rRbb9nvIQWEg5POM0dDCecD8sX7T9zKGQhZsnc5xfqiEZV4plcUnA8Zt4od6q6
         1+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgzFBfd1L8gIswoLsa9e4bScB/4Us/z7PKgKE1kxKk0=;
        b=Szwukb/MNr1pDGwur+K22VqoS98Xkyd8IbBGQ2M3TXQkgtYWGtOgyEC/1Tqs0XvQoL
         GPLmd26hD2DHgBvMLnMpsl4vG0/YqiEuPa0gtzegsdUur0vJ049jCbATCu6fMXSX4W0G
         LAvdMEt7CU0no925+V1IfNI30iLqNpASxfIftws1enTt6KUr+EXZVd7z3hnYMiwD2wok
         tmVoSWxa1zxcKBi1arFhxqu0V10sOwu1ZC1Ahbc595URkg72HGJEAi3cQOvNeal9aOT6
         YdYKLr0h8P4tJ9FiYCoDclsrpYbpwsKidgnPh4QIxzrnlkJZtlivI12iJgKOyUJPYfbT
         5GhQ==
X-Gm-Message-State: AOAM532vmM9aVUD6T96NvaaF9sNMY5d5mwGZAb/XpZd7K3voUrbGfCzK
        EuorbOQLtrbMrNjvGNdnTtRaZRF/
X-Google-Smtp-Source: ABdhPJxILI9kIQVi/IzMOCbDxxFrikiBeyiop3NvXUYPgNvMjePeIEmdB8WnFfWYdLpZIagendcrTQ==
X-Received: by 2002:a17:90a:3525:: with SMTP id q34mr6911330pjb.192.1594195634298;
        Wed, 08 Jul 2020 01:07:14 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c132sm23925453pfb.112.2020.07.08.01.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 01:07:13 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 8 Jul 2020 17:07:12 +0900
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200708080712.GC571@jagdpanzerIV.localdomain>
References: <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com>
 <20200703103241.GB182102@jagdpanzerIV.localdomain>
 <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
 <877dvg6ft6.fsf@kurt>
 <20200706144314.GB1485@jagdpanzerIV.localdomain>
 <87o8oqa1zy.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8oqa1zy.fsf@kurt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/08 09:40), Kurt Kanzenbach wrote:
> I'm not sure how this patch will help with the situation. Because at the
> point of that THRE test the irq handler isn't registered. It's
> registered a few lines below (up->ops->setup_irq()) meaning the irq line
> has to be disabled if shared. Otherwise the kernel might detect a
> spurious irq and disables it. That's at least my understanding of the
> problem (see commit message from 54e53b2e8081 ("tty: serial: 8250: pass
> IRQ shared flag to UART ports")).

So the only remaining approach then is to move
disable_irq_nosync()/enable_irq() out of port->lock
scope.

	-ss
