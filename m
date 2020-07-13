Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3022075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594624213;
	bh=jGSk/z7yOHASf5gSx5c/Q8/vy5u3h8bdD5nxDNQVYTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0kcnW8i3yaofXiXxeBltfUu9HDf5M87ftCy1tlosKhkwDCCxg8lHHY0uABzNdhv/H
	 FtV8n0OzlD/MbT66IH8JuNPMMW7LsT3bkYI5h5ZrbVsinw7xAtyPO/CNLcgt8R7eJt
	 0x1kK8ksvE5HHEJHM28fg3JJ6cT1jBve7tSgJ0Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgGMHKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMHKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:10:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BF972067D;
        Mon, 13 Jul 2020 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594624210;
        bh=jGSk/z7yOHASf5gSx5c/Q8/vy5u3h8bdD5nxDNQVYTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge30XAU9b+9Oh3BtF3tRlD9SnXuSmSVQHu+DKNvc+ugRYCHvHaTHztQ48iRoIq9C4
         Ex7IoSzAYDnXLqmdEhD76evf0HUPFGpz0riyR+5YULfei3LokaFtRAQdnBs7CdqjbJ
         OMXNmJrxjpxmV365DkHYpQZoXmvjkvtHBMv20vRU=
Date:   Mon, 13 Jul 2020 15:10:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1043a: update USB nodes status to match
 board config
Message-ID: <20200713071005.GJ12113@dragon>
References: <20200707074031.13943-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707074031.13943-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:40:31PM +0800, Ran Wang wrote:
> ls1043a-rdb and ls1043a-qds board’s default HW config (such as
> pin mux selection) would not enable some USB controllers’
> data path, which causing over-current detected on those
> controllers. This will hit the case of ‘xhci driver prevent bus suspend
> if a root hub port detected over-current condition’, causing system
> failed to be suspended. So disable them in device tree to resolve this
> issue.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied, thanks.
