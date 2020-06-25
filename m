Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A2EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4651E206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404410AbgFYL40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404285AbgFYL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:56:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412EDC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:56:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6D12D2A50E0
Subject: Re: [PATCH 0/4] platform/chrome: typec: Add mux support
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@google.com>
References: <20200528113607.120841-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fa79e7e4-08cd-1d9e-d8d7-71a50edcc4a2@collabora.com>
Date:   Thu, 25 Jun 2020 13:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200528113607.120841-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 28/5/20 13:36, Prashant Malani wrote:
> This series adds mux control support for USB and DP alternate modes on
> devices using the cros-ec-typec driver with Type C switch handles
> provided by firmware bindings.
> 
> The first patch imports some recent updates to the
> EC_CMD_USB_PD_MUX_INFO bit fields from the Chrome EC
> code base[1], while the rest add the aforementioned functionality.
> 
> This series depends on the following patch :
> https://lkml.org/lkml/2020/5/19/1219
> 
> [1] : https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h
> 
> Prashant Malani (4):
>   platform/chrome: cros_ec: Update mux state bits
>   platform/chrome: typec: Register PD CTRL cmd v2
>   platform/chrome: typec: Add USB mux control
>   platform/chrome: typec: Support DP alt mode
> 
>  drivers/platform/chrome/cros_ec_typec.c       | 190 ++++++++++++++++--
>  .../linux/platform_data/cros_ec_commands.h    |  14 +-
>  2 files changed, 187 insertions(+), 17 deletions(-)
> 

Tweaked a bit the subject, s/typec/cros_ec_typec/ and queued the four patches
for 5.9.

Thanks,
 Enric
