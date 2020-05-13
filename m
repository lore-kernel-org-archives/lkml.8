Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB6C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1904820675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFpn58/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgEMFRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgEMFRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:17:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899C7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:17:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z80so10652823qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=kuNAvbqiOq9VWIGuyjkC9WGSpZO1oJmYNzCCBwUSpwk=;
        b=gFpn58/zD4GPNaUUWwT8ECKmCRTGvN+48akn7IqlEJsbO9P9acoKe60CZdlE5BOJSH
         UPFkmNqajJwfcr94aXrzanMfeQiaCRf67Cn/jAWhsviyRsPMQmRQ4Se1NYDsYldwCNdx
         SRtDNGrCWzQgX2EMPinCEG7uPhzJ7lnSOJqiuZxn5xdfU8mjAmcxLYYIvcBTnQewvmJr
         H8jBV7OTYFpJD0UZnKp00al4aM+NXxzdT64XbPQR5VxKUIehikETK325PNgvFyG3hgIt
         yD16uh1Ic23W9w/6uQ0C6LMQyQsZAP+7juubWkATRhDe06tGbuXT9aFo+91o4eKlX5y9
         BrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=kuNAvbqiOq9VWIGuyjkC9WGSpZO1oJmYNzCCBwUSpwk=;
        b=sA1xbZaPrcmWRy0W60O+9rzjWr9ogG3R5q8e/3hbfwBGNsKN+pdpUeHgtr7f6eop/r
         luKdXVGzj94szJwOq0PdLRLudoKJdj+inNUtwsXd5ZTv4WU0/a9MSOjuZ12F2hbELS8O
         P5vMQRykSuoMQf4adgXP3BdsE3bd+Amn/9zAnOVGtwGf6qBd/9n/nRyva+HuL9mQ7HWU
         4EYvbjtp77kxQh218enZd3nYVA6jclV6ivWMLWNYQGtC0DnQE1MfZ3czzEURkyPC/Mmx
         faxQB02nK4S38ezOBnaYRLZwtUWKXLw4XS0793EG8M9Pv9RCEWmkQwXd3eA+/u8N4rr7
         DEfQ==
X-Gm-Message-State: AGi0Pubzjg0yHsmqH537YDY1xfGruzXLW5fLIR9hiSqybGSafNHd4DdN
        i7xxxc6y0DSSRBRSPcvBt44=
X-Google-Smtp-Source: APiQypKDv7ceqF305L4FOrbWAafwKOMG/xyyQf0plZG6F6kRUgAbBfuOsLBF2qrXfqiCQbobXqsLKQ==
X-Received: by 2002:a37:6506:: with SMTP id z6mr24966820qkb.246.1589347031619;
        Tue, 12 May 2020 22:17:11 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id 10sm15859166qtp.4.2020.05.12.22.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:17:10 -0700 (PDT)
Message-ID: <fdf3ad3282febe0451cb52c960d954988e87d531.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/crash: Use NMI context for printk when
 starting to crash
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 13 May 2020 02:16:58 -0300
In-Reply-To: <1589344247.2akwhmzwhg.astroid@bobo.none>
References: <20200512214533.93878-1-leobras.c@gmail.com>
         <1589344247.2akwhmzwhg.astroid@bobo.none>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick, thanks for your feedback.
Comments inline:

On Wed, 2020-05-13 at 14:36 +1000, Nicholas Piggin wrote:
> Excerpts from Leonardo Bras's message of May 13, 2020 7:45 am:
> > Currently, if printk lock (logbuf_lock) is held by other thread during
> > crash, there is a chance of deadlocking the crash on next printk, and
> > blocking a possibly desired kdump.
> > 
> > At the start of default_machine_crash_shutdown, make printk enter
> > NMI context, as it will use per-cpu buffers to store the message,
> > and avoid locking logbuf_lock.
> 
> printk_nmi_enter is used in one other place outside nmi_enter.
> 
> Is there a different/better way to handle this? What do other 
> architectures do?

To be honest, I was unaware of nmi_enter() and I have yet to study what
other architectures do here.

> Other subsystems get put into an nmi-mode when we call nmi_enter
> (lockdep, ftrace, rcu etc). It seems like those would be useful for 
> similar reasons, so at least explaining why that is not used in a 
> comment would be good.

My reasoning for using printk_nmi_enter() here was only to keep it from
using printk regular buffer (and locking logbuf_lock) at this point of
the crash.

I have yet to see how nmi_enter() extra functions would happen to
interfere with the crash at this point. 

(In a quick look at x86, (native_machine_crash_shutdown) I could not
see it using any printk, so it may not be necessary).

> Aside from that, I welcome any effort to make our crashes more reliable
> so thanks for working on this stuff.
> 
> Thanks,
> Nick

Thank you, it means a lot.

Leonardo Bras

