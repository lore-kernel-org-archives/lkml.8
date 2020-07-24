Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1DEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9B72068F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBDrRoFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGXH5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:57:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C87C0619D3;
        Fri, 24 Jul 2020 00:57:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so4777163pjc.4;
        Fri, 24 Jul 2020 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xv1zcnsXMWiFNO1yGG77PvS7le6RI8NhBpIqWlz5EF8=;
        b=MBDrRoFhTThMwn4vuJaaJ1dUYtoHvJ9AvJUl0nf0zlaZSI6t6TWtrxf9QZLT16Cjac
         H23NM9EEsXLczUcARcfJgpW3/75JTNWtoVXlH1i8PJQYqMUT0IESJDkn6TJLdVsA1URB
         ZmMzUC35wS3XEC3figGP8sKiEVYd0Pxdb1pSLbN+YB9N14rqtIQaLMc8yI3lP1ATVkC0
         C7F6xEs3MNco4mv0eLNtiF+a5dTIWyog3K+3h57lmwPpu96CBzsjOk0L9KTnAfJmfJg/
         Zdl7/zxuRdCOtE2s5tYxBtXqjB1YznlEDwOmetthQnbq7IjCYMMoxf/PzdJjvpaibbjs
         VPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xv1zcnsXMWiFNO1yGG77PvS7le6RI8NhBpIqWlz5EF8=;
        b=rKJ5+UprjweLR5iy4PeiefLesuVDRRjIvpCEAaBsUqM4mzcm6ZmbZoVGkPZfvX5n5C
         7hH1I3o5OmlTRH+BfZI52Pmnof9O1oaAYJNXUgMOd+X1AcITX33sCClkK0k0vGnsXdGT
         UAKQSEO6K+/o4Zndag7hmlLPidmPfLCloO3oGWK8JLz0eToM2xwKtRmq1Aejjfez03dy
         6kah2F3H/fzxjLoDRbyB8ZnbYBpTObPoH4V7vDGON3BK11xRuordgWHuNTsmxpWemI++
         ImAQ+jxsjKEVjsDjSFS/W1R9okxyJuEPuquj8LvC85gnAm5KY4N1tHZJMaZjzvTkLvTv
         qjvA==
X-Gm-Message-State: AOAM533KwR9d0zNNJ52Gi2PML1KkpWEYEDFwimH3red1NBUNA04I90Hz
        eoMilB05pziEAjIwzGNnA8M=
X-Google-Smtp-Source: ABdhPJynechrOQSEPYvcFtvaqlpIS9gq+rCF/yyS8wRTv0ETsMXi1wl44AtzrxCRuDoo1r19Tx0gGA==
X-Received: by 2002:a17:902:6941:: with SMTP id k1mr7207545plt.270.1595577467811;
        Fri, 24 Jul 2020 00:57:47 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b22sm4784117pju.26.2020.07.24.00.57.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 00:57:47 -0700 (PDT)
Date:   Fri, 24 Jul 2020 00:57:40 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: fixup wedge40 device tree
Message-ID: <20200724075739.GA4327@taoren-ubuntu-R90MNF91>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
 <CACPK8XdiHLcBBhXjCpTZotVPuRj4bFh0x8TFhSj1TBK2xB0SiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdiHLcBBhXjCpTZotVPuRj4bFh0x8TFhSj1TBK2xB0SiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:32:30AM +0000, Joel Stanley wrote:
> On Thu, 23 Jul 2020 at 23:05, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series update several devices' settings in Facebook Wedge40
> > device tree.
> >
> > Patch #1 disables a few i2c controllers as they are not being used at
> > present.
> >
> > Patch #2 enables adc device for voltage monitoring.
> >
> > Patch #3 enables pwm_tacho device for fan control and monitoring.
> >
> > Tao Ren (3):
> >   ARM: dts: aspeed: wedge40: disable a few i2c controllers
> >   ARM: dts: aspeed: wedge40: enable adc device
> >   ARM: dts: aspeed: wedge40: enable pwm_tacho device
> 
> I have merged this series into the aspeed dt-for-5.9 branch.
> 
> Cheers,
> 
> Joel

Thanks a lot Joel. Have a great weekend.


Cheers,

Tao
