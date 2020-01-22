Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1631C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCA324656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579682683;
	bh=YARmYFb76TDa0hVOR+T3bvNGeQGBEuPLBh/7c4SKc8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NctKR1L/319+usWu1hmHpFaeIX39emFTv9Gg+RN23wl21gmOyFZyURyM+U0AHkVGL
	 L6yMbiZkkwP8/wkdY9Q34REoZhT7eKiJZoQN5+ySIx7/iwKDFE6ldgYPoFoIVZy3m3
	 zpTncuFQa9bIT1JG31tCorh8vtsmPooYb5pEHQkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAVIom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgAVIol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:44:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D782465A;
        Wed, 22 Jan 2020 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579682681;
        bh=YARmYFb76TDa0hVOR+T3bvNGeQGBEuPLBh/7c4SKc8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkoSM+nmg0PCdeVo4kFeokmVrAsgPK80qOHF+igSbOmgtzHNxJrsI6aatK+APO4J6
         wWXBMd4oAQv8Apg12LfvHl78+cQbY3Wevkny25GQQxltb16PIRfnGGL/9GYvnIQnX1
         VNF6+SoBITmjWj4SBWLAfBOms7UtaUX0eCi0DEDw=
Date:   Wed, 22 Jan 2020 09:44:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: fix missing a blank line after declaration
Message-ID: <20200122084436.GA2407794@kroah.com>
References: <20200119140359.GA8668@home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119140359.GA8668@home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 04:03:59PM +0200, Valery Ivanov wrote:
> This patch fixes "WARNING: Missing a blank lin after declarations"
> Issue found by checkpatch.pl
> 
> Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
> ---
>  drivers/staging/qlge/qlge_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/qlge/qlge_ethtool.c b/drivers/staging/qlge/qlge_ethtool.c
> index 56d116d79e56..2872b7120e36 100644
> --- a/drivers/staging/qlge/qlge_ethtool.c
> +++ b/drivers/staging/qlge/qlge_ethtool.c
> @@ -412,6 +412,7 @@ static void ql_get_drvinfo(struct net_device *ndev,
>  			   struct ethtool_drvinfo *drvinfo)
>  {
>  	struct ql_adapter *qdev = netdev_priv(ndev);
> +
>  	strlcpy(drvinfo->driver, qlge_driver_name, sizeof(drvinfo->driver));
>  	strlcpy(drvinfo->version, qlge_driver_version,
>  		sizeof(drvinfo->version));
> @@ -703,12 +704,14 @@ static int ql_set_pauseparam(struct net_device *netdev,
>  static u32 ql_get_msglevel(struct net_device *ndev)
>  {
>  	struct ql_adapter *qdev = netdev_priv(ndev);
> +
>  	return qdev->msg_enable;
>  }
>  
>  static void ql_set_msglevel(struct net_device *ndev, u32 value)
>  {
>  	struct ql_adapter *qdev = netdev_priv(ndev);
> +
>  	qdev->msg_enable = value;
>  }
>  

This fix is already in my tree, always be sure to work against
linux-next for new development so you do not duplicate existing work.

thanks,

greg k-h
