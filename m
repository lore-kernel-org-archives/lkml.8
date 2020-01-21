Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A087BC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7843E2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfQ8Yf58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgAUMCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:02:01 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42237 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:02:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id b79so1534009vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlDPGUCXlEVeTcZhHawX07d2lxqh/Mdp7/s77E+/zJk=;
        b=DfQ8Yf58JeljkgTbS9a3cao8ML5+qV3DAnHkunbr6P8ZYoE8SUvNa1Rf0hVrg43uKJ
         kqX0jYwwVIB8lTLwl8EbNxpWl1YtOU3tCQOMd1IX7BfJ0T+LwkxMPMll8T6cmu0ah5rq
         NNLC5WfsRD5iyXp1L9pfxQu9gdjwVUdO1glJ1maM+uYHzZAXRpIqt4PAib1HaoDkODN0
         jcm3IlJ5gksSzosGgVcDcYW16DhgnzTqWvQO9CCv9B/kcJbh91U4vGPQUeYd3qDbo2V0
         xgZv0VOsjmkqWYX+6LdS0cyPzdLRxiFD5rWCijz6aSl1+wlg2PAjECRYhAiHRs0CdPBO
         cZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlDPGUCXlEVeTcZhHawX07d2lxqh/Mdp7/s77E+/zJk=;
        b=kGjwfSqbjUF8kz9Zvsq4NYTFenPrV57Us6UiUFtw54/PbLQG4VeCwcwjFfyC5G4A7S
         FQtLBxrKPDCDqCdvZc9QZvMli0Ep6ZFXiRbjpwpSqivT4ah+4IAPqgYtxgCE5tbPJ3E6
         KjDEJLpu3P3RonFPvsdEaQ5F2HGa0exxWw6tkhASPRV3jH+No4yEl2kunQ9uhBNevh2Z
         WJS/0Wo0Qmbd+ImRhlPZhVp0s4XHMAMsaryCOkbxnOHvIhthmRPFL4TfkBV2N3qyYgJj
         FVAQva72yqDNM0VSj2wHxAFErwnMvEf6rfE+nRzh4yBkq3vcT0hiTeUF5be+4ZDLAU/K
         IzYQ==
X-Gm-Message-State: APjAAAWoDkeHfmmaEI6uPNY8yqyFVdkk50FF1Cg+EZ5H+5JYj2jrQz+V
        LusRylaL/CStPL0sQuUlQA96tVA656yO7l/Ia/dOPw==
X-Google-Smtp-Source: APXvYqz2LEHuJMC+X8IU73bToBskn+ELWXDHBTXmfrBQoD8n5OvOsFOieWKumRukn3ny3dcoDaCxoZahX5z/weTMUNA=
X-Received: by 2002:a67:cd96:: with SMTP id r22mr2417118vsl.165.1579608119447;
 Tue, 21 Jan 2020 04:01:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578560282.git.benchuanggli@gmail.com> <CACT4zj9B8BSebZgf5-nc3zGYhsAGQ6gTRvfFf9r1DBB_mpRtHA@mail.gmail.com>
In-Reply-To: <CACT4zj9B8BSebZgf5-nc3zGYhsAGQ6gTRvfFf9r1DBB_mpRtHA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Jan 2020 13:01:22 +0100
Message-ID: <CAPDyKFpVN1w7sRbcSAOezVYAkq0pq6kCFo0gjT3TO4FVqDCe=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] Add support UHS-II for GL9755
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 10:37, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Uffe and Adrian,
>
> On Thu, Jan 9, 2020 at 5:13 PM Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Hi Uffe and Adrian,
> >
> > These patches support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > The parts of UHS-II are based on [1][2] and porting to Linux 5.5-rc5.
> > I have seen that Uffe comment that splitting the UHS-II parts into smaller
> > patches. Other than splitting into small patches, could you give me some
> > suggestions for refactoring/splitting files?
> >
> > Best regards,
> > Ben
>
> Gentle Ping, Any comments?

I coming to this, but I need some additional time. In any case, thanks
for posting this and for pinging!

[...]

Kind regards
Uffe
