Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB06C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4C02070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBKJmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:42:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33010 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBKJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:42:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 30B93293EE0
Subject: Re: [PATCH v6] platform/chrome: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
To:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org,
        gwendal@chromium.org, andriy.shevchenko@linux.intel.com,
        Jonathan.Cameron@huawei.com, evgreen@chromium.org,
        rushikesh.s.kadam@intel.com, tglx@linutronix.de
References: <20200203225356.203946-1-yichengli@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8a4273cc-3700-8398-598e-cbcb05e6e595@collabora.com>
Date:   Tue, 11 Feb 2020 10:42:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200203225356.203946-1-yichengli@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/20 23:53, Yicheng Li wrote:
> RO and RW of EC may have different EC protocol version. If EC transitions
> between RO and RW, but AP does not reboot (this is true for fingerprint
> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> still uses the protocol version queried before transition, which can
> cause problems. In the case of fingerprint microcontroller, this causes
> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> interrupt handler, which in turn prevents RO to clear the interrupt
> line to AP, in an infinite loop.
> 
> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> might have been a transition between RO and RW, so re-query the protocol.
> 
> Signed-off-by: Yicheng Li <yichengli@chromium.org>
> ---

Queued for 5.7 with all the collected tags, thanks.
