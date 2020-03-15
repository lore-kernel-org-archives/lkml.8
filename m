Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D5EC18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E84206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgCOSOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:14:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:49683 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgCOSOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:14:50 -0400
IronPort-SDR: JJS1KShbjfpiUAy1pzVLffCmtYsgXfZGPbvYy7A+1QOga0VVZs/OH2Mlf5bin8H5/TL9/qdKqg
 v9Qh+HE5cyRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 11:14:49 -0700
IronPort-SDR: S7JlCLgnKLniOLwGJWA3ufxlOWM4qy471wRdfKsVmjvmwsog/+18oo2JQS7jQYmkSYSrP6XMDK
 8jLRkZJD6AxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,557,1574150400"; 
   d="scan'208";a="235824287"
Received: from babayass-mobl.ger.corp.intel.com (HELO localhost) ([10.249.90.210])
  by fmsmga007.fm.intel.com with ESMTP; 15 Mar 2020 11:14:47 -0700
Date:   Sun, 15 Mar 2020 20:14:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: linux-next: Fixes tag needs some work in the tpmdd tree
Message-ID: <20200315181445.GB224162@linux.intel.com>
References: <20200314215307.1c5f4a45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314215307.1c5f4a45@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 09:53:07PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   606c8d992ba5 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> 
> Fixes tag
> 
>   Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks, has been fixed now.

Stefan, please do modify the short summary next time when you add a
fixes tag. Thanks.

/Jarkko
