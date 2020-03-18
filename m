Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB327C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80B20771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCRLz0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:55:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57313 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:55:26 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B5C2FCECF3;
        Wed, 18 Mar 2020 13:04:54 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: Do not cancel advertising when starting a scan
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO1O6sdfdVavo9U0UKewbS9YAjCVzdXDYms-OJZNEJVzMmkgMg@mail.gmail.com>
Date:   Wed, 18 Mar 2020 12:54:54 +0100
Cc:     Manish Mandlik <mmandlik@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F5E108DF-2004-4C52-8A5B-12A392D2416D@holtmann.org>
References: <20200316224023.1.I002569822232363cfbb5af1f33a293ea390c24c7@changeid>
 <4DF7C709-1AD3-42FF-A0C2-EF488D82F083@holtmann.org>
 <CAO1O6sdfdVavo9U0UKewbS9YAjCVzdXDYms-OJZNEJVzMmkgMg@mail.gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

>>> BlueZ cancels adv when starting a scan, but does not cancel a scan when
>>> starting to adv. Neither is required, so this brings both to a
>>> consistent state (of not affecting each other). Some very rare (I've
>>> never seen one) BT 4.0 chips will fail to do both at once. Even this is
>>> ok since the command that will fail will be the second one, and thus the
>>> common sense logic of first-come-first-served is preserved for BLE
>>> requests.
>>> 
>>> Signed-off-by: Dmitry Grinberg <dmitrygr@google.com>
>>> Signed-off-by: Manish Mandlik <mmandlik@google.com>
>>> ---
>>> 
>>> net/bluetooth/hci_request.c | 17 -----------------
>>> 1 file changed, 17 deletions(-)
>> 
>> patch has been applied to bluetooth-next tree.
>> 
>> If you know the controller that doesn’t support this, can we blacklist that one and just disable advertising (peripheral mode) for that controller.
> 
> Can't the "LE Supported States" be inspected instead to figure out
> what simultaneous capabilities are supported? It seems a bit rough to
> always assume the worst.

if there are not false-positives, then yes, by all means. However my statement still applies. If a controller can do scanning and advertising at the same time, we should just not indicate support for peripheral mode.

Regards

Marcel

