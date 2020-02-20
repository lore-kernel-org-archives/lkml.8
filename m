Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4A5C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E1024672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBTHdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:33:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37319 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgBTHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:33:18 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B296ECECDC;
        Thu, 20 Feb 2020 08:42:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [Bluez PATCH v3] bluetooth: fix passkey uninitialized when used
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200220111711.Bluez.v3.1.I145f6c5bbf2437a6f6afc28d3db2b876c034c2d8@changeid>
Date:   Thu, 20 Feb 2020 08:33:15 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        clang-built-linux@googlegroups.com
Content-Transfer-Encoding: 7bit
Message-Id: <5E3D09AD-23D2-4D1F-ADC5-447B948002EA@holtmann.org>
References: <20200220111711.Bluez.v3.1.I145f6c5bbf2437a6f6afc28d3db2b876c034c2d8@changeid>
To:     Howard Chung <howardchung@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

> This patch fix the issue: warning:variable 'passkey' is uninitialized
> when used here
> 
> Link: https://groups.google.com/forum/#!topic/clang-built-linux/kyRKCjRsGoU
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Suggested-by: Marcel Holtmann <marcel@holtmann.org>
> 
> Signed-off-by: Howard Chung <howardchung@google.com>
> 
> ---
> 
> Changes in v3:
> - rephrase the commit message
> 
> Changes in v2:
> - refactor code
> 
> net/bluetooth/smp.c | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

