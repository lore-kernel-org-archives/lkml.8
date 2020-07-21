Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AFDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603FB206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgGUPKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:10:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:21379 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgGUPKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:10:39 -0400
IronPort-SDR: ms318p0UH9Q7a6+aFDaYmOyOmHUtv3ScMXBz9A8w7f9zVq16kgyxb072RwRj3LacyTUD2cFB6w
 LJpvxR7AmZmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="137638742"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="137638742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 08:10:38 -0700
IronPort-SDR: gqs9NAZaX6QyRmoHUJUMjXKZ9RxkBRWR5NLJDHpzkR3buOgZRYTTuV/761O6QGVOT3geQyROlP
 46CX+ipLXKcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="326398431"
Received: from jacoraci-mobl.amr.corp.intel.com ([10.212.210.224])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2020 08:10:38 -0700
Message-ID: <c76c51bfa78316caaf8201a63ac200fa373ae3ae.camel@linux.intel.com>
Subject: Re: [PATCH] isst: isst_if.h: drop a duplicated word
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Date:   Tue, 21 Jul 2020 08:10:37 -0700
In-Reply-To: <20200719002903.20469-1-rdunlap@infradead.org>
References: <20200719002903.20469-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-18 at 17:29 -0700, Randy Dunlap wrote:
> Drop the repeated word "for" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> This description could still use some better wording.

I will fix the wording in a follow up patch.

>  include/uapi/linux/isst_if.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/include/uapi/linux/isst_if.h
> +++ linux-next-20200717/include/uapi/linux/isst_if.h
> @@ -69,7 +69,7 @@ struct isst_if_cpu_maps {
>   * @logical_cpu:	Logical CPU number to get target PCI device.
>   * @reg:		PUNIT register offset
>   * @value:		For write operation value to write and for
> - *			for read placeholder read value
> + *			read placeholder read value
>   *
>   * Structure to specify read/write data to PUNIT registers.
>   */

