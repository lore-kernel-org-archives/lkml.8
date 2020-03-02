Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB4A21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCBWRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:17:36 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56616 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:17:36 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 52E32CECC4;
        Mon,  2 Mar 2020 23:27:01 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH v3 1/5] Bluetooth: Add mgmt op set_wake_capable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mUehaCSR2W3mXpq2s80YLJVfO2U8D_N+sRzJ2pMZQw1UA@mail.gmail.com>
Date:   Mon, 2 Mar 2020 23:17:33 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3532949B-483D-4087-A94B-E9567878EC3E@holtmann.org>
References: <20200225000036.156250-1-abhishekpandit@chromium.org>
 <20200224160019.RFC.v3.1.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid>
 <CANFp7mUehaCSR2W3mXpq2s80YLJVfO2U8D_N+sRzJ2pMZQw1UA@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> I seem to have forgotten to update the series changes here. In series
> 3, I added a wakeable property to le_conn_param so that the wakeable
> list is only used for BR/EDR as requested in the previous revision.

are you sending a v4?

Regards

Marcel

