Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64854C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4680122482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="uK1fPqsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgGTSzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgGTSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:55:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93A9C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:55:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so14216417ill.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlzIBOC64fwM6IZTzOMQZVXjakvnkez1SRmk/mqAZb8=;
        b=uK1fPqsTDsXtxyQAcmH3LFricfO/N5csbRJtisfSNyVv5LU35FtnPgVQSWo5mS+wR5
         /ziDzA2dZmKZBQQbzKbb7t9LFHODzW1lJWQelwii0DidY8vKAJecbEH7htVhsR/CsiRD
         zhjx3Nrnf+9u9mQNtAKgPUluDqdLqKXsM9s7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlzIBOC64fwM6IZTzOMQZVXjakvnkez1SRmk/mqAZb8=;
        b=f3Ug2XD1vt6KWclUOqBiFcIYJsfPtjDmZhvxOCVKOVxmv7QPtlrG6v1OyVeOHIwzFZ
         7mHLA+rRY+xZXJGlCAReB9pF2PnxKoqX4M0yPnNLV3rKN/iNJKYc+5mP7i9QEU4hvs7y
         ouJmZlD2/7IOVvHtxum13eVP4wmnUUgVSeN4eQg1L4rAU6Urg0/Rdt9QmvbIiIMJETEZ
         t03HJMbXN+O+lIM0q+l6LVwkeu68VKcd+XupLXTjlZp5XQxjGmCitIci3SyxDumGWavU
         5msiwFYlcDFwjDNNuXwmbZbevd+k5VDDhgzU06obAVRkzEtgUDDHSMGEjpkGTpYzLczD
         EU0A==
X-Gm-Message-State: AOAM531MbzFpG5L3CtRjpjQq59qEmWZO2wUladV+WzoQWe+/C25ZHd78
        g2RSmFhhmsB7cQHlvcU+VPbYltxotOZL/pG9EcKX+w==
X-Google-Smtp-Source: ABdhPJx5b/BDLb+4gQ/xgW/0XyifxMyqE8yIKeMG0cLy2dTbP/W31SQE54F4cN7PPNeOrBzfbdBrQ9ArVGRsa0r01A4=
X-Received: by 2002:a05:6e02:4c6:: with SMTP id f6mr23615757ils.98.1595271353891;
 Mon, 20 Jul 2020 11:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200720152820.122442056@linuxfoundation.org> <20200720152822.437100100@linuxfoundation.org>
 <613577badc9937049d40ff14d11646f64b3dac36.camel@perches.com>
In-Reply-To: <613577badc9937049d40ff14d11646f64b3dac36.camel@perches.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 20 Jul 2020 11:55:43 -0700
Message-ID: <CAJCx=gmxHDm2Qhi8kXhSkpgrGc2-AKb7ymuU5oK+fcBqmQaROQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 047/215] iio:humidity:hdc100x Fix alignment and data
 leak issues
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 9:50 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-07-20 at 17:35 +0200, Greg Kroah-Hartman wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > commit ea5e7a7bb6205d24371373cd80325db1bc15eded upstream.
> >
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data.
> > This data is allocated with kzalloc so no data can leak apart
> > from previous readings.
> []
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -38,6 +38,11 @@ struct hdc100x_data {
> >
> >       /* integration time of the sensor */
> >       int adc_int_us[2];
> > +     /* Ensure natural alignment of timestamp */
> > +     struct {
> > +             __be16 channels[2];
> > +             s64 ts __aligned(8);
>
> Why does an s64 need __aligned(8) ?

This is due to on 32-bit x86 it is aligned to 4 bytes by default.

- Matt

> This seems needlessly redundant.
>
> Isn't this naturally aligned by the compiler?
>
> The struct isn't packed.
>
