Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612152077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbgGAPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:49:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:28891 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGAPtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:49:36 -0400
IronPort-SDR: O59kB8H475LLwzRSjHEMXpDrHBTa7OONWVOg6XyDxF0ugmE0Q0K5ak+xqEhlAyY73qlKdT6+dc
 CLLfkubxWhlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="211672182"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="211672182"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:49:36 -0700
IronPort-SDR: uIcVsZKpC1T/XZABeBlT37G65ne6km5mDT/3irZE34DT8lWnPGk+KZtJ6UPqd9vR1kLZns5THn
 JSuZkfIIiucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="312732363"
Received: from spandruv-mobl3.amr.corp.intel.com ([10.254.75.215])
  by orsmga008.jf.intel.com with ESMTP; 01 Jul 2020 08:49:36 -0700
Message-ID: <4c8abeb4ddff2355d9ba397f50b7844a7734c2e9.camel@linux.intel.com>
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rkumbako@codeaurora.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 08:49:35 -0700
In-Reply-To: <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <20200625144509.17918-4-daniel.lezcano@linaro.org>
         <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
         <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
         <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> Then I'd prefer we only introduce the events that are used or will be
> used soon, like the tz disable/enable, to avoid some potential dead
> code.
> We can easily add more events when they are needed.
> 
> Srinivas, do you have plan to use the trip add/delete events?
Yes and also trip modify.
Also I need to have one more event for heartbeat like event which needs
confirmation from user space to hardware the user process controlling
thermal is active not dead. So whenever hardware wants to check health 
it will send an event, which user space should acknowledge

Thanks,
Srinivas
> > 
> > 
> > 

