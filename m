Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251EAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022032071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgA2VII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:08:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:61173 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbgA2VIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:08:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 13:08:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="223945144"
Received: from cmossx-mobl1.amr.corp.intel.com ([10.251.7.89])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2020 13:08:04 -0800
Date:   Wed, 29 Jan 2020 13:08:04 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
X-X-Sender: mjmartin@cmossx-mobl1.amr.corp.intel.com
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Paolo Abeni <pabeni@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: MPTCP_HMAC_TEST should depend on MPTCP
In-Reply-To: <20200129180224.700-1-geert@linux-m68k.org>
Message-ID: <alpine.OSX.2.21.2001291246140.9282@cmossx-mobl1.amr.corp.intel.com>
References: <20200129180224.700-1-geert@linux-m68k.org>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Jan 2020, Geert Uytterhoeven wrote:

> As the MPTCP HMAC test is integrated into the MPTCP code, it can be
> built only when MPTCP is enabled.  Hence when MPTCP is disabled, asking
> the user if the test code should be enabled is futile.
>
> Wrap the whole block of MPTCP-specific config options inside a check for
> MPTCP.  While at it, drop the "default n" for MPTCP_HMAC_TEST, as that
> is the default anyway.
>
> Fixes: 65492c5a6ab5df50 ("mptcp: move from sha1 (v0) to sha256 (v1)")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
