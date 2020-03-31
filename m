Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876202080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691878;
	bh=Zu1+EDUOL9F+mTyPpnq9JwMy3rLL0NZ6rRu7yWBytSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yr4qs9FPGMF7s6LHBb9UbrZ41T0yQPA9Xr8X9LTDXjsSG92w5RaIpQavAjfSGrtDG
	 I/GEcC+0NGqyPCnWJNTEOTFT6/luFmrYshdDUIUsEEh+NqiRZRTzkkdoxzXbThiATA
	 Q14PpZFNONRfZEVjh9vkG8y3bKloyc21kom6WW8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgCaV55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:57:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgCaV55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:57:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so23615917ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWCL2jCppG5LkoKMYYPBwC+nwI0ZdMJ2BLHFibGdvI0=;
        b=PUXpLmb3tX0bxge/0WtFWPqqx57HXPBcgrdgO5zWA71NBQj8TgTxIlRKouWePigaHD
         avry2Mt29/TnJWoEoWgxVKRe/I4TdNKFU9QrnHIjrgONlXZpAxeOMOgoFTN0Ax6i0Ogp
         ib2zWaoo36ruVJGV7Z8H7upXi6FauXuTe9iAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWCL2jCppG5LkoKMYYPBwC+nwI0ZdMJ2BLHFibGdvI0=;
        b=YNj1e9foHQyVKS5m8I53vhwKXMMcRgQ5yxWG/qqdC0obKYg1D0aON6alJNm2wD2FJN
         uvmpqK6kGwnuDpXzxjdH445FY8txf1fpwsJOWZpbvoGrDAM7RAoRGBl+cS0CJ/eSH1Zi
         rbaaDH3aAMNBvArZYZ/BTPL7hjZhqidiZYuz007WbapPmdE8zpGDW2HIHUazIGGtISet
         9O2E4RHw9kptFnRChgTHCvg3TI36EMDSjmFa5dXoZAYcxNUgL066WyQ9Tppl//mjTSah
         Kw1Mm+udWJShwn2lNtSxs2PtNYCebzknVcKvcw5VMY6c8xuEQC7xSns7A/yrC9UhdYaG
         g3/w==
X-Gm-Message-State: AGi0PubqeibKfsC+Qju6kl6OzJel7NGYwyJr5AcsWBC0+ir+WcX8oeqD
        RQm8ggyxFTVDjR8atUoiNQ7VztYF3mo=
X-Google-Smtp-Source: APiQypK8YU9XLM2Fo+v6uD7vikihz5o5wa/bzKq2mVSqFyzBpXuKONeo1b2JIByzggi1hyFM22q/yg==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr11328016ljh.28.1585691873822;
        Tue, 31 Mar 2020 14:57:53 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d2sm107995lfj.67.2020.03.31.14.57.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 14:57:53 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n17so23661928lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 14:57:52 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr11824471ljj.265.1585691872539;
 Tue, 31 Mar 2020 14:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <1136650016.19797621.1585672680530.JavaMail.zimbra@redhat.com> <328533763.19799053.1585672849599.JavaMail.zimbra@redhat.com>
In-Reply-To: <328533763.19799053.1585672849599.JavaMail.zimbra@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Mar 2020 14:57:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whP9ufV=m6PrSWOcJCEx2Ere1fqhRYszE+Wu1D1ZjTn5Q@mail.gmail.com>
Message-ID: <CAHk-=whP9ufV=m6PrSWOcJCEx2Ere1fqhRYszE+Wu1D1ZjTn5Q@mail.gmail.com>
Subject: Re: GFS2 changes for the 5.7 merge window
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 9:41 AM Bob Peterson <rpeterso@redhat.com> wrote:
>
> Could you please pull the following changes for gfs2?

So I've pulled it, but I note that you didn't get the automated
notification of that like almost everybody else does.

The reason seems to be pretty simple: the pr-tracker-bot looks for
emails to lkml (and other mailing lists) with variations of the
subject line "[GIT PULL]" in it.

And while lkml was cc'd for your pull request, you don't use that
subject line prefix, and so pr-tracker-bot ignores your email.

I don't personally care - you do have the markers that _I_ look for,
with both "git" and "pull" in the message body, so your pull request
doesn't get lost in the chaos that is my inbox during the merge
window. So this is purely about that notification bot.

IOW, if you care, then you should change your scripting (or manual
habits, I don't know) to have that "[GIT PULL]" in the subject line,
and then you will get that nice timely notification when I've pulled
(and pushed out).

And if you don't want that notification, you can just continue doing
what you're doing.

                  Linus
