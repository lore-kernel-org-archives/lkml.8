Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F96C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FB7206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ouw7PqH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGJVqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:46:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDBC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:46:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so7553622ejn.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4VTlerwbUNoSt2XThLD+6dlusu4El/U42eSnUsX6n4=;
        b=ouw7PqH/fd8RGpSOHN4Mf9hQW5R4Y18NG0VUofEAKvSp8zxVfLxlcyWHs6/BawgCtQ
         Wu9E+0/yRuuOxqZBIymVEUbDrr7izwaHEnnrSOzaYCCakeKdQXptNiTmqjGnvoQ/j7aZ
         Y5DsRdkkGJRcE9gYVv2USPQcehf0mDfFbQ1Nw8kcBHf5+d4OvU+Gc0/4/nZlfSshnh77
         pAe4uFiIoeXSGaPPnlJszgorOVd/NkWtv+XzqK5VwrCbxx/3QIFTRWcMyGHXHKVs7fhM
         vJU4VuUZ8O+RUPgjoLvIsLIwmXPZQEH0MwDrplvv70LdG6KC6ooH26ncHDvoGNbd9PJE
         50UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4VTlerwbUNoSt2XThLD+6dlusu4El/U42eSnUsX6n4=;
        b=iUpjYu0/D8rVqK5JCsFgSEJphgIo2Znp7ACzz5aMA00vNLAwwEAQaeaD1jRQEAYyDM
         wRRkJOa0lqmF7/wvUwW3KX4Nf7l97Z+HkdHZ5YKKohyBXVJV+FwYoS0HrcFc+Sr1JcJi
         5HixUg/b7dpqUhGtlFxSzALMKWU99MrEUYLbB21/LMHpZVoyhsXafCJ/N8fydjAl0NaR
         oKQouZs/FDbcSpPEZLUb+kUibRPGRH9HQmhSsNIpUGAUGEcgZgd7ktRBrIbh26ZYa5Kc
         7pyAPAFy7JbPom6vntkwIvSs+3N36X6XxoV6mwqwD5iSzS6AcXoNvRQYRbX9VF+KUEGn
         hLRw==
X-Gm-Message-State: AOAM531Vz2Vs2DPAvDgeBquxp6S/O3BCRk+k8kD4RlDbZ/Vi11D/e7e2
        aYj1bApEPA7Zpm498eOYVKynj4rZmDoBACPqLYm2+A==
X-Google-Smtp-Source: ABdhPJxLaVOXj7Cfq7OFeW3FAbbjCqcQic4yp5DelaumYpXwZLQLJubKiaDXlv2Z7to/Tyc2BK9z0MZe48Rnok/Xx4c=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr62470722ejb.124.1594417604353;
 Fri, 10 Jul 2020 14:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrVufhJTh3LweQqqH1OHc2rTsGkMcmTzCq6kKh1ETY0arw@mail.gmail.com>
In-Reply-To: <CALCETrVufhJTh3LweQqqH1OHc2rTsGkMcmTzCq6kKh1ETY0arw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 14:46:33 -0700
Message-ID: <CAPcyv4iCJfzggmOXpmWUWcFPay5DauWzzBWjECYr2f9vCxLZWg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
To:     Andy Lutomirski <luto@amacapital.net>
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

On Fri, Jul 10, 2020 at 2:12 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Wed, Jul 8, 2020 at 11:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Linux maintains a coding-style and its own idiomatic set of terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
>
> Acked-by: Andy Lutomirski <luto@kernel.org>

Thanks, Andy.
