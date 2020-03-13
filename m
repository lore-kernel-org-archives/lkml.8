Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6FAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833D22074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5Xx0HR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgCMPpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:45:34 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38383 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCMPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so3831790pje.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=b0QFGPtaOFgS1p4j3kzI40sn+TuGXFBWdbjN6ThamFU=;
        b=S5Xx0HR4uK3x5sZ2lkKqGpCZp5dRn6W6zSGgtxKpy1TECKMkzzMOvS3GeXCgBYYHDp
         SH1F/Hwzv+DsDzXLH6IpdksjXDooRuwMJMu7DgsfKkMrF3msvQSJqnaFvXCvwSXmH5HN
         wXkr1U3oI6pWg5oOJSrQHCJiTigWEnHGF+cSR8lFea9K7/QhIQyfcDiwM3iPTH6KY9vZ
         8N5jyoVZLGuwTn0Mu0JvubH0/C7bzfQavdAVTDwROfSn79DIVeVBeoEy/Oy1C5HexGWF
         Qp7gORvUQnyb5JGRhJKaQSARgfFUfKirAycOGaskBuwP7qivSl3SNC88BIACqdXDFcer
         1VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0QFGPtaOFgS1p4j3kzI40sn+TuGXFBWdbjN6ThamFU=;
        b=U+5Hh8/9fkQu6IXklXbjXNGV4pk/8yZzZVZrdZRQ8LDNa+FkwKTpGQc7aOj9XHTZ5Y
         W7BpkbCGO4kkBbHuHfrWxf8Mn8kOuWpbtuCdjhVlsCkG8UqtmCpW9MkWwbeIwvaUnz/I
         mfyylHvJoR3/YS0JsRcHcPpPkITYtsStnjlpgsl576KCqlIhzdVwXvwBKNjnrTmT0I+8
         or6dE6SH9iKEv4RzH9gecxxRUX6ADThZs8TEmVjxlUAu6ki2Kmqe/HmYFeRvkvRCuEys
         ofcofKbKN1eh+uFbrSsNHiR0HVZMzsaKdepL66yr6njn/WxGG5D4/N0w/gGEHPjHeFO5
         bmAg==
X-Gm-Message-State: ANhLgQ3yMxQutH/5DndGdhIXmkOiZwyaAEcac72nU2cAsgNrOtwUCBXW
        k2Zwxb1iAZsQW9rRDbEPLU8=
X-Google-Smtp-Source: ADFU+vu9PFUO7WrFo2R1c/TgS38hSQNK69c/qQfS0BG45kU8AHakgaykC8oUbsiMu8fYIqN85vQJzg==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr14083210plt.10.1584114322624;
        Fri, 13 Mar 2020 08:45:22 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id b15sm58991693pft.58.2020.03.13.08.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 08:45:22 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:15:20 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
Message-ID: <20200313154520.GA5375@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu8ppknv.fsf@FE-laptop>
 <20200302031736.5or4ww5a4l7zomfo@vireshk-i7>
 <20200308161903.GA156645@furthur.local>
 <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl>
 <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Arnd,

This is regarding cleanup of setup_irq() usages & replacing it w/
request_irq(). Earlier it was sent as single series spanning all
architectures & drivers, later Thomas Gleixner suggested [1] to take it
thr' relevant maintainers. As for ARM, there is an additional layer of
sub-architecture maintainers, for ARM, patches were sent to relevant
subsystem maintainers & mailing list, all copied to LAKML as well.

There were 10 sub-arch's in ARM that were subjected to the cleanup,

1. OMAP :https://lkml.kernel.org/r/20200301121945.3604-1-afzal.mohd.ma@gmail.com
2. ebsa110 :https://lkml.kernel.org/r/20200301122210.4013-1-afzal.mohd.ma@gmail.com
3. rpc :https://lkml.kernel.org/r/20200301122300.4185-1-afzal.mohd.ma@gmail.com
4. footbridge :https://lkml.kernel.org/r/20200301122131.3902-1-afzal.mohd.ma@gmail.com
5. orion :https://lkml.kernel.org/r/20200301122330.4296-1-afzal.mohd.ma@gmail.com
6. ep93xx :https://lkml.kernel.org/r/20200301122112.3847-1-afzal.mohd.ma@gmail.com
7. spear :https://lkml.kernel.org/r/20200301122315.4240-1-afzal.mohd.ma@gmail.com
8. cns3xxx :https://lkml.kernel.org/r/20200301122155.3957-1-afzal.mohd.ma@gmail.com
9. mmp :https://lkml.kernel.org/r/20200301122243.4129-1-afzal.mohd.ma@gmail.com
10. iop32x :https://lkml.kernel.org/r/20200301122226.4068-1-afzal.mohd.ma@gmail.com

Of this,

(1) OMAP, (2) ebsa110 & (3) rpc are already in linux-next.

(4) footbridge (Russell) - there was a build warning, so he dropped
after applying to his tree, i have submitted the newer fixed version in
his patch system.

(5) orion - Andrew has given Reviewed-by & Gregory mentioned that he will
take care of it.

So if things goes as expected 1 & 5 will be coming to you thr' sub-arch
maintainers, while 2-4 directly via Russell

Now we are left with five (6-10),
(6) ep93xx - Alexander has given Acked-by & mentioned to take thr' Arnd
(7) spear - Viresh has given Acked-by & mentioned to take it thr' Arnd
(8) cns3xxx - Krzysztof has given Acked-by (though not copied to lists,
he has been cc'ed here)
(9) mmp - Lubomir has given Acked-by & Tested-by & mentioned to get it
thr' Olof
(10) iop32xx - per get_mantainer, an orphan

Can you please include the patches 6-10 directly into the armsoc tree ?,
Let me know if anything needs to be done from my side.

Regards
afzal

[1] https://lkml.kernel.org/r/87y2somido.fsf@nanos.tec.linutronix.de
