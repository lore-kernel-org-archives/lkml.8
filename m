Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDCBC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC1F2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIAJHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:07:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52406 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:07:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3E66A299342
Subject: Re: [PATCH v5 0/3] TypeC Connector Class driver improvements
To:     Azhar Shaikh <azhar.shaikh@intel.com>, bleung@chromium.org,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, rajmohan.mani@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com
References: <20200821214724.20056-1-azhar.shaikh@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <94a80152-a5d5-79d9-dfee-b7ea0ba20ad4@collabora.com>
Date:   Tue, 1 Sep 2020 11:07:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821214724.20056-1-azhar.shaikh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azhar,

On 21/8/20 23:47, Azhar Shaikh wrote:
> Changes in v5:
> 
> * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
>             usb_role_switch_set_role()"
>   - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
> 
> * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
>             during disconnect"
>   - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
>   - Added Reviewed-by from v4
> 
> * Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
>             configuration steps"
>   - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
>   - Added Reviewed-by from v4
> 
> Changes in v4:
> * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
>             usb_role_switch_set_role()"
>   - Remove extra line between Fixes and Signed-off tag.
>   - Added Reviewed-by and Cc tags from v1 and v2.
> 
> * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
>             during disconnect"
>   - Added Suggested-by from v2.
> 
> * Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
>             configuration steps"
>   - No change
> 
> Changes in v3:
> * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
>             usb_role_switch_set_role()"
>  - No change
> 
> * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
>             during disconnect"
>  - Move the location of calling usb_role_switch_set_role() to
>    end of function in cros_typec_configure_mux() to avoid any change
>    in code flow.
> 
> * Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
>             configuration steps"
>  - New patch added
> 
> Changes in v2:
> * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
>             usb_role_switch_set_role()"
>   - Update the commit message to change 'USB_ROLE_HOST in case of
>     UFP.'  to 'USB_ROLE_HOST in case of DFP.'
> 
> * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
>             during disconnect"
>   - New patch added.
> 
> Azhar Shaikh (3):
>   platform/chrome: cros_ec_typec: Send enum values to
>     usb_role_switch_set_role()
>   platform/chrome: cros_ec_typec: Avoid setting usb role twice during
>     disconnect
>   platform/chrome: cros_ec_typec: Re-order connector configuration steps
> 
>  drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 


The three patches of this series have been queued for 5.10.

Thanks,
 Enric
