Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992B220734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGQGv6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:51:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40187 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgGQGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:51:57 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id E391ECED0F;
        Fri, 17 Jul 2020 09:01:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH v1 1/2] Bluetooth: queue ACL packets if no handle is
 found
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_Vrn_pXMbkXifKFazha7BYPqLpCthqHOb9ZmVE3wDRMfA@mail.gmail.com>
Date:   Fri, 17 Jul 2020 08:51:55 +0200
Cc:     Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F17D321B-DCD2-4A80-97EE-B4589FBFF406@holtmann.org>
References: <20200627105437.453053-1-apusaka@google.com>
 <20200627185320.RFC.v1.1.Icea550bb064a24b89f2217cf19e35b4480a31afd@changeid>
 <91CFE951-262A-4E83-8550-25445AE84B5A@holtmann.org>
 <CAJQfnxFSfbUbPLVC-be41TqNXzr_6hLq2z=u521HL+BqxLHn_Q@mail.gmail.com>
 <7BBB55E0-FBD9-40C0-80D9-D5E7FC9F80D2@holtmann.org>
 <CALWDO_Vrn_pXMbkXifKFazha7BYPqLpCthqHOb9ZmVE3wDRMfA@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

> >>> There is a possibility that an ACL packet is received before we
> >>> receive the HCI connect event for the corresponding handle. If this
> >>> happens, we discard the ACL packet.
> >>> 
> >>> Rather than just ignoring them, this patch provides a queue for
> >>> incoming ACL packet without a handle. The queue is processed when
> >>> receiving a HCI connection event. If 2 seconds elapsed without
> >>> receiving the HCI connection event, assume something bad happened
> >>> and discard the queued packet.
> >>> 
> >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >> 
> >> so two things up front. I want to hide this behind a HCI_QUIRK_OUT_OF_ORDER_ACL that a transport driver has to set first. Frankly if this kind of out-of-order happens on UART or SDIO transports, then something is obviously going wrong. I have no plan to fix up after a fully serialized transport.
> >> 
> >> Secondly, if a transport sets HCI_QUIRK_OUT_OF_ORDER_ACL, then I want this off by default. You can enable it via an experimental setting. The reason here is that we have to make it really hard and fail as often as possible so that hardware manufactures and spec writers realize that something is fundamentally broken here.
> I don't have any objection to making this explicit enable to non serialized transports.  However, I do wonder what the intention is around making this off by default.  We already know there is a race condition between the interupt and bulk endpoints over USB, so this can and does happen.  Hardware manufaturers can't relly do much about this other than trying to pull the interupt endpoint more often, but that's only a workaround, it can't avoid it all together.
> 
> IMO, this seems like a legitimate fix at the host level and I don't see any obvious benefits to hide this fix under an experimental feature and make it more difficult for the customers and system integrators to discover.

the problem is that this is not a fix. It is papering over a hole and at best a workaround with both eyes closed and hoping for the best. I am not looking forward for the first security researcher to figure out that they have a chance to inject an unencrypted packet since we are waiting 2 seconds for the USB transport to get its act together.

In addition, I think that Luiz attempt to align with the poll intervals inside the USB transport directly is a cleaner and more self-contained approach. It also reduces the window of opportunity for any attacker since we actually align the USB transport specific intervals with each other.

Regards

Marcel

