Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0C920774
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGYCUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:20:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:45289 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgGYCUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:20:06 -0400
IronPort-SDR: /WROuQKLt78JRGXsL/4l9Lty6xH/5gMET90Y6AsP61COQ3EjYEQtD+97sOKDAk38tgGLl+5vTM
 /cy4wbj1ZeJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130883739"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="130883739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 19:20:06 -0700
IronPort-SDR: E0YyHVaOEDusA67xm0IGVA/qNY+7MWnlTT1JY03GWazN1WmgsL5KI+W6b/TlwOBFN0U5C600Yf
 2LrOlIXep48w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="489391139"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2020 19:20:02 -0700
Date:   Sat, 25 Jul 2020 05:20:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/6] vmalloc: Add text_alloc() and text_free()
Message-ID: <20200725022000.GB17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-3-jarkko.sakkinen@linux.intel.com>
 <20200724102243.GA2831654@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724102243.GA2831654@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:22:43PM +0300, Mike Rapoport wrote:
> On Fri, Jul 24, 2020 at 08:05:49AM +0300, Jarkko Sakkinen wrote:
> > Introduce functions for allocating memory for dynamic trampolines, such
> > as kprobes. An arch can promote the availability of these functions with
> > CONFIG_ARCH_HAS_TEXT_ALLOC.
> 
> As it was pointed out at the discussion on the previous version [1],
> text_alloc() alone won't necessarily suit other architectures.
>  
> I don't see a point in defining a "generic" interface that apriory could
> not be imeplemented by several architectures.
> 
> [1] https://lore.kernel.org/lkml/20200714094625.1443261-1-jarkko.sakkinen@linux.intel.com/

These changes do actually acknowledge the feedback [1][2][3]. They do not
interfere with module_alloc() and are fully optional.

[1] https://lore.kernel.org/linux-riscv/20200714102826.GB4756@willie-the-truck/
[2] https://lore.kernel.org/linux-riscv/20200714164245.GE1551@shell.armlinux.org.uk/
[3] https://lore.kernel.org/linux-riscv/20200714135651.GA27819@linux-8ccs/

/Jarkko
