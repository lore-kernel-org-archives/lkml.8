Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A2C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6245720409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCWXBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:01:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:26246 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:01:19 -0400
IronPort-SDR: nZRcagTbDknFulPRrDVKGJ5vudG5DYN7RvYUNEdgVeqzlQnMOzi5amezxfTNA2O3DnjciLTmOu
 exPIHh4SD1pQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:01:13 -0700
IronPort-SDR: 63L9BKLoOyhbYTG1gj60ZxljqPCG74hvFUzHVqHYkdYLU2uVX8C/WpO6r95vZtLh5lf/rZhpu+
 OBngCE5zvw1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419673469"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 16:01:13 -0700
Date:   Mon, 23 Mar 2020 16:01:13 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200323230113.GA84386@otc-nc-03>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200320092955.GA1702630@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320092955.GA1702630@myrica>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean

On Fri, Mar 20, 2020 at 10:29:55AM +0100, Jean-Philippe Brucker wrote:
> > +#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
> > +struct iommu_sva *
> > +intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> > +{
> > +	struct iommu_sva *sva = ERR_PTR(-EINVAL);
> > +	struct intel_svm_dev *sdev = NULL;
> > +	int flags = 0;
> > +	int ret;
> > +
> > +	/*
> > +	 * TODO: Consolidate with generic iommu-sva bind after it is merged.
> > +	 * It will require shared SVM data structures, i.e. combine io_mm
> > +	 * and intel_svm etc.
> > +	 */
> > +	if (drvdata)
> > +		flags = *(int *)drvdata;
> 
> drvdata is more for storing device driver contexts that can be passed to
> iommu_sva_ops, but I get that this is temporary.
> 
> As usual I'm dreading supervisor mode making it into the common API. What
> are your plans regarding SUPERVISOR_MODE and PRIVATE_PASID flags?  The
> previous discussion on the subject [1] had me hoping that you could
> replace supervisor mode with normal mappings (auxiliary domains?)
> I'm less worried about PRIVATE_PASID, it would just add complexity into

We don't seem to have an immediate need for PRIVATE_PASID. There are some talks
about potential usages, but nothing concrete. I think it might be good to
get rid of it now and add when we really need.

For SUPERVISOR_MODE, the idea is to have aux domain. Baolu is working on
something to replace. Certainly the entire kernel address is opening up 
the whole kimono.. so we are looking at dynamically creating mappings on demand. 
It might take some of the benefits of SVA in general with no need to create
mappings, but for security somebody has to pay the price :-)

Cheers,
Ashok


> the API and iommu-sva implementation, but doesn't really have security
> implications.
> 
> [1] https://lore.kernel.org/linux-iommu/20190228220449.GA12682@araj-mobl1.jf.intel.com/
