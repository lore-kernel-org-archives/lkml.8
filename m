Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C652076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394015AbgDOO3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729358AbgDOO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:29:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B044C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:29:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D6E452A0156
Subject: Re: [PATCH v4 0/3] platform/chrome: typec: Add port partner
 registration
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200415052943.93009-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3279b538-3f68-c2f4-814b-ad64969b29e4@collabora.com>
Date:   Wed, 15 Apr 2020 16:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415052943.93009-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 15/4/20 7:29, Prashant Malani wrote:
> The following series adds port-partner registration when
> connects/disconnects are detected. In order to do that, we also register
> a listener for the cros-usbpd-notifier, which will inform the driver of
> EC PD events. While we are here, separate out the Type C port data
> objects into a separate struct.
> 
> v3: https://lkml.org/lkml/2020/4/9/868
> v2: https://lkml.org/lkml/2020/4/9/861
> v1: https://lkml.org/lkml/2020/4/6/1155
> 
> Changes in v4:
> - Modified typec_register_partner() error check.
> 
> Prashant Malani (3):
>   platform/chrome: typec: Use notifier for updates
>   platform/chrome: typec: Add struct for port data
>   platform/chrome: typec: Register port partner
> 
>  drivers/platform/chrome/Kconfig         |   1 +
>  drivers/platform/chrome/cros_ec_typec.c | 119 ++++++++++++++++++++----
>  2 files changed, 103 insertions(+), 17 deletions(-)
> 

Queued all the patches for 5.8

Thanks,
 Enric
