Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DCC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D33208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgD2XD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:03:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:35874 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2XD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:03:57 -0400
IronPort-SDR: 5+4gyuwOSaNd/bKetSz38/CFPhvkrw5g4pPwgyMS3k+q2+rugXXvBRKNUsh2J5k73R/DxHAiEH
 4vCnXYoamYGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 16:03:56 -0700
IronPort-SDR: HEWSbOYZhHWZs3EibEmYMjXE6Bdy7kdDjOJ/N6xw9YHSmehbNHhiwNFMAMFQGRiSb4AnVA5J4W
 S+pChSQH7+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="258111219"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2020 16:03:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 19E10301AAA; Wed, 29 Apr 2020 16:03:56 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:03:56 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] perf intel-pt: Update documentation about itrace G
 and L options
Message-ID: <20200429230356.GB874567@tassilo.jf.intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
 <20200429150751.12570-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429150751.12570-9-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +One caveat with the G and L options is that they work poorly with "Large PEBS".
> +Large PEBS means PEBS records will be accumulated by hardware and the written
> +into the event buffer in one go.  That reduces interrupts, but can give very
> +late timestamps.  Because the Intel PT trace is synchronized by timestamps,

Are you refering to Broadwell here?

On Skylake/Goldmont the PEBS event contains the TSC and the time stamp reported by
perf should report the time the event was sampled based on that TSC. 
Or is that not working for some reason?

-Andi
