Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4DFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA21820643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgERTgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:36:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:30774 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgERTgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:36:47 -0400
IronPort-SDR: sORlY+LQtCLjv/80fPEO0+c53D39naO5NUfIaFw60IV6/5JXTv/Xfkwc0xA5CP4Lk5XZNcGFHa
 Y48iynqcpMiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 12:36:47 -0700
IronPort-SDR: JgII08vzFp7TiLbhkCEyuH17m3o1UH4/ywN1WMbO4D2ryt0erYtkUZsvjoU/H22U/s1SFvnkHV
 BfG6MtacjfZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="342900872"
Received: from afloress-mobl2.amr.corp.intel.com ([10.252.56.85])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2020 12:36:43 -0700
Message-ID: <2871941d922a30334741081640ff5f4105100d00.camel@linux.intel.com>
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Date:   Mon, 18 May 2020 22:36:42 +0300
In-Reply-To: <87o8qly3jo.fsf@nanos.tec.linutronix.de>
References: <20200511045311.4785-1-sashal@kernel.org>
         <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
         <20200515164013.GF29995@sasha-vm> <87o8qly3jo.fsf@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 11:51 +0200, Thomas Gleixner wrote:
> Sasha Levin <sashal@kernel.org> writes:
> > On Fri, May 15, 2020 at 12:24:14PM +0300, Jarkko Sakkinen wrote:
> > > Can you put me to the CC-loop for this patches. Some SGX-enabled
> > > frameworks such as Graphene use out-of-tree changes to achieve this.
> > > That's where the interest to possibly test this comes from.
> > 
> > Indeed, we've seen a few hacks that basically just enable FSGSBASE:
> > 
> >  - https://github.com/oscarlab/graphene-sgx-driver
> >  - https://github.com/occlum/enable_rdfsbase
> 
> I'm really amazed by all these security experts enabling a full root
> hole. It clearly puts the SGX hypocrisy into perspective.
> 
> Thanks,
> 
>         tglx

That's exactly why I'm interested to test this series.

/Jarkko

