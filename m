Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA88C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5820420679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnDI3JHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFPV0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFPV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:26:13 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09378C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:26:13 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y123so147530vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6rG31+4EgXZsrVZK4JBwqCdiwjfn5xnPZxnLvzKcko=;
        b=ZnDI3JHDcHtpLbnjY7yqQ2eezrsV9iupGf/ooiB9LX4/oKjvZSW7PbhkJkq/pjcE6Q
         foLa5UQgYFIRRka6Tw8nSXEg4aW2HnilWL/EzKuTobdw8O+Q4GkuT6zs0WqlV9kCJc4d
         dfRWBEadYm7s+JcD69v1Yc7+z8pAN9GkgZlRvuLed/HcfXhn9nlx7oCGxOjptcdJKs7D
         Y8nxKXNWAluv40VDOZevkNMJUzaYJ4B0Al8pjHaEx8zxvL4dPil1Ue2XxFXrC3+BfusR
         XewQnB1qYgIPUPqibTcNb6tseXd6NV+KAAgZLlOXuFL/G9qVxHVPZp6LIKs+kOjHVXNA
         E5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6rG31+4EgXZsrVZK4JBwqCdiwjfn5xnPZxnLvzKcko=;
        b=Q+ZRCyXz1XgNrIPMRFzCmxmoo8hBuDaOvfZnfv5IRlRWEud6mXGsDsnAdjFZVjlx/E
         8O4zPMttDnNK9ZzYocueNhX+xIQpJxgaKN66CRD2wGULlOJeUESWB0L4rmLUockQUHdt
         w6Np7A+TleF+QBSdfmtY4HfjqUjg9hKyBhZSIyVTWzyAP3I0Kakxjhk29nLlpdMARYQr
         cLNpCwjlU1N/EQ8niv9Pc0fA776DvPxQX6GFOhQ9XkYISRmGzgCbysHpLVW7clZDDF5/
         rFPFEmd1hTymNXifr5CIcqMLhd5ODpNwXuXY/0P1Fi0Fd5Knwx/ToC+Ah6LqhJc6sNQB
         3Kcw==
X-Gm-Message-State: AOAM530IuX9ahallEsmLWbEIlsmN6in9ZgZIDwBsC22+Wu6UShOkkLJ4
        DbgQuX896WOfsNb3H6+qmKJfbSMgnUgitVRnh1k=
X-Google-Smtp-Source: ABdhPJyTNMnwRdTM+dc/qparcISArQHFYK7MCoeBRjALTL75CeVZGbyq8JL3KYEsQmhZ66mdaSXjgfl6uVMSNRiXQ90=
X-Received: by 2002:a67:5cc1:: with SMTP id q184mr3468872vsb.78.1592342772250;
 Tue, 16 Jun 2020 14:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-21-jim.cromie@gmail.com> <20200616134507.GO31238@alley>
 <CAJfuBxxvejGJtyQfcPmG7i6p6NAESjTuBPHeGDUwTVkg9_JfzQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxvejGJtyQfcPmG7i6p6NAESjTuBPHeGDUwTVkg9_JfzQ@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Tue, 16 Jun 2020 15:25:46 -0600
Message-ID: <CAJfuBxxrX6f2qRUk6xUsHVC9+zDnpE6CJ3SU3aXVFfKP4=XQoQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
To:     Petr Mladek <pmladek@suse.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Or that meaning could be handled by merely issuing the fill-in activations.
> In the module that wants debug levels
>
>   echo module foo mflags 4 >control
> auto generates same query 3 more times, with mflags 3 flags 2 mflags:1
>

let me also note that just because a module might do the
descending loop N..1 to implement debug levels,
doesnt mean you cant then override manually using echo >control
to say disable N=3 but keep 4,5,
except 4,5 in file x

youre in >control ;-)


>
>
> >
> > Best Regards,
> > Petr
