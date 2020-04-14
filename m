Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81501C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4A42076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586868870;
	bh=YUpri+yKycAaMDUJHqCjgPaw+1UmNzVpa8KwUx8HgkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S0HnOMSuwX4obrJheX5hp1esRGffJE9nGisxJmiWn9Uxrf684dyKAkmQFrCJFX8tQ
	 E85X7RtS9QCI7Y9Phnn+aFCLUuawzfcQ3NzNXa4sMhuVLxOmOrI4DkrtLrQssJ9Yil
	 DHrpQQpNpGNyn3p3+3zjlbzrWuY7FyD6mRvpMjYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502349AbgDNMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502334AbgDNMyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:54:22 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B2620768;
        Tue, 14 Apr 2020 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586868862;
        bh=YUpri+yKycAaMDUJHqCjgPaw+1UmNzVpa8KwUx8HgkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lb9mFnr3p1inieyWD+Fh8mCQFyOTKvMc6fExU/SuD4KMfsl7p/8MMszC00SiPVHCL
         g9YaWlicRx4nRPkO4+RWqKFb0Lqwg8GcnMBpgtJb8heEFxVijYSQWTnWYYbRWBagOP
         DvZt+B1ldRvJRvO/TF+LsAzm3A1eRy5RIEDs8wMU=
Date:   Tue, 14 Apr 2020 20:54:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx7: Correct CPU supply name
Message-ID: <20200414125407.GB30676@dragon>
References: <1584006613-31623-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584006613-31623-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:50:12PM +0800, Anson Huang wrote:
> i.MX7 uses cpufreq-dt driver which requires the CPU supply name to be
> either "cpu0-supply" or "cpu-supply", correct it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
