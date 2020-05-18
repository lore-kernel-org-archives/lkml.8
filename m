Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFFD207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgERIBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:01:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40079 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:01:15 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 49EE7CECE2;
        Mon, 18 May 2020 10:10:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Add SCO fallback for invalid LMP parameters
 error
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200515092704.902-1-hychao@google.com>
Date:   Mon, 18 May 2020 10:01:13 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org, alainm@chromium.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B657F91B-0494-4B4C-8DE7-1E9F51085B1B@holtmann.org>
References: <20200515092704.902-1-hychao@google.com>
To:     Hsin-Yu Chao <hychao@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yu,

> Bluetooth PTS test case HFP/AG/ACC/BI-12-I accepts SCO connection
> with invalid parameter at the first SCO request expecting AG to
> attempt another SCO request with the use of "safe settings" for
> given codec, base on section 5.7.1.2 of HFP 1.7 specification.
> 
> This patch addresses it by adding "Invalid LMP Parameters" (0x1e)
> to the SCO fallback case. Verified with below log:
> 
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>        Handle: 256
>        Transmit bandwidth: 8000
>        Receive bandwidth: 8000
>        Max latency: 13
>        Setting: 0x0003
>          Input Coding: Linear
>          Input Data Format: 1's complement
>          Input Sample Size: 8-bit
>          # of bits padding at MSB: 0
>          Air Coding Format: Transparent Data
>        Retransmission effort: Optimize for link quality (0x02)
>        Packet type: 0x0380
>          3-EV3 may not be used
>          2-EV5 may not be used
>          3-EV5 may not be used
>> HCI Event: Command Status (0x0f) plen 4
>      Setup Synchronous Connection (0x01|0x0028) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Number of Completed Packets (0x13) plen 5
>        Num handles: 1
>        Handle: 256
>        Count: 1
>> HCI Event: Max Slots Change (0x1b) plen 3
>        Handle: 256
>        Max slots: 1
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17
>        Status: Invalid LMP Parameters / Invalid LL Parameters (0x1e)
>        Handle: 0
>        Address: 00:1B:DC:F2:21:59 (OUI 00-1B-DC)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x00
>        Retransmission window: 0x02
>        RX packet length: 0
>        TX packet length: 0
>        Air mode: Transparent (0x03)
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>        Handle: 256
>        Transmit bandwidth: 8000
>        Receive bandwidth: 8000
>        Max latency: 8
>        Setting: 0x0003
>          Input Coding: Linear
>          Input Data Format: 1's complement
>          Input Sample Size: 8-bit
>          # of bits padding at MSB: 0
>          Air Coding Format: Transparent Data
>        Retransmission effort: Optimize for link quality (0x02)
>        Packet type: 0x03c8
>          EV3 may be used
>          2-EV3 may not be used
>          3-EV3 may not be used
>          2-EV5 may not be used
>          3-EV5 may not be used
>> HCI Event: Command Status (0x0f) plen 4
>      Setup Synchronous Connection (0x01|0x0028) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Max Slots Change (0x1b) plen 3
>        Handle: 256
>        Max slots: 5
>> HCI Event: Max Slots Change (0x1b) plen 3
>        Handle: 256
>        Max slots: 1
>> HCI Event: Synchronous Connect Complete (0x2c) plen 17
>        Status: Success (0x00)
>        Handle: 257
>        Address: 00:1B:DC:F2:21:59 (OUI 00-1B-DC)
>        Link type: eSCO (0x02)
>        Transmission interval: 0x06
>        Retransmission window: 0x04
>        RX packet length: 30
>        TX packet length: 30
>        Air mode: Transparent (0x03)
> 
> Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> ---
> net/bluetooth/hci_event.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

