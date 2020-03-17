Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE596206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVHUd3yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgCQEhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:37:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38037 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCQEhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:37:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so11006897pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6LqbjpYd53Jp9kp/0aPiSSghdNoCLRiq2Rd7QnWjLIc=;
        b=iVHUd3ywdaBlLYso7oVZ0XswpPkdLkJ/oUySME3/MTNKnNSuwcGayhEKjvHxQqmT99
         PteQgFyxpfR2zAtrvFt0HA6L4doFJsRSoG86ZNZCHMZEWGRdL2eeOjBmbNAZJy++zE+j
         +tp9ekAHdZm/thBTPpFkKBTEPYFsAHuToGKbfDG5fE9MoZzuxwEHNUc5jbSc2HPZZChq
         92NvxixLSBvVm8kVBa0UGLOnqTCXJGdfRywFZD8ln5nPCHm58Kg1dOoM2fWvgnDn6oOk
         /Nlllcz9KFMZ4VxTIeFs2kFEkzP9mAHfEZs/Iu3HLwL1f5K+sLfEZN6Ot4Gi7b525T/J
         Qspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LqbjpYd53Jp9kp/0aPiSSghdNoCLRiq2Rd7QnWjLIc=;
        b=Pxptn2w00/8HAaYGu66E2aGYaLJ6nKbWSt+rNON63+2yZvnrkjw8QM5WHXKGGCnVY/
         zWx0UQ57KGYGAiTyVo8DBPk9Tf1w8rzrm/v/CaKv1KzeSoAo+Cfo8B8ZNfr/0euqS5Kn
         PAx2mDe+PpAKEPN+nD419b0UIQHNGn5ucXPP2hWet0PGlLF7I8vlCjHNMEYLps+PnzCi
         aM0BfDzU+WPedJUK+W0+nKWOxIRPSlstPrbh+Cl1Fd0riKmObmc39xI7KhVCTCj+QBFM
         1Uc5Z+yDQLB5LBoXhv2bITbqhhWZqBlXVvYbxOUj2n18e3eMQOtTETJXIBsJ50DbtLDV
         2EoA==
X-Gm-Message-State: ANhLgQ2WqV5ZlNAQYkt3V2hkg4yftmlR9Xl0LYTaXbZ7q3JllrE1DshB
        IyHeeO+0UV5xgwNLH1VCIZc=
X-Google-Smtp-Source: ADFU+vvbzRw15Ig2fBLmy5JSjm+B+3HeuiLNPurXkFUrbvDosMzVLIH2+Sb0RkNMSNA7pP2wwgBG1Q==
X-Received: by 2002:a62:e40b:: with SMTP id r11mr3216028pfh.137.1584419826053;
        Mon, 16 Mar 2020 21:37:06 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id kb18sm1309929pjb.14.2020.03.16.21.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 21:37:05 -0700 (PDT)
Date:   Tue, 17 Mar 2020 10:07:02 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, arm@kernel.org
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
Message-ID: <20200317043702.GA5852@afzalpc>
References: <87mu8ppknv.fsf@FE-laptop>
 <20200302031736.5or4ww5a4l7zomfo@vireshk-i7>
 <20200308161903.GA156645@furthur.local>
 <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl>
 <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
 <20200313154520.GA5375@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313154520.GA5375@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ soc@kernel.org, arm@kernel.org,

in case it helps to reduce the chances of below mail getting slipped
thr' the cracks.

Regards
afzal

On Fri, Mar 13, 2020 at 09:15:20PM +0530, afzal mohammed wrote:
> Hi Olof, Arnd,
> 
> This is regarding cleanup of setup_irq() usages & replacing it w/
> request_irq(). Earlier it was sent as single series spanning all
> architectures & drivers, later Thomas Gleixner suggested [1] to take it
> thr' relevant maintainers. As for ARM, there is an additional layer of
> sub-architecture maintainers, for ARM, patches were sent to relevant
> subsystem maintainers & mailing list, all copied to LAKML as well.
> 
> There were 10 sub-arch's in ARM that were subjected to the cleanup,
> 
> 1. OMAP :https://lkml.kernel.org/r/20200301121945.3604-1-afzal.mohd.ma@gmail.com
> 2. ebsa110 :https://lkml.kernel.org/r/20200301122210.4013-1-afzal.mohd.ma@gmail.com
> 3. rpc :https://lkml.kernel.org/r/20200301122300.4185-1-afzal.mohd.ma@gmail.com
> 4. footbridge :https://lkml.kernel.org/r/20200301122131.3902-1-afzal.mohd.ma@gmail.com
> 5. orion :https://lkml.kernel.org/r/20200301122330.4296-1-afzal.mohd.ma@gmail.com
> 6. ep93xx :https://lkml.kernel.org/r/20200301122112.3847-1-afzal.mohd.ma@gmail.com
> 7. spear :https://lkml.kernel.org/r/20200301122315.4240-1-afzal.mohd.ma@gmail.com
> 8. cns3xxx :https://lkml.kernel.org/r/20200301122155.3957-1-afzal.mohd.ma@gmail.com
> 9. mmp :https://lkml.kernel.org/r/20200301122243.4129-1-afzal.mohd.ma@gmail.com
> 10. iop32x :https://lkml.kernel.org/r/20200301122226.4068-1-afzal.mohd.ma@gmail.com
> 
> Of this,
> 
> (1) OMAP, (2) ebsa110 & (3) rpc are already in linux-next.
> 
> (4) footbridge (Russell) - there was a build warning, so he dropped
> after applying to his tree, i have submitted the newer fixed version in
> his patch system.
> 
> (5) orion - Andrew has given Reviewed-by & Gregory mentioned that he will
> take care of it.
> 
> So if things goes as expected 1 & 5 will be coming to you thr' sub-arch
> maintainers, while 2-4 directly via Russell
> 
> Now we are left with five (6-10),
> (6) ep93xx - Alexander has given Acked-by & mentioned to take thr' Arnd
> (7) spear - Viresh has given Acked-by & mentioned to take it thr' Arnd
> (8) cns3xxx - Krzysztof has given Acked-by (though not copied to lists,
> he has been cc'ed here)
> (9) mmp - Lubomir has given Acked-by & Tested-by & mentioned to get it
> thr' Olof
> (10) iop32xx - per get_mantainer, an orphan
> 
> Can you please include the patches 6-10 directly into the armsoc tree ?,
> Let me know if anything needs to be done from my side.
> 
> Regards
> afzal
> 
> [1] https://lkml.kernel.org/r/87y2somido.fsf@nanos.tec.linutronix.de
