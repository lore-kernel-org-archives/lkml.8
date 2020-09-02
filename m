Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36094C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4DE207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIBVkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:40:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:39576 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:40:00 -0400
IronPort-SDR: 9xUbG0934/O4+mvBeZ3XtwGC2wcZzXFbdvheTEPYPVXlG4rqP7lw0KeQqA13LYOmC+vzDMVKkC
 GtymY9lQPjWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="175532402"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="175532402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 14:39:59 -0700
IronPort-SDR: 3aN1bVBGjYGTxOItKGjSaxdAAnK0XFpwLvwn33eSYR7d579dGO4MNdI00YPL/2qu7AkYJRhHaH
 WB2X0WmURgiQ==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="331572226"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 14:39:59 -0700
Date:   Wed, 2 Sep 2020 14:47:06 -0700
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
Message-ID: <20200902144706.331e1032@jacob-builder>
In-Reply-To: <1be98989-fab3-f9e4-cbd6-cf72a67dc5f1@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200824182848.GB3210689@myrica>
        <1be98989-fab3-f9e4-cbd6-cf72a67dc5f1@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 11:34:29 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
> >> +/**
> >> + * struct ioasid_set - Meta data about ioasid_set
> >> + * @type:	Token types and other features  
> > nit: doesn't follow struct order
> >   
> >> + * @token:	Unique to identify an IOASID set
> >> + * @xa:		XArray to store ioasid_set private IDs, can be used for
> >> + *		guest-host IOASID mapping, or just a private IOASID namespace.
> >> + * @quota:	Max number of IOASIDs can be allocated within the set
> >> + * @nr_ioasids	Number of IOASIDs currently allocated in the set  
> 
>  * @nr_ioasids: Number of IOASIDs currently allocated in the set
> 
got it. thanks!

> >> + * @sid:	ID of the set
> >> + * @ref:	Reference count of the users
> >> + */
> >>  struct ioasid_set {
> >> -	int dummy;
> >> +	void *token;
> >> +	struct xarray xa;
> >> +	int type;
> >> +	int quota;
> >> +	int nr_ioasids;
> >> +	int sid;
> >> +	refcount_t ref;
> >> +	struct rcu_head rcu;
> >>  };  
> 
> 

[Jacob Pan]
