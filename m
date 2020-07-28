Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB9FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA5320809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595897985;
	bh=u8nl1DFIWFG6UKSluVniywWOMGkPGO7/1nDNjF8VG6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EEylIYFyALlVL2Yi33hETohzWQSVrVHGnYNS/9vFCVrg641m0xwPr863dkgZQo21V
	 k2ErftpihYtLb/clJ0MLrs3xws+fg4RfNAn9madpuOdnmiEfRs02644SfvOySQCbaF
	 4coIeVkd17etL8w7PZxTnvRa2gOWCUiyZGoEiLqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgG1A7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG1A7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:59:43 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043ED20809;
        Tue, 28 Jul 2020 00:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595897983;
        bh=u8nl1DFIWFG6UKSluVniywWOMGkPGO7/1nDNjF8VG6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CgwDMWeDpj55eSWPeS/OCfghvavliIMPpgAJFN7VccKYuAF3CRbPQEVbounLQHLPC
         rniC1IyXNMv0UAdkiQ3tKRnLayqk2uwIwVLfT59WP8jrfakqF6i5kFW1qhrKVePkXR
         CsDMRGjCvH+OtAqdlnzW5ssAnn5iGKbbx0xfB/H0=
Date:   Mon, 27 Jul 2020 17:59:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC 10/13] net/mlx5: Add devlink param
 enable_remote_dev_reset support
Message-ID: <20200727175941.05550c92@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1595847753-2234-11-git-send-email-moshe@mellanox.com>
References: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
        <1595847753-2234-11-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 14:02:30 +0300 Moshe Shemesh wrote:
>  static void mlx5_sync_reset_request_event(struct work_struct *work)
>  {
>  	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
>  						      reset_request_work);
>  	struct mlx5_core_dev *dev = fw_reset->dev;
> +	int err;
>  
> +	if (test_bit(MLX5_HEALTH_RESET_FLAGS_NACK_RESET_REQUEST, &dev->priv.health.reset_flags)) {
> +		err = mlx5_fw_set_reset_sync_nack(dev);
> +		mlx5_core_warn(dev, "PCI Sync FW Update Reset Nack %s",
> +			       err ? "Failed" : "Sent");
> +		return;
> +	}

What if the NACK fails? Does the reset still proceed?

>  	mlx5_health_set_reset_requested_mode(dev);
>  	mlx5_reload_health_poll_timer(dev);
>  	if (mlx5_fw_set_reset_sync_ack(dev))
