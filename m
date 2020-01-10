Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF901C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E92080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgAJS3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:29:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:61558 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgAJS3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:29:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 10:29:30 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218732927"
Received: from agluck-desk2.amr.corp.intel.com ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 10:29:30 -0800
Date:   Fri, 10 Jan 2020 10:29:29 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Chuansheng Liu <chuansheng.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH v2] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Message-ID: <20200110182929.GA20511@agluck-desk2.amr.corp.intel.com>
References: <20200107004116.59353-1-chuansheng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107004116.59353-1-chuansheng.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:41:16AM +0000, Chuansheng Liu wrote:
> In my ICL platform, it can be reproduced in several times
> of reboot stress. With this fix, the system keeps alive
> for more than 200 times of reboot stress.
> 
> V2: Boris shares a good suggestion that we can moving the
> interrupt unmasking at the end of therm_work initialization.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>

Looks good to me:

Acked-by: Tony Luck <tony.luck@intel.com>
