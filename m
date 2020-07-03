Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F37A207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8omVD//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCKxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:53:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439CC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 03:53:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so12523604plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 03:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OGpuzxy+MIp1rENc9jMCC/mFYHbkQY9vYIT5QTgbmWY=;
        b=Y8omVD//GCbGlXcKzoFyVJ3TZNxqpcQrcXvYGjk7s8ZSMiLHmndCYMhy5FFzSfehLp
         +mqnAq6R85+kF02ylNBK0KRxaiJ7WkJCk74+Fr7X9dsfhjbsO6jCzLXrvaeAgccJXtiV
         khACNA2bp67N58fQGUDb9MZ8tKy2vSmU4NrEL9a870Y135yTSJCz/iFzbH8A0/02/UDx
         vUtppSY4IwBNT5TcFm6Jqy8MS464JomSUzShRLYXbS8UMBrvMeq6E6DStDBhLvADvPae
         VLwfnjVVSFN/Ja1M0zMOxyxpKSBNam0bRKJSyMjebYT75vleYgFhjKfOJ8nnBshSQYiO
         vTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGpuzxy+MIp1rENc9jMCC/mFYHbkQY9vYIT5QTgbmWY=;
        b=WAUE6G2iYui2yvYuHuVLIjtfjmDbA1ukAsV5e7rVCNvxG7vLsij0t6T7GFjcZXhjFK
         pFUXfkWbFFJ4lQmZqMlqts9r38TaOtO+T1KduJOqC7QFdcLMwKQ71hbgFJMDrV0SKkLu
         vf1SU3FRNf3e4a2RxDusyyHgQy1qNApYhXsoTSZhzNdKgqId9OlAx9caUVIAh6Qd7fNy
         mk1IvQqD6L+Sps9mn0jQlFcWbZJFc+cOcB2RuscQ/+UKNLBhFF/G4oKlX4liTxIhSMjg
         9tOG2lVbFgkx8E/aDzIQ+vpnkFpfvihk2TbiI9D6RKFyzCzCI2yX9TPU38eENBbG/yEY
         nqnw==
X-Gm-Message-State: AOAM531zFtoN53MDjzENpFlrRgfhRQHy8Af+7q0JhrlCanBob7p9vA4p
        Q+LdPLnwbgDWxf1bW+KkiDR0L28+
X-Google-Smtp-Source: ABdhPJyLQAQGnk4XRz3gN+ixe6a2o3AdtA5zjeR+MJs2FiKIZLMplBB5KZldIizrcPDWU61tm/ALAw==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr6673988pjx.169.1593773584539;
        Fri, 03 Jul 2020 03:53:04 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x10sm528364pfp.144.2020.07.03.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 03:53:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 3 Jul 2020 19:53:02 +0900
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200703105302.GC182102@jagdpanzerIV.localdomain>
References: <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702054033.GC3450@jagdpanzerIV.localdomain>
 <20200702082008.GE3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702082008.GE3703480@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/02 11:20), Andy Shevchenko wrote:
> 
> I didn't look into this deeply, but my understanding that this is something for
> special case when you have several UART ports sharing the IRQ (multi-port card)
> and IRQ even maybe undesirable b/c it will confuse real IRQ handler. I don't
> remember details, but AFAIR IRQ handler does a busyloop to service as much as
> possible and in between it may release the lock (again, multi-port UART cards),
> that's why we better avoid IRQ event in the first place.
> But it's my pure speculation.

Hmm. Would different IRQ handlers use different UART port structures? ->irq
might be the only thing they share. Even if they use the same port, we
keep IRQs disabled on local CPU, and UART port locked. To unlock the UART
port during IRQ, the handler (on another CPU) first needs to acquire the
port->lock, which is locked by serial8250_do_startup().

	-ss
