Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F84C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933F520678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IDP378Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbgDBUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:14:38 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36878 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388148AbgDBUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:14:38 -0400
Received: by mail-vs1-f66.google.com with SMTP id o3so3424567vsd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xnVk01EXqzg7moA4R1yAW9PPXebyh4g8UETIH3Gq/E=;
        b=IDP378Q/VvOE2mD9ZMEgZg6Z1NnCKss4dfxlUumNJhwIKibnLnUWx6Ipu5w2nFNGS9
         tny5YIJ+kPWqMna/I7tp4bFp4lJVUccz4q9Sh2C4rbD11PpHkIG/IsaN0k2iPdzE/sxa
         Dd6vyDJpxsmtUysn8dvyLRARqbr9P9fZpsoM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xnVk01EXqzg7moA4R1yAW9PPXebyh4g8UETIH3Gq/E=;
        b=mBJEYiJD6bz9fZK32feEDK5kCYG9tDvidqYf+Ht+vsVOVNAfHqmTiW5DuH0MVvC+xQ
         jUjEVDCmXIfCcazcofNTW2rdBsIJIfaDlQ7kGra+xdugbOow8N2ZvZtyxxVgIYWkOYkX
         xmhxDqaeuXKrLwPOUOJP+5z7eBBZxPEUbv5+w3saWpjAznpCd+jvm1IHbMdQgFDoMO5F
         +E9WAX/lBrA8a+g8NgkgN1CXf3zXh2cmc+ptCFnPGZURd24wkK2j2Y2UcoM0TJlTh0VW
         wQSlhVO8I/QqveA6d7o1+FUwCSt5phLd886ChjbxO52gWHRVhHHerX972ErxGa96SlKJ
         tgdw==
X-Gm-Message-State: AGi0PubhXLoXo8mlQOvVavP+5UDx94MFSWtZ4PhggmxIptgvG7dXOWJQ
        0srt/A0G5shVKOl9jCo4EEEXael0vK4=
X-Google-Smtp-Source: APiQypJmTAt3ItRoqD3SuP7fUH4Ofjn6O0U+IFAMkGeN/xGf82synVanIgO1VaZ+OIkfM2RhFs8W7g==
X-Received: by 2002:a05:6102:10dd:: with SMTP id t29mr4051196vsr.229.1585858476434;
        Thu, 02 Apr 2020 13:14:36 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id g135sm1665254vkg.48.2020.04.02.13.14.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:14:35 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id w14so3420220vsf.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:14:35 -0700 (PDT)
X-Received: by 2002:a67:2c81:: with SMTP id s123mr4049018vss.198.1585858474864;
 Thu, 02 Apr 2020 13:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1585660782-23416-1-git-send-email-mkshah@codeaurora.org> <1585660782-23416-7-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1585660782-23416-7-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 13:14:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UqaTR7=i=5BApvnptZXpqVJiF1AE+Q+6H9Y4QdYfjfUQ@mail.gmail.com>
Message-ID: <CAD=FV=UqaTR7=i=5BApvnptZXpqVJiF1AE+Q+6H9Y4QdYfjfUQ@mail.gmail.com>
Subject: Re: [PATCH v15 6/7] soc: qcom: rpmh-rsc: Clear active mode
 configuration for wake TCS
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 31, 2020 at 6:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> @@ -243,6 +279,14 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>                 }
>
>                 trace_rpmh_tx_done(drv, i, req, err);
> +
> +               /*
> +                * If wake tcs was re-purposed for sending active
> +                * votes, clear AMC trigger & enable modes and
> +                * disable interrupt for this TCS
> +                */
> +               if (!drv->tcs[ACTIVE_TCS].num_tcs)
> +                       __tcs_set_trigger(drv, i, false);

Still seems weird that we have to do the untrigger in the IRQ routine
here and also weird that we _don't_ do it in the IRQ routine for
non-borrowed TCSes.  I guess it's not the end of the world, though.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
