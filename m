Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B72C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865792081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579119053;
	bh=65S5eOyLt09Ip2F4rHVAlGMtCApAVFVOvraYSmj4wBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m9R8jXyJGtzgJ8WDoVFpmqOkIZxS+fx/TNWlCiqipUfciAboH46Plwn2QWFrgDHjX
	 vrmiOYq567Q5gFjklVyVv85yUoMyVb8Kbt0LnPhmWZa9yy3jvTqnV0FyeZqkqmEnSa
	 kH1kxkaHRbasR3RmkEtBLy2MAmsBh7UatpjzgxwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgAOUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:10:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43031 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbgAOUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:10:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so19961579ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=OrYEwmU6lkXsGZWCHNNhtVtpsE6fs3wEj0m6dC3WrtWTeidQt6E9H+zSvKowaPh1ec
         ugRczy3F4djq+5tAM9KSePUrrGy8RTZj+3Nsfw0drc5nlDq0wGY+b9DTqALVC2112QUl
         PU4s1hiA953qkOxsAyvqyWsjNb5gpuGJJ8PeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=Qkf/LjCxFOF3WNpUpB/rNOzMz+GCAnCzv9DqNFUcJ2RDsvgBAt2ZK4B5wD7sNoDpRO
         8Q8w/fajPlaaTc6HPPXIc9opUX+LglSqDC8EQiA3YDHf6CzQ1ln6oU9Uq2/pq1tFzkZe
         SAjOPSjkHwdTVKBdv2+CrWnRazKdFq8YxhHPBruAR3O1TsLGYBXiQBJoFBHqrmIHxV3A
         RXC+7jS1wrxUqyd9BUoH6KwWVyX5Ov63B8ekyHdBPD9qSZNB1C7PmRcYM6dUA+rciQDY
         G5ROUSUpY5d/Z8h/x82WRgNM3UU0KxVmLNgyHcCJYP1vIJSfOn4KdPWWKrJTtqU7vw5k
         9ZeQ==
X-Gm-Message-State: APjAAAWYH5kSzHxQ2Qk1TyFXAM0sB4M3o8JIo4j+12UAotVf5ILr9imC
        FdAQX/Tdj3BXtqRiuVjZoUbAbyDVgtQ=
X-Google-Smtp-Source: APXvYqxCS+B2lwaHa/eDveKF7FcqJEJH6s/j8BomVCso5Qjkz7R5opDb4B4LiYE7RybWvOW7qMBEAw==
X-Received: by 2002:a2e:9806:: with SMTP id a6mr86176ljj.178.1579119049962;
        Wed, 15 Jan 2020 12:10:49 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b17sm9371498lfp.15.2020.01.15.12.10.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:10:48 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id z22so20001776ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:10:48 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14mr74215lji.23.1579119048131;
 Wed, 15 Jan 2020 12:10:48 -0800 (PST)
MIME-Version: 1.0
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jan 2020 12:10:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications
 [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I no longer hate the implementation, but I do want to see the
actual user space users come out of the woodwork and try this out for
their use cases.

I'd hate to see a new event queue interface that people then can't
really use due to it not fulfilling their needs, or can't use for some
other reason.

We've had a fair number of kernel interfaces that ended up not being
used all that much, but had one or two minor users and ended up being
nasty long-term maintenance issues.. I don't want this to become yet
another such one.

                 Linus
