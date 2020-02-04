Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE8C3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0221121741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jvi8QbyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBDUti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:49:38 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35548 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgBDUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:49:38 -0500
Received: by mail-vs1-f66.google.com with SMTP id x123so12410689vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDMn7tspiLbabREBPncdwnRL1LH/yW4VpIem+eMXcdY=;
        b=Jvi8QbyK+alPjB3i+rU2Ydb52K2Cr2ER4rlq6Ohk4VOaRNp3T+BkEDdEzkvR4yW9F0
         +3q3G2bto22tSH/jvMKXTBNdgwvUKeL72DKrAg8Lrd7M0vBvUcj6nT1GAMCxqtVlvVMD
         J97ugqLNv8AVmQrF7E6TIbQNA8POEkoe1hiak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDMn7tspiLbabREBPncdwnRL1LH/yW4VpIem+eMXcdY=;
        b=rXyt2OaNnKlPea4vzmyflpHKcBQ5TM5onbjmjWFUqQx+U6jPkCy1VD4FdeybAQuZvb
         vjtyZs26j5ccv+vtP0RK7eJ6KV+zT0KG3ol66AocuarF2kKXCH06WasAAYCbI2//O9Qn
         IleIXP+7IS5NmPdYTQ4NNKYbuSPuU87VLbh2RG6O8lD+lmNKrNffdgwgs6/GZPCJA/2u
         qyVYswkT0aOvJOGsA4U5ir7V8imPEqTzs0jl1rvhAZ8Y648kBl6bh26VcnpV+/SeFhMz
         LhNpitqnuRbDEfDXE248G5OhQ5R4yg5kP+4/HBmKWxCB36okKkwTl1ps9ZnQOa7xNxPA
         oL7g==
X-Gm-Message-State: APjAAAVY9FW/G6xpPOxZrQoF0EUludASe8KCAdMdZSon7QHfZsH7SL4S
        uHLWQ5FqulUMpbWdBjff5BUHcmUCiVQ=
X-Google-Smtp-Source: APXvYqwDoiw+mSUW4EqxlbTZIbsIagLKkpf8RdjQ1821eiJLccbsAyYFaZ4mzKfDvCjZ+9DvYbchbA==
X-Received: by 2002:a67:1081:: with SMTP id 123mr19801962vsq.199.1580849376124;
        Tue, 04 Feb 2020 12:49:36 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id u3sm7637334vkg.4.2020.02.04.12.49.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 12:49:34 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id y184so5592262vkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 12:49:34 -0800 (PST)
X-Received: by 2002:ac5:c807:: with SMTP id y7mr18261663vkl.92.1580849373967;
 Tue, 04 Feb 2020 12:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20200203183149.73842-1-dianders@chromium.org> <20200203103049.v4.11.I27bbd90045f38cd3218c259526409d52a48efb35@changeid>
 <20200204174900.45A5420674@mail.kernel.org>
In-Reply-To: <20200204174900.45A5420674@mail.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 12:49:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VaK6faWiAC1CHd081UzWCLEE42dHBq22ZyaSaUu8CXhA@mail.gmail.com>
Message-ID: <CAD=FV=VaK6faWiAC1CHd081UzWCLEE42dHBq22ZyaSaUu8CXhA@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] dt-bindings: clock: Cleanup qcom,videocc
 bindings for sdm845/sc7180
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 9:49 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Douglas Anderson (2020-02-03 10:31:44)
> > This makes the qcom,videocc bindings match the recent changes to the
> > dispcc and gpucc.
> >
> > 1. Switched to using "bi_tcxo" instead of "xo".
> >
> > 2. Adds a description for the XO clock.  Not terribly important but
> >    nice if it cleanly matches its cousins.
> >
> > 3. Updates the example to use the symbolic name for the RPMH clock and
> >    also show that the real devices are currently using 2 address cells
> >    / size cells and fixes the spacing on the closing brace.
> >
> > 4. Split into 2 files.  In this case they could probably share one
> >    file, but let's be consistent.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Added Rob's review tag.
>
> I don't see it. I guess I should add it?

Whoops.  I knew I'd mess something like this up.  Looks like it got
pushed without his tag but I don't think it's a big deal.  For
reference, he added his tag in:

https://lore.kernel.org/r/CAL_Jsq+_2E-bAbP9F6VYkWRp0crEyRGa5peuwP58-PZniVny7w@mail.gmail.com

I did manage to remove the "/bindings" from the ID as he requested, so
at least I didn't mess up the important part...

-Doug


-Doug
