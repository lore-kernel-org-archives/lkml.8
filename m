Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD25208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHTUHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:07:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:21646 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgHTUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:07:53 -0400
IronPort-SDR: kphsX01UFMMYGaAy1JxJPN/VsjYow6UTR46nUL+SHCS6njEorFXIvxaZ4zfxZTef8TuEStXchV
 t9UFL2iZUBOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="153009353"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="153009353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 13:07:52 -0700
IronPort-SDR: Mbb9LPom8qxQIBvVF6HRnvV1+zb/lUH0VMqlAlerVsfiifIjDale+32e8NnxWipDJvE5BjmMhj
 SeGid7eGHOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="327547627"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2020 13:07:52 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0FA2A301C06; Thu, 20 Aug 2020 13:05:52 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:05:52 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH 3/4] perf stat: Support new per thread TopDown metrics
Message-ID: <20200820200552.GE1509399@tassilo.jf.intel.com>
References: <20200820164532.8011-1-kan.liang@linux.intel.com>
 <20200820164532.8011-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820164532.8011-4-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +				fprintf(stat_config.output,
> +					"Topdown accuracy may decreases when measuring long period.\n"

"may decrease" ... "long periods".

(s needs to move to the end)


-Andi
