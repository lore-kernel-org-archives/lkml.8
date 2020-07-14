Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1852224D3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGNNyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:54:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:33363 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNNyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:54:50 -0400
IronPort-SDR: DfQ4pygSGIKCWICuBzK2GxdfELpJaN+3QJRCzuj7ImTAHpFioEkrBeR/QKbjnAkiRHcHmGyA/d
 HChDdavJa1nA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150318980"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="150318980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 06:54:50 -0700
IronPort-SDR: +XxidMzrv1a/8/8wXZ7LcHaInmy7T6RrqjR1IZ3hUJ3l6CBXlDbbvF1v1Acu2ApZ+1FOxRdw/u
 m41TaWmbXY1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="485370296"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 06:54:49 -0700
Date:   Tue, 14 Jul 2020 06:54:49 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6 01/12] iommu: Change type of pasid to u32
Message-ID: <20200714135449.GI32961@romley-ivt3.sc.intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
 <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 07:45:49PM -0700, Liu, Yi L wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Sent: Tuesday, July 14, 2020 7:48 AM
> >
> > PASID is defined as a few different types in iommu including "int",
> > "u32", and "unsigned int". To be consistent and to match with uapi
> > definitions, define PASID and its variations (e.g. max PASID) as "u32".
> > "u32" is also shorter and a little more explicit than "unsigned int".
> >
> > No PASID type change in uapi although it defines PASID as __u64 in
> > some places.
> 
> just out of curious, why not using ioasid_t? In Linux kernel, PASID is
> managed by ioasid.

ioasid_t is only used in limited underneath files (ioasid.c and ioasid.h).
Instead of changing hundreds of places to use ioasid_t, it's better to
keep ioasid_t only used in the files.

And it's explict and matches with uapi to define PASID as u32. Changing
to ioasid_t in so many files (amd, gpu, crypto, etc) may confuse upper
users on "why ioasid_t".

So we had better to explicitly define PASID as u32 and keep ioasid_t in
the limited underneath files.

Thanks.

-Fenghua
