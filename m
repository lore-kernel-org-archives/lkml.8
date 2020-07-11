Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEACC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3E207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594476841;
	bh=5Mctzvbr3G78uuYnmsubOSbyWmk4GLbs/rOqB5DGvuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J7hhM0CaSx5Fn3gqSgvB3TcYjsEylUDqebPiEjWMEIS/grPHMKVq2NnjzYQ47tLfC
	 Wld/A+s7WzPYBwR6XfOz6JBuUd5kWnOBGlYC+0BXCpBw1wuOz1spWN4myMzlCCYM3t
	 KuxrP1isREm/H0K9QYkxSi+7kwSF15RGyof7RZDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGKOOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 10:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgGKOOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 10:14:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9642076A;
        Sat, 11 Jul 2020 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594476839;
        bh=5Mctzvbr3G78uuYnmsubOSbyWmk4GLbs/rOqB5DGvuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1KMo84ipTgP6mmEKLIWnsb7nu0vu5XtLbWpsGR8Rb4eyIHjaOI9cUyRlUkI01vn3
         vv25we9UC+3GAgoDeBHeqw7VjdEXmUyubMmbKPx9fFNQHb/Revo/8DH6Qy2SlPSjFq
         jLuEDgpJlhk9l9MGZQfJJxkPoopOivhwSvm/QCl0=
Date:   Sat, 11 Jul 2020 22:13:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, Chuanhua Han <chuanhua.han@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: lx2160a: add dspi controller DT nodes
Message-ID: <20200711141352.GH21277@dragon>
References: <20200622081752.481-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622081752.481-1-qiang.zhao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:17:51PM +0800, Qiang Zhao wrote:
> From: Chuanhua Han <chuanhua.han@nxp.com>
> 
> Add the dspi support on lx2160
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>

Applied both, thanks.
