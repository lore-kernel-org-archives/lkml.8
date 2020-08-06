Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E920C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE372224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bIRXS68h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHFUKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHFUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:10:35 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 13:10:35 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g11so2584538ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3vwUVs19vIEjWfyfpOeOe4lGyH2nlye5ZP+rs9rBEc=;
        b=bIRXS68h6i679hB3/SfWEVWF6Df4eW/+UznxGvkKqe4XMHBmUl76cokIPxFPlBfpL5
         uSnk7z6y7Hb7lzN/4lOzGuqSBhCfp2fuTxjQBK5h1m513Asz3f0qzg7z2kXQqqX/IR0+
         vDfgFTBwRSfoXvGQcLIk71MNV91B4wRASLnMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3vwUVs19vIEjWfyfpOeOe4lGyH2nlye5ZP+rs9rBEc=;
        b=LSPx9UG2NUQfyLE+pSa5Ifucw86gAcsDK++rxzBjwUMFxDK2WAo1J3K09cs5+dcUSV
         ui4sE6B2tO6t7Iq92/lbnkWzRUXIGYidOfTp5JpXVRhDrUgV6nvVmNW/UFB34V9estZ8
         I0QKUP1cL0jDihQB/QJ91L4coqD4nJdr8/0E3eyj69Bv4OJF6PWLOab+H6A38vWneKwm
         amKu9FJxBs/E/G+GM7xVTJwzOrR3vuHCQh43i2NLkN9i9ib9UZPgoYSXAsFZl1cZha4R
         QvoTMmWtPmN0MQBFNHAzl6TIoQfy8s7mJmJw30DfnMprScn/2gB15At1kmd5ucdzwQen
         Jmfg==
X-Gm-Message-State: AOAM530pRGvC4tcJ6iGAGA7dNtFw9L8EzfSbWv2fH+nCZT15D1Gda7Q/
        VM5t66mgu5KtEmSWD97/LCeDCWyiZzc=
X-Google-Smtp-Source: ABdhPJzAWJNHt88LNGvz8O9Wyyn8o1Szc8TllkdOEpYf6HkRLBPiYgpeHZmm0Ggfm1AYnT1sNQn08A==
X-Received: by 2002:ab0:283:: with SMTP id 3mr8271926uah.18.1596744634251;
        Thu, 06 Aug 2020 13:10:34 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id l84sm1244907vkl.36.2020.08.06.13.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 13:10:33 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id e20so7790013uav.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 13:10:33 -0700 (PDT)
X-Received: by 2002:ab0:22c9:: with SMTP id z9mr7910964uam.0.1596744633145;
 Thu, 06 Aug 2020 13:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200720152803.732195882@linuxfoundation.org> <20200720152806.931980695@linuxfoundation.org>
 <20200722120930.GB25691@duo.ucw.cz>
In-Reply-To: <20200722120930.GB25691@duo.ucw.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Aug 2020 13:10:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V53j6h-RAA9xpoj2BBUVOJa=3hH85rnm=0Mh7WnQHMog@mail.gmail.com>
Message-ID: <CAD=FV=V53j6h-RAA9xpoj2BBUVOJa=3hH85rnm=0Mh7WnQHMog@mail.gmail.com>
Subject: Re: [PATCH 4.19 066/133] regmap: debugfs: Dont sleep while atomic for
 fast_io regmaps
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 22, 2020 at 5:09 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Douglas Anderson <dianders@chromium.org>
> >
> > [ Upstream commit 299632e54b2e692d2830af84be51172480dc1e26 ]
> >
>
> > +     err = kstrtobool_from_user(user_buf, count, &new_val);
> > +     /* Ignore malforned data like debugfs_write_file_bool() */
>
> > +     err = kstrtobool_from_user(user_buf, count, &new_val);
> > +     /* Ignore malforned data like debugfs_write_file_bool() */
>
> I guess that should be "malformed" in both cases.

Sure.

https://lore.kernel.org/r/20200806130222.1.I832b2b45244c80ba2550a5bbcef80b574e47c57e@changeid


> Plus it would not be bad to share code between those two functions, as
> they are pretty much identical...

I took a quick attempt at it and it seemed slightly worse to me when
they shared code, at least if we wanted to keep the behavior
identical.  For me it was the extra ": syncing cache" part of the
message in one of the two functions that pushed it over the edge.
Specifically if we wanted to keep that we'd have to do one of these:

a) Keep the printing out of the common code, but then the common code
is really small.

b) Add a special parameter to the common code named something like
"do_sync_if_val_becomes_false"

c) Pass some extra string named something like
"append_to_log_message_in_no_case", then do the actual sync outside of
the common code.

That being said, if you want to try to make these two functions use a
common helper and everyone thinks it's better that way then I won't
stand in your way.

-Doug
