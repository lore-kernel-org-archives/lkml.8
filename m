Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB511C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F8B207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZaYfub8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgHUNLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgHUNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:10:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D83C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:10:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md23so1429904ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OZLx+a/nSQcE7lQdpLIV/137NKEYeYc+vVq6Ax+/Us=;
        b=ZaYfub8fe77pPgsvZfW8Zc4FcYt8oZN0UCtpyAacgVXaWup8KKTmQKUad7W88SvSxH
         xpE9Tq+lW84yYf+VUBfXZBxR/AeVok4P0MxBhl9fNbruLFI8K7lTt+w8Yjsd1DT34IJk
         Wz2wZedQHFfr8jIftz/ZcPBofnKK52Rxd/S8im3bg/wKNYkGpDf388CinN3RERYFWeRF
         ndY3/nMIM5t0ZIsJxHbl+oX4LOYkKwbcsKXtL6UloDv2VctqK2cmD/zGklZip3mmcWHB
         PWAmdAS4ZRtRNy9jp49obXFGotMBF5ogailGh0clq9PaAFfcRkgZb3noyt6AM0TDci3X
         YPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OZLx+a/nSQcE7lQdpLIV/137NKEYeYc+vVq6Ax+/Us=;
        b=tR3c660hmi3KjCfHYBoul/e90deY5uWsCGZ6Nj5KghEv9jpU92wmSlQGrGlMghJq1U
         EazKS190jgaUT6yExaVjhIst/w/rAiL8ehJf1p2RGZlb1bD9dBPnAKzI8A2y+LkF8Xop
         q3QeuqbC0ZUD0UCMv2S9y0EGfq0SLD3JETQJftwwetacnjwvhD77tNnxg5RcQYzwmGEA
         Q1xL7F2LS1iPGT2/HEwp6zvu0uVOv8uEKhBU1pFDMZn41KG7BAMyszxmlCvRqwgaWgnM
         BWDXZSm80E13EDVYFEPffe8BKz/sqPmjkYuy48rmqAuSlpw6t+CwiBP+TerkgxB2W4dv
         sWtg==
X-Gm-Message-State: AOAM532saaag4juOsYkdNBXAz6JL1MoOhYrNaJB573CxfKrwWuqjE+Ws
        MpIt7zbekQWXEk/CfkK0os4L+SZhdw7ALRcA/VKV
X-Google-Smtp-Source: ABdhPJyQWB2b57FXvUUgdmXqQCQjy9gLRIDgIlPOlRK6o42KWg3AaomHrHBOWrFgNtNSLh3FIhetrDVcJWXpSnu9pto=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr2755928ejn.542.1598015457398;
 Fri, 21 Aug 2020 06:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com> <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
 <CAEjxPJ7k648nQxCDzcHc0h1vEfNhAJShG5iKmD52nuO5s9phsQ@mail.gmail.com>
 <CAHC9VhSYJUAacvzp1hR4RMChTctJ2sFb5+oy_wbsigaWMGTYHg@mail.gmail.com> <CAEjxPJ73t1p9K_FbDKOTRPZn-bz8p7KVOB48UzfzELsMhx5MPw@mail.gmail.com>
In-Reply-To: <CAEjxPJ73t1p9K_FbDKOTRPZn-bz8p7KVOB48UzfzELsMhx5MPw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:10:45 -0400
Message-ID: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:15 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 20, 2020 at 10:22 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 8:14 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Aug 18, 2020 at 4:11 AM peter enderborg <peter.enderborg@sony.com> wrote:
> >
> > ...
> >
> > > > Is there any other things we need to fix? A part 1&2 now OK?
> > >
> > > They looked ok to me, but Paul should review them.
> >
> > Patches 1 and 2 look fine to me with the small nits that Stephen
> > pointed out corrected.  I'm glad to see the information in string form
> > now, I think that will be a big help for people making use of this.
> >
> > Unfortunately, I'm a little concerned about patch 3 for the reason
> > Stephen already mentioned.  While changes to the class mapping are
> > infrequent, they do happen, and I'm not very excited about adding it
> > to the userspace kAPI via a header.  Considering that the tracing
> > tools are going to be running on the same system that is being
> > inspected, perhaps the tracing tools could inspect
> > /sys/fs/selinux/class at runtime to query the permission mappings?
> > Stephen, is there a libselinux API which does this already?
>
> There is a libselinux API but both it and the /sys/fs/selinux/class
> tree is exposing the policy values for classes/permissions, not the
> kernel-private indices.  The dynamic class/perm mapping support
> introduced a layer of indirection between them.  The tracepoint is in
> the avc and therefore dealing with the kernel-private values, not the
> policy values.  The mapping occurs on entry/exit of the security
> server functions. So there is no way for userspace to read the kernel
> class/perm values.  We'd just need to keep them in sync manually.  And
> one is allowed to insert new classes or permissions before existing
> ones, thereby changing the values of existing ones, or even to remove
> them.

Ah, okay, thanks.  Can you tell I've never really had to look very
closely at that code ;)

-- 
paul moore
www.paul-moore.com
