Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DFBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC924207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgE0IUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:20:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:51898 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387610AbgE0IUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:20:13 -0400
IronPort-SDR: mASz4X5Q5S3jVGasOi4+tr3SFcQ3Zw44s4m86DyYPa9051V81Q+y/vwt7lP7hX0akZ0HhHIDd6
 VSuZ1azGNm5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:20:12 -0700
IronPort-SDR: Vkrfy2pofcn0ByQPZKPgniWVF8eN83YDP6fLrkQQlWpI7m2tz9JwcVcyx7y4AlKj0QQH6AsNB3
 foCDBL3jQBmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="302019772"
Received: from rharrie2-mobl.ger.corp.intel.com ([10.252.56.247])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2020 01:20:09 -0700
Message-ID: <1276588f1ea395bdedf8b5e3af15666f0095dc0d.camel@linux.intel.com>
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Don Porter <porter@cs.unc.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Date:   Wed, 27 May 2020 11:20:08 +0300
In-Reply-To: <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
References: <20200511045311.4785-1-sashal@kernel.org>
         <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
         <20200515164013.GF29995@sasha-vm>
         <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
         <20200518153407.GA499505@tassilo.jf.intel.com>
         <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
         <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
         <20200519164853.GA19706@linux.intel.com>
         <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 16:14 -0400, Don Porter wrote:
> legacy code in SGX.  We have been following LKML discussions on this 
> instruction for years, and hoping this feature would be supported by 
> Linux, so that we can retire this module.  To our knowledge, every SGX 

Why have you followed this for years and never tried the patches?

/Jarkko

