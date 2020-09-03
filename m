Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5382072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0ZpLV8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgICN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:57:54 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFDC061A1B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 06:46:48 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id y194so1765127vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j0CWDjHuel9BhIbAeE9SClU/k1SGiwHbME2EsbEVqqg=;
        b=H0ZpLV8XVaPO5Koy+JT8TV7Werq7grrAXsb7ndgYrWD9aaM+kA2QtzugtG05VDPave
         ses3ofeebxQHSLAcjOGBkC9btWfyNNGqg8vbRKxZ07es2kQ6lWMR4pK7q2EDD14dauZP
         30UPjbW4pxO5QwJcqFdY16nw8daWweukbCV/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j0CWDjHuel9BhIbAeE9SClU/k1SGiwHbME2EsbEVqqg=;
        b=aaokvfl7S+sQMA0gn/aIl8cbgvaQihQtML/Heq5Ari5rdOoSDjDZDXFHyMjxA4K242
         kvlfH3oj2zdxLQgOIbpL4mRfzEJ62Ny2wk/HqU/ehPzzwAfHpkYranOfQALmPOn0Yr5L
         +SxhL0KsBjybxcRJEX8FaZpEOJQZI+sL5N5A7J8wO49R9S0Zp3T++/8zxLShhda3Yosd
         JeL766pK2s6vloVQImZScA3sm3gXsgje/Th8odbDaHYKcZleexlIPTBrO19Bcjpqvz0X
         520NycjiT/6USoy8DSdUsBA8AKRJs6BM/R43QJh7MQV7/c3Fj62ltRtUVz2SllDwQK/k
         pbRw==
X-Gm-Message-State: AOAM533EqzW2EC/OSGCA246VzCuXpdPmjKjNWon3z55jSIGy7SE+/eNr
        nDUMKi8olJkz0N9nCdpQcAW09yggWRkz4w==
X-Google-Smtp-Source: ABdhPJyUpbFUVZkfjxEdJ1UeboIjtYhm+7e8EHtxbcGg2Dkx8ZArpBpOG8q/RlUoUfbkcZd6rkfutw==
X-Received: by 2002:a67:7905:: with SMTP id u5mr1759500vsc.179.1599140804306;
        Thu, 03 Sep 2020 06:46:44 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id n9sm285299vkq.31.2020.09.03.06.46.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:46:43 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id x203so1731588vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 06:46:43 -0700 (PDT)
X-Received: by 2002:a67:e447:: with SMTP id n7mr1767573vsm.53.1599140802881;
 Thu, 03 Sep 2020 06:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200817144722.6665-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=VE6vCPjDvvP0e73tnd8u5rPuMUa-mwvDazrfUpXP+bKQ@mail.gmail.com>
 <2a0c5fa189dbb2e810ba88f59621b65c@codeaurora.org> <CAD=FV=X8yS1gUNhhVNyfuRPzDUheG2Rco2g16KMegCG6fKJw7Q@mail.gmail.com>
 <d949bdfa15b133f74a47727401553c76@codeaurora.org> <7714ee57f75542839d5c33b28f232aa6@codeaurora.org>
In-Reply-To: <7714ee57f75542839d5c33b28f232aa6@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Sep 2020 06:46:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xt0NTNjCEJ2USfyd2qZ+FfBz9xwctbpv+hSWvvCoAZFg@mail.gmail.com>
Message-ID: <CAD=FV=Xt0NTNjCEJ2USfyd2qZ+FfBz9xwctbpv+hSWvvCoAZFg@mail.gmail.com>
Subject: Re: [PATCHv2] soc: qcom: llcc: Support chipsets that can write to
 llcc registers
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 3, 2020 at 2:58 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi,
>
> On 2020-08-18 21:07, Sai Prakash Ranjan wrote:
> > Hi Doug,
> >
> >>
> >> I guess to start, it wasn't obvious (to me) that there were two
> >> choices and we were picking one.  Mentioning that the other
> >> alternative was way-based allocation would help a lot.  Even if you
> >> can't fully explain the differences between the two, adding something
> >> to the commit message indicating that this is a policy decision (in
> >> other words, both work but each have their tradeoffs) would help.
> >> Something like this, if it's correct:
> >>
> >> In general we try to enable capacity based allocation (instead of the
> >> default way based allocation) since that gives us better performance
> >> with the current software / hardware configuration.
> >>
> >
> > Thanks, I will add it for next version. Let me also go poke some arch
> > teams
> > to understand if we actually do gain something with this selection, who
> > knows
> > we might get some additional details as well.
> >
>
> I got some information from arch team today, to quote them exactly:
>
> 1) What benefits capacity based allocation brings over the default way
> based allocation?
>
> "Capacity based allows finer grain partition. It is not about improved
> performance but more flexibility in configuration."
>
> 2) Retain through power collapse, doesn=E2=80=99t it burn more power?
>
> "This feature is similar to the standard feature of retention. Yes, when
> we
> have cache in retention mode it burns more power but it keeps the values
> so
> that when we wake up we can get more cache hits."
>
>
> If its good enough, then I will add this info to the commit msg and post
> next version.

Sounds fine to me.  I was mostly looking for a high level idea of what
was happening here.  I am at least a little curious about the
retention bit.  Is that retention during S3, or during some sort of
Runtime PM?  Any idea how much power is burned?  Unless the power is
miniscule it seems hard to believe that it would be a net win to keep
a cache powered up during S3 unless you're planning on waking up a
lot.

-Doug
