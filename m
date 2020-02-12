Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E4C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205C21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581492988;
	bh=/KSK0QZ64G2qHIpfcw85Qp0QWjJYVgwWNgeO7oEdGZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKOUaaugDSTITw7tDb0LpumUwGFerCYIsCs8nEM/9wWluPsmrfzzqMPOohIaiagQt
	 WlRyDLvw7JtnEusrG6rO1snYiN/6fp73Tzx4iO1uirn9VbPPLlXbNmP5Zru4eKbi3X
	 G2lO4Rar8FGAAs/PkBMd+hPyGsWK0EmzyszO9nfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgBLHg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgBLHg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:36:27 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E31E9206DB;
        Wed, 12 Feb 2020 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492986;
        bh=/KSK0QZ64G2qHIpfcw85Qp0QWjJYVgwWNgeO7oEdGZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iX74qhcaMYomMKagp2ajZF6gSTnay5mhUl3J5yH0y3z4EFWd0qd9lqm1YfdTnn6NO
         wp+2YkeS+jPZ6mSkHjg0a6V/98sqFwC7VxBjdWaRsS6XJbv1OKVZb4Q1kGz0tv1kOD
         GnTFaJbtN0+LyxL868gRovypXEPxhOh6KGTfKPT4=
Date:   Wed, 12 Feb 2020 15:36:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: arm: fsl: add LS1028A based boards
Message-ID: <20200212073617.GA11096@dragon>
References: <20191209234350.18994-1-michael@walle.cc>
 <20191209234350.18994-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209234350.18994-4-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:43:48AM +0100, Michael Walle wrote:
> Add the Freescale LS1028A evaluation boards.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied #3 ~ #5, thanks.
