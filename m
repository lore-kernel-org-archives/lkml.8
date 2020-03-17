Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A560C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EC020663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgCQHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:46:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56810 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:46:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E704128A3FD
Subject: Re: [PATCH v2 0/3] platform/chrome: notify: Use PD_HOST_EVENT_STATUS
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>
References: <20200316082831.242516-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0f5a0385-0d13-4558-8e25-3765220d2e3d@collabora.com>
Date:   Tue, 17 Mar 2020 08:46:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316082831.242516-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 16/3/20 9:28, Prashant Malani wrote:
> This series improves the PD notifier driver to get the
> EC_CMD_PD_HOST_EVENT_STATUS bits from the Chrome EC, and send those to
> the notifier listeners. Earlier, the "event" param of the notifier was
> always being hard-coded to a single value (corresponding to PD_MCU
> events on ACPI and DT platforms) which wasn't of much use to the
> listeners.
> 
> Changes in v2:
> - Fixed unnecessary error checks.
> - Removed extraneous dev_info prints about device registration.
> - Rixed pd_command() return codes to be standard Linux error codes.
> 
> v1: https://lkml.org/lkml/2020/3/12/287
> 
> Prashant Malani (3):
>   platform/chrome: notify: Add driver data struct
>   platform/chrome: notify: Amend ACPI driver to plat
>   platform/chrome: notify: Pull PD_HOST_EVENT status
> 
>  drivers/platform/chrome/cros_usbpd_notify.c | 183 +++++++++++++++++---
>  1 file changed, 160 insertions(+), 23 deletions(-)
> 

Queued all for 5.7. Thanks.

~ Enric
