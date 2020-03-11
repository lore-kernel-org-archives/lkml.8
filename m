Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2CC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFB720739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgCKTBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:01:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33740 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgCKTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:01:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 8F772292194
Message-ID: <02c89cb555c10ae61a365a2f54eb72bc4aee3c78.camel@collabora.com>
Subject: Re: [PATCH 6/6] hantro: Refactor for V4L2 API spec compliancy
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Date:   Wed, 11 Mar 2020 16:01:44 -0300
In-Reply-To: <20200311174300.19407-7-ezequiel@collabora.com>
References: <20200311174300.19407-1-ezequiel@collabora.com>
         <20200311174300.19407-7-ezequiel@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 14:43 -0300, Ezequiel Garcia wrote:
> Refactor how S_FMT and TRY_FMT are handled, and also make sure
> internal initial format and format reset are done properly.
> 
> The latter is achieved by making sure the same hantro_{set,try}_fmt
> helpers are called on all paths that set the format (which is
> part of the driver state).
> 
> This commit removes the following v4l2-compliance warnings:
> 
> test VIDIOC_G_FMT: OK
> 	fail: v4l2-test-formats.cpp(711): Video Capture Multiplanar: TRY_FMT(G_FMT) != G_FMT
> test VIDIOC_TRY_FMT: FAIL
> 	fail: v4l2-test-formats.cpp(1116): Video Capture Multiplanar: S_FMT(G_FMT) != G_FMT
> test VIDIOC_S_FMT: FAIL
> 
> Reported-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
[..]
> @@ -227,12 +232,12 @@ static int vidioc_g_fmt_cap_mplane(struct file *file, void *priv,
>  	return 0;
>  }
>  
> -static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f,
> -			  bool capture)
> +static int hantro_try_fmt(const struct hantro_ctx *ctx,

Oops, it seems there's a warning due to ctx being const-qualified.

That should be fixed of course.

Regards,
Ezequiel


