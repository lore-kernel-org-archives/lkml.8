Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3CAC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD3206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooDVIr/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgC0LKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:10:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0LKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:10:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so3324460plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TGLdq/U95WT3HxV3sUtO3DHH/5EDIKVtU9/EIJiiqA0=;
        b=ooDVIr/nQdq4AcQGTXHjjO6dJVbi51GdNjzGeNh99xO+1hi1/ufg/eevXiM9cQglkE
         bq8AimnGS9XIa3R5C7rGG27gevdg7jlS9Hfs/RnoGemFpecapjdhMLotbInDyaqB58v1
         dl3iwezCYpzJ+Esk/AZXIa4JyrK6WGhHYBr+H8zFm/cCgSF0Hu1k8PWJCpQjPQx8zMJa
         RVAo25zw5VyZo9g8lpSkqLIgWsqc1+i89AgE8K9FsIUu/81l/tnEu92fPH4gofuv5UyC
         cJDpds+OZCPwOeBH3FDRYuL/+sDCN5kQK/rBM6tfldSUKLENsnNKFOlG5Sfs4l2qAFJP
         3yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGLdq/U95WT3HxV3sUtO3DHH/5EDIKVtU9/EIJiiqA0=;
        b=Z+Bn7rRWDSS0pgniNMltwXRgf3LJ32v2eQ85vnhRfddltpp63PDojC8W85aL090the
         krzUr1v2oHlfhgEG8rw0gwlVOpyBLZeqR0SQnNIE2H9umqiJryCzRlsNJXzubC1NJ0cx
         vSxwgT6t33zAX8q/aT+edG/hRKfYo95wCsoCp2/3cNUke+Lqmg+ga63F1w0htWx/ryd/
         SGNkhuNP6dMUDjQ5qMnb7vrANn3f8+eXcZBuoCuqRXPvbVLeiLLOstThZi7w5Rgg6GF/
         Wpwj7/A574QBjtkQOYbSqN9TAX596x3LT5TyAlp/bfqJJCYVnGjSFXeAxshafPt0Vr7k
         BLsQ==
X-Gm-Message-State: ANhLgQ2X0GN3eL+7Q2GUkq1Cofb39m3Vdf1zUSDA0nMrFFOdQwfnsGRs
        AxhOtyiCJubWg0Vg5lNSNWw=
X-Google-Smtp-Source: ADFU+vvx6xgRoCFobHljQubBlxi17gVHoQR1r82g3QG+ZJ1M3ewEJcTwpCSIhlcpqaaNY2cX9bcmNg==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr12498205plo.284.1585307415138;
        Fri, 27 Mar 2020 04:10:15 -0700 (PDT)
Received: from localhost ([183.82.181.40])
        by smtp.gmail.com with ESMTPSA id x24sm3866628pfn.140.2020.03.27.04.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 04:10:14 -0700 (PDT)
Date:   Fri, 27 Mar 2020 16:40:12 +0530
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
Message-ID: <20200327111012.GA8355@afzalpc>
References: <20200308161903.GA156645@furthur.local>
 <20200301122226.4068-1-afzal.mohd.ma@gmail.com>
 <m3ftepbtxm.fsf@t19.piap.pl>
 <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
 <20200304163412.GX37466@atomide.com>
 <20200313154520.GA5375@afzalpc>
 <20200317043702.GA5852@afzalpc>
 <20200325114332.GA6337@afzalpc>
 <20200327104635.GA7775@afzalpc>
 <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0kVvkCW+2eiyZTkfS=LqqnbeQS+S-os=vxhaYXCwLK+A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Mar 27, 2020 at 11:55:36AM +0100, Arnd Bergmann wrote:

> To make sure I get the right ones, could you bounce all the patches that are
> still missing to soc@kernel.org to let them show up in patchwork?

Done.

If it helps, i can send the same patches w/ tags received as well.

Regards
afzal
