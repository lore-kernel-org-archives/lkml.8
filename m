Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7249FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A4A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMpPaEKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgC0Kqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:46:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37924 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Kqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:46:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so4400641pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgyOzx+8KXAFpBo6KqposIHyFFF0IVaddFwhQt3iB0g=;
        b=bMpPaEKuT+7GXNVtglrV0XvGhBOCgz70EG9qTx9FhGLA4dAGp3ryeOE+AzIPoMiUW3
         M/Je+BKBjd/5YXaksH2rX3BMgNQLhlCCoswsO8Nj4JRswo+rVYzGOAE5zG1jzFey3LtS
         U/FROUrK7oD4O5ufh+Q80AQ8eIw5O8y0vhLkBLY93/bhcvYiPXnZICZ67Bg78x7x7F56
         ZSPhz3gv2RcgINiyCEUObohp/IAUbzQ0dX4zMRkcN31l77MirJKEPMcx+DS4NyI/Xi1w
         xvQElgJ6WUJRRzIjiJxjJnRvWBfq2dwuXHHLmB0G8arGDfmi5rQQ8BkTxESQwHA+D80D
         O52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgyOzx+8KXAFpBo6KqposIHyFFF0IVaddFwhQt3iB0g=;
        b=LGjCqg3YyEbwExgfHF/kT4/g0frCqC+eBgoVS+yU4AmPAzJcS/N0fYD/6VSyuJLHFx
         cskCc27gVuC4KxUMVCob4I3ys+iEpqLNUJl+2ddfDF5YJxhYQgkekZ2yN2u0nmUukpVB
         uIQVdVZbzQnFeTDAAfxq2jrgPgAVjU3Ezg/mVLyhtPf2o+B7RFmFbj0s7cpj5X2RMjjo
         jaHHyLKyvTiIz9q1d0bsYiakxpP5O5TQNdCW1mVsFy6jLuWQLyTfMQbVM5dLwJbsQnk3
         TEaVbGcxFeDoWt0mgqZqnOf4rns2Tmw8wwTD0L4BBGJ/B+1wEOjGsuqLW0v9VBrCuMD5
         7WwQ==
X-Gm-Message-State: ANhLgQ0XoWKX+7/ixMVH3sVygwnx7gpbFwUX8Zrx5Mz4WtmEaWF4WokL
        +XPKNYKOgihvrUiPl30SiDg=
X-Google-Smtp-Source: ADFU+vv+9gPYHDYNT5694OtuE+4+X3HsxNDhG/5RwWw42SX4SAnOn6KsXnzCHUsKrOeO1If0wO4Imw==
X-Received: by 2002:a62:2c87:: with SMTP id s129mr1229539pfs.263.1585305998020;
        Fri, 27 Mar 2020 03:46:38 -0700 (PDT)
Received: from localhost ([183.82.181.40])
        by smtp.gmail.com with ESMTPSA id k189sm3625905pgc.24.2020.03.27.03.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 03:46:37 -0700 (PDT)
Date:   Fri, 27 Mar 2020 16:16:35 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: <soc.lore.kernel.org>
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] ARM: replace setup_irq() by request_irq()
Message-ID: <20200327104635.GA7775@afzalpc>
References: <87mu8ppknv.fsf@FE-laptop>
 <20200302031736.5or4ww5a4l7zomfo@vireshk-i7>
 <20200308161903.GA156645@furthur.local>
 <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl>
 <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
 <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc>
 <20200325114332.GA6337@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325114332.GA6337@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Mar 25, 2020 at 05:13:32PM +0530, afzal mohammed wrote:
> On Tue, Mar 17, 2020 at 10:07:02AM +0530, afzal mohammed wrote:
> > On Fri, Mar 13, 2020 at 09:15:20PM +0530, afzal mohammed wrote:

> > > Can you please include the patches 6-10 directly into the armsoc tree ?,
> > > Let me know if anything needs to be done from my side.
> 
> Can you please consider for inclusion the above 5 patches.
> 
> Sorry for pestering, i understand that none of the ARM SoC pull requests
> has been picked up as opposed to what happens normally by this time of
> development cycle.

i think you have pulled the ARM SoC pull requests, but above changes
doesn't seem to be applied, can you please respond on how to proceed ?
(of all the tree-wide changes, the above are the only ones in limbo)

Regards
afzal
