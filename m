Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD774C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB4E2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMSGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:06:01 -0500
Received: from muru.com ([72.249.23.125]:50764 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMSGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:06:01 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1E4F98047;
        Mon, 13 Jan 2020 18:06:43 +0000 (UTC)
Date:   Mon, 13 Jan 2020 10:05:58 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Use ARM SMC Calling Convention when OP-TEE is
 available
Message-ID: <20200113180558.GM5885@atomide.com>
References: <20200102211943.20480-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102211943.20480-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [200102 21:20]:
> Hello all,
> 
> This is the reworked patch turned into a series to allow upstream kernels
> to make use of OP-TEE on the OMAP2+ platform.
> 
> Thanks,
> Andrew
> 
> Changes from v1:
>  - Split into logical patches
>  - Check for OP-TEE in DT only once
>  - Check the OP-TEE node is "okay"
> 
> Changes from v2:
>  - Add HS patch using 'optee_available'
> 
> Changes from v3:
>  - Add comments as suggested by Tony and Lokesh

Thanks applying into omap-for-v5.6/soc.

Regards,

Tony
