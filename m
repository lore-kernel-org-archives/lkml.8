Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E1C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C309206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581920347;
	bh=f3VOOy6CTJtnh0VI3z3/xaikmMNxZ4lv5y2xGGj1zxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P5KJTMolJhl4vPVGIqTT3k/th4bFrA+uopZxo3fV2D7G5mF5oXiDsLw6AtqyQjlze
	 qaDDVJvwg0azWRkNDks9qe23GxR72KWbydz1mImX/ouhX0bhnGdJuxRsQX6S/Xb4z6
	 JimG4oKj4PLYtNqC+zS+0jWd/qw05MmKfiiR8tbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgBQGTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgBQGTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:19:05 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C41120679;
        Mon, 17 Feb 2020 06:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581920345;
        bh=f3VOOy6CTJtnh0VI3z3/xaikmMNxZ4lv5y2xGGj1zxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oK3n/P4t8LarlsfbQ3YsmW+KybfaWi6krW3i5QTm0kbSLRrUYev40fhu2ZQKZu2Fq
         5FfKCNAou/P+Z3oUvD1LIJs5CgCn4XYERsv16tTXBNS7kcFmfIYTDzPljgsErjV8Ut
         F/d9+/lWUpANjBWERRggEnktaFRf2fUx2TP+04YU=
Date:   Mon, 17 Feb 2020 14:18:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     robh+dt@kernel.org, festevam@gmail.com, marco.franchi@nxp.com,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-phanbell: Add support for ethernet
Message-ID: <20200217061849.GA6790@dragon>
References: <20200211134828.138-1-alifer.wsdm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211134828.138-1-alifer.wsdm@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:48:28AM -0300, Alifer Moraes wrote:
> Add support for ethernet on Google's i.MX 8MQ Phanbell
> 
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>

Applied, thanks.
