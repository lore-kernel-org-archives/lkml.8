Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A86720732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbgDODj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:39:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:24529 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbgDODj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:39:56 -0400
IronPort-SDR: DYSJawISL5ei+DtA3UbmNUP4Vrq+GLpv/p+ShcIwK/aBj/n1g3xcaMK4qAQ1vvjRpP2lgRgGFG
 mdJu44Dy77TQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 20:39:55 -0700
IronPort-SDR: 7JCPDFuG5gkmHoJv5Pr8ofM1Ya93E2671SFEH1yk6PSuA+sedyOqii0YLtp15hDH5IU3V4ckqY
 yHUBabzjYESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="271607890"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2020 20:39:55 -0700
Date:   Tue, 14 Apr 2020 20:40:40 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, ebiederm@xmission.com, Babu.Moger@amd.com,
        bshanks@codeweavers.com, wangkefeng.wang@huawei.com,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] x86/umip: make umip_insns static
Message-ID: <20200415034040.GA23851@ranerica-svr.sc.intel.com>
References: <20200413082213.22934-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413082213.22934-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:22:13PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> arch/x86/kernel/umip.c:84:12: warning: symbol 'umip_insns' was not
> declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

FWIW. This looks good to me.

Acked-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks and BR,
Ricardo
