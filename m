Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B58C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E027C20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCEJA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:00:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCEJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:00:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CFD51283C93
Subject: Re: chrome platform Kconfig typo
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
References: <e5618826-6a5a-08a7-d261-e2eecb1348ce@infradead.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b992473c-45ff-6cd5-3b09-0c1947d76e1d@collabora.com>
Date:   Thu, 5 Mar 2020 10:00:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e5618826-6a5a-08a7-d261-e2eecb1348ce@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 5/3/20 8:11, Randy Dunlap wrote:
> 
> from drivers/platform/chrome/Kconfig:
> 
> config MFD_CROS_EC
> 	tristate "Platform support for Chrome hardware (transitional)"
> 	select CHROME_PLATFORMS
> 	select CROS_EC
> 	select CONFIG_MFD_CROS_EC_DEV   <<<<<<<<<<<<<<<<<<<<<<   drop the /CONFIG_/ <<<<<<<<<<<<<<

Thanks for the report I'll send a patch. Our plan was remove this config at some
point and that makes me think if this transitional config was ever useful, seems
there is still a defconfig using it, though, so we can't remove yet.

> 	depends on X86 || ARM || ARM64 || COMPILE_TEST
> 	help
> 	  This is a transitional Kconfig option and will be removed after
> 	  everyone enables the parts individually.
> 
> 
