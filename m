Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9BEC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D20321569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAUPLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:11:30 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAUPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:11:30 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MEmMt-1iqvRj0xgZ-00GJ8B for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 16:11:28 +0100
Received: by mail-qk1-f174.google.com with SMTP id c16so2997825qko.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:11:28 -0800 (PST)
X-Gm-Message-State: APjAAAWFksoEaDPVMrns8Y3K8Unek/TRpajSIIbwCZJUBUDjLvMefW4+
        9rthb+fENfCbHZVtVpK+D1Knj7gKzUfzbTePU1Q=
X-Google-Smtp-Source: APXvYqzi6p95hHekGtgpHUuq99FRYZcaopKwXcC72TbiR1kO/b+K0GTaMvWpR985L8t471EI9eZkxsPcBlxx6hhL0gE=
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr5026356qkj.352.1579619487171;
 Tue, 21 Jan 2020 07:11:27 -0800 (PST)
MIME-Version: 1.0
References: <4b74f1b6c1f9653241a1b5754525e230b3d76a3f.1579595093.git.viresh.kumar@linaro.org>
In-Reply-To: <4b74f1b6c1f9653241a1b5754525e230b3d76a3f.1579595093.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 16:11:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0fWf-wd8exJa+_UL9n0bQ26W6wd0iQH32osM1Q+cLu_w@mail.gmail.com>
Message-ID: <CAK8P3a0fWf-wd8exJa+_UL9n0bQ26W6wd0iQH32osM1Q+cLu_w@mail.gmail.com>
Subject: Re: [PATCH V3] firmware: arm_scmi: Make scmi core independent of the
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, Peng Fan <peng.fan@nxp.com>,
        peter.hilber@opensynergy.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u92ie38gqw+Syq8n9l1eIBd6Axi1BiuveWcduSSZI7f9Uh3l4ff
 IHKXwCl+DH7acDzJSp1egCmMQHKr/aUeagiz9EPlARn2urbA5u8lEjKtHReentBjvgdxPUj
 gAMx+QHUDbnd/bdomvSxdumd1y6qV3JNrw6E5LGZeJoUFrPAnFzhrCnIQLyLRkDC0PzG4ZR
 ylQ+tS2ofpGBGVcAZElMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z8+o8rI+DHk=:+1Ho0OMHdJ1ClSJY8xb+fk
 zCn1IohjOAxNfU12sbTzx0g7yA4qhMki0XbaMxq7l/jaqH1MLwjJ7vDJKupKxqrmUoczvVCLL
 DlCVM9RyKhmA1GA1tq0Bl+yLO4z5/Bom/UGlpFjb1Y7ZxZzxGZH+CcuMiwA72WfbHzsf3/iNj
 hcY7wFPHbVhClTILredsFb0IococOrWyUVNZ6s2NtvPRaKbk4lOH/2w7ATvA1BpeUbwiWcLpr
 o1hr1/RQ7cCp1RkcXH+EeKnlQ+EtWMplhlrPxsPsTDApH3P6OV2ksJeK4odeyAMHGtfffvFHu
 4YykxlD4xUhNf62ot7NovUhVYhwr9Upx1A0XTwfCiCI6wjM3+VGNRu1Lujk53p5H6v9FZs4kj
 7fZ8+1E0A2n07aECPY7laUjuaItddy8N2odnke/N2lGBwOmwcjgbqc82j5r6yQh/o1TUXnAqa
 mXivwGbPS3nnNMiyaCiH//wIKIOPrZ92wbjKO/eR+a/5jWErURGKSGKMvM4UdRpycrG0l7gZY
 DY4ygAsGqd6k1mWD+UmhCIaa9AoLNI7u9prjnSH/CeuIUJTsaktUqM33Tk1QxO8EMCDXHK434
 Z/TeD/2Mwe3DovNCgd8unADUhnTdS0UrF/NtJWziN9H7+gej1Z0nCFyHCIYG65yyJ2l6WpCuc
 Xwsa4OlKCwZJbVd8Kf9s/1HnnquSpgSjFQhkJMqHnRhaWqbT1g1uN3RPIYXB2VrhlD3qCojCm
 bfOy3phTOsN4Gi0b6T1jREqZRBb5cX2zi5+hq29UhIjSwOoWbo7vGLn8Q9GVntzhMH73bAr7x
 J0CdVtAYbBeVMp8TgSdMHcXMvGCtOHCX1ZaBM6a2kK033zTLX4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 9:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent on the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages.
>
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Sudeep: Can you please help me getting this tested?
>
> V2->V3:
> - Added more ops to the structure to read/write/memcpy data
> - Payload is moved to mailbox.c and is handled in transport specific way
>   now. This resulted in lots of changes.

This addresses the comments I had about the implementation.

It's still hard for me to judge whether this is a good abstraction as
long as there is only one backend in the framework, but I see nothing
immediately wrong with it either.

       Arnd
