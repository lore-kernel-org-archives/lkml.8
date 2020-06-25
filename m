Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D23C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A942081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1vRHXhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407784AbgFYXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406866AbgFYXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:23:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:23:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e64so3005970iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 16:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyyZOuZX38QbPacNjXd2wzVJ/i/9nFUqGqcfWHXw8Z4=;
        b=G1vRHXhKfudkpwbvZLZehPjfot0Cx21BOzNTPxAT6vHSK8CbKfoY0ueiGcQ796AiL8
         xbA3ukt+TN02A4CfhzZ+yMo94Olkn7rc0Gckz08oCm26fRzwZM5pVykQMgv/t3q754xl
         3CA7m79ZDUUoWfNL5fjl4zEKCs+2Pk/0XWKhZhWOq+cmdzb+RID5O0xnF2o6FQRv24QW
         JfEE1Tr2G7ITXKWdwa0uQ+OXI70Mk1jKxMqOnEDkhE9unhMPiZRQgBEFhtkBSWhMRgTA
         KxNNhypN6trrrC+B8ZBcU62EFKE+s9DMx0Tx2DtjXOy22tgm+lJkEqVrNMWxAARg9FWL
         ZLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyyZOuZX38QbPacNjXd2wzVJ/i/9nFUqGqcfWHXw8Z4=;
        b=Tu6GBN0tmtJBfcwUKvmiupIrNxDvpnztcxcJUOJC9F3C37oju3fqiYm2WJhjdDyU9F
         3SOI5rNUDRtXZiqJkbVKIq7Rvl2YWy5jDkrvfbBzy6vdlhk52YRgCZF2m/ueRwBcSpPz
         AqastMuazZ3nTEC9jZywtpA9imRHeqKnotoSlVDaDs8dj/HGEprdfmuLt9IsK+DbQMDJ
         yWwniZJAGOntS59YBi79j0Q5Tl7/GQMGjWzDy1aN57uqLBxlUIhQYeAjdsJoqihN+qKp
         5OGuPqaSqqFzeghMDc9ONIPqFUxXnlCrxHQMUjSPKZq2K4xRzLQeYQGnc+mhwVmHK4tt
         h1Yg==
X-Gm-Message-State: AOAM530A1fsk2j+9YhmdGOxfDbCvZtA4dATRXpCowdY4takVyawXUrNH
        S0tVF0pWvVM4XSjGeh7TCCA2T1l9CYX6j7NgwLc=
X-Google-Smtp-Source: ABdhPJxgoTWxBzXlXV8iqMm1jsdJB6/N20+4vg5uEdnQBRLXLPMAkTdRvu/y07KVwGnS6VgeYQuARKc3lwBV6mfiyxY=
X-Received: by 2002:a02:6a1a:: with SMTP id l26mr569818jac.66.1593127434687;
 Thu, 25 Jun 2020 16:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
In-Reply-To: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Fri, 26 Jun 2020 00:23:42 +0100
Message-ID: <CALeDE9N0gbYRKbmoPYF73VNr=Q9UetP+fpYFbhWfVsUZL+GkWA@mail.gmail.com>
Subject: Re: [fedora-arm] Banana Pi-R1 - kernel 5.6.0 and later broken - b43 DSA
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having troubles with the Banana Pi-R1 router with newer kernels. No
> config changes, config works well since a lot of lernel updates ...
> Banana Pi-R1 is configured via systemd-networkd and uses the DSA
> (Distributed Switch Architecture) with b53 switch. No visible difference
> in interfaces, vlan config, bridge config, etc. Looks like actual
> configuration in the switch in the hardware is broken.
>
> # OK: Last good known version (booting that version is also ok)
> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
> armv7l armv7l armv7l GNU/Linux
>
> # NOK: no network
> Linux bpi 5.6.8-200.fc31.armv7hl #1 SMP Wed Apr 29 19:05:06 UTC 2020
> armv7l armv7l armv7l GNU/Linux
>
> # NOK: no network
> Linux bpi 5.6.0-300.fc32.armv7hl #1 SMP Mon Mar 30 16:37:50 UTC 2020
> armv7l armv7l armv7l GNU/Linux
>
> # NOK: no network
> Linux bpi 5.6.19-200.fc31.armv7hl #1 SMP Wed Jun 17 17:10:22 UTC 2020
> armv7l armv7l armv7l GNU/Linux
>
> # NOK: no network
> Linux bpi 5.7.4-200.fc32.armv7hl #1 SMP Fri Jun 19 00:52:22 UTC 2020
> armv7l armv7l armv7l GNU/Linux
>
>
> Saw that there were a lot of changes in the near past in the b53 driver:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/dsa/b53?h=v5.8-rc1+

So from your notes above it looks like something regressed between the
5.5.x series and the 5.6.0 release? If so I'm not sure what the
context of the changed in 5.8 are here. If there's more changes to the
driver in 5.8 dev cycle have you tried one of the Fedora rawhide 5.8
rc1 or rc2 kernel builds to see if that resolves it?

Failing that looking for the change in the 5.6 cycle would likely be
the better bet so we can work out what broke it and report it to the
upstream driver maintainer. Have you searched to see if others are
seeing a similar issue or have reported a similar issue upstream?
