Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77370C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D172076C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861537;
	bh=sw5+Y6Pc2OHWl2mKtV8KEZF9TTl5q+j8uF1Y6RhA9LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tjY4eKf9R/kfkHUDIeOAe14NYjy6z6Fi+ZVP++m7HC/73rnUvJb6unTm2t9o3QWSJ
	 y18TbQBkkl0uq+XojXK1ytCiQPkIBs2WOXlpixGIqVbW8SqQasWEjgAR2iIr3RSt9H
	 fBmmuOkSQIRciYgCS/rNciwmd6fU7hmVyVpisjlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGPBFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPBFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:05:35 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AB82071B;
        Thu, 16 Jul 2020 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861535;
        bh=sw5+Y6Pc2OHWl2mKtV8KEZF9TTl5q+j8uF1Y6RhA9LY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2cWUDn2wEdF45UhJNbWUrK3x2HUl3CbUZjSsXZjvbniLn9Bg52DlsN4MH/5TBuTY2
         mpS14Blj0TCLFkgQ77JPgCusD7nIOBmH+OSxmH35AGu8P1sLt9cin8n4e0Zi6wctxi
         LsgVodFolS3OLjtQA7erb5YxI1a3Rzeb5IEZJ/Ak=
Date:   Wed, 15 Jul 2020 18:05:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     davem@davemloft.net, linux-decnet-user@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] decnet: dn_dev: Remove an unnecessary label.
Message-ID: <20200715180532.5297f0dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200714142328.GA4630@blackclown>
References: <20200714142328.GA4630@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 19:53:28 +0530 Suraj Upadhyay wrote:
> Remove the unnecessary label from dn_dev_ioctl() and make its error
> handling simpler to read.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>

Applied, thank you.
