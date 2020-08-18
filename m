Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA42245C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHRPqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:46:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:39627 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgHRPpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:35 -0400
IronPort-SDR: PqBHDbmlU/dRhgnHQEu6bpTIgeeX0MTUm+tGgQWqzJcBOIuqj3nzuGCHpadezj1fAlwZmu0jpW
 /DMUSR9/b7/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="156016569"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="156016569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 08:44:47 -0700
IronPort-SDR: T9Fg95g8XxLenJ5jQDfLCFegfIwxQ9pjRGDy3DrWpASLq6K2h2Wvzw2iMobVVHYE72TcDFbo6R
 MMHEABIuZ0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="497411171"
Received: from ribnhajh-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.113])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2020 08:44:45 -0700
Date:   Tue, 18 Aug 2020 18:44:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Coly Li <colyli@suse.de>, Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH RESEND] docs: update trusted-encrypted.rst
Message-ID: <20200818154444.GA137138@linux.intel.com>
References: <20200815075143.47082-1-colyli@suse.de>
 <cf667ea0-dab7-a242-886c-938582c62ff6@linux.ibm.com>
 <1597595769.8344.7.camel@linux.ibm.com>
 <f9d4c4a9-5059-eae2-bc89-51f16e8ca4d9@suse.de>
 <1597597933.8344.13.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597597933.8344.13.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:12:13AM -0700, James Bottomley wrote:
> On Mon, 2020-08-17 at 00:57 +0800, Coly Li wrote:
> > On 2020/8/17 00:36, James Bottomley wrote:
> > > On Sun, 2020-08-16 at 12:06 -0400, Stefan Berger wrote:
> > > [...]
> > > > A note in this file states this:
> > > > 
> > > > Note: When using a TPM 2.0 with a persistent key with handle
> > > > 0x81000001, append 'keyhandle=0x81000001' to statements between
> > > > quotes, such as "new 32 keyhandle=0x81000001".
> > > > 
> > > > Now if someone was (still) interested in TPM 1.2 
> > > > adapt the  note to state that these keyhandle=... should be
> > > > removed for the TPM 1.2 case.
> > > 
> > > Actually, I also have a plan to match what userspace does and
> > > simply assume a keyhandle of 40000001 (generate an EC Storage
> > > Primary Key on the fly) if it's not specified, which will make the
> > > TPM1.2 and 2.0 versions of this the same.  Unfortunately the
> > > necessary precursor patches are taking an age to get upstream.
> > 
> > Hi James,
> > 
> > Do you have a plan to push such patches into upstream soon? If yes
> > than I may wait for your patch and withdraw this one.
> 
> Well, as I said above it depends on not yet upstream precursor patches.
>  They have been pending for about a year, so I've no real idea of the
> timeline.
> 
> James

As far as I remember there was not much left in the previous version to
do. Some time has passed when it was discussed but I recall it was
mainly about documenting the key format.

/Jarkko
