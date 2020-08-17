Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D17D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gpu1742R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbgHQR2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389474AbgHQRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:12:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436AC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:12:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r4so15695517wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AueLUpVNwOplEaRIeklXnlMpQk/hv9PNTq+/4iLo0R0=;
        b=Gpu1742R6bQKiE7BaePK5diMLvF+iZfSSkZ0BOARPwt42lhi8nz00uW6K89/MGg4zm
         hZXZDUrk/4N+XUcR0wbbQo713rcnKWaOX9p4s60ZhAx89+KzEZhhA4saULYqOxNRGYdx
         hUyQy65h8Dy4+B9yFynN1Kh1R/12oHa6Gs3j4u3Q4o3r9uQOP6RgH+35nG01K9CZdK68
         rzoGzIXjOR9WHXTKTHVQO9vD4+jdCw3iMYQLPoCTJcpW+4tvowsYeLvIo21HjWRa2vmV
         04Cx09aiVDy2hFLu9lZ+jRZdQNHnPp6FILixg0q9oSK7M9y8md8BFE7vFrK7eGa8X8yl
         WMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AueLUpVNwOplEaRIeklXnlMpQk/hv9PNTq+/4iLo0R0=;
        b=gG99knuWUx6D2FgLYOJkYOFRNUAQ69GMYjaPrMofv5NWt8ou2LnMEMh6wOYC+EkNmE
         0dqF9+4MGG5ofuo28yoHO9G4Bq269xqYCdJGUpBqDz2KPB46NhFMXWAjX9RWMfwHmoRQ
         hocWBI9c0B2rz8XOD01wYe5jCKnHVoR1DOGvX6ie/VLFVfXbL8Ekn2MqsWj79baGV5Sz
         iu/BTpCS164Pk3q2c0Zq32xYwIJhAHvznWz1usoHoaV07m7AUOxAJthgpOjy8Y2sx3XQ
         c5s61hp3Dne8WWOag1whcmi8Xj0Jh25ql/gdgCNyQ4w6j+AfkI3y6MTGcATqdZOejQdG
         AFSw==
X-Gm-Message-State: AOAM532J16NPPyzU6NbBEw1WwC3oi/A5775+ST4+coT9OQPBcd601y30
        bbp2QcnUavZR9/Ey0wokG8DtZ7v6FZA1GEeTEmMfUKRhncQcOg==
X-Google-Smtp-Source: ABdhPJwzzJqqKP8Dz57WEH4mjrx29gWDTGQSyhqQk/3EQMn3h+P+wfHkvWUG7jnjma/rWD/FdEgspqJzfrhXMf85F+M=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr16257949wrr.79.1597684357045;
 Mon, 17 Aug 2020 10:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd3Dv_T7kgThLTk2QLtfS7LBvhJ5R=6C3seUYK0GvNV6eA@mail.gmail.com>
 <20200806223134.42748-1-konradybcio@gmail.com> <20200813070448.GA499758@builder.lan>
In-Reply-To: <20200813070448.GA499758@builder.lan>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 17 Aug 2020 22:42:00 +0530
Message-ID: <CAMi1Hd3j-A1Se9swD0TQ9YzTBGicPDc1nFZbf4uisVk5A+u1GQ@mail.gmail.com>
Subject: Re: your mail
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        dt <devicetree@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 at 12:38, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 06 Aug 15:31 PDT 2020, Konrad Dybcio wrote:
>
> > Subject: Re: [PATCH v4] arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)
> >
> > >// This removed_region is needed to boot the device
> > >               // TODO: Find out the user of this reserved memory
> > >               removed_region: memory@88f00000 {
> >
> > This region seems to belong to the Trust Zone. When Linux tries to access it, TZ bites and shuts the device down.
> >
>
> This is in line with what the documentation indicates and then it would
> be better to just bump &tz_mem to a size of 0x4900000.

Hi, so just to be sure that I got this right, you want me to extend
&tz_mem to the size of 0x4900000 from the default size of 0x2D00000 by
including this downstream &removed_region (of size 0x1A00000) +
previously unreserved downstream memory region (of size 0x200000), to
align with the starting address of &qseecom_mem?

I just gave this &tz_mem change a spin and I do not see any obvious
regression in my limited smoke testing (Boots AOSP to UI with
v5.9-rc1. Touch/BT/WiFi works) so far, with 20+ out-of-tree patches.

Regards,
Amit Pundir

>
> Regards,
> Bjorn
