Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9205CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC2B206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE4RxeLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgC0MxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:53:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33429 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0MxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:53:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so3434366plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G68liNtd5NAG8F0BUIcyo/RJH3sB3+HWc+rvRzN4j0s=;
        b=GE4RxeLUl+XDIRjDHsc7r1GUEwGkxGTk5jppoxA5ILovhndXMF/ujBurOL+/JkFMSM
         +bbYVGl9yQ2iTsxsheQSgowngt51vzFgFJMz7XgW4wNQE+0Ux9W9mcEo97kB+lW1XpX1
         Fjy8DnG/PyYkN2Xx0S1jUf2DNtBGca/QdBTm0gZTBbb5DcnQhdxgdqDQFkCwnqR5sMw8
         DiWMZMDhj19kkLU5hZ3ct2BPboJy2NURR5muASZRP+wSbNzgEqoh6/6mbHwavM3IPiHH
         mjC28oO48zd/RIPc3dQwMs5iH5j//DBdK6+xr84cYVFk+BSbEFl3Yjn96nEy7HyW7MfA
         KizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G68liNtd5NAG8F0BUIcyo/RJH3sB3+HWc+rvRzN4j0s=;
        b=p000eSNDBXK16vQPXF+UvIFi+FYk7VyQJFrsFKvFxpQKvFd/zM1BpDUC8JrcDrOOHC
         urZphqm7a6rD7Jf1DwZW0dI7eW8JQJmoFGLxUvuCCXUcmlAD6y4Daqj1fqttg34IpT87
         guQ/R5KCDOrHGF1czN0G/Kq6EYawFA/zzOO54x9vjLQ4oNBcwCOcEqXE69qOMFVaio8Q
         pc0gwufyW+Z05rU4jVNtTXt/hfuvjMGkPBj4NBKvCiukQKhbLlpu4cLMxDsXGIWq6XE2
         fwpWU7hBGyj0gc/tZ/cqjWg7FdhT6UnUZ8tSiD0L+SzoJL1KcYQ57SUy4+HE5FQQ9Xvg
         4+gA==
X-Gm-Message-State: ANhLgQ2jyHO+0ksBOd3CXSfEpXsfjR7nxpFMYjAWC04OJQvZSWyQ3v5J
        bHRf2IKPSP3YIUAthGphFds=
X-Google-Smtp-Source: ADFU+vur85N5b/dYIZxb3jY8T3tnGlocKor6avYVXq6UVEyv5NAFg9S0iJYegIyPVQZreo4gMtB6vA==
X-Received: by 2002:a17:902:d895:: with SMTP id b21mr12893200plz.118.1585313600479;
        Fri, 27 Mar 2020 05:53:20 -0700 (PDT)
Received: from localhost ([49.207.51.33])
        by smtp.gmail.com with ESMTPSA id c9sm3710728pjr.47.2020.03.27.05.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 05:53:20 -0700 (PDT)
Date:   Fri, 27 Mar 2020 18:23:18 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
Message-ID: <20200327125318.GA4979@afzalpc>
References: <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
 <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc>
 <20200325114332.GA6337@afzalpc>
 <20200327104635.GA7775@afzalpc>
 <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
 <20200327111012.GA8355@afzalpc>
 <20200327112913.GA8711@afzalpc>
 <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2sqika7=3D6Zgkz+v8HtGEc0q0+skWG8mSKuL+qSoYLw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 27, 2020 at 12:58:57PM +0100, Arnd Bergmann wrote:

> I can probably fix it up here, but it would help if you can resend the
> remaining patches using git-send-email with all the tags added in
> and the normal subject lines.

i have sent the remaining patches using git send-email w/ all the tags
collected and with normal subject lines, as a reply to your mail. They
look okay in patchwork, let me know in case of any problems.

Regards
afzal
