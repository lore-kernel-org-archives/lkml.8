Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEADC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D5207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIBVi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:38:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:39501 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBVi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:38:58 -0400
IronPort-SDR: JVUR8B9IP/ddXmEt2fVDvZVAJW4J6LZjT48j0iPG5E/+Koi+7cZmReKIJSYAh7zJXPcb2AQgfZ
 k/Ni08lr9kNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="175532335"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="175532335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 14:38:58 -0700
IronPort-SDR: R74Gpyyhve4xHettzn6a1t0Z9R83rkUlGOsa8XP8RCEr0J7K3iV8D7cgW5oHmkIDB3GkrFpHyl
 dpTz1U/zB2/g==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="325946433"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 14:38:58 -0700
Date:   Wed, 2 Sep 2020 14:46:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.pan.linux@gmail.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Wu Hao <hao.wu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
Message-ID: <20200902144604.33595c0d@jacob-builder>
In-Reply-To: <a6bc666c-d327-998b-b740-d03b9f0f5ffc@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200824182848.GB3210689@myrica>
        <a6bc666c-d327-998b-b740-d03b9f0f5ffc@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 11:30:47 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
> >> +/**
> >> + * struct ioasid_data - Meta data about ioasid
> >> + *
> >> + * @id:		Unique ID
> >> + * @users	Number of active users
> >> + * @state	Track state of the IOASID
> >> + * @set		Meta data of the set this IOASID belongs to
> >> + * @private	Private data associated with the IOASID
> >> + * @rcu		For free after RCU grace period  
> > nit: it would be nicer to follow the struct order  
> 
> and use a ':' after each struct member name, as is done for @id:
> 
Got it, thanks.
