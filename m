Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54195C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF020842
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKbJOhe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgFKOJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgFKOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:09:35 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A99C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:09:34 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id r9so2146093ual.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTyfOyKAP1NkHULoUQ9fRplZcl3aA+X4eH3AIaEch8A=;
        b=EKbJOhe1HXzQJwIuQfIgSQTJ4dBb/OkYsIF0hnEc7gazeGteERQELU0r+OQ0QEDDcC
         tVuUKM7brG4GlAWR5Ns14RorVLBFKGHY/Z0VVBhhMW7QGrEGjGLXJrLG9XNlAnM9Z8TS
         7Mwc0G0RLYF+kX/6UWBGc8Xk6htwwZXj90K7QBL2cGXquX1wUBFVN6rIg9W+jvGax0h4
         hjjOvsNbeDxgTAuH88v8nswoCSfJ9Zl04DYj1m8nyXtPj0N+Net/7Q++wFuEgA+/Ijfz
         szWCDkcRP7kXWsaFN1xcyQerIvkmZ43Su3N6ThQYO8g+90kz3VXVgTkgCBDQurwR8Fye
         nQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTyfOyKAP1NkHULoUQ9fRplZcl3aA+X4eH3AIaEch8A=;
        b=rAJySeFMArxXQOHb47gI952u1v2UPF8o9gmKRou6/iBoPOxP2ibbHN3zLYSSHut8nu
         YWHteqlfwMdIBBWWloo7kcZ4efYpNQU1mtByqEKlGKnS1fJW6nF7g7VlFWZa3bDhlXo0
         er6SmAd0iv617wA9AjBaatgzxujof1jc3k9P8x8jWy9+QYpSic5euvJBt7ql9mAiLl6P
         Z2kxD/Om++3mxFkGIE7Jwd3/uS0rKl+ALYHdXagLYyejf12ICumAoCGPsz0gBPLpxwoD
         OnpcRyO2thjTGZjRbuYcKTNOwkr/+mqHZtxS6rFzPRC2xgi0C8cT+QFQWvV0TYZWlpmG
         QVzw==
X-Gm-Message-State: AOAM532otXXS8i/VHgz0fS8KfcaO2ceUijhS7leE1NWeAhuF7hR91EVf
        poQfg/WARRRBKbaK+YYDET98kATj7C9aKey/I90=
X-Google-Smtp-Source: ABdhPJw+aJ8ZsrudzdEEF8a/SZQDp7bLWsJkCwvZ+EKqzSQbhngbiqbpp+6BX2JcsBOAaxHWlmngCSZLbyvkyzR+moo=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr6655940uae.121.1591884573191;
 Thu, 11 Jun 2020 07:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
 <20200609104604.1594-7-stanimir.varbanov@linaro.org> <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
 <548d30a8-0a5a-4ada-5564-b61f88863afc@rasmusvillemoes.dk>
In-Reply-To: <548d30a8-0a5a-4ada-5564-b61f88863afc@rasmusvillemoes.dk>
From:   jim.cromie@gmail.com
Date:   Thu, 11 Jun 2020 08:09:06 -0600
Message-ID: <CAJfuBxz1=GJQAf+kNZPLZAKLXeTUd6JeRXRRtA4zc6BLo5H5Og@mail.gmail.com>
Subject: Re: WIP generic module->debug_flags and dynamic_debug
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > can anyone diagnose my problem ?
>
> Sorry, I have not the faintest idea of what you're trying to achieve.
> Can you spell that out?
>
> Rasmus

hey, sorry for the lack of context.
Ive solved my problem, by adding (void*) to my container_of usage.
WIP code now "works", but still incomplete.
will reroll and resubmit
