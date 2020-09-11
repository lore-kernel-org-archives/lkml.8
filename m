Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A47C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC200221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgIKHGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:06:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32837 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIKHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:06:07 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 91787CED19;
        Fri, 11 Sep 2020 09:13:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: Re-order clearing suspend tasks
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200909165317.1.Ie55bb8dde9847e8005f24402f3f2d66ea09cd7b2@changeid>
Date:   Fri, 11 Sep 2020 09:06:04 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E430CF8E-218C-4C64-B963-57AE70CD11CB@holtmann.org>
References: <20200909165317.1.Ie55bb8dde9847e8005f24402f3f2d66ea09cd7b2@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> Unregister_pm_notifier is a blocking call so suspend tasks should be
> cleared beforehand. Otherwise, the notifier will wait for completion
> before returning (and we encounter a 2s timeout on resume).
> 
> Fixes: 0e9952804ec9c8 (Bluetooth: Clear suspend tasks on unregister)
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Should have caught that unregister_pm_notifier was blocking last time
> but when testing the earlier patch, I got unlucky and saw that the error
> message was never hit (the suspend timeout).
> 
> When re-testing this patch on the same device, I was able to reproduce
> the problem on an older build with the 0e9952804ec9c8 but not on a newer
> build with the same patch. Changing the order correctly fixes it
> everywhere. Confirmed this by adding debug logs in btusb_disconnect and
> hci_suspend_notifier to confirm what order things were getting called.
> 
> Sorry about the churn. Next I'm going try to do something about the palm
> shaped indentation on my forehead...
> 
> net/bluetooth/hci_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

