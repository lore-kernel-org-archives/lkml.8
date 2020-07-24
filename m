Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65345C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3DB207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXD3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:29:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:63599 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgGXD3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:29:24 -0400
IronPort-SDR: 7sEPOlg2g0vCizuj5NeQO+2Pr3lxSbc2eSex4DLWoTp86Dxak0B800oCCvDS8mkaVy9+e0UtHV
 RnsFT59dYduw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235532455"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="235532455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 20:29:24 -0700
IronPort-SDR: F0pCIRnT00o/gFlmlMdddXBgAQteEuDnthZw+xus5QxzuwsRyhZG1QQuCs5gkmy8w960ulnYDk
 8raY/cEkWJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="328786431"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga007.jf.intel.com with ESMTP; 23 Jul 2020 20:29:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id EC43F301BF9; Thu, 23 Jul 2020 20:29:23 -0700 (PDT)
Date:   Thu, 23 Jul 2020 20:29:23 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, like.xu@linux.intel.com
Subject: Re: [PATCH V7 12/14] perf, tools, stat: Support new per thread
 TopDown metrics
Message-ID: <20200724032923.GB1180481@tassilo.jf.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-13-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723171117.9918-13-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		if (topdown_metric_attrs[0] && str) {`
> +			if (!stat_config.interval) {
> +				fprintf(stat_config.output,
> +					"Topdown accuracy may decreases when measuring long period.\n"
> +					"Please print the result regularly, e.g. -I1000\n");

Can you disable this warning when --metrics-only is used? In this case it doesn't matter
because the error is proportional to the percentage accuracy and should be invisible.

You can only see a difference when looking at the expanded counts.

-andi
