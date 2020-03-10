Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E4EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6877B24677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgCJNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:49:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:22466 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCJNtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:49:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="260793292"
Received: from akharche-mobl2.ccr.corp.intel.com (HELO localhost) ([10.251.86.23])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2020 06:49:01 -0700
Date:   Tue, 10 Mar 2020 15:49:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the tpmdd tree
Message-ID: <20200310134900.GB32334@linux.intel.com>
References: <20200310004629.5a752080@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310004629.5a752080@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:46:29AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   4eecda6b7df2 ("tpm: tpm_tis_spi_cr50: use new structure for SPI transfer delays")
>   0fbd8fe52759 ("tpm_tis_spi: use new 'delay' structure for SPI transfer delays")
> 
> are missing a Signed-off-by from their committer.
> 
> Not really, but "Signed-off-by" is misspelled.  Please fix up what ever
> script produces this (or your finger memory :-)).

Sure thing!

Backtracked to a manual typo in a filter-branch spell. I'll convert my
regulary used fb-spells as scripts to counter measure this in the future.

/Jarkko
