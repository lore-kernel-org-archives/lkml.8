Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC2C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB04420772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHQb2BZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCaRom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:44:42 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40736 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgCaRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:44:41 -0400
Received: by mail-yb1-f195.google.com with SMTP id a5so8079790ybo.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jR1ZIvGGpwr49EcYtbAyRYtsyb7fcIsCPTJgz8brLjg=;
        b=SHQb2BZb1NJwzySP/s/k9r0GQUXNdN+AowbsOZXgtxeugyf1Pbz5h9RYTfQ/txGmiz
         NW6n042eS9IZqgphrdA1Ix0kbn9I1Dcc9NfMaX1Oc352yj3IUPLpe6Ts7yzbDQTDV+ms
         wOMIWDEWIRPaVQTApzIEL2LXOw28qnygtqLrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jR1ZIvGGpwr49EcYtbAyRYtsyb7fcIsCPTJgz8brLjg=;
        b=ZApkTFPKiJ5eY84y71rFXXgtRGAHySkbe67p39kMqWKGMiGGBWi9EKHsp6rmQkboCV
         sp2JhiOSwyHsTLdwggywP7rcL8EMaJL+X1o70N2+LYXz5MB0bpoNJsj2a9ba1gs5H1bR
         ARayxLBzIhGL3UBBnmk0Nx5UkQxBK2WMQYvNHfaYXH5EDK5KUEcBO76mp3UQ/dqmzNqw
         xMjdltf5xkCaAiMsOFBvI//0Ev2WRyWy1LW3PDAKBHbyilsVq0pRZ5p/bzJuBc0vAHh4
         ZrsqaQgATdAhhRIipf/hA1gt3sEPVX6+u6H2mqiCYrko0rpCwfKjw1CgYvN3T/IeIzWC
         aiHw==
X-Gm-Message-State: ANhLgQ2/dkkWxwGSJkLz0WvZCwbkjY+RPeKpVF+H0HBT36SK8nuNVHFG
        FZJPmDkIJ4mnDX7RQL8Jmqi4H8dHwwUGooU3yTEv5Q==
X-Google-Smtp-Source: ADFU+vve5e1tGuJEA3r0In28yh8ZrkCmYIkMq/ET420MGqIwCwN7MftCJTiN7MqyF8fIt9NpdjXD9GAtvkLDqJQBdlo=
X-Received: by 2002:a25:6042:: with SMTP id u63mr31758293ybb.77.1585676679963;
 Tue, 31 Mar 2020 10:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da6059059fcfdcf9@google.com> <0000000000005b022005a22a0050@google.com>
 <20200331174116.GA1844017@kroah.com>
In-Reply-To: <20200331174116.GA1844017@kroah.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Tue, 31 Mar 2020 10:44:29 -0700
Message-ID: <CANEJEGuhZChGXFzbwaEwArM4UKjUxZo=WNbREPH3887xtu62Nw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in skb_release_data (2)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, festevam@gmail.com,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>, johan.hedberg@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-imx@nxp.com,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        marcel@holtmann.org, nishadkamdar@gmail.com, peter.chen@nxp.com,
        Prashant Malani <pmalani@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, shawnguo@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 31, 2020 at 10:36:01AM -0700, syzbot wrote:
> > syzbot suspects this bug was fixed by commit:
> >
> > commit d9958306d4be14f4c7466242b38ed3893a7b1386
> > Author: Nishad Kamdar <nishadkamdar@gmail.com>
> > Date:   Sun Mar 15 10:55:07 2020 +0000
> >
> >     USB: chipidea: Use the correct style for SPDX License Identifier
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d4940be00000
> > start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a66a7c2e996797bb4acb
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c25a81e00000
> >
> > If the result looks correct, please mark the bug fixed by replying with:
> >
> > #syz fix: USB: chipidea: Use the correct style for SPDX License Identifier
>
> I really doubt a comment change fixed a syzbot bug :)

Just as I don't believe the bug was caused by pmalani's patch to r8152.

syzbot is just having trouble automatically bisecting/tracking this
bug since it appears only intermittently.

cheers,
grant
