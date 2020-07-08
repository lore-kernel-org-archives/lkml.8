Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5620786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgGHEuM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:50:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36097 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHEuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:50:11 -0400
Received: from [192.168.1.91] (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 51BEACECF6;
        Wed,  8 Jul 2020 07:00:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH][next] Bluetooth: Use fallthrough pseudo-keyword
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200707203541.GA8972@embeddedor>
Date:   Wed, 8 Jul 2020 06:49:39 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AA68478E-A46A-4914-BE62-3AC9989E358D@holtmann.org>
References: <20200707203541.GA8972@embeddedor>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> drivers/bluetooth/bcm203x.c     |  2 +-
> drivers/bluetooth/bluecard_cs.c |  2 --
> drivers/bluetooth/hci_ll.c      |  2 +-
> drivers/bluetooth/hci_qca.c     |  8 +-------
> net/bluetooth/hci_event.c       |  4 ++--
> net/bluetooth/hci_sock.c        |  3 +--
> net/bluetooth/l2cap_core.c      | 19 +++++++++----------
> net/bluetooth/l2cap_sock.c      |  4 ++--
> net/bluetooth/mgmt.c            |  4 ++--
> net/bluetooth/rfcomm/core.c     |  2 +-
> net/bluetooth/rfcomm/sock.c     |  2 +-
> net/bluetooth/smp.c             |  2 +-
> 12 files changed, 22 insertions(+), 32 deletions(-)

can we split these a little bit between drivers, core and rfcomm. Thanks.

Regards

Marcel

