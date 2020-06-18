Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24988206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgFRPhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:37:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:42434 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgFRPhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:37:48 -0400
IronPort-SDR: CNNBvHKsDM5GSohAS/CjD9gyPyD1GErxSc3fgE4GVQsBj0U+rRBkMPtO0GiRzinSGlU3BC4D0w
 3G68RYre8QJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="129979308"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="129979308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:37:47 -0700
IronPort-SDR: CzS5MoOz9LW2W8ufcf7VltJ40EwQvdPZ9f1UIByPKyXcF7fjAaxqMgTRiN1ED9CIyfAtjpBrfb
 JU43hSx3nDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="291807299"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2020 08:37:47 -0700
Date:   Thu, 18 Jun 2020 08:37:47 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 02/12] ocxl: Change type of pasid to unsigned int
Message-ID: <20200618153747.GE15763@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-3-git-send-email-fenghua.yu@intel.com>
 <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frederic,

On Thu, Jun 18, 2020 at 10:05:19AM +0200, Frederic Barrat wrote:
> 
> 
> Le 13/06/2020 à 02:41, Fenghua Yu a écrit :
> >PASID is defined as "int" although it's a 20-bit value and shouldn't be
> >negative int. To be consistent with type defined in iommu, define PASID
> >as "unsigned int".
> 
> 
> It looks like this patch was considered because of the use of 'pasid' in
> variable or function names. The ocxl driver only makes sense on powerpc and
> shouldn't compile on anything else, so it's probably useless in the context
> of that series.
> The pasid here is defined by the opencapi specification
> (https://opencapi.org), it is borrowed from the PCI world and you could
> argue it could be an unsigned int. But then I think the patch doesn't go far
> enough. But considering it's not used on x86, I think this patch can be
> dropped.

The first 3 patches clean up pasid and flag defitions to prepare for
following patches.

If you think this patch can be dropped, we will drop it.

Thanks.

-Fenghua
