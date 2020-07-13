Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E1C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C8320773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgGMQcx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:32:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48827 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgGMQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:32:44 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1EE46CECC9;
        Mon, 13 Jul 2020 18:42:40 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/3] Bluetooth: Add new quirk for broken local ext
 features max_page
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+E=qVf_8-nXP=nSbtb49bF8SxF6P_A+5ntsUHKKmONccwkSwA@mail.gmail.com>
Date:   Mon, 13 Jul 2020 18:32:41 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <BD312721-96F1-4E12-914B-6F3C0C398E57@holtmann.org>
References: <20200705195110.405139-1-anarsoul@gmail.com>
 <20200705195110.405139-2-anarsoul@gmail.com>
 <DF6CC01A-0282-45E2-A437-2E3E58CC2883@holtmann.org>
 <CA+E=qVeYT41Wpp4wHgoVFMa9ty-FPsxxvUB-DJDnj07SpWhpjQ@mail.gmail.com>
 <70578F86-20D3-41C7-A968-83B0605D3526@holtmann.org>
 <CA+E=qVf_8-nXP=nSbtb49bF8SxF6P_A+5ntsUHKKmONccwkSwA@mail.gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

>> maybe just the read sync train params command is broken? Can you change the init code and not send it and see if the rest of the init phase proceeds. I would rather have the secure connections actually tested before dismissing it altogether.
> 
> I don't think that I have any devices that support secure connections
> to test, I've got only a bluetooth mouse and headphones, both are from
> the 2.0 era.
> 
> FWIW unofficial recommendation from Realtek to Pine64 was to avoid
> using any 4.1+ features on this chip. Unfortunately I don't have any
> contacts with Realtek, so I can't confirm that.
> 
>> Mind you, there were broken Broadcom implementation of connectionless slave broadcast as well. Maybe this is similar.
> 
> I'd prefer to stick to what works unless there's some comprehensive
> test that can figure out what's broken.

check if removing the read sync trains params command makes the controller initialize and usable. Then we see about the rest.

Regards

Marcel

