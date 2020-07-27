Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A698C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E052075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgG0NDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:03:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:54684 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgG0NDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:03:23 -0400
IronPort-SDR: T9I0GywVMs5N+1zZokssczZf4oaznJzaxAFjw9VXiqHnrqETX7DCrOrRNIzB2p79QrHFjYl16T
 lTeMNbFDP7MA==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="212530980"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="212530980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 06:03:10 -0700
IronPort-SDR: q9DQZ7YNrIoN2Xz2vlS3z+dHECqw6VqFZWyNPw9tY4ndMZwAy9sN+EN9LuG6R5os6SM95CxeAe
 nucbnZzHBk8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="433922627"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga004.jf.intel.com with ESMTP; 27 Jul 2020 06:03:10 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: Replace Thor Thayer as Altera Triple Speed
 Ethernet maintainer
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>
References: <20200727094641.174870-1-joyce.ooi@intel.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <37251f15-b8ce-1dd8-9ebb-b995f147c792@linux.intel.com>
Date:   Mon, 27 Jul 2020 08:03:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200727094641.174870-1-joyce.ooi@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 4:46 AM, Ooi, Joyce wrote:
> From: Joyce Ooi <joyce.ooi@intel.com>
> 
> This patch is to replace Thor Thayer as Altera Triple Speed Ethernet
> maintainer as he is moving to a different role.
> 
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64cdde81851..9e6789e1d168 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -782,7 +782,7 @@ F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
>   F:	include/linux/mfd/altera-a10sr.h
>   
>   ALTERA TRIPLE SPEED ETHERNET DRIVER
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/net/ethernet/altera/
> 

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
