Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2954BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B38A2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="osDCo+V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFOW61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFOW61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:58:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:58:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so19257343ejn.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=immT4WkLnda6YfNKYGwHA9yJDk2kiBhS/pGbh2mQjPk=;
        b=osDCo+V4i6RfQ9YW4YDYILIZNvZoI+Ny/6fv///i+0Cnhy882MZDO+KHnTAOtwpO+B
         8yI6URlUs0bSn9QkaXsPwbbmNdxmG6ij3zJdphYY/9THZIEhI/GAHR8mPoy2F+XgrEGX
         9WEiEBPC/MDGSTAKBf4X9BSdo9ksaetEO4mGEOSeVm9jTNDyp6B4D4GXkIcUjNlKSwI1
         J9vAUhCkNsJserK6QmEqWNTwF0OeANvwRlMz8gZbmKZr6MCDbVyWoOxHH8XSmKLisV81
         YV1mmTnHjGeZLvZOasGFl7ftWD0+TM1eJJL4h6eK0pU5ctWBcApr+NqvsEHxmGLiMRh6
         i4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=immT4WkLnda6YfNKYGwHA9yJDk2kiBhS/pGbh2mQjPk=;
        b=pcLDi96B2VqDmxVfKaG1TcxzZSEEGNWt5T4M0e6ZJ5OBge495fvwpZVMQEn4i4V2//
         XYKYQOjQb5WusJWJOUzRbbm9E0hDpNRVJXqMq7q51HR5WhQzs687gFfUsY7eeAZg187L
         xmfVXynxDRImBoQQ3EJKmy6xHVOGe/Rf15WXB+OcGtETWQV/j+3mffySeAqXKBRAvucF
         efhC/RlS49V/HavoZ7FxNtwKp4koMGX6GogPpNKYivNtZHlekdqC1vdeTIztYBR5OWqK
         IJHND8N4VooNUi5EDGgkOxKmeE0xrt9IwyAQFlNadepgdEgg/kwo9VuDLNJqYfnIZerA
         fp+w==
X-Gm-Message-State: AOAM531XKSmva1uh0or8cw34ya5Z1oUGWf6aO8d9KvI8WvLzsZHqNVoB
        0qGNFymEe4e6LlePCBJYTcNO4REvzQWMUxESxPMq
X-Google-Smtp-Source: ABdhPJz59Qp09HBaGGrVxVf2joidqjdaTot5Cni90eRr1tEiWW7ztppOOClTAF7v0Wc9hS6nXdg99/Q7znc2zKHsCjk=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr77860ejb.91.1592261904302;
 Mon, 15 Jun 2020 15:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <1591989920.11061.90.camel@linux.ibm.com> <42482562-d74c-2678-069f-1d8ef4feffac@linux.microsoft.com>
 <8800031.dr63W5FlUW@x2>
In-Reply-To: <8800031.dr63W5FlUW@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Jun 2020 18:58:13 -0400
Message-ID: <CAHC9VhT6JSLBD-JMfQbn9eUsUg=juznRz41DTOaia-=WhrAAuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 6:23 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Friday, June 12, 2020 3:50:14 PM EDT Lakshmi Ramasubramanian wrote:
> > On 6/12/20 12:25 PM, Mimi Zohar wrote:
> > > The idea is a good idea, but you're assuming that "result" is always
> > > errno.  That was probably true originally, but isn't now.  For
> > > example, ima_appraise_measurement() calls xattr_verify(), which
> > > compares the security.ima hash with the calculated file hash.  On
> > > failure, it returns the result of memcmp().  Each and every code path
> > > will need to be checked.
> >
> > Good catch Mimi.
> >
> > Instead of "errno" should we just use "result" and log the value given
> > in the result parameter?
>
> That would likely collide with another field of the same name which is the
> operation's results. If it really is errno, the name is fine. It's generic
> enough that it can be reused on other events if that mattered.

Steve, what is the historical reason why we have both "res" and
"result" for indicating a boolean success/fail?  I'm just curious how
we ended up this way, and who may still be using "result".

-- 
paul moore
www.paul-moore.com
