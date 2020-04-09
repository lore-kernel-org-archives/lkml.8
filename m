Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA42C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D585520730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH+iUENs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDIJ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:56:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47016 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDIJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:56:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id m19so5415379lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmpXYqbqn6hu5HmQg9baYh3BhcraoFFV2QM1waztJBc=;
        b=kH+iUENsVoHCN21uy8fVrGIfDSBU4srBeYf5uN8s5rktiiZFZq65dEGOiTx4I0JYws
         M7Ao+tMNId33nCNOXnkkOt9aUyq0joE45lLsYLACB3Vl8Csu6Gd9RXJpd9GIs2URyt/M
         sXsXsGp0Z0eugPnv6oNvW82t0kY0oxQ9sk2I5V1UHU0xLk9f6DXJAUt4vX4630d6i+YO
         nruY5dOcvHTzZv43i5QvrtdOk4K3JMCpk/1XVZfSi1V+xmHLsnY9rybSauzX4SM44Vrm
         MzI/z8iqWFe3JGhAwMhR38UZ9K1M8f7bd/F9VekFo62XUU6Z5uIESluXN0lomRXqNjDb
         vPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmpXYqbqn6hu5HmQg9baYh3BhcraoFFV2QM1waztJBc=;
        b=bPBocGH5CkGLPUkbRIVU1YleCLVE/BApq7WOEVrzeSSEcU8OOKDsoLC1GXP5+fJegm
         F/at6kTtQnSG4xq1XCijmrTimMd/ZNfM2gpQeekiRrs9UQ1kGxFvJCXdD0jGHNEbNj5A
         ifwFodjLAehbaio9lDW+87QLCriZimMIpf1NhnLHWLJDxpI/6msKWRf+WQ5MwtrgD+mX
         yUwvBs9Jg//Gb5sZoUzG7ZM6l6xHTwoYG3LpmXyInL+R7XrO8qeysZEBwga+US+OVBt2
         PBTrUAUQqmJ6jCGLGa4UvprsmtvTN14k/enW2qUUb2bLpv3O7LRHLUB3WHRQ1Syy+S+o
         9NkQ==
X-Gm-Message-State: AGi0PuZQlYivAmO19yQV7ViJPuN2AQupxnnSm83ysCYZQqdQOxn8210G
        Ap2l/gdv48xByikpUncsa1CzysqvCSG4xXs/s+A=
X-Google-Smtp-Source: APiQypIE5oKLgR90Ki9XINj494PWwKFabwLLzVGjj6aGuRbmE+6+ELUABmPYlGoCyrvROb0rbcXvFOub4UsYC6aSZrk=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr7303909lfh.90.1586426197268;
 Thu, 09 Apr 2020 02:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <CAK8P3a1rWuL-mSeFBN0Dk7u3wnDmPgknEM3Em734KP64-Wv0ZQ@mail.gmail.com>
 <CADBw62qEfdLM9e2oyPKz1qRk4mZaFPbXRYpLfVHzxKj0Cz90kw@mail.gmail.com> <CAK8P3a3rFKVukWk7U1abHnW4a-5TV4e57f=9Lt9Xbfytm7H09A@mail.gmail.com>
In-Reply-To: <CAK8P3a3rFKVukWk7U1abHnW4a-5TV4e57f=9Lt9Xbfytm7H09A@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 9 Apr 2020 17:56:25 +0800
Message-ID: <CADBw62oGRPhhA4pRJXZ=1s5pt2FEYps=cSK+RG+doWE9owDqZw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add new reg_update_bits() support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 5:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 9, 2020 at 11:40 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> > > It would be nice in theory to move the sigmatel devices over to
> > > reg_update_bits() in theory, but this seems unlikely to actually happen,
> > > given that these are mostly obsolete drivers at this point.
> >
> > I checked all sigmatel devices (about 10 drivers), I think there will
> > be more work to change them to use syscon/regmap when changing to
> > reg_update_bits(). I am afraid I can not thelp to convert them without
> > a hardware, and as you said, some drivers are already dead. So I think
> > it would be nice if the driver owners can help to convert these
> > drivers, if we get a consensus about the reg_update_bits()
> > implementation at last.
>
> Thanks for taking a closer look. I didn't want to imply that you should
> fix them, just saying that it might have been nice if they had been
> done like this in the first place. Of course, when the drivers were
> written, we did not even have the regmap-mmio helpers at all.

Make sense. Thanks.

-- 
Baolin Wang
