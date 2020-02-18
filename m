Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D7C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7172070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582019195;
	bh=wbpMc1MVbg40n0/gW71pGkctZMTT4kZFYH24D32jamY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQlddG4kRbcL2H8evwY5wA29ahxdxnTu6lAPCaIcurTDxPbU22Y5dAWBB7ujZTLm4
	 EhA1PVUMPjV51sReo97nMyypP0yRJQMTKq0zZyGLzd4pS3BtwQpyXe+CAvhZhVr/Ho
	 2UK7GKSLPJPb4jR6uARdga9/cYkPP67VXRtUFAoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgBRJqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgBRJqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:46:33 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638E4206E2;
        Tue, 18 Feb 2020 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582019193;
        bh=wbpMc1MVbg40n0/gW71pGkctZMTT4kZFYH24D32jamY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwLLZeaS0In7WJ5AxPXmqRY3ZUJra+9yqvRwSEZTpmywGQ9Tl6O+v9Eg0Tig5q1AT
         JIinsBLNGG6LOvvoOoIoRt7f51w5riFJMmFtEHTFPnX19xIbTZr1ihI06o7TnvrZ/n
         sl6knbsDaZsTNSFdpvscpaoactMcS3un3IfajO1I=
Date:   Tue, 18 Feb 2020 17:46:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, allison@lohutok.net,
        tglx@linutronix.de, andrew.smirnov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com, sakari.ailus@linux.intel.com,
        bhelgaas@google.com, dsterba@suse.com, peng.fan@nxp.com,
        okuno.kohji@jp.panasonic.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V3] ARM: imx: Add missing of_node_put()
Message-ID: <20200218094622.GF6075@dragon>
References: <1581582933-901-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581582933-901-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 04:35:33PM +0800, Anson Huang wrote:
> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
