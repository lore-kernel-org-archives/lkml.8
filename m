Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D2C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDC2221F6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD2AULqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDFNAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:00:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41400 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgDFNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:00:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id z23so11746266lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaRtA1Jxq4FuD6KqIBhNnRMRisYsJA5aLAs60fjZD2Q=;
        b=rD2AULqSP96WxjXaqAFp5EsQfPhsFzhnNWBb8t2W/fTRDZ4yomA7CMj74SfCjCGPfr
         B/Ilxh+VR73N/yBlOUaLew5ENt0LqEJR/0252PKKN/vc/3wspe4donmTh2zcWSVH9v1V
         CijhHhY4atIh1Avty7uGZYDLi0sezXPX6t0rZQMcnBRFc76hkXGZHInYAI63UiW+wbQ8
         NbEthKqfcLUYQDUuAyhONVCYhn1IAkM2dB+VeAIkkPl7fhzacMVYKGCSFpr++ME88JnU
         eEWuQMML8MKSGEUELb5W/Td4Bg057bP8H9NIN65XVJxCzTcgOQNpP1DUVjIBmIIuUl9j
         bl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaRtA1Jxq4FuD6KqIBhNnRMRisYsJA5aLAs60fjZD2Q=;
        b=FRb2K7hs7Yj1wbjTl3vzyzjyj/EDnU3TEI21JwalwucUexGunweR+uv1XV2Sy4fO8H
         apyPQdIXsZodrydoGGYJ+8zdrd0Bfo3AWPWN7xLXdn9eYjlaI2AUMJhE9WsowCJYbT3/
         MPHassxM3VvccMmfHw73VfYOcRvY0yU8Ttf5ZeNLTYph0eYwUJ5K1w/tOpD07N1NqsgG
         0U49441WnFAWkZgjLLHCRdsWMeRb7xjuZ2SofVNZ0wc/+VwkuMwcnKkJMz+ARvZG8p1t
         ZpBBFQktefU85Bn+lTPgED+Lmn91e9Bd/cjL2pXjr8Vv6hKagKUdfKDPKhfcu/FGtPId
         QLqA==
X-Gm-Message-State: AGi0PuZPhAnUfdh6H3tEbDa4z9HTMgO5y3RctowXxHDjtznCqSzybZdV
        3rAqTzJ2yrX2E/WkoyK4rWgvTANqTkGQRCSe16q1tw==
X-Google-Smtp-Source: APiQypKWLxaOr2JwxPFRIKy8DyIk+GnLoWmCpZts1WGuVzegc2XBLTsdqA1LYFKaM6QY1KoWLGPuGNAn7rVqCVucQYw=
X-Received: by 2002:a19:6749:: with SMTP id e9mr12526614lfj.122.1586178012739;
 Mon, 06 Apr 2020 06:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <1586175677-3061-1-git-send-email-sumit.garg@linaro.org> <f2a393a2f01c93776446c83e345a102a780cfe88.camel@sipsolutions.net>
In-Reply-To: <f2a393a2f01c93776446c83e345a102a780cfe88.camel@sipsolutions.net>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Apr 2020 18:30:01 +0530
Message-ID: <CAFA6WYPBef1w2YG8vDTnRK9N3Tjt-vQahpYd61H6twsRuT8YZw@mail.gmail.com>
Subject: Re: [PATCH] mac80211: fix race in ieee80211_register_hw()
To:     Johannes Berg <johannes@sipsolutions.net>
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

On Mon, 6 Apr 2020 at 18:14, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-04-06 at 17:51 +0530, Sumit Garg wrote:
> > A race condition leading to a kernel crash is observed during invocation
> > of ieee80211_register_hw() on a dragonboard410c device having wcn36xx
> > driver built as a loadable module along with a wifi manager in user-space
> > waiting for a wifi device (wlanX) to be active.
> >
> > Sequence diagram for a particular kernel crash scenario:
> >
> >     user-space  ieee80211_register_hw()  RX IRQ
> >     +++++++++++++++++++++++++++++++++++++++++++++
> >        |                    |             |
> >        |<---wlan0---wiphy_register()      |
> >        |----start wlan0---->|             |
> >        |                    |<---IRQ---(RX packet)
> >        |              Kernel crash        |
> >        |              due to unallocated  |
> >        |              workqueue.          |
> >        |                    |             |
> >        |       alloc_ordered_workqueue()  |
> >        |                    |             |
> >        |              Misc wiphy init.    |
> >        |                    |             |
> >        |            ieee80211_if_add()    |
> >        |                    |             |
> >
> > As evident from above sequence diagram, this race condition isn't specific
> > to a particular wifi driver but rather the initialization sequence in
> > ieee80211_register_hw() needs to be fixed.
>
> Indeed, oops.
>
> > So re-order the initialization
> > sequence and the updated sequence diagram would look like:
> >
> >     user-space  ieee80211_register_hw()  RX IRQ
> >     +++++++++++++++++++++++++++++++++++++++++++++
> >        |                    |             |
> >        |       alloc_ordered_workqueue()  |
> >        |                    |             |
> >        |              Misc wiphy init.    |
> >        |                    |             |
> >        |<---wlan0---wiphy_register()      |
> >        |----start wlan0---->|             |
> >        |                    |<---IRQ---(RX packet)
> >        |                    |             |
> >        |            ieee80211_if_add()    |
> >        |                    |             |
>
> Makes sense.
>
> > @@ -1254,6 +1250,14 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
> >               local->sband_allocated |= BIT(band);
> >       }
> >
> > +     rtnl_unlock();
> > +
> > +     result = wiphy_register(local->hw.wiphy);
> > +     if (result < 0)
> > +             goto fail_wiphy_register;
> > +
> > +     rtnl_lock();
>
> I'm a bit worried about this unlock/relock here though.
>
> I think we only need the RTNL for the call to
> ieee80211_init_rate_ctrl_alg() and then later ieee80211_if_add(), so
> perhaps we can move that a little closer?
>

Sure, will move rtnl_unlock() to just after call to
ieee80211_init_rate_ctrl_alg().

> All the stuff between is really just setting up local stuff, so doesn't
> really need to worry?
>

Okay.

-Sumit

> johannes
>
>
