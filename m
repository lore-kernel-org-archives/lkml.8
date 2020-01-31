Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CBBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4921734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580489712;
	bh=mTrY2TnLbSS5HqaZCPPqkko32zM2EGAbWUoxiqWzQMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SK1GFdxQ4aoKqkU9mXT19XoYak1ofLv08oVWEk9nb+qHgx7HolUif1Wtw7eqiAGb5
	 eUPrbDPN2DZC1sPZyzpu8B1vhEiTWLGLLqN01ivfJwXo+DcFE7/dI/30oYCVhxk7yD
	 yzuHLX4l8SzLbcIZ3n+uOTfdtfPtj+9Z5g8dvYD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgAaQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgAaQzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:55:11 -0500
Received: from cakuba.hsd1.ca.comcast.net (unknown [199.201.64.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBA8214D8;
        Fri, 31 Jan 2020 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580489710;
        bh=mTrY2TnLbSS5HqaZCPPqkko32zM2EGAbWUoxiqWzQMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n18GKHOXtieLCERotzoM8UcCz0OrdkENMYj6EBRLFvRx+CbnqpI5W3ioQF4xNwXm4
         fZiorxdNfraW1ZSxrWW8ZK3cOd9cy3fiEbxG261++LMuiNEquPcCeepl0bWKsDgdHV
         j4SUcyOnF0yRsGb//6yNppAXi/qKgnxodpJYqwEQ=
Date:   Fri, 31 Jan 2020 08:55:09 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] mlxsw: spectrum_qdisc: Fix 64-bit division error in
 mlxsw_sp_qdisc_tbf_rate_kbps
Message-ID: <20200131085509.199405a9@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20200131015123.55400-1-natechancellor@gmail.com>
References: <20200130232641.51095-1-natechancellor@gmail.com>
        <20200131015123.55400-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 18:51:23 -0700, Nathan Chancellor wrote:
> When building arm32 allmodconfig:
> 
> ERROR: "__aeabi_uldivmod"
> [drivers/net/ethernet/mellanox/mlxsw/mlxsw_spectrum.ko] undefined!
> 
> rate_bytes_ps has type u64, we need to use a 64-bit division helper to
> avoid a build error.
> 
> Fixes: a44f58c41bfb ("mlxsw: spectrum_qdisc: Support offloading of TBF Qdisc")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thank you.

