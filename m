Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B84C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35FF206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594880895;
	bh=ONWXzMaEugk8tRzX9+nfZsMEU76PKxzOv3kYH2Ukiow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qLKFOg1neG8ueZmB251VIgzF0i5rlkmMsNnu3XDNCiTXDwWeBrnDR8JEe4aL7TDXh
	 zsekYdP0E1TDhpfpOR/TNHQP9aMB6uZfacEWIWNbXbmiabMCwaqQD/fewrR6UKKB3r
	 PPqGw+2VVdiWoAM0WlPNGoNYQx067dvKJcxWBSVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGPG2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPG2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:28:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29632067D;
        Thu, 16 Jul 2020 06:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594880893;
        bh=ONWXzMaEugk8tRzX9+nfZsMEU76PKxzOv3kYH2Ukiow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvppkY6ej9yMrz6W7JfuKI0aBpDIELFxSCSA+kn4dmDeZ4bb6xt2AmeaFa/qdSweV
         HVhvCvAv2VVLpMC7EKHIvzffcns0J6b+HoxnyzM4wsVeK0PF4Vj+k4jGr/C0PdJx9M
         X1gnTBcKild4SegecDgJ9mEeWu2hOab/KTzurgAs=
Date:   Thu, 16 Jul 2020 08:28:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
Message-ID: <20200716062807.GA958325@kroah.com>
References: <20200715221150.v3.1.I7605646b16c98c0095eee7fbe39f8f7b2b59e6f4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715221150.v3.1.I7605646b16c98c0095eee7fbe39f8f7b2b59e6f4@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:14:29PM -0700, Bhanu Prakash Maiya wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> This patch enables uart transport layer for cros_ec framework.
> The cros-ec-uart binds with EC device working on uart transport to
> send request and receive response.
> 
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

If this really is a "UART", why is this not a serial/tty driver?

thanks,

greg k-h
