Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C676D20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmNB12tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgFBXNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:13:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9FC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:13:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y5so113514iob.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXZokHEySPFA08JPHMN8m6QgonxNfRX4BjCitd9AiX8=;
        b=rmNB12tN8mdPfiqkCugvVPCvLrfqUH8B9GQsBpunJeYazumhNF8BzpFY76VwHaIvlt
         nTUujxj8X1oTPrb6GkFAOysjhhKgC8QyN1HKdFMSQFDHG4VXnmnT+ukMOLRRoChl15MJ
         var0Pu4BwoJ0TkDqAgtDnWkgxCphx16tj7+9elZW1CyyaRngNVIFPro3tJAJkss4AiQh
         oexQBPlotrrwKi7Ve4LaY5Ml0/TfJdSLdvvLDkUVDKHQ5bL8cMS98RdFU5E9Vux3Leai
         LwPQxW0RfnVNPjBwgoqj2mmu93fELzEl3/JrJmFbOm2CZHse+rU40RsWYdRfoPrTeaX6
         +5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXZokHEySPFA08JPHMN8m6QgonxNfRX4BjCitd9AiX8=;
        b=UYbPgp7wCyxJs4zqU43JWTXMSk8tgA9Zd4sBWQaaeuBekSnCxHLOgH5TI7SLchcOhx
         nI1lVFdQ2EcFZZSpBiixO8Pt1lG1GoIWqx8kh7OpSpT3Y5JsJf2yGKI9viRNb0DndZIy
         Qojt31upfH9HzK0n5YgNIAJI7iQ+2+X5aYC4nUaY4Oi+pf9jcA7Ec7LAal69VIm843+B
         Q6atVfrFdzErXT9ECSzRg1COvHZ1u72OxxEZnZnx5Dy/CiFXE+yy6xRS3NK6Xoi84ckd
         7cZj+MudRmRvCbUjDIKk/wLrECYpSG2oo1ks16tATIFCVwF2BiqGRVfpEyAByotSIREZ
         m9vA==
X-Gm-Message-State: AOAM531RZKQju//kp7box2Ihn5o9hh3wyLlLEZCNaiRBOHU8SV4r4xI0
        E/nZ6ZgEbu5OyEHffWzlAzk+q9UOhen4KNSBRzE=
X-Google-Smtp-Source: ABdhPJxq+Iora96VovmCINQ4dS1t6iuqbkLmA6tTdxA1x7ePhhsdKwpNulQHfKweiaukCJFCTWZmX1/JySqgpQBhfIY=
X-Received: by 2002:a6b:dc12:: with SMTP id s18mr1399660ioc.56.1591139623635;
 Tue, 02 Jun 2020 16:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200601060802.3260-1-laijs@linux.alibaba.com>
 <20200602134915.2644-1-laijs@linux.alibaba.com> <20200602161350.GH31548@mtj.thefacebook.com>
In-Reply-To: <20200602161350.GH31548@mtj.thefacebook.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 3 Jun 2020 07:13:32 +0800
Message-ID: <CAJhGHyDso12OTjKTiX7fOnMXHG9-=0jD1p09-1ZgjLeSg18zmA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: ensure all flush_work() completed when being destoryed
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 12:13 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Lai.
>
> On Tue, Jun 02, 2020 at 01:49:14PM +0000, Lai Jiangshan wrote:
> > +static void dec_nr_in_flight_flush_work(struct workqueue_struct *wq)
> > +{
> > +     if (atomic_dec_and_test(&wq->nr_flush_work))
>
> Do you think it'd make sense to put this in pwq so that it can be
> synchronized with the pool lock instead of using a separate atomic counter?
>

Hello, Tejun

When the counter is put in pwq, there will be a per-pwq counter,
a per-pwq completion or pointer and a flush_workqueue_prep_pwqs()-like
function (although simpler) to set up them before waiting for them.

It would sound like the V1 patch. per-pwq counter may have better
performance over per-wq atomic, it seems too tiny to add code
complicity. V1 has the simplest pwq_dec_nr_in_flight() except
there is too much WARN_ON_ONCE() in flush_no_color().

Thanks
Lai

> Makes sense to me otherwise.
>
> Thanks.
>
> --
> tejun
