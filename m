Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC7EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9106207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHaGZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:25:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:63039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaGZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:25:56 -0400
IronPort-SDR: VxgrzvB5KNGWGzrmKXH0XA/URlVtLTlRbLVvXDvkGfMoIEPLcKrAeACwLg3pjUW3GA5IZyaHcn
 AB2jXrn8HjjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156920637"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="156920637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 23:25:55 -0700
IronPort-SDR: mejfkoU5Jgeszft+ovSUOOGzMPLw1O7pPN+7ZWv4oVi5xZ4aUjoBfZD4RT2lnCvIB7jvH+UIoK
 Eb+7NLFlg2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="501748305"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2020 23:25:52 -0700
Date:   Mon, 31 Aug 2020 14:25:52 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, <x86@kernel.org>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200831062552.GH13723@shuo-intel.sh.intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-7-shuo.a.liu@intel.com>
 <20200828102738.GC1470435@kroah.com>
 <20200829110436.GF13723@shuo-intel.sh.intel.com>
 <20200830072342.GA110796@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200830072342.GA110796@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun 30.Aug'20 at  9:23:42 +0200, Greg Kroah-Hartman wrote:
>On Sat, Aug 29, 2020 at 07:04:36PM +0800, Shuo A Liu wrote:
>> On Fri 28.Aug'20 at 12:27:38 +0200, Greg Kroah-Hartman wrote:
>> > On Tue, Aug 25, 2020 at 10:45:06AM +0800, shuo.a.liu@intel.com wrote:
>> > > +	default:
>> > > +		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
>> > > +		ret = -EINVAL;
>> >
>> > Wrong error value here, right?
>>
>> Right, it should be -ENOIOCTLCMD.
>
>It could, but really, just return the correct error for this, to prevent
>the core from having to do the conversion.
>
>The reviewers at Intel who should have read this before submitting it,
>know the correct value to return for an illegal ioctl, please go ask
>them.
>
>> However, i found many instances in kernel drivers return -EINVAL for no
>> ioctl command support. :)
>
>Then they too are wrong.  No need to add known bugs before the code is
>accepted.
>
>See the comments above the is_unrecognized_ioctl() in block/ioctl.c for
>all of the details and why -EINVAL is not the correct thing to do here.

Thanks for the information. -ENOTTY will be used.

Thanks
shuo
