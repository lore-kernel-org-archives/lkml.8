Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99818C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5E0206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgCXNkD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:40:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55976 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgCXNkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:40:03 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jGjmf-0008HX-2K; Tue, 24 Mar 2020 14:39:57 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif bindings to yaml
Date:   Tue, 24 Mar 2020 14:39:56 +0100
Message-ID: <2135168.SEOWuCda4h@diego>
In-Reply-To: <20200324133506.GC7039@sirena.org.uk>
References: <20200324123155.11858-1-jbx6244@gmail.com> <20200324133506.GC7039@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Am Dienstag, 24. März 2020, 14:35:06 CET schrieb Mark Brown:
> On Tue, Mar 24, 2020 at 01:31:53PM +0100, Johan Jonker wrote:
> > Current dts files with 'spdif' nodes are manually verified.
> > In order to automate this process rockchip-spdif.txt
> > has to be converted to yaml.
> 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> > Changed V2:
> >   dmas and dma-names layout
> 
> This is the second v2 you've sent of this today

hmm at least when looking at my inbox ... I got one series for
spdif in v2 (this one) and one for i2s in v2. And yes they do look
somewhat identical in what they do but of course handle binding
changes for different controllers.

Heiko

> - it adds these but
> drops Rob's ack?
> 




