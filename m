Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438BC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161D020773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBIgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:36:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46311 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:36:13 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDOFW-0006Fr-GN; Wed, 02 Sep 2020 08:36:10 +0000
Date:   Wed, 2 Sep 2020 10:36:09 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 2/2] mailmap, MAINTAINERS: move to tycho.pizza
Message-ID: <20200902083609.qkwzqg4h53n4skey@wittgenstein>
References: <20200902014017.934315-1-tycho@tycho.pizza>
 <20200902014017.934315-2-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902014017.934315-2-tycho@tycho.pizza>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 07:40:17PM -0600, Tycho Andersen wrote:
> I've changed my e-mail address to tycho.pizza, so let's reflect that in
> these files.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 332c7833057f..50096b96c85d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -308,6 +308,7 @@ Tony Luck <tony.luck@intel.com>
>  TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
>  TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
>  Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
> +Tycho Andersen <tycho@tycho.pizza> <tycho@tycho.ws>
>  Uwe Kleine-König <ukleinek@informatik.uni-freiburg.de>
>  Uwe Kleine-König <ukl@pengutronix.de>
>  Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4647c84c987..2c60f3ec2496 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9776,7 +9776,7 @@ F:	drivers/scsi/53c700*
>  
>  LEAKING_ADDRESSES
>  M:	Tobin C. Harding <me@tobin.cc>
> -M:	Tycho Andersen <tycho@tycho.ws>
> +M:	Tycho Andersen <tycho@tycho.pizza>

Honestly, I'm just acking this because I truly belive we need more pizza
in the kernel:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Christian
