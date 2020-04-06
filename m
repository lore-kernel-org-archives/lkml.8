Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0DCC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2155A23107
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0+b59CK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDFNVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:21:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36393 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgDFNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:21:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id b1so14668901ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjFMtmuU3xHuzoUFWq9Y0DhLjc0PE8fgYoHAQmkfrZE=;
        b=q0+b59CKCMf16lfCFCrz+8Vga8AQbbnlul6SAAPiEK6Z40MhjCJl5lMXZGjeOIR4sj
         WXFXqWqaxBwiuX3ek3W41llkgTTwVBk0Gv7UwLunZB1ahYNl0fas+Fwmv4Go9rCdrnnR
         vOc3SPVG2rXgARf8j1lZYXSHapc7lXi7u1sv3/a1uBGyF6PET55UO7ry3TIxoItAriBJ
         6QOpxQ19v5kFVg5xKS1C/k4iUoZc0gERXlmZLjjgNfO8i8DxiUNfc57UbPzoCRalcWxQ
         ew1SyBeJ86G4p5AOKyX4AnoqTRKsh4lVSSWA85IA6oQdkwHuhsnIgCDpqu0FRCuceiaa
         Ko0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjFMtmuU3xHuzoUFWq9Y0DhLjc0PE8fgYoHAQmkfrZE=;
        b=cDi9Cr5oIsgeLscZRswiuAFL671bY8o26DO4FRWEQOL5YSgJBxgZa8oRaywoy72rOC
         ncD0Nx4vpfBBi6feJZamCylQXeRelM30n2nf0DSB2VYnHXN4tSZxgu7JdDuveqNb+xrg
         zZzItAEmU9/5I/pmMKFeNoEHQC8MaZ44zqrIk263SljyOmmd+I8eCgE9VO7BNrl6MKzC
         Si7MYyb5ENtWKfa6KeE8wavZzT6oVekQabYRTgW2zJ8+rsWGy678cBb7i0z1HUZM/+ja
         O2fb74DuknSbw99fo6QmNvnMYzBTu8ERdrFlbZcEkC6Dr+/T6d5WGMSGSJ9EzFwG5SEA
         gEjA==
X-Gm-Message-State: AGi0PuabJE6uHP+0tcProIyUqBnL2LOXdAC9kJnN1bqdX3P6dRg0LH87
        QFvK+Ofg2CFnl1qKDulYSLhN5bzAkwvjf5ebtsc9Cg==
X-Google-Smtp-Source: APiQypIZr3Wr7gU6HfYZ2DPp4KYZRoMiMMIzh0ZeGpLkLlpRcwTmLnmLC682+JLbzmgWhr4LrLDmlXima8G8ek4WTDk=
X-Received: by 2002:a2e:8093:: with SMTP id i19mr12191984ljg.12.1586179276126;
 Mon, 06 Apr 2020 06:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <1586175677-3061-1-git-send-email-sumit.garg@linaro.org>
 <87ftdgokao.fsf@tynnyri.adurom.net> <1e352e2130e19aec5aa5fc42db397ad50bb4ad05.camel@sipsolutions.net>
 <87r1x0zsgk.fsf@kamboji.qca.qualcomm.com> <a7e3e8cceff1301f5de5fb2c9aac62b372922b3e.camel@sipsolutions.net>
 <87imiczrwm.fsf@kamboji.qca.qualcomm.com> <ee168acb768d87776db2be4e978616f9187908d0.camel@sipsolutions.net>
In-Reply-To: <ee168acb768d87776db2be4e978616f9187908d0.camel@sipsolutions.net>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Apr 2020 18:51:04 +0530
Message-ID: <CAFA6WYOjU_iDyAn5PMGe=usg-2sPtupSQEYwcomUcHZBAPnURA@mail.gmail.com>
Subject: Re: [PATCH] mac80211: fix race in ieee80211_register_hw()
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Matthias=2DPeter_Sch=C3=B6pfer?= 
        <matthias.schoepfer@ithinx.io>,
        "Berg Philipp (HAU-EDS)" <Philipp.Berg@liebherr.com>,
        "Weitner Michael (HAU-EDS)" <Michael.Weitner@liebherr.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 at 18:38, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-04-06 at 16:04 +0300, Kalle Valo wrote:
> > Johannes Berg <johannes@sipsolutions.net> writes:
> >
> > > On Mon, 2020-04-06 at 15:52 +0300, Kalle Valo wrote:
> > > > Johannes Berg <johannes@sipsolutions.net> writes:
> > > >
> > > > > On Mon, 2020-04-06 at 15:44 +0300, Kalle Valo wrote:
> > > > > > >     user-space  ieee80211_register_hw()  RX IRQ
> > > > > > >     +++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >        |                    |             |
> > > > > > >        |<---wlan0---wiphy_register()      |
> > > > > > >        |----start wlan0---->|             |
> > > > > > >        |                    |<---IRQ---(RX packet)
> > > > > > >        |              Kernel crash        |
> > > > > > >        |              due to unallocated  |
> > > > > > >        |              workqueue.          |
> > > > >
> > > > > [snip]
> > > > >
> > > > > > I have understood that no frames should be received until mac80211 calls
> > > > > > struct ieee80211_ops::start:
> > > > > >
> > > > > >  * @start: Called before the first netdevice attached to the hardware
> > > > > >  *         is enabled. This should turn on the hardware and must turn on
> > > > > >  *         frame reception (for possibly enabled monitor interfaces.)
> > > > >
> > > > > True, but I think he's saying that you can actually add and configure an
> > > > > interface as soon as the wiphy is registered?
> > > >
> > > > With '<---IRQ---(RX packet)' I assumed wcn36xx is delivering a frame to
> > > > mac80211 using ieee80211_rx(), but of course I'm just guessing here.
> > >
> > > Yeah, but that could be legitimate?
> >
> > Ah, I misunderstood then. The way I have understood is that no rx frames
> > should be delivered (= calling ieee80211_rx()_ before start() is called,
> > but if that's not the case please ignore me :)
>
> No no, that _is_ the case. But I think the "start wlan0" could end up
> calling it?
>

Sorry if I wasn't clear enough via the sequence diagram. It's a common
RX packet that arrives via ieee80211_tasklet_handler() which is
enabled via call to "struct ieee80211_ops::start" api.

-Sumit

> johannes
>
