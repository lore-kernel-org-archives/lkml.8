Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A17C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF60222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgCJWW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:22:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:9772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCJWW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:22:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="415353254"
Received: from jbrandeb-desk4.amr.corp.intel.com (HELO localhost) ([10.166.241.50])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2020 15:22:25 -0700
Date:   Tue, 10 Mar 2020 15:22:25 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@rasmusvillemoes.dk>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200310152225.00002327@intel.com>
In-Reply-To: <20200225125030.GL18400@hirez.programming.kicks-ass.net>
References: <20200224225020.2212544-1-jesse.brandeburg@intel.com>
        <20200225103050.GD10400@smile.fi.intel.com>
        <20200225125030.GL18400@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 13:50:30 +0100 Peter wrote:
> On Tue, Feb 25, 2020 at 12:30:50PM +0200, Andy Shevchenko wrote:
> 
> > I think it is a C standard which dictates this, compiler just follows.  
> 
> Correct, a semi readable explanation of this:
> 
>   https://stackoverflow.com/questions/46073295/implicit-type-promotion-rules

Thanks! I sent a v6 with a reworded explanation and link to the above.
