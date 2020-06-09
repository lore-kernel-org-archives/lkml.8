Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E25E20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNlpBp6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgFIRI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgFIRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:08:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5FC05BD1E;
        Tue,  9 Jun 2020 10:08:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k8so16970584edq.4;
        Tue, 09 Jun 2020 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4p5Irg6Dzn2qLwF5HDdUraLZe46R8G3poyQBaNHtlzs=;
        b=kNlpBp6u6KVQEvJ4vmJM0+s8WDGqNnE4bKe6zBVx6HH31p4KJOpHoIspUOe4UlWv/q
         Md1608OMu1hHqQ6MV0jgH6BttxuQ7f75/wW2oZAPWr41bB0SotscqivF0NFngZ3HyPp3
         f55S0Q5aHP9WiWMFPW+8P/CgLC5S1OkOSX13ZjhAr0ztKHuWFnkVozDpFWHsBtQLO42T
         qwjkZVJ1iJXFdgkP0tNy1gaKle7IVaY8ADUM8tAgPycpRf0o2+jj5JTTBq+SN2TjI6SX
         TZacSnO7breOdu/e1yPCbSiF74Ywdi8kie1YA4r4zKQ/KWWJjww9xzBw0UcajZ1ph2C8
         RV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4p5Irg6Dzn2qLwF5HDdUraLZe46R8G3poyQBaNHtlzs=;
        b=To63hQ80lFuo2I0la1d9JHs8UUg7kUypMrtJRWihwyMjTZWuVtZGj2mwhscXdTN5Ot
         JVn3OvFYR64wlR0GouYsMK/B2GB4s5FHIMA8T2PH/z+NgWQRpvxGkl/ZKQzwIOLLz30B
         bWjZt3y7zgwjQeDSvugrr9JDIey5Z9nP2U9dE6ygwZcWs6DZ7CgXrX4pgMtBVy9/2bVR
         RWjeurw+A4Xc5HaOd4GH5j+P26J2OTMmWj2eC1YMt6ImuKxNhXJSQLOKtB1sIdXeW3Wf
         eTx/eati3yIbVzv9nJ7MGMabYpekUa9VZs/7pGZ1bjhvHHdcrhbppI5QAl/wRSLSby7G
         e7Bg==
X-Gm-Message-State: AOAM530V2SDe7dY4tQvxjHLQDIBxNc7p93JGldf5EmXaiJJca2x3wjb8
        e277kiMdFyHKYEGptkWzkOWyjL4yNCO7YgOClkYdvg==
X-Google-Smtp-Source: ABdhPJxIQpWRQjLFGlHZE6AbU18+SSFFpS2P6+r3lJPt3pUdjEciqDF05PyFD/cJ4DYgDVbiZ4EKc1Lw3JNlF4MA15E=
X-Received: by 2002:a05:6402:1ca2:: with SMTP id cz2mr26766668edb.15.1591722534934;
 Tue, 09 Jun 2020 10:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
 <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Tue, 9 Jun 2020 14:08:43 -0300
Message-ID: <CAB9dFdv_a_EoWOAaULD3fJpmpZdUbquKAFV7=LaZ1udAuDkFEA@mail.gmail.com>
Subject: Re: [PATCH 4/6] afs: Fix debugging statements with %px to be %p
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 1:13 PM David Howells <dhowells@redhat.com> wrote:
>
> Fix a couple of %px to be %x in debugging statements.
>

Nothing critical, but as in the patch subject this should be "%px to
be %p", not %x.

Marc
