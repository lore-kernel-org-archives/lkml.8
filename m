Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AB8C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459B320787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgEAHxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:53:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:30582 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgEAHxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:53:40 -0400
IronPort-SDR: S1K+TQHpm9sqkzQwd2daPWK+ycCd3niI8sl8oK5+DKXaDfKR5Wzj+bOTJdPLjYIJ4r2VPxxqtj
 x8A6axuenR8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 00:53:39 -0700
IronPort-SDR: Dn+gD+vL4URtCzu7GeGwctS0NKW0CU9LiZfoU2j+XmeiqUwKRS6ABwm6XH5FThXlU84sEkvWFX
 R4HzDsN9zgGA==
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="405683121"
Received: from vivienne-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.13.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 00:53:37 -0700
Message-ID: <c6c51b93978b95cc1ca5b03909f0766bc4bc2638.camel@linux.intel.com>
Subject: Re: [PATCH 0/1] Add IMR driver for Keem Bay
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 01 May 2020 08:53:34 +0100
In-Reply-To: <20200501070930.GA892454@kroah.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
         <d3f045b05c83d0eca1d5498587493ca485e0a1a0.camel@intel.com>
         <20200501070930.GA892454@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 09:09 +0200, gregkh@linuxfoundation.org wrote:
> On Thu, Apr 30, 2020 at 07:49:36PM +0000, Alessandrelli, Daniele
> wrote:
> > This e-mail and any attachments may contain confidential material
> > for the sole
> > use of the intended recipient(s). Any review or distribution by
> > others is
> > strictly prohibited. If you are not the intended recipient, please
> > contact the
> > sender and delete all copies.
> 
> This footer means I delete all of your emails...

My bad, I replied using the wrong email address (i.e., the one that
adds the footer automatically). Sorry about that :/
I'll be more careful the next time.

The original emails (the ones with the cover letter and the patch) were
fine though (unless I did something else wrong). Any advice on how to
have the patch reviewed and eventually merged?







