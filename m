Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D867C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A422070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgEYQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:42:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:60868 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbgEYQmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:42:32 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DA1474A2;
        Mon, 25 May 2020 16:42:31 +0000 (UTC)
Date:   Mon, 25 May 2020 10:42:30 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ricardo Ribalda <ricardo@ribalda.com>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: Re: [PATCH] mailmap: change email for Ricardo Ribalda
Message-ID: <20200525104230.3d5d4869@lwn.net>
In-Reply-To: <20200430135224.362700-1-ricardo@ribalda.com>
References: <20200430135224.362700-1-ricardo@ribalda.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 15:52:24 +0200
Ricardo Ribalda <ricardo@ribalda.com> wrote:

> From: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> 
> Modify  emails to ribalda@kernel.org and unify my surname in all the
> files.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@kernel.org>
> ---
>  .mailmap                             | 4 +++-
>  CREDITS                              | 6 ++++--
>  MAINTAINERS                          | 4 ++--
>  drivers/iio/dac/ad5761.c             | 4 ++--
>  drivers/iio/dac/ti-dac7612.c         | 4 ++--
>  drivers/leds/leds-pca963x.c          | 2 +-
>  drivers/media/i2c/imx214.c           | 4 ++--
>  include/linux/platform_data/ad5761.h | 2 +-
>  8 files changed, 17 insertions(+), 13 deletions(-)

Applied, thanks; sorry for the delay.

jon
