Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B31AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E852070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCZJCA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:02:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38318 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:01:59 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 23B15CECDB;
        Thu, 26 Mar 2020 10:11:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Indicate Microsoft vendor
 extension for Intel 9460/9560 and 9160/9260
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200326005931.v3.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
Date:   Thu, 26 Mar 2020 10:01:56 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ADF19483-721C-4263-8CA8-CF4587E79BA4@holtmann.org>
References: <20200326075938.65053-1-mcchou@chromium.org>
 <20200326005931.v3.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miao-chen,

> This adds a bit mask of driver_info for Microsoft vendor extension and
> indicates the support for Intel 9460/9560 and 9160/9260. See
> https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
> microsoft-defined-bluetooth-hci-commands-and-events for more information
> about the extension. This was verified with Intel ThunderPeak BT controller
> where msft_vnd_ext_opcode is 0xFC1E.
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> Changes in v3:
> - Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
> and change the hdev->msft_ext field to void*.
> - Define and expose msft_vnd_ext_set_opcode() for btusb use.
> - Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().

so I spent some cycles on thinking about on how we can have this nice and cleanly without putting too much into the core stack or hci_dev. I took your patches and converted them a little bit into how I would do it. Please have a look.

Regards

Marcel

