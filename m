Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B1C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCCD207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBIbRLfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgBTXmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:42:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46682 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgBTXmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:42:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so365586otb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mr+VHjynLMEANny/0nIV3zWD+WyLvlUkqaeAfl5xCHA=;
        b=qBIbRLfEmXAwjIXDvpxdYIRzNMtY3UQKtvB38sFBD0D3GkgID7LfoWml9YTm6+Rm3a
         z6Y7sseBYWs7Y7XEBfql0NZRAcQWHvbdl2Y8wr8gqfwbukDGsZqX8eqSl8TYAvhgyo0t
         oTRn3nlSfdeAIYbsGgIDwfDB3nZk1LvcRqdU2hsNCMM8YtWQGpAnHu4spxWYf5H8tzKV
         H8WagXKn1AO3+ab3Qo4W0/qaOLdA8dZcwEKaXmPSxVplvd4ORjf38lZLQ5nB9m74bzvM
         X+G4lAMKXtT7eTwqpZPDCEaPvotvCALpOqDxwabMZml5lwOZ7C619bxA95Gi8b2fdNEW
         i6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mr+VHjynLMEANny/0nIV3zWD+WyLvlUkqaeAfl5xCHA=;
        b=lrUuraUaQZxB3mTvzQ7cAeZc+42gCxiu435qzf5kxGkLbXXfxkV5ZFHyexYJFLBJWy
         zfyGuCDm5YZc0ygCBNs3rtXNYjC9GOLKlvB9HbMlRZ51Mex+SSkhD55csRVT01InZ+cA
         IOZsUQ0bOeFNtq4c0IisDalxYP8qqlmRfqXik6rxp/7A7c1iRuVBO55c+9FczQNFfOwP
         nBepCUyMxeIwv95F78tCxm5kOECrDaH2F/alOLBrt+uVqMGudh4Cz4OeFfrohu93P8E/
         vaRXeG+Rj8q2Uz60LH/y2cYFS0ovxm39tXemshkxxpaWE2sQWaaepJKTnMNO25TiqvhM
         rJNA==
X-Gm-Message-State: APjAAAWrut+Seg/VHELXaFgGq4LTNo9fDuD3G0v1ghe/UUcPrGnFVpCQ
        hO2tBIS99AGktG+poAYpf1bUob8JVeRW2WmmCkppYA==
X-Google-Smtp-Source: APXvYqyfbkpMNarbih+y6wE69usN/6K9JSA+So1IbETqWBHfyAogAnfC6t6LgYF0Pq3+ixOAylZgBPrf5jqGV5Jj7hU=
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr24416922otq.221.1582242140757;
 Thu, 20 Feb 2020 15:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-2-john.stultz@linaro.org> <20200220234013.GA1544@amd>
In-Reply-To: <20200220234013.GA1544@amd>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 20 Feb 2020 15:42:08 -0800
Message-ID: <CALAqxLVxx6UFtv0+DcH4t7YhZ4Nmnq9DSyqPMyot=N8VFMowTA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] driver core: Fix driver_deferred_probe_check_state()
 logic
To:     Pavel Machek <pavel@denx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 3:40 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * If deferred_probe_timeout is not set (-1), it returns
> >   -EPROBE_DEFER until late_initcall, after which it returns
> >
>
> You may want to complete the sentence here :-).
>

Yes. I somehow cut the line accidentally. Its already fixed in my tree. :)

thanks for the review!
-john
