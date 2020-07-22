Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE0EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A5320709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbgGVOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:14:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:23142 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgGVOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:14:44 -0400
IronPort-SDR: 6/HXe+MVhu6kwAKLQWfrR5xAI7WRAbXsBvTMAjdu8nU4yymFw2A/3ktVfzYCZZE7A8eVxuh441
 lOka8tv552+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="137836566"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="137836566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 07:14:43 -0700
IronPort-SDR: TwU9st3SfjJIJdrXID4JCICd1AGfD3MEjEoDRt2kGhUOWFppOiRoiZZlCdP4IBZp2KJGOwsr29
 QQ+GKE1V5eyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="432390891"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga004.jf.intel.com with ESMTP; 22 Jul 2020 07:14:42 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: altera: change maintainer for Altera drivers
To:     Greg KH <gregkh@linuxfoundation.org>, richard.gong@linux.intel.com
Cc:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
References: <1595426980-32062-1-git-send-email-richard.gong@linux.intel.com>
 <20200722140831.GB3755463@kroah.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <de3709c8-e341-3f11-e182-721d596bf563@linux.intel.com>
Date:   Wed, 22 Jul 2020 09:14:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200722140831.GB3755463@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 9:08 AM, Greg KH wrote:
> On Wed, Jul 22, 2020 at 09:09:40AM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Thor is moving to a new position and I will take over the maintainership.
>> Add myself as maintainer for 3 Altera drivers below:
>> 1. Altera I2C driver
>> 2. Altera System Manager driver
>> 3. Altera System Resource driver
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
> 
> No ack from Thor?
> 
> :(
> 
I was too slow... :)

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
