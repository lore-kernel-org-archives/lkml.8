Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFCFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02162065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHerMhrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgEZSIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgEZSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:08:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB04C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:08:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so17136419ote.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOePJEqzOpldNpBCP7tiQal13VtjOaSKu8Mf0AiyKEI=;
        b=LHerMhrRjDvYSPQcdFKJwGDWO70nXCx2w6vo4xJFPsObj1NbvulOFG+pHyD9nelhm+
         oFhF5Kc1UQ0qk6XEEY9UviM6dksasQ7oeWtIGzXqwTd/m6CIelrPhzxK75SH/FYEzp10
         UNLNtypTCz+DotDxXL4ej6Z6N3tjkwfKcV5JLDaOqWoRIVvr5x9Vu3iMjP+8WXuJoLEb
         +7dhYyiLkAebECLI/eQSvFX1zljc/KNYsd9Rpql7ilm5FM7jGUOnDZfw9ZW3oIVCsa/n
         DwqyfAo4ygntvZiXRLWBnDBAFyJsrX9GJPtm9t2fPTEpORoXe8ZfWfDnFUdL+vddh6Wz
         fOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOePJEqzOpldNpBCP7tiQal13VtjOaSKu8Mf0AiyKEI=;
        b=LF3UdXfdlOMXNroi6S9pgjVxEHhupbLaH2JAkyPBHD+AUD09iWCZHdkdlrWhsQeYSc
         +o/4WWm252sHfOAEROY9M8sLTl1uBkchGrq+UTKZrn4U1z2q7DOmXl1gmjnvYbJu8o/a
         /YT86kTN18VuxMTvUsur+j3iUKbUM1IB8jDO2Xn0XxlgcYAOVRNIJMmw5a9tNpRdNTXn
         5PYrMh33KDsnx7oVd3WzJ2XmjIT5qz4ixiFPEg0W7QcAfYDWkoiMSB0dviHwajsevGug
         jzu6WzTFVqANftign+lylgyOGB2N1xIHekr7twFzu57ayIW4tnwz9FQVYdPDHweUmsbq
         97mQ==
X-Gm-Message-State: AOAM533sGs7ONBB7F1vH5yoHwNZflD7bWZwOa05QiHPAfX/DM2b7Wq0e
        VCC7YvLEH0m9qJZlBQvGyDhQm3y2kKfl6GG1rpM2kg==
X-Google-Smtp-Source: ABdhPJxcmaAVdh0ujGCGKr1HPyMWjwhEp+FeToSzOp+e8yyxq5YqQRrbEqpSGpnZ5yZPxLPF+Bdrvd+HbqtPIbUOGUk=
X-Received: by 2002:a9d:66d5:: with SMTP id t21mr1907974otm.231.1590516528738;
 Tue, 26 May 2020 11:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc> <20200526070518.107333-1-saravanak@google.com>
 <CAGETcx-b4+a8U=Qd0mKaB9JUBaj178694QshqZVrAa_x6AgcAg@mail.gmail.com> <dac3da8b373f131e53e18083f6fac5b0@walle.cc>
In-Reply-To: <dac3da8b373f131e53e18083f6fac5b0@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 26 May 2020 11:08:12 -0700
Message-ID: <CAGETcx_iHs5xsXq81k4YRzrFxs2j01u3HzfnSNU9Vxs8ZTGGuA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 4:04 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Saravana,
>
> Am 2020-05-26 09:07, schrieb Saravana Kannan:
> >> Greg,
> >>
> >> I think this is the issue Michael ran into. I'd like him to test the
> >> fix
> >> before it's pulled in.
> >>
> >> Michael,
> >>
> >> If you can test this on the branch you saw the issue in and give a
> >> Tested-by if it works, that'd be great.
>
> Unfortunately, now I'm triggering another WARN_ON() in
> device_links_driver_bound():
>    WARN_ON(link->status != DL_STATE_DORMANT);
>
> I've attached two bootlog one based on linux-next-20200525 with this
> patch applied and another one where your previous debug printfs are
> applied, too.
>
> Let me know, if you need any other debug outputs.

Can you make the same debug changes I did for the other WARN and get
me the logs?

Thanks,
Saravana
