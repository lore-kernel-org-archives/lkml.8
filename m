Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B52A2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgGFN6W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:58:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56777 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgGFN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:58:21 -0400
Received: from sogo13.sd4.0x35.net (sogo13.sd4.0x35.net [10.200.201.63])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPA id 441146000E;
        Mon,  6 Jul 2020 13:58:18 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <20200706130717.GA2276608@kroah.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 06 Jul 2020 15:58:17 +0200
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        "David Laight" <David.Laight@aculab.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Pavel Machek" <pavel@denx.de>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "Oliver Neukum" <oneukum@suse.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <74dc-5f032e00-69-5f1a6480@172803432>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH=5D?==?utf-8?q?_usb=3A?=
 =?utf-8?q?_core=3A?= fix =?utf-8?q?quirks=5Fparam=5Fset=28=29?= writing to 
 a const pointer
User-Agent: SOGoMail 4.3.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 06, 2020 15:07 CEST, Greg Kroah-Hartman wrote: 
> Just test for memory allocation failure and handle it properly, it isn't
> hard to do.
> 
> 128 bytes on the stack can be a problem, don't get in the habit of doing
> so please.

Thank you for the clarification. The next version of my patch shall use
kstrdup() instead of copying to the stack.

