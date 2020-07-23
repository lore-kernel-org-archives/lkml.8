Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD51C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB276206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="RcM+VRiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGWIKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:10:42 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:47743 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgGWIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:10:42 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id yWJHjzu6MuuXOyWJIj8xiI; Thu, 23 Jul 2020 10:10:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1595491839; bh=S4EgoCbBmTgeGbV3FNpEwzrs8Seq7SlB0q88PTB/Mg4=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=RcM+VRiD8st0V/BJSf2L9MvhUo0T8OyRhqfznuVlPCajuoUlCnjB+2Z4FDo/qPraQ
         Jc9L1m3XOA7bSxoFe3VUP9FRh130sr07z79w51IRnUlgXp8elE7boYyu0R9NDRC6ty
         VD2fZx4HimeIgxOnL1lC0SuWfIf5b47hpaHqi2Cs7tFWCXN3DybD8XpGXosfoNhZOU
         TUTvJS3k7LTRKjElL9LC8h7RFTFo/V7nh1geXg1mhaZ4Ik0uKt1xGk9iPIIU9wXuwT
         4Sw+HeFsvhs7ozb2AQWCp0u94SpMvLNXm6fZJ1dtC4+NICYAyGsE95rG6T424CZgcW
         g1P2h4N2m3l1A==
Subject: Re: [PATCH v3,1/2] media: v4l UAPI: add
 V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
References: <20200701093522.8521-1-yunfei.dong@mediatek.com>
 <20200701093522.8521-2-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <047b49b0-53d4-3ddf-e629-1686a6d4eb31@xs4all.nl>
Date:   Thu, 23 Jul 2020 10:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701093522.8521-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFQN2IYlI+0IepjRuZ70GgrkpY9Ngx0UU6k7lKmM0epEF1LWTvJfQyRbUzdemzReVKMEfVECkSDwUvHCFqmC6WMTFU9/qdfF+EpUapAgHTBNveCH/J6N
 nK0IDmGmDsoRpHl7xhiH/Bz4mofLIkVPScuqHc2kMFhfE2eoYNdtXbnpfgwfrZDVVA/IGWIN5z8i2lAWY7qBwzETEzVoWtMgxjM1vplYXWvv3lXbKi7ETxm6
 6QHvYAKqYhVStAtKkFeyFDOBHDLXEf8gpuDdsnNbbIQ02HC9zjz/W7ihTVdV2RaQ19lAZboxNUh7wdGr6m9+N5gGE+5wbpVw0cRz+4SZxUogco0tbkvwB4ZN
 EzW4ZDP5oQmwg+fA7nU68gleNtparGKVRvI1PmpqV1JualWfAvMAoFbJFgRSvs9Ws3WGMr+mqZGQB4/7Q6onnvwZay9aQ1wsK25IJOuvebncPdHgicn6oSbw
 LavBgbF6lhFEZ247AQerScfwAdjxvQ5YiRP6zp9cYbwAp1dCvhq1HPHHB7lNUQCVif9uX5aJCg/SWAW//v7OEapSGpa+uIKQ1gJR1rpZuUtDENL+1Dx3Jz/S
 oaPd6qO95uTtcPmmGS936jCgdoUSuD0iloZ2cKGp1yLzKQrI/3pvMsXXB1aFqzTTUxM0ABDsw7SdO+I9EE6azUpGamhAe8wMD3ud3hrShZc3jxyExKk2OoHE
 W6UVMGaaACw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 11:35, Yunfei Dong wrote:
> This patch adds support for the V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS
> flag. This flag is used for Read-only(Ro) Request.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> index b6d52083707b..7c7451773b8e 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
> @@ -126,6 +126,7 @@ aborting or finishing any DMA in progress, an implicit
>  .. _V4L2-BUF-CAP-SUPPORTS-REQUESTS:
>  .. _V4L2-BUF-CAP-SUPPORTS-ORPHANED-BUFS:
>  .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
> +.. _V4L2-BUF-CAP-SUPPORTS-RO-REQUESTS:
>  
>  .. cssclass:: longtable
>  
> @@ -156,6 +157,9 @@ aborting or finishing any DMA in progress, an implicit
>        - Only valid for stateless decoders. If set, then userspace can set the
>          ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag to hold off on returning the
>  	capture buffer until the OUTPUT timestamp changes.
> +    * - ``V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS``
> +      - 0x00000040
> +      - This buffer type supports :ref:`requests <media-request-api>`.

This is wrong, it supports *read-only* requests.

Also, Documentation/userspace-api/media/mediactl/request-api.rst should mention
read-only requests: I think a new section "Read-Only Requests" explaining the
purpose and use of such requests would be best. It can be inserted just before
the "Example for a Codec Device" at the end.

Regards,

	Hans

>  
>  Return Value
>  ============
> 

