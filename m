Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE76C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0C520809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexb-com.20150623.gappssmtp.com header.i=@nexb-com.20150623.gappssmtp.com header.b="AevcBSO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgG3Vqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgG3Vqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:46:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C66C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:46:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so7532097wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgSrYhpGekxRZP3lV7wzc1DduVX7xLMamMd+6NIxKag=;
        b=AevcBSO/AYq9UPAtSDw4FCQSNdy0SqgOyF1wN6R2N3j0OuNCGutm1+YlqI8Hm3vX/t
         lNm00L4jYDDTJ4AUA+Qki5NsnwKgXZmkaZ0buEW5dq6+s39a1/O1pdM2dWkxQ7XCRBUD
         gau4R5tTPoAZ+zBCipCxnS5063WOXmOzNJKh46IXbV+mRcydBd/3GP9JstbO26dDMXUt
         0jVMJcBN/8uyViTYyDAdvWa9wZ+z2BD591/9iPb6nBUszgB3DeWAZMVVS9/BlCTM9wxV
         PKar+vG8PwByIn5yl7Av9w9vcQnt7ujMUgoVfLZ6OyKw9DfIOm0shVYl1ZXTxmqWTrMe
         B2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgSrYhpGekxRZP3lV7wzc1DduVX7xLMamMd+6NIxKag=;
        b=o1glUUWukpn1h0sj4n1FCd6ub8U6r1GCF6bWGOMgqDCsnhQPAt6sxOXAfy8v7ZV3pJ
         2YwSUyQkS8ZuAaVWb6wsTODS3g1mUIZ4yWneyAULD0N29TsARzxEjgHK784asR6Ea7QI
         vkY+/etkm/Mf+lfbSEIDeDCQxGahoMIqchXQBJ1A1yNddlU6zKxp/eadjPmzzQfsMyoG
         QpXL2HxxOi090TQziyJ7+fZPtx1Igho+AHqj6R8ecw2sBM3ajdDrK4rv0K4yEfxeYtY7
         iyeyx6XhZAmgTLXM/0Hh258XF61mJXMA5ZyIJ+IYdKbTfJPrp99V0YcgWzlhKaMxSwlA
         BgPA==
X-Gm-Message-State: AOAM5321X3dBNztLj26D7ZSUGFTOGiYfGkl6ahpYwVL0xiH2JcgbmmvX
        qL6CXn4A6mIW8Yy9JLZ9OMgSfpua9E+Mm7jWZCwszd8wBa0=
X-Google-Smtp-Source: ABdhPJwNe4PAz/SuuqZnBk9Ypuo1k80uzUfHx7Yr1cBrQI5BlDaLAAxtcs4VcLczrjkukxFjOQ39GevbehseRAdkdDM=
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr969575wmi.139.1596145607560;
 Thu, 30 Jul 2020 14:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200713084231.32496-1-grandmaster@al2klimov.de> <20200721145038.GA1991774@kroah.com>
In-Reply-To: <20200721145038.GA1991774@kroah.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Thu, 30 Jul 2020 23:46:11 +0200
Message-ID: <CAOFm3uEj6yt9Y7BmuW9s9ob10v0CJgDbywrxQtJvMOxkgjx9cg@mail.gmail.com>
Subject: Re: [PATCH] LICENSES: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander:

On Tue, Jul 21, 2020 at 4:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 10:42:31AM +0200, Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> >
> > Deterministic algorithm:
> > For each file:
> >   If not .svg:
> >     For each line:
> >       If doesn't contain `\bxmlns\b`:
> >         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> >         If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> >             If both the HTTP and HTTPS versions
> >             return 200 OK and serve the same content:
> >               Replace HTTP with HTTPS.
> >
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > ---
> >  Continuing my work started at 93431e0607e5.
> >  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> >  (Actually letting a shell for loop submit all this stuff for me.)
> >
> >  If there are any URLs to be removed completely or at least not just HTTPSified:
> >  Just clearly say so and I'll *undo my change*.
> >  See also: https://lkml.org/lkml/2020/6/27/64
> >
> >  If there are any valid, but yet not changed URLs:
> >  See: https://lkml.org/lkml/2020/6/26/837
> >
> >  If you apply the patch, please let me know.
> >
> >  Sorry again to all maintainers who complained about subject lines.
> >  Now I realized that you want an actually perfect prefixes,
> >  not just subsystem ones.
> >  I tried my best...
> >  And yes, *I could* (at least half-)automate it.
> >  Impossible is nothing! :)
> >
> >
> >  LICENSES/dual/Apache-2.0 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/LICENSES/dual/Apache-2.0 b/LICENSES/dual/Apache-2.0
> > index 6e89ddeab187..fd71308fd2c3 100644
> > --- a/LICENSES/dual/Apache-2.0
> > +++ b/LICENSES/dual/Apache-2.0
> > @@ -15,7 +15,7 @@ Apache License
> >
> >  Version 2.0, January 2004
> >
> > -http://www.apache.org/licenses/
> > +https://www.apache.org/licenses/
> >
> >  TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
> >
> > --
> > 2.27.0
> >
>
> You can't change the text of a license that comes from elsewhere.  This
> file is fine as-is.

It is so fine that -FWIW- even the Apache folks toyed with the idea of
updating their license text to switch to HTTPS there and decided not
to [1] which is IMHO a sane thing.

[1] https://issues.apache.org/jira/browse/LEGAL-457
-- 
Cordially
Philippe Ombredanne
