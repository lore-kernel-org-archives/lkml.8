Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5DCC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77333206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbgIHQpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:45:18 -0400
Received: from gw.c-home.cz ([89.24.150.100]:32800 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbgIHQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:45:01 -0400
Received: from dmz.c-home.cz (localhost [127.0.0.1])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 088GiCUd007906;
        Tue, 8 Sep 2020 18:44:17 +0200 (CEST)
Received: from localhost (martin@localhost)
        by dmz.c-home.cz (8.14.4+Sun/8.14.4/Submit) with ESMTP id 088Gi6FG007903;
        Tue, 8 Sep 2020 18:44:07 +0200 (CEST)
X-Authentication-Warning: dmz.c-home.cz: martin owned process doing -bs
Date:   Tue, 8 Sep 2020 18:44:06 +0200 (CEST)
From:   Martin Cerveny <martin@c-home.cz>
Reply-To: Martin Cerveny <M.Cerveny@computer.org>
To:     Maxime Ripard <maxime@cerno.tech>
cc:     Martin Cerveny <m.cerveny@computer.org>,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/6] ARM: dts: sun8i: v3s: Enable video decoder
In-Reply-To: <20200908062327.7o4abjnosvghtafy@gilmour.lan>
Message-ID: <alpine.GSO.2.00.2009081840380.6717@dmz.c-home.cz>
References: <20200904200112.5563-1-m.cerveny@computer.org> <20200908062327.7o4abjnosvghtafy@gilmour.lan>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Tue, 8 Sep 2020, Maxime Ripard wrote:
> On Fri, Sep 04, 2020 at 10:01:06PM +0200, Martin Cerveny wrote:
>> First patch extends cedrus capability to all decoders
>> because V3s missing MPEG2 decoder.
>>
>> Next two patches add system control node (SRAM C1) and
>> next three patches add support for Cedrus VPU.
>
> How was it tested?

On V3s with LCD and bootlin raw v4l2 api test:
- https://github.com/mcerveny/linux/tree/v3s_videocodec_v3
- https://github.com/mcerveny/v4l2-request-test

Regards.
