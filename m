Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED93C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F101208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYI7yYC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgCXUPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:15:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42395 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCXUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:15:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id s18so8811843otr.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJIzOnVu3DQLx4vRFPDx9xqnP0o3EH/y5eNpNcG8TTo=;
        b=YYI7yYC0i61wlhTirMbQTbOC4uNj7eBadi2+eGf1L2zQHULuOWxmYMOW/0dfgnoTSa
         HJsuQPABBhNxWVInT6GhnHOcSoSuiRQ932NLNkkvYUZXgufD43oep3B47aQlz8l2M7XB
         sg3NFhKFOuF6LBSQ5i90p+R/NSklBv3Fnh0UsEISMG64L9OmWY9bmXbp2360PQHUKMQf
         PTIhhqv1ZABSOD6kaGaNMdmFosULThqIfROObf1DcL55uGIUICtlZYdtoSgmp9ulzWWN
         P+wE4ugZTgklHDuNRVlAhPzn6f0GBEeaEkunDU3FbH54V/t5YnVX6oQosFs0WzhHY7Id
         lwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJIzOnVu3DQLx4vRFPDx9xqnP0o3EH/y5eNpNcG8TTo=;
        b=pxQGU9Z1PXxlJuGlXJtMGfbDeXPqot1x+w4l3XxkiTshMMI7OX0RUcU6thTWJTAt1z
         VpAbfEAMM79T+OVjdrnsA6ozwlV2gRtwmARMsdodGEz85u7EQ/kyk2noM38++f8FHRRh
         QY3g1+Wn97HwMmqwWHZauJRM9i7Q5537pzoer0RDLTkg2zY3DlCI8FhqUFWmv5css1U3
         fiY6kei16w0UAw9hX8NPneaZ7/lNK6SMzq5iErTlRFaje7Id/OnXh2bbujuK/FKJlQ3q
         I/U4YJziJqVqDFN6v+LfyUAF/Qisu5+s5g7ju3ArEYsSmjzIROOh9H9Hz/AsskcWRtxS
         JX9Q==
X-Gm-Message-State: ANhLgQ0B3Y1bxkS9TvhyQBw22xU9MBV6YRbkSuZW/odGMDyqjQsOV3Xk
        Wn2w1N7n/35s1g3zJ1MWcuXWDiXkKMDTYDO1uzC49g==
X-Google-Smtp-Source: ADFU+vsmuFr22wZQLIMsh77Al2FrSJEgldSYiuQWvJCbf09Y9zkfWkAGun7fw0GUBHpTCz73vmnEqu2/9zFVg/xO2Qg=
X-Received: by 2002:a9d:5ad:: with SMTP id 42mr24587182otd.231.1585080934065;
 Tue, 24 Mar 2020 13:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200221080510.197337-1-saravanak@google.com> <20200221080510.197337-4-saravanak@google.com>
 <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
In-Reply-To: <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Mar 2020 13:14:57 -0700
Message-ID: <CAGETcx9Ab8ygQhsrQPhYjymvmNdQYxYzczrXJdLeTPiSYh5VEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] driver core: Skip unnecessary work when device
 doesn't have sync_state()
To:     Davide Caratti <dcaratti@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Benes <vbenes@redhat.com>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:03 PM Davide Caratti <dcaratti@redhat.com> wrote:
>
> On Fri, 2020-02-21 at 00:05 -0800, Saravana Kannan wrote:
> > A bunch of busy work is done for devices that don't have sync_state()
> > support. Stop doing the busy work.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
>
> hello Greg,
>
> this patch and patch 2/3 of the same series proved to fix systematic
> crashes (NULL pointer dereference in device_links_flush_sync_list() while
> loading mac80211_hwsim.ko, see [1]) on Fedora 31, that are triggered by
> NetworkManager-ci [2]. May I ask to queue these two patches for the next
> 5.5 stable?
>
> thank you in advance (and thanks to Vladimir for reporting)!

This was reported internally on some backports I did of 1/3. But I
forgot 1/3 was cherry-picked onto stable releases too. Otherwise, I'd
have reported this upstream too.

Thanks for reporting this and sorry about the breakage. 2/3 and 3/3
weren't meant to be fixes for 1/3, but they just happened to fix 1/3.
Problems of testing a series I suppose.

Thanks,
Saravana
