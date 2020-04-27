Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B4CC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931A0206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgD0UCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:02:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:39874 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgD0UCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:02:50 -0400
IronPort-SDR: xyhOBZkl21/qbGBfznK57qFUK7MTGpmCEXRCe6DtBqlNBSkNub++q9R9llCcrFOYEty5E9I9ue
 c56ONvCzCJcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 13:02:49 -0700
IronPort-SDR: GjYAFcoCqlm+a4DLVaIJAvUAkzUxehDUWIlKKkNGv15CoC9Gjm0QebAmw4Fh+1XvSlidfKCs59
 jTk3opP0EgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="458979574"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 13:02:49 -0700
Message-ID: <01620c87bb6aa7870854ae1e23ec7bd379a058de.camel@intel.com>
Subject: Re: [PATCH v2 0/1] platform/x86: Add Slim Bootloader firmware
 update support
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        Sean V Kelley <sean.v.kelley@intel.com>,
        kuo-lang.tseng@intel.com, jithu.joseph@intel.com
Date:   Mon, 27 Apr 2020 12:57:05 -0700
In-Reply-To: <CAHp75Vezc9-vTSVsTE=ce_2XRPfFVT2gHwZhwqZiRX8M=sdmmg@mail.gmail.com>
References: <20200423224222.29730-1-jithu.joseph@intel.com>
         <CAHp75VcqV3e8ecAUX+dr9h-bE+1XJ_71hJRA1b9XdouJJLD2ZA@mail.gmail.com>
         <CAHp75Vezc9-vTSVsTE=ce_2XRPfFVT2gHwZhwqZiRX8M=sdmmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 13:03 +0300, Andy Shevchenko wrote:
> 
> 
> We use a bit different template for module names
> 
> vendor-...-wmi
> 
> (yes, with exception to TBT)
> 
> I would like to rename sbl_fwu_wmi to something like this:
> 
> intel-wmi-sbl-fw-update
> 
> What do you think?

Yes I think it is better to rename this driver to intel-wmi-sbl-fw-
update as you suggested, given many drivers follow vendor-wmi-*
pattern. Thanks for pointing this out.

I will send v3 which addresses this.

Thanks
Jithu

