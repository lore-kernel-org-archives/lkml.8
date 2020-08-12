Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3EB20774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLS7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:59:01 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:54520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726447AbgHLS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:59:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 78FAA100E86C6;
        Wed, 12 Aug 2020 18:58:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: head53_0e1322226fed
X-Filterd-Recvd-Size: 1835
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 18:58:56 +0000 (UTC)
Message-ID: <81cfca4309624b4f33cace78297872a526aa4763.camel@perches.com>
Subject: Re: [PATCH 00/44] SPMI patches needed by Hikey 970
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devel@driverdev.osuosl.org,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 12 Aug 2020 11:58:55 -0700
In-Reply-To: <20200812154752.3223b9d8@onda.lan>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <305f0df155e89e0c626b8f7366c4ab5f6741aedd.camel@perches.com>
         <20200812154752.3223b9d8@onda.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 15:47 -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 12 Aug 2020 10:13:51 -0700
> Joe Perches <joe@perches.com> escreveu:
> 
> > Perhaps these trivial bits on top:
> 
> Sounds fine for me. Feel free to send it with your SOB, adding my reviewed by:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I don't know that your original
series is going to be applied as-is
so I think you should carry it.

cheers, Joe


