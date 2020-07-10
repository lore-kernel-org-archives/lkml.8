Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB7FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0DD2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="IhVmn6R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgGJVMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:12:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71867C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:12:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so7461145wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDU8fng2u/ptUYYN0OIalaQDIlRQ0CTBvjvqWdkkHMk=;
        b=IhVmn6R4tsUfkKh5I/ciZ/rBQ8BsnoOVHYitAACUrBI96Gx5knzzbDJxd1g8amSNc1
         h9NfSTz9p4iFMllLRKvvgIBucijejW6s+LUcmt7ZbsHKNINLfAQhhmh1f80wtJ/31ZIL
         OBaw7HIjiBAK+SqgzXOECZj7SIbMC7eTvAcZx3O/DF3HMPS2sIPK+FXnGBYt+JQeMiuz
         tacnne67e4StiLJQ0nh2JzxX3hC9xEIdAe+U4gnmooNA21ND0tIeBNFaercXcxxrbJ49
         ByG6nTNPDRsZtM57GJLwiezngo4vT+tdYc5SATOmz5BLMvQiAm2VJwURTN4bRjysI6i9
         5XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDU8fng2u/ptUYYN0OIalaQDIlRQ0CTBvjvqWdkkHMk=;
        b=P+xs9jMeh8cH9Zs87nvt9xp2zJVYHaBEUq6oGEN3YF3ARRaTo5EgbBpbKiK1n7vQX2
         UlrdEBBFy+dRHRQ0O05r/mSMSs6Rby4klMNX9gS04ra2WwOHcYYaxqedr8hogTDSQjZy
         AwuIINCm82/ShuQb3xyY+3HvcCqE4Dx43HI5w7JAQHjnW3nT3BT/72BokHQaZ+wayDIu
         LmXssJZHpukxOV26mg0tS+N3zUnWXx1COa0B6COYKVONfCAZCm/uGbM20imghEf+HM9Y
         bDhfQeOiNy1MNtdWRaYTHDvPRFJJMdMLU79V6uzkElk0QpL/vKrPztMTapycBnkmvNF9
         CjdA==
X-Gm-Message-State: AOAM530FBWY50nk6bdvE1NIyhDWFi5Bb7sUeU6OPSD75QSDd14PWhNGa
        zX9qf1qRvSO/2/zsfi57mONqSn5qjGqgrg9+jrEUVZu48+w=
X-Google-Smtp-Source: ABdhPJw0YGnnoDBY2TL0MP5/In74DMvl0tW5Rc0TZ5jcVzPWcrZ/lgxBz9FeD1GSxb4qE+8Xci1yeE8ZPWNpKsDhnKc=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr6698254wml.36.1594415543141;
 Fri, 10 Jul 2020 14:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 10 Jul 2020 14:12:11 -0700
Message-ID: <CALCETrVufhJTh3LweQqqH1OHc2rTsGkMcmTzCq6kKh1ETY0arw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 11:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.

Acked-by: Andy Lutomirski <luto@kernel.org>
