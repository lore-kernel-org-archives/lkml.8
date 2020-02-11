Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A61DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E893720848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBKJoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:44:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33028 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgBKJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:44:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8C579293EE0
Subject: Re: [PATCH v2] platform/chrome: wilco_ec: Platform data shan't
 include kernel.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>
References: <20200205094828.77940-1-andriy.shevchenko@linux.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f23fb55a-dc91-45f4-bbb3-2a8968d4099a@collabora.com>
Date:   Tue, 11 Feb 2020 10:44:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200205094828.77940-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/2/20 10:48, Andy Shevchenko wrote:
> Replace with appropriate types.h.
> 
> Also there is no need to include device.h, but mutex.h.
> For the pointers to unknown structures use forward declarations.
> 
> In the *.c files we need to include all headers that provide APIs
> being used in the module.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Queued for 5.7, thanks.
