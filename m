Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D230DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9891206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgC0L7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:59:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49533 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0L7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:59:16 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M8hlZ-1jD8wF388P-004jIv for <linux-kernel@vger.kernel.org>; Fri, 27 Mar
 2020 12:59:14 +0100
Received: by mail-qk1-f180.google.com with SMTP id d11so10431754qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 04:59:14 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3f7zr3f4cOtpEWkBJeuRXX/sk5nkRn+ynjRGKOlJnZlQdLXFki
        C+bhIddSLyaiEjPGaoZq4QfE1uTZrvrKr6ZF49I=
X-Google-Smtp-Source: ADFU+vuE+pRxvTEA/tUOWrqhrw6Yo/aFYGbSxiy/A0Z97EJ0d/qGe5AGsH4sFBSJry+cXavGtFSTjhkWadU8yBY+3Dc=
X-Received: by 2002:a37:6285:: with SMTP id w127mr13147141qkb.138.1585310353633;
 Fri, 27 Mar 2020 04:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl> <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com> <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc> <20200325114332.GA6337@afzalpc>
 <20200327104635.GA7775@afzalpc> <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
 <20200327111012.GA8355@afzalpc> <20200327112913.GA8711@afzalpc>
In-Reply-To: <20200327112913.GA8711@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 27 Mar 2020 12:58:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
Message-ID: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
List-Id: <soc.lore.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eSpsFH22Zf29ANsZtvepCx5u7KMIPMMr9Nc+39smeQAqpCjEOff
 SaBfaGwreUbb0Dzt8ABjevEHRyqEHhSE6L6InnWFzsUg60V2l5rI8fv0Nut5KIGpLz5i6n3
 phLhObKV/AM7Z0lewcmwwEoVhArIzk0kZyXYAOQS+kjj8BdleSBik7IcFYQUsWB+y+pNC+4
 Gt4oJYc3c1gJgNoVyqYSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x5prTMqlB4E=:7UvqZhZbxqc0vh9xs77Xiq
 xOBxbPNEWag4zCMYudJag/OGvqq83/mELgf3vKUD/fN9I5RbvUQcanSOGi6Npr2ahNo2FyJCB
 E28veyVUmZaUvPSWltTSswwmJM1UG3kTirX/kxqn4I5Li8MsInU+yVv6TjLz0hfKRsYy5U1ut
 BMRs1bN9aZook1w/2AkTQM5KYSEO13z8LcSpQhOE2ZAKqzkTuiAGD22oC+xBINpfVOT5BBCTm
 kCsKbL6038OMgTmDdTeJLNLsn18ZzcoXlGZDNKmAhpSZcrIOe0BrBOmgTtmjBP2TKBUOwUj0D
 mm/Xmwn6xoJFfk94prno0e9aUNFwsBEf2wY5GOA2DZIcocYZgiUSk4eC4h3vA12Xc7HBZpHQa
 ft+BkA6L8f1fPyIAxW3FQPC+9i+U7REKfTAgsVnYqQE3BvkZ+nHdLI3XewzTz6sCN85lSubfH
 W5PoItJjnqxZupRQuywP7Khmu6e53cv6SUAcsgwKkbRolgfRa+1c9EaTKQ+tXdnvNNE+JMvbJ
 MkWypHIT5/DlP2II63KcZKea0+gol9wSGQqf3VA9l8ZoaCOo8IXLHCK3i14DMC4TmqkhRMIYg
 Dco8pycdL0CD6g6xmt6xCfrEYmXoB/q/CSitiV+25boQ3GhBJKhNPAN59EDs0JKJ8+HkQokQ6
 o3uwJgYPeirhKB56uIQGwbqfmINecQ6slLE/rgavc2VaFFdrjEn3y9p37AhtJmd9z4kc6dUfn
 brlhWgaRNtwjwyhDhLKRTEg5r8xyGrvDISp+4aCdPdijxHak7PvVtWtYjsFgiqRBHgw480Z1g
 i4YHNcY0lIUKiFQqQmrdk4lsCRkwsJaHizNMXVdnJyOQypR+Qg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:29 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> Hi Arnd,
>
> On Fri, Mar 27, 2020 at 04:40:12PM +0530, afzal mohammed wrote:
> > On Fri, Mar 27, 2020 at 11:55:36AM +0100, Arnd Bergmann wrote:
>
> > > To make sure I get the right ones, could you bounce all the patches that are
> > > still missing to soc@kernel.org to let them show up in patchwork?
> >
> > Done.
>
> Sorry, i first forwarded, after that i bounced all, but not able to
> see the bounced ones in patchwork, only the forwarded ones.

Right, I see the same thing. Unfortunately, the version I have now
doesn't work easily in git-am.

> > If it helps, i can send the same patches w/ tags received as well.
>
> Let me know if if anything more needs to be done from my side.

I can probably fix it up here, but it would help if you can resend the
remaining patches using git-send-email with all the tags added in
and the normal subject lines.

      Arnd
