Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D882078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LX9f2FDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGJUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:48:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7CAC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:48:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k5so2712704plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FumEoV8e5N9kqFLqhqQhuIzaAQuhZkshnLb7x6jq7DA=;
        b=LX9f2FDpoxDy98TWHQ6HnyjBlxL0kuIHShuw4m7uIhtAFv3ReAGO7qiSFIM/vVxuos
         zJZ/s7/D3Y7MyPty+QmjhHqcDJ0LvC6laLWYcQ0I/qkaIYYx0hsDOqSJtFi+i1DBWmIC
         L5TY9HZveJGjmnz9rR/JWgX9f9NQhCPjqKuWZV/OYO8IrO3UrtgEijAMjxDvtUW8ZX3J
         OzqST9xp6xdpCKuszOqsUHbvHebn7ZGXNdTRBVH5mnxdXu6uiuih+XRtDxxGFJZveTum
         MsDA6e3bo/kyposjDrAPLP3t4mfYQ5z2/UFiEker7aNAOd92QkTtdYDc+0HZeB6G4oza
         qGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FumEoV8e5N9kqFLqhqQhuIzaAQuhZkshnLb7x6jq7DA=;
        b=CMcvpqi/vKExWsdypCAIeGn7lS8Iv1mK3wQqfkU82qiwfEVgPkQTpUp2mfxf4DWrjc
         9Obv/k7JqGXsHARo8om3DFajV4DwU+EZIjxFeTuELgnTF/ZXaF+BhdMB3P7OOBqHFMId
         cRscah9vRKX0vN7dxYoAtJ1pATChOf3WbCcdQzoTgNnX5xhW2vYLydNYXAnzXgrOLYGC
         32jNMCbKWoaBR55HUmH31KMIx6LogrZmTRvRALYd0em4CaAFNvUKvD4ICjA/I7x/qsoR
         OcM0a8y1IPhxHpUoFBCEsxFKk3UDirpEDOMrGN6ldWYbMS3JzhZhj7Gwgn2CaTSbwNdi
         9piw==
X-Gm-Message-State: AOAM533w4UWJa/Ant+7k6NJHBi7/IuUPd62g+TSTRoQebueIAxrCE90Y
        vKpbCQqCYyJX+W3KkgAZY3fy/lmG84WurKFajXEebTjXGhs=
X-Google-Smtp-Source: ABdhPJzuEK1wSL1JctoSTszHagXjlkrLDRHZjevcnPycfweJWKeUxwrH9A+sKJArjq/ZyPlq7jcaRAejd79t7cbK2tI=
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr18687695plb.21.1594414099779;
 Fri, 10 Jul 2020 13:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx9iLH8fBEA0a9=iPsObzaePg9Zj0A9T_7NSKH6KSq3vFg@mail.gmail.com>
 <CAJZ5v0iONFBX00NqzUaZ9kNWr6yLBNtLnA+sF-Ge-QNtY9qSug@mail.gmail.com>
 <CAGETcx-YqJDnc6fNu5dncc=DSHwS_=-uOMHvR8V=b-QQJ7HOcA@mail.gmail.com>
 <CAJZ5v0ju58LxvRckv2T=H0D=aDooGUoGfqFze5zWQ1ARAAJcag@mail.gmail.com>
 <CAGETcx8KknvzZxfW4o=siswB__c9yeh=1wOVyvtM2112WEBizQ@mail.gmail.com>
 <CAMuHMdXbzXnWQSaQ44p-cL9TA=ng20UB=vjscRDjpf7N=S4fjg@mail.gmail.com>
 <CAJZ5v0joi2YDgAPrPhT8SMXTu-Va7s9DXVs7YDYf87JY_ntONQ@mail.gmail.com>
 <20200630153850.GE1785141@kroah.com> <CAJZ5v0jQYK8LHaaJ4-GeJpzGdGY2Csmp_jmHfgc7BOaXyfsZCg@mail.gmail.com>
 <CAGETcx9xCvjZiht4Z_pnFVdaYp9vLPybwZTKNZ9wHGRRCi6VuA@mail.gmail.com> <20200710132138.GA1866890@kroah.com>
In-Reply-To: <20200710132138.GA1866890@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Jul 2020 13:47:43 -0700
Message-ID: <CAGETcx9LXbsUOQ2TL+=qcQV5Wp0qVL3OG8VwXoA4tUgXNKMoYw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 6:21 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 10:11:01AM -0700, Saravana Kannan wrote:
> > I already have a patch to avoid deferred probe during batch fwnode
> > parsing. I'm trying to do a few more tests before I send it out. So,
> > it'd be nice if we don't revert it right now and give me some time to
> > finish testing.
>
> So this series is no longer needed given your other series that I just
> took?

This series is no longer needed to fix the issue with fw_devlink
optimization that Geert was seeing. The other series you pulled in
takes care of Geert's issue.

But deferred probe can still break suspend/resume ordering (example
mentioned in the commit text). So I think we should fix that (version
X of this patch).

Rafael was concerned about some of the extra work v1 will cause for
cases that work fine today. So, we need to find a compromise where we
can fix the issue and optimize the fix as much as possible.

One optimization we can do is to call device_pm_move_to_tail(dev) in
really_probe() only after deferred probe is triggered (as in the
thread gets to run) for the first time. Until then, really_probe()
wouldn't have to call device_pm_move_to_tail(dev);

-Saravana
