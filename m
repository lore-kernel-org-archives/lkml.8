Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DB82051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgCPPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:53:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:22093 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbgCPPxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:53:02 -0400
IronPort-SDR: 5qpzMdLW4e7mVkA5hOmjA/0d475lmih4dlr4TLBaihaQTiIfwyRWBD4I7veemIybtLrI0BjjX4
 29o5KYP8hJhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 08:53:01 -0700
IronPort-SDR: m4qk9cjU9K3K1Ux+eirr3VL+FhWHBJq/X9VBy52QQ2LBz76EJkIaosYfwm1yVsEqrGe+PpH2Qh
 Liuv+4FUNDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="233203982"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2020 08:53:01 -0700
Subject: Re: [PATCH 0/2] Patches for firmware
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org, dinguyen@kernel.org,
        Richard Gong <richard.gong@intel.com>
References: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <7c63fe9d-d8fb-b3ea-7ec8-2bb136cc512b@linux.intel.com>
Date:   Mon, 16 Mar 2020 11:10:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Sorry for asking.

When you get chance, please help to take these 2 firmware patches.

Regards,
Richard

On 3/5/20 11:12 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Hi Greg,
> 
> Please take these 2 firmware patches, which are changes for Intel
> Service Layer driver.
> 
> Those patches have been reviewed on the mailing list and applied cleanly
> on current linux-next.
> 
> Thanks,
> Richard
> 
> Richard Gong (2):
>    firmware: stratix10-svc: add the compatible value for intel agilex
>    firmware: intel_stratix10_service: add depend on agilex
> 
>   drivers/firmware/Kconfig         | 2 +-
>   drivers/firmware/stratix10-svc.c | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
