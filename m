Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A9C433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FFB20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgGWDXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:23:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:61441 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbgGWDXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:23:24 -0400
IronPort-SDR: vcKrXicXSXcjbEJPYLpWcTua71NTWMMFMBm/BO21zuyYZ0X3FNAb6aO/77l7KQ1t0I3JKsuxHE
 QZHjt2QPnLxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="147953208"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="147953208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 20:23:24 -0700
IronPort-SDR: 3kKotiZApIQY8Zk2u+X+59Xne0H1eXvgGZL4/h8gyTCHEB7kIbgJ7uUNKQti+CwJy3nbKNfrMa
 GhvbK1jmMoOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="270924049"
Received: from aghafar1-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.58.209])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2020 20:23:18 -0700
Date:   Thu, 23 Jul 2020 06:23:17 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200723032317.GA50398@linux.intel.com>
References: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
 <20200529152756.GA7452@invisiblethingslab.com>
 <ef8bbdff-e891-bee3-677d-3606474ecc10@cs.unc.edu>
 <20200625213705.GF20341@linux.intel.com>
 <a6e45675-a7f0-7708-6cc6-318a947e2e57@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e45675-a7f0-7708-6cc6-318a947e2e57@cs.unc.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 02:19:52PM -0400, Don Porter wrote:
> On 6/25/20 5:37 PM, Jarkko Sakkinen wrote:
> > 
> > Can unmodified Graphene-SGX used with these changes?
> > 
> 
> Yes.  I just double-checked that all of the needed changes have made it to
> master branch.
> 
> I also re-tested on 5.8-rc1 with v13 of the patch, and it looks good.

OK, cool, have to play with this once I'm back from vacation (away
WW31-WW32). Thanks for the info.

/Jarkko
