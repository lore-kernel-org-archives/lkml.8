Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5054C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA20220716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTskBs0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgC1Vqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:46:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39162 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1Vqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:46:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id x11so13871624otp.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPXNxsOZ3C7pRcm5mKIgZGPNm3UgML/++VJMRLMb3AI=;
        b=qTskBs0YmHh+tZEs84jHvRBn/43ZsP4wf1/5WCdmRZJ0AsdWtvM4X04ADXXYAcSi8J
         iLeuHFAS97j2PhIz3A+o9X0tQ/qo19nMFjGDx6kweTbNWQ50pCz+FFZgDHYxQEo+Bf8I
         KKUuqmBa53G1zkdO2LnPVx68/t2Gv3WUSP5Bks4cKmZuNLvUKbX4MoFxbGSp4N1a6BzK
         etcXqxEdv4quoP2Hoh5SAao+bAcBWdrE3l+d7oJgXG6uYq5vqlxRy3VS6HN7x0VDW6fR
         E1+45JyNk1fHKvAP1+4FzhLZHmRRJ3WLvm2JmPvMcfbDLCdja5/kOaJcDfF4c8pPwly9
         xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPXNxsOZ3C7pRcm5mKIgZGPNm3UgML/++VJMRLMb3AI=;
        b=g7w/JA66qWhOaC9P88jIIgE6QOjyT4t5wumRQvOR1i2N0MC2IOqYexNBQdknhHFpba
         Odbt2DBQeDcmq8TjCzS9nSmyhRl+GRWgKMBIN9xGDAJp+raFcDAm5TIg2ln98Nzg5IYz
         nGhoIZduelZsujNTNthxDnJvDhXE24IAHRt4L+GqL5EIrs9HZMxuA7WVKYJWlRGNeels
         G4IeA+m0NOg0BR9baooEvl0u4N7uW/W5G5xjQD7iIl2z05NWZK2pxV2YI/varIr7oZLr
         tUpho/accs4X9LfFI+PFgL7eyOoW2oUh4ccnYHcFYgu5HKXxqGeXsh9tNx0XlQM21fLC
         LJ8g==
X-Gm-Message-State: ANhLgQ2uuLTPBuSo5HBvOFaCOSonCEH3gWs7iVeoEgi1wgSLTQ363F6y
        vfjBIf1zV5R490sqn9DuTU7Ra1OEx+kle6GszH+MCg==
X-Google-Smtp-Source: ADFU+vvO4/e4aHB57owXkNgpgc4HV0D0tikOOK0ubtXnhm0OhkMPch3zJcOJ9Q4m/i7MsgSphG9JBcOGlz6Ynv6bL7Q=
X-Received: by 2002:a9d:42f:: with SMTP id 44mr3947412otc.236.1585432003872;
 Sat, 28 Mar 2020 14:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170132.17275-1-grant.likely@arm.com> <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
 <2885b440-77a5-f2be-7524-d5fba2b0c08a@arm.com> <CAGETcx_0=W6P_Zf-6fvDfncXUrPvt31bf6de-RWwHaXtwJizmQ@mail.gmail.com>
 <20200328110351.4e50491e@lwn.net>
In-Reply-To: <20200328110351.4e50491e@lwn.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 28 Mar 2020 14:46:07 -0700
Message-ID: <CAGETcx_Y-S=tAZiiymB2qWdx0uKzoDnGcmPoOr8EkOUsi6A0mg@mail.gmail.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Grant Likely <grant.likely@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 10:03 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Fri, 27 Mar 2020 16:55:34 -0700
> Saravana Kannan <saravanak@google.com> wrote:
>
> > > > The infinite loop is a current implementation behavior. Not an
> > > > intentional choice. So, maybe we can say the behavior is undefined
> > > > instead?
> > >
> > > If you feel strongly about it, but I don't have any problem with
> > > documenting it as the current implementation behaviour, and then
> > > changing the text if that ever changes.
> >
> > Assuming Greg is okay with this doc update, I'm kinda leaning towards
> > "undefined" because if documented as "infinite loop" people might be
> > hesitant towards removing that behavior. But I'll let Greg make the
> > final call. Not going to NACK for this point.
>
> FWIW, kernel developers have to cope with enough trouble from "undefined
> behavior" already; I don't think we should really be adding that to our
> own docs.  We can certainly document the infinite loop behavior as being
> not guaranteed as part of the API if we're worried that somebody might
> start to rely on it...:)

Ok, all of you have convinced me of the error of my ways. :)

Thanks,
Saravana
