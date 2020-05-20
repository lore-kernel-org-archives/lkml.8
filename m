Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3820756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="e4GAUZr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgETE3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETE3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:29:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5EDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:29:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i5so828942uaq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qZZbuT843G0ykcP4WOBCe4Afr8ELi6EnDD0MmBi+I4=;
        b=e4GAUZr0pYYlAbmqzr5mBscJHnTVsJRtiQmpa37SgUxJp1nut8NqINekK2P+p9iHP8
         0O+ePxYtdOc+NKNqX5iCCyYeaMcxzXYdc2rGBUwQmAJNAVZjRTNIGmOFuqSqQBoQdoDc
         vVkWvI/cl4u/oHEQE2LiLFT1n4xReLm9wvYiSSNEBVZlI84Rp3leRcc/ydVcl6rz8RXQ
         OHqexNizzlctGtaXQkZY/ODZ46zQbQxP0KN1o8J9TDQ63u0K2uYX4DSyIO/eRfmmMEZ7
         xbjGDFDYdO0w/nzf5Axr6TV3MTMVWwXt3bjgcfJfvrV5rYofoDP51e8cLqlekQsJXb3s
         8LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qZZbuT843G0ykcP4WOBCe4Afr8ELi6EnDD0MmBi+I4=;
        b=ahJgAWwL30004sIuOyZbrbNPoiO9MHFH1kdcvPNvYXhUyBP7t/aXu/IwzCLFPNEyXS
         XE5IrvdQtLm/Hpt6v/35RX4JMHxxq4Wkv5TBVzg50nG3sVzoT/JGZ5GD1tyiJbYczvWA
         4tw27QUpdpwTiCda30aeBPrsKUCmq+Q3EkVs4Cw3uKfwpDF0klWorfeGewKrmBMiP/WH
         s/dCI+n2OZxCjO/80GSu3puK5KR6FR3GiDhPGYPHnD0Sy2g+dK+HpGv6gIqSZRMQfF04
         v7JYioPh/aWArvJmn2DcRxEgv+43ObiUbHDgkE4DfM33nTRvhwSYKFKV/kwqTw83qU3g
         aOew==
X-Gm-Message-State: AOAM533Obuh6lAAcQqFYynXx9/+eP0jIhIzcARst2Esasq0ImikVNmLC
        aLNfksropLOYWZhPz/Vcg0ZUPfohUwCZa02lJmpYlA==
X-Google-Smtp-Source: ABdhPJz/7dzzKIcOTkCfA7HyKaMiShlW5edXQ9UXQspFQ4VSXLLphRu+GFq2HxwSJt8TDxiIDqOwpBhdbeS8jtJjiB4=
X-Received: by 2002:ab0:30ba:: with SMTP id b26mr2042602uam.77.1589948941382;
 Tue, 19 May 2020 21:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
 <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
 <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org> <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
In-Reply-To: <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 20 May 2020 09:58:18 +0530
Message-ID: <CAHLCerMfnHPuJnj6G4EvRPvODf1_Se4xM-OobA1o7eao5eetzg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5] thermal: Add support for setting notification thresholds
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 5:10 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2020-05-18 at 18:37 +0200, Daniel Lezcano wrote:
> > On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > > Add new attributes in thermal syfs when a thermal drivers provides
> > > callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE is
> > > defined.
> > >
> > > These attribute allow user space to stop polling for temperature.
> > >
> > > These attributes are:
> > > - temp_thres_low: Specify a notification temperature for a low
> > > temperature threshold event.
> > > temp_thres_high: Specify a notification temperature for a high
> > > temperature threshold event.
> > > temp_thres_hyst: Specify a change in temperature to send
> > > notification
> > > again.
> > >
> > > This is implemented by adding additional sysfs attribute group. The
> > > changes in this patch are trivial to add new attributes in thermal
> > > sysfs as done for other attributes.
> >
> > Isn't it duplicate with the trip point?
> A trip point is where an in-kernel governor takes some action. This is
> not same as a notification temperature. For example at trip point
> configured by ACPI at 85C, the thermal governor may start aggressive
> throttling.
> But a user space can set a notification threshold at 80C and start some
> active controls like activate some fan to reduce the impact of passive
> control on performance.

Then what is the use of thermal trip type "ACTIVE" ?

> We need a way to distinguish between temperature notification threshold
> and actual trip point. Changing a trip point means that user wants
> kernel to throttle at temperature.
