Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B54C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA8D20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRS0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:26:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:24086 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgHRS0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:26:06 -0400
IronPort-SDR: dHpTq1qXN7/4wYILMELe3w7gwqEQMGwU/P0Xnykja7gFHXhd+S6x8Y3LPQpFz7SiR3W7s7ZWwN
 gSzggFfq5eeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="173032866"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="173032866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:26:07 -0700
IronPort-SDR: oC63Dy7qujs42aK44MwCv4Dhj/DyNLMFkIj7OrB6Wo3dyWwXxaBa53jFFRkn+6oI33G8ssXBWI
 i+KMeWZnBm/w==
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="441318282"
Received: from jbrandeb-mobl3.amr.corp.intel.com (HELO localhost) ([10.212.158.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:26:06 -0700
Date:   Tue, 18 Aug 2020 11:26:05 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Qingyu Li <ieatmuttonchuan@gmail.com>
Cc:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/bluetooth/hci_sock.c: add CAP_NET_RAW check.
Message-ID: <20200818112605.0000735f@intel.com>
In-Reply-To: <20200818075648.GA29124@oppo>
References: <20200818075648.GA29124@oppo>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 15:56:48 +0800
Qingyu Li <ieatmuttonchuan@gmail.com> wrote:

> When creating a raw PF_BLUETOOTH socket,
> CAP_NET_RAW needs to be checked first.
> 

Thanks for the patch! Your subject doesn't need to end in a period. In
your commit message, I can guess why you'd want this patch, but your
commit message should include more info about why the kernel wants this
patch included. Especially since this is a user visible change and
likely a fix of a bug. Please review:
https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html
specifically:
https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html#q-any-other-tips-to-help-ensure-my-net-net-next-patch-gets-ok-d

This looks like a fix, please add a Fixes tag.
