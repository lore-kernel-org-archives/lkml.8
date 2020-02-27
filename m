Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F3BC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB3A24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBGk3y53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgB0Web (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:34:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42958 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbgB0Web (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:34:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id 15so582783pfo.9;
        Thu, 27 Feb 2020 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEgm7G3Oorn2p+U3SUvjAXjrUbk1a/Mg7TANrk2b//4=;
        b=qBGk3y53fGrIoD9YVbCtRjk94Q6RcxNk2DSm3mh434SY+OeNEv+jBkV8dglcusUA+R
         L9mwI4MHxQNulbX/2XretJJFtukcDGzr2zLCBNAkiws90+uuoSKtuF1EROggBJffSdKA
         qgggk49UicheeH2QMRaXodHbyDiRh7P6/kHwp03Qgo9PQ24UR4jbyoqss3gfllwvQvVL
         xwPDxSBopjmtHJX5f74rVo97JgjI8Yitea1jHRJYWPIvIVzfbC6PC9a5X0IHms8IgMCK
         4WlJkdiWKYejSZSyCp9T8rIybyOSefTm2XK4DXMzvuRuMra5mVvzOdAJGX853Tdp2LWM
         Rx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEgm7G3Oorn2p+U3SUvjAXjrUbk1a/Mg7TANrk2b//4=;
        b=P9neHsm/pTYgzDJAlQhPG4Dr2h6mvd4N61kZXRYCWIVHNhzFdqoU/L0GBJGKmAqd8s
         CQoj1a/gy+CKJKi2sCoovyTtoUBw7SXZnJE4IhLV2+YOJ/sUB5ElSknqIHejbb71HtQ0
         atZXxffpaPAycUz9Be0jHm8yJjHYGDTZQ2USdZiF8rquQkUDYehYB8S13fNF+dXavMs7
         omwWtzW6hYRSB8cy72zP+2JEWfdivAXNC/OiUJ6fbXJQhLbtjSy8z6PcbuwLK+TCX6jj
         lfKKcgds25k2PV59HSO9bpLg7W3P97bkw95cRuTUhPF7EgPowfbK6CIpz9354XIgVq5x
         dOzg==
X-Gm-Message-State: APjAAAVUjPitvyZWC4iCzNsClZRipdQ+1dqayRGCfQgLPHXs/eTJjSOY
        d786fuaxhtdVDMRtN27l6JA=
X-Google-Smtp-Source: APXvYqw5t5F5Y64xPWlPBKQeB1b3ZAolobkAyq2a30keMZ7QjMV3RtaaKUEDeVezZZN7BeyPxNi9EQ==
X-Received: by 2002:a62:6d01:: with SMTP id i1mr1237798pfc.94.1582842869095;
        Thu, 27 Feb 2020 14:34:29 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id y193sm5500583pgd.87.2020.02.27.14.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 14:34:28 -0800 (PST)
Date:   Thu, 27 Feb 2020 14:34:25 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH v4 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint
 properties
Message-ID: <20200227223425.GB29420@taoren-ubuntu-R90MNF91>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-7-rentao.bupt@gmail.com>
 <83d7b817234f99c92272f7950129c56a58f4de54.camel@kernel.crashing.org>
 <CACPK8XdkPLZVJTpAc2u3Q0W0KoRrC4hfHjy27VKpGDRF45JByg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdkPLZVJTpAc2u3Q0W0KoRrC4hfHjy27VKpGDRF45JByg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:54:34AM +0000, Joel Stanley wrote:
> On Thu, 27 Feb 2020 at 04:11, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-
> > > endpoints"
> > > properties to describe supported number of vhub ports and endpoints.
> > >
> > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> >
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I will take this patch through the aspeed tree for 5.7.
> 
> Cheers,
> 
> Joel

Thanks Joel for the continued support!

Cheers,

Tao
