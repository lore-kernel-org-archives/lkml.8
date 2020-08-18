Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2078C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853DC20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHRIkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:40:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:40470 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgHRIki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:40:38 -0400
IronPort-SDR: T9R1fIU2ryonDXheVzsQIsdXIECAukWDZyc9KZWzhKhQVPqQVEb+Xt+LSlPnOikUPKaqBKa78I
 KBeF3WNjd21g==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216388157"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="216388157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 01:40:37 -0700
IronPort-SDR: IyUEvBF20eM7Hhc/CZ3qTnf0ZmrCmOt13gqRWqWoG9St1mIjB8NkWCQimi3/J5zs6pS031RCB1
 4ol/IsdRznOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="471722425"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2020 01:40:32 -0700
Date:   Tue, 18 Aug 2020 16:36:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-ID: <20200818083647.GE22873@yilunxu-OptiPlex-7050>
References: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
 <20200817082410.GB19661@yilunxu-OptiPlex-7050>
 <20200817091252.GV4354@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817091252.GV4354@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:12:52AM +0100, Lee Jones wrote:
> On Mon, 17 Aug 2020, Xu Yilun wrote:
> 
> > Hi Brown & jones:
> > 
> > I tried to refacor the regmap code and add comments in this patchset. I
> > made big changes to the rx flow and remove some tricky parts in it.
> > 
> > Would it be more understandable than last version? I'm expecting your
> > comments on it when you have time, thanks in advance.
> 
> Just resubmit please.  We can review the code itself.

Ok. I'll rebase it to 5.9-rc1 and resubmit it.

Thanks,
Yilun

> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
