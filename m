Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAE9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFEB20772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgHSFfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:35:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:22447 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgHSFfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:35:11 -0400
IronPort-SDR: 6BiIzDRvDXgouyQmyFCzkBWcAr2QS/HxDKaKFKKxGX5w1n7+1SAyrPigqIVGGxxLVxn5sGYieU
 IFrS6IoZjN1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152465476"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="152465476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 22:35:11 -0700
IronPort-SDR: 5Qx4ak8fqEmKBS4ovChUcTS/BxC0h39yROy1I5gxfN8tYLQWjyz7KGNOQRaukDR/wnNJgNVeGV
 5mazWxfrmMMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="292997649"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2020 22:35:11 -0700
Received: from [10.226.38.22] (unknown [10.226.38.22])
        by linux.intel.com (Postfix) with ESMTP id 9377F580583;
        Tue, 18 Aug 2020 22:35:08 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
Date:   Wed, 19 Aug 2020 13:35:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818084044.GD1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
> On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> USB external connector chip PTN5150 used on the Intel LGM SoC
>> boards to detect the USB type and connection.
> Internally I meant you can send cleanups, but couple of patches here are the
> features and were still under discussion... But here we are.

you mean asking us to implement the Heikki suggested as below..

Heikki Krogerus: register the port and the partner attached to it with 
the USB Type-C connector class in the driver. Is my understaanding 
right? if not, please explain it. Thanks!

Regards
Vadivel

> 
