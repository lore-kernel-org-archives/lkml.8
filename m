Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE2DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F024691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWEOl2hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCJLRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45462 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgCJLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:17:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so12701396otp.12;
        Tue, 10 Mar 2020 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m09U5Nj3Yoc7UUHoM3/K3YvvnK5tLs5UgDhB2bnbB7s=;
        b=UWEOl2hn0i6+civfP1gv0gPmQwxE4CF6xj/4mYyIYXRpIxVZwunziiWbLGexnCHfuZ
         WAadVKx04+a0iRAb/rnVieVBkWuLoUaRBBItAD8rAgp8nn+rzgaMOaRuyosEG7KYkidQ
         Eii+l29ipjRGEomNmFP09PPcZWzCTu6ORe09toaXlT5ElKkPbReHKXS49GVhUn/888lc
         5bb47DGtrwGV+kkkTSyX8v0pBOsk2+Ea3PTNiJm3eVNIwiT99zFoTeW3abX+XGgyv5Bp
         EOJAgjh5LO6H46zOF8KQke/MnRrYlbyENrZjrwJPYhYBWy7SQRciY/QSHq0YkW1PIruB
         fVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m09U5Nj3Yoc7UUHoM3/K3YvvnK5tLs5UgDhB2bnbB7s=;
        b=GbA8Bg/92CAn6bDfLbaWrlB0WQZFz90m0Z7Av2VtTgEkMz89uvEWKGO7WeVpLRijVb
         caHpOtKKRES80AChSNgS6bAIYBpgK7ay+WoK78UAJjXBt/Jwt+Glo0EZv5cd7CRvOBFE
         K8fzSoMzWN4K55o666QNqfT2zEbq/MmRkpJZPZu7aPaBsOiiBmhmpo7lj4+FUD7RqgV/
         ie/oirwFeaUJx//MyEXl7+ewl1v2s4nkln5hI9k07GO4Y7UQ7Jef3JzYG+5kF+0pBAwV
         hukXHrZ0QzSIGZ4lT3slwERUASz9PQsxFX+B8jX/w2ScPKSyUxshNXhlPIerBS3GCptc
         xkzA==
X-Gm-Message-State: ANhLgQ3MSekVgARJgRO6vG2nK3p1G14FA9v/6p/D8E2NubfQ01/4erW8
        mjQ+5OXlQYaPQFlPpKIjsk/hhix4cvo01FbFCY0=
X-Google-Smtp-Source: ADFU+vtN+zaOZYvzPnrYZoO2Or6SvEL79vvzFTm+3xIivtNvlmRie/gGWT1dTZhv8Nz3jO1SqSMsBQ4RxqjesurQdoo=
X-Received: by 2002:a9d:64cd:: with SMTP id n13mr16686281otl.274.1583839056416;
 Tue, 10 Mar 2020 04:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200228164126.17517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200305114314.GP5379@paasikivi.fi.intel.com> <CA+V-a8tGEYT7sOqzLRu8cx3u1DySt4mOz0UujU57SZSGqXB=Pw@mail.gmail.com>
In-Reply-To: <CA+V-a8tGEYT7sOqzLRu8cx3u1DySt4mOz0UujU57SZSGqXB=Pw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 10 Mar 2020 11:17:10 +0000
Message-ID: <CA+V-a8sXP98EkrvepX6hqj8oNE8c5o5PUtU306V_QYb1Bowjpw@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5645: Add virtual_channel module parameter
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Fri, Mar 6, 2020 at 10:18 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Sakari,
>
> On Thu, Mar 5, 2020 at 11:43 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Fri, Feb 28, 2020 at 04:41:26PM +0000, Lad Prabhakar wrote:
> > > OV5645 can operate in virtual channel 0-3 in CSI2 interfaces, this patch
> > > adds support for module parameter virtual_channel to select the required
> > > channel. By default OV5645 operates in virtual channel 0.
> >
> > What's your use case for different virtual channels?
> >
> Just ability to switch to different virtual channel, based on ov5640
> driver. The rcar-csi2
> has capability to capture  from multiple channels so that we can
> capture simultaneously
> from two sensors.
>
Any thoughts on how this could be handled ?

Cheers,
--Prabhakar
