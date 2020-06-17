Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10C22070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFQXPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:15:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:31378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgFQXPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:15:17 -0400
IronPort-SDR: 3zg/nwdTIU9DPfM284luz3cuuoyHr6QSknvPiY/bc5g2G4qwlLPrm+Pdcdze8Oqx2WwiQX9iul
 TolbZ4NEE49w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:15:16 -0700
IronPort-SDR: ++RGzALe2pOvo6KRUl91nb+Pw4i5g1dF+OoqX3mgvwaHvhwzHsTgAWVyL7uzmhOmu+jxxAHkN+
 JuU1oDXQqCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="421305721"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by orsmga004.jf.intel.com with ESMTP; 17 Jun 2020 16:15:12 -0700
Date:   Thu, 18 Jun 2020 02:15:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] Documentation: tee: Document TEE kernel interface
Message-ID: <20200617231511.GE62794@linux.intel.com>
References: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
 <20200615201907.GE5416@linux.intel.com>
 <CAFA6WYOpXmdabrpbyJqeknkwv1NeD4+tp95zP+si23SSXDwJdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOpXmdabrpbyJqeknkwv1NeD4+tp95zP+si23SSXDwJdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:20:17PM +0530, Sumit Garg wrote:
> On Tue, 16 Jun 2020 at 01:49, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Jun 04, 2020 at 12:29:39PM +0530, Sumit Garg wrote:
> > > Update documentation with TEE bus infrastructure which provides an
> > > interface for kernel client drivers to communicate with corresponding
> > > Trusted Application.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Please at least broadly describe the update in the commit message.
> >
> 
> How about following additional info to the above commit description?
> 
> Brief description of changes:
> - Add a section to describe TEE kernel interface along with a TEE
> client driver example snippet.
> - Add a sub-section for OP-TEE driver to describe OP-TEE specific
> device enumeration.
> 
> -Sumit
> 
> > /Jarkko

WFM

/Jarkko
