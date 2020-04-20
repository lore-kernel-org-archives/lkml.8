Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF4EC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B4420775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTfjRiH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgDTQDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:03:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:03:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so5141669pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wdUyQ2R+xAzme4zTBxGVpmcGXSkai/iqAkUXoFX9w3s=;
        b=jTfjRiH6h79dw6Vf3fXViAYxpCrKVFvSi+LZhi4eo5d5FiorCqIwFB7p6DeCxH5xFZ
         YkJQ5uINYfcnZNrZqkZTkBb9aE1rLg/hcBrCG9XUr+Lfvw8CylmSiYDh7qW4kgtM1S+N
         3zldiGWuMivdvzcnyRA4I+r3ETVgEzcT7m8ykPjgSRYSSB5rzf1oq6Dp8S4XXbdr0NrE
         ETH0DH08ZzD8HUC/18rehJsqaCXplbY2zDAK6gUSSpNWm1duSYeklwepMeohvGCWHZKY
         ttrcy+eFfOEA4M1np0QitC2Efdc4lUl6z+V9anSiwaohSAh4ivAGc5tzOSy925CIyKT3
         Mvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wdUyQ2R+xAzme4zTBxGVpmcGXSkai/iqAkUXoFX9w3s=;
        b=hoMKgkxVCkmNJXvNBgU13X7fzzq9L0KJ7XTNr1g1eBl6W66VuE6nrw4q2s/HOD08kR
         tgJZzOgESMTm7Cbbb18VHTebv21tsWYE0PfFJ/2HAq+BZjwZC9RKcl4oR8dVnFpDeSCZ
         GbZycGDDXbXhVEQZ7blcgwyT6gknHsR6vG+OxHYl3hN6pwS+fLYQfzlJFR3n4TQPmuF6
         GjDXplYMszCAH8MEJZotL0b4oddHiBCQ19h3QxrVS00cHWJEZVYoqzTcoYe2eHHnVGML
         PkDbnYhfqYICMxMz+ZEpmeAIXyNj/JwcrXTIydhIdooeKNGRo7S98S72Q+T873GeScNy
         6wPw==
X-Gm-Message-State: AGi0PuZtGpLi0zPbPitA8RWb9TxpAjEyM5W5C9CxtnZLyv0fyZNepGd2
        fWdCpT9Kf5515y+mRRiP7rhbnhTxeeI=
X-Google-Smtp-Source: APiQypJ5iNL4218OdaaCTDZNjzbrKX4jLb4CSIfOcuvWsr3+g1DHAcODY91RRrVBpVw/SwHZjMvgLA==
X-Received: by 2002:a63:7d19:: with SMTP id y25mr16642339pgc.78.1587398617573;
        Mon, 20 Apr 2020 09:03:37 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id d36sm1466311pgb.93.2020.04.20.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:03:36 -0700 (PDT)
Date:   Mon, 20 Apr 2020 09:03:34 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] vdso/datapage: use correct clock mode name in comment
Message-ID: <20200420160334.GA925174@gmail.com>
References: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:06:15PM +0200, Christian Brauner wrote:
> While the explanation for time namespace <-> vdso interactions is very
> helpful it uses the wrong name in the comment when describing the clock
> mode making grepping a bit annoying.
> 
> This seems like an accidental oversight when moving from VCLOCK_TIMENS
> to VDSO_CLOCKMODE_TIMENS. It seems that
> 660fd04f9317 ("lib/vdso: Prepare for time namespace support") misspelled
> VCLOCK_TIMENS as VLOCK_TIMENS which explains why it got missed when
> VCLOCK_TIMENS became VDSO_CLOCKMODE_TIMENS in
> 2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes").
> 
> Update the commit to use VDSO_CLOCKMODE_TIMENS.
> 
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Fixes: 660fd04f9317 ("lib/vdso: Prepare for time namespace support")
> Fixes: 2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes")
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei
