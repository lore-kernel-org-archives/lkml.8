Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBDAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C8320738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgHDK4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:56:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:30872 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbgHDK4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:56:53 -0400
IronPort-SDR: dwA5Z+dNBSjKEXfmxYOW7onJDA3OLXZuHXxqdzzoqgepxyYg2Hpd8NHbqmlcmF2mAEFJKvscOO
 8Nl3KxCE9EWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170373297"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="170373297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 03:56:53 -0700
IronPort-SDR: GA/hxUYtLCY4tWeJlOq1OnY61DR1NJPKT9f5Z7/8Xcbk03qNHUzQWKkSNKxM5oyKoapbkO+bGM
 Y/ziYhlodoUw==
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="306309145"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 03:56:51 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id AD7DF20606; Tue,  4 Aug 2020 13:56:49 +0300 (EEST)
Date:   Tue, 4 Aug 2020 13:56:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: add sanity check in nvmem_device_read()
Message-ID: <20200804105649.GG13316@paasikivi.fi.intel.com>
References: <1596532436-19073-1-git-send-email-bingbu.cao@intel.com>
 <20200804095815.GF13316@paasikivi.fi.intel.com>
 <0e8d60cf-7f8b-c6ab-4184-b869c16b603e@linaro.org>
 <48f2d716-dad9-054d-d049-452fa272d53b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48f2d716-dad9-054d-d049-452fa272d53b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 06:44:27PM +0800, Bingbu Cao wrote:
> 
> On 8/4/20 6:03 PM, Srinivas Kandagatla wrote:
> > 
> > 
> > On 04/08/2020 10:58, Sakari Ailus wrote:
> >> Hi Bingbu,
> >>
> >> Thank you for the patch.
> >>
> >> On Tue, Aug 04, 2020 at 05:13:56PM +0800, Bingbu Cao wrote:
> >>> nvmem_device_read() could be called directly once nvmem device
> >>> registered, the sanity check should be done before call
> >>> nvmem_reg_read() as cell and sysfs read did now.
> >>>
> >>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> >>> ---
> >>>   drivers/nvmem/core.c | 7 +++++++
> >>>   1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> >>> index 927eb5f6003f..c9a77993f008 100644
> >>> --- a/drivers/nvmem/core.c
> >>> +++ b/drivers/nvmem/core.c
> >>> @@ -1491,6 +1491,13 @@ int nvmem_device_read(struct nvmem_device *nvmem,
> >>>       if (!nvmem)
> >>>           return -EINVAL;
> >>>   +    if (offset >= nvmem->size || bytes < nvmem->word_size)
> >>> +        return 0;
> >>> +
> >>> +    if (bytes + offset > nvmem->size)
> >>> +        bytes = nvmem->size - offset;
> >>
> >> The check is relevant for nvmem_device_write(), too.
> >>
> >> There are also other ways to access nvmem devices such as nvmem_cell_read
> >> and others alike. Should they be considered as well?
> > 
> > We should probably move these sanity checks to a common place like
> > nvmem_reg_read() and nvmem_reg_write(), so the callers need not duplicate the same!
> > 
> Srini and Sakari, thanks for your review.
> 
> Is it OK just return INVAL with simple check like below?
> 
> if (bytes + offset > nvmem->size ||
>     bytes != round_down(bytes, nvmem->word_size))
>         return -EINVAL;

This changes what is currently supported so I'd say no.

-- 
Sakari Ailus
