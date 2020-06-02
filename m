Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC12206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFBWTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:19:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:40692 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbgFBWTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:19:22 -0400
IronPort-SDR: k2vT3/Vn0qpjgLAXGV2zOc+xR7kF5qxuY/4iKu/uqJV9edJQ1EAn47lRrUkOBOxyOL+kgWQOYT
 FaHg0X8gV1fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 15:19:21 -0700
IronPort-SDR: nxLteX2ZmSUuqHH4eXQGDxZEOw8X9TozrlcGrspPl0xRqFGlV1NAiEQM+las5z2VuwZ8mb0xhz
 BptSwpm1A3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="304163743"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2020 15:19:21 -0700
Date:   Tue, 2 Jun 2020 15:17:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] x86/resctrl: fix a NULL vs IS_ERR() static checker
 warning
Message-ID: <20200602221727.GA59412@romley-ivt3.sc.intel.com>
References: <20200602193611.GA190851@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602193611.GA190851@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:36:11PM +0300, Dan Carpenter wrote:
> The callers don't expect *d_cdp to be set to an error pointer, they only
> check for NULL.  This leads to a static checker warning:
> 
>     arch/x86/kernel/cpu/resctrl/rdtgroup.c:2648 __init_one_rdt_domain()
>     warn: 'd_cdp' could be an error pointer
> 
> This would not trigger a bug in this specific case because
> __init_one_rdt_domain() calls it with a valid domain that would not have
> a negative id and thus not trigger the return of the ERR_PTR(). If this
> was a negative domain id then the call to rdt_find_domain() in
> domain_add_cpu() would have returned the ERR_PTR() much earlier and the
> creation of the domain with an invalid id would have been prevented.
> 
> Even though a bug is not triggered currently the right and safe thing to
> do is to set the pointer to NULL because that is what can be checked for
> when the caller is handling the CDP and non-CDP cases.
> 
> Fixes: 52eb74339a62 ("x86/resctrl: Fix rdt_find_domain() return value and checks")

Acked-by: Fenghua Yu <fenghua.yu@intel.com>
