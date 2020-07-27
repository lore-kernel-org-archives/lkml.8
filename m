Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4583BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A60B2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595865297;
	bh=r4gVtL5bEAhWJpndkYkQKV4g6kh85tQmBYzrzdeoQmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DLoStozoXphKWjlEWisH8cCPuqiWB75NttXazlkhyenmOWJi1S6+6UjEgNvXe8qnE
	 GYqOm8IX1dMq+iv/cFEwnlTYdcXyYzLtoGBzRrOwp6Xtpy29BWp3Dznt5PX5H8hrts
	 UO21j3yFy5Npn5e5S27IO11ujiOhmA/aS3n8yZFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgG0Pyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgG0Pyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:54:55 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3082083B;
        Mon, 27 Jul 2020 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595865294;
        bh=r4gVtL5bEAhWJpndkYkQKV4g6kh85tQmBYzrzdeoQmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rFcPokJ1hNO2ZAZboOsd6quqJ7MkklxYnGhCWGroq121z/YTSqiAnl5FJEfckXHS9
         KYrjHELe2AqYB3FFOyEY3sFaA0NjRlTR0Jz/FAcnQJ7nRW5o9H2rnqaiZbsojZwrKV
         jugqO6ivP2SosEpZk1LStf5eKRj5TW+oLLgXBVPE=
Date:   Mon, 27 Jul 2020 08:54:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Ooi, Joyce" <joyce.ooi@intel.com>
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dalon Westergreen <dalon.westergreen@linux.intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>,
        Dalon Westergreen <dalon.westergreen@intel.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v5 08/10] net: eth: altera: add support for ptp and
 timestamping
Message-ID: <20200727085452.412f7031@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200727092157.115937-9-joyce.ooi@intel.com>
References: <20200727092157.115937-1-joyce.ooi@intel.com>
        <20200727092157.115937-9-joyce.ooi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 17:21:55 +0800 Ooi, Joyce wrote:
> From: Dalon Westergreen <dalon.westergreen@intel.com>
> 
> Add support for the ptp clock used with the tse, and update
> the driver to support timestamping when enabled.  We also
> enable debugfs entries for the ptp clock to allow some user
> control and interaction with the ptp clock.
> 
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Dalon Westergreen <dalon.westergreen@intel.com>
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>

W=1 build reveals a warnings, please fix:

drivers/net/ethernet/altera/intel_fpga_tod.c:334:55: warning: Using plain integer as NULL 
pointer

