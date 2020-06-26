Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57E020675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+9YB76F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgFZJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFZJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:10:05 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF6C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 02:10:05 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so7798396ili.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/eCHD5MeGyOQruj1/qugTRXIeBr6V4nhgfDuOP4Euk=;
        b=o+9YB76F7krnJluMLNWELB+8rA30o+GOlyeCy4l6qx16wReY6Q06BQ0AwNAtKKS+qc
         P9a/BdPFlH/vdhrQpkWfXQorsAZdvnc0tBalo9ESV/gX4DjetZuSwpA68KjBjezlyT9P
         psD0EXlI4bSNt9om3gI78DMeqXqi65cKMe0y3SeKV8nDBONSmj3JB0D7EEypUAwyNqez
         mFutQg2XGC6WtkVaS4iMhqk4YicsH3PPbUjRZt/zJ5qSyOZw4mEJ8fdYyv9J4pmdm3xD
         nasy564VPalfcXLDH0ftUJcz645Ce1rIaAj10AjUeNNxc8Bb2hbE7fvBiTzP7YHs3Y7I
         Xlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/eCHD5MeGyOQruj1/qugTRXIeBr6V4nhgfDuOP4Euk=;
        b=WqZOlSKJS33D+OqFFuGJwRxrdvBgm/oYSFnLYIxz1p1CubGyob+yKPpj5XnwD1YO+o
         mYj6SVZhZQ51iGQVVSEKg8ZDXirYYuKdYHelQ9VrfDjufxGMyzwXFt+Z1i3MPEykcab5
         YKC5/ZGJOwy6WxWOczshIH9+iGnQxzEIMYiPvrh2tn3xZWV64RijIspwbdoAFGLTu3oP
         fjH/Zr9hwsMpTycg7rhyfvDC+muos09OtkHGu0R0yvjXS/kb/VqsrMii2t+FSwOWKikG
         TX6qeJybPFGkz4lU5hwcfxBf1jYKyY7TFrn5OhegXiv4Vy9S4JCyr96Fw4KjgzJmluYn
         0hDA==
X-Gm-Message-State: AOAM530ZCMCiKfYiGXtReKuNCv9ezCZDPK8DG35z8riM7wPi66veFvgn
        kAsxsHYJwjjWMjJjxyzoNuqJw+BCAN5BjMwVMro=
X-Google-Smtp-Source: ABdhPJwVmrDkI52G+/gipVEhsgJfsB0+JF+HXsKswCwh23NA9KXyCDczaGNwR/DEjPFtA5jeZ+z605ev2K3t/yvHb6w=
X-Received: by 2002:a92:cecd:: with SMTP id z13mr2107054ilq.76.1593162604839;
 Fri, 26 Jun 2020 02:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
 <CALeDE9N0gbYRKbmoPYF73VNr=Q9UetP+fpYFbhWfVsUZL+GkWA@mail.gmail.com> <8e2040e2-9faa-cd95-c474-eb2fa2c7c6c0@gmail.com>
In-Reply-To: <8e2040e2-9faa-cd95-c474-eb2fa2c7c6c0@gmail.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Fri, 26 Jun 2020 10:09:53 +0100
Message-ID: <CALeDE9OwtiG2cBxeyoDdJ6g9EXZBi6MbS+MNUh-JiVod3o-3xw@mail.gmail.com>
Subject: Re: [fedora-arm] Banana Pi-R1 - kernel 5.6.0 and later broken - b43 DSA
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Gerhard Wiesinger <lists@wiesinger.com>,
        arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, filbar@centrum.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 5:42 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/25/2020 4:23 PM, Peter Robinson wrote:
> >> I'm having troubles with the Banana Pi-R1 router with newer kernels. No
> >> config changes, config works well since a lot of lernel updates ...
> >> Banana Pi-R1 is configured via systemd-networkd and uses the DSA
> >> (Distributed Switch Architecture) with b53 switch. No visible difference
> >> in interfaces, vlan config, bridge config, etc. Looks like actual
> >> configuration in the switch in the hardware is broken.
> >>
> >> # OK: Last good known version (booting that version is also ok)
> >> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
> >> armv7l armv7l armv7l GNU/Linux
> >>
> >> # NOK: no network
> >> Linux bpi 5.6.8-200.fc31.armv7hl #1 SMP Wed Apr 29 19:05:06 UTC 2020
> >> armv7l armv7l armv7l GNU/Linux
> >>
> >> # NOK: no network
> >> Linux bpi 5.6.0-300.fc32.armv7hl #1 SMP Mon Mar 30 16:37:50 UTC 2020
> >> armv7l armv7l armv7l GNU/Linux
> >>
> >> # NOK: no network
> >> Linux bpi 5.6.19-200.fc31.armv7hl #1 SMP Wed Jun 17 17:10:22 UTC 2020
> >> armv7l armv7l armv7l GNU/Linux
> >>
> >> # NOK: no network
> >> Linux bpi 5.7.4-200.fc32.armv7hl #1 SMP Fri Jun 19 00:52:22 UTC 2020
> >> armv7l armv7l armv7l GNU/Linux
> >>
> >>
> >> Saw that there were a lot of changes in the near past in the b53 driver:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/dsa/b53?h=v5.8-rc1+
> >
> > So from your notes above it looks like something regressed between the
> > 5.5.x series and the 5.6.0 release? If so I'm not sure what the
> > context of the changed in 5.8 are here. If there's more changes to the
> > driver in 5.8 dev cycle have you tried one of the Fedora rawhide 5.8
> > rc1 or rc2 kernel builds to see if that resolves it?
>
> See my response to Gerhard, there are changes expected to how the
> network configuration should be done after:

It appears your response was off list, and he had follow up questions
and I don't see a response from you.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fab459e69abfd04a66d76423d18ba853fced4ab
>
> >
> > Failing that looking for the change in the 5.6 cycle would likely be
> > the better bet so we can work out what broke it and report it to the
> > upstream driver maintainer. Have you searched to see if others are
> > seeing a similar issue or have reported a similar issue upstream?
> >
>
> Gerhard is doing exactly this with his email.

No, I asked if he'd searched elsewhere to see if others are having
problems, like other distros etc.
