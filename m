Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F749C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668402075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHRSoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:44:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:15780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRSoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:44:05 -0400
IronPort-SDR: FMIxQcVGUcKk5/Co+dLMYo5XwNNwFGeno55VcDcxXb5AN4vBWWQ2nJM5V4uXfGpzIyQxH+dZXX
 2E2sSqtJzy5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239818752"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="239818752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:44:04 -0700
IronPort-SDR: 0v27BdBA5Pepl85rDOmgZmjtX1cPhpyLJXU86op25rnsZ4yx6orUh/zCbrmdjU/Z5WlfR37IaG
 uI+dZEKHo34A==
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="471916265"
Received: from jbrandeb-mobl3.amr.corp.intel.com (HELO localhost) ([10.212.158.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:44:04 -0700
Date:   Tue, 18 Aug 2020 11:44:03 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     <aelior@marvell.com>, <GR-everest-linux-l2@marvell.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qed_main: Remove unnecessary cast in kfree
Message-ID: <20200818114403.00001257@intel.com>
In-Reply-To: <20200818091056.12309-1-vulab@iscas.ac.cn>
References: <20200818091056.12309-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 09:10:56 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> Remove unnecassary casts in the argument to kfree.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

You seem to have several of these patches, they should be sent in a
series with the series patch subject (for example):
[PATCH net-next 0/n] fix up casts on kfree

Did you use a coccinelle script to find these? 

They could all have Fixes tags. I'd resend the whole bunch as a series.

Since this has no functional change, you could mention that in the
series commit message text.

Jesse
