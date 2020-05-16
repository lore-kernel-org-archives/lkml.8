Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD94C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDE0207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgEPMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:21:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:40967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgEPMVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:21:11 -0400
IronPort-SDR: D7ST/xiMIg6iJLqYuhWeDdH92Yd6ichsYCVNsx51lKJPznBNn5QRNjqfeFKl0KyO83dwaI+Fdr
 o2XKGygB5GAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 05:21:11 -0700
IronPort-SDR: sqNFnfn6/3GsBFxZeUWVfwbPj2OofvafDAdeZ11Ok8vxej578NFxZvq23Fd0gA1Tzxr1IaqKgT
 iAlyWhPbOyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="465047818"
Received: from ebutchex-mobl1.ger.corp.intel.com ([10.249.40.79])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2020 05:21:07 -0700
Message-ID: <ac7edbf7ad681ab762998e3aa1ed118b2cbdf47a.camel@linux.intel.com>
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Date:   Sat, 16 May 2020 15:21:06 +0300
In-Reply-To: <20200515175550.GP3538@tassilo.jf.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org>
         <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
         <20200515164013.GF29995@sasha-vm>
         <20200515175550.GP3538@tassilo.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-15 at 10:55 -0700, Andi Kleen wrote:
> > Indeed, we've seen a few hacks that basically just enable FSGSBASE:
> > 
> > - https://github.com/oscarlab/graphene-sgx-driver
> > - https://github.com/occlum/enable_rdfsbase
> > 
> > And would very much like to get rid of them...
> 
> These are insecure and open root holes without the patches
> used here.
> 
> -Andi

Yup, totally. 

/Jarkko

