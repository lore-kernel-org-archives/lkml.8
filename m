Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48CCC3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B459B20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="rJteDZ77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBDT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:58:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41466 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgBDT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:58:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id l19so15332374qtq.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nUYiDfAhgCZXRYErtoRQy6/rVWr7Gr3L/ebDcQHtW8c=;
        b=rJteDZ77rao5hGEilyGPjz2uLvmX8nHdHJNyj2fs0bRbiulWazSW29HRjw63ZRbMSf
         YOOaGro7M76kDhN4Pz8lQrpWqWnBaPpT9idY4uJoSenhaB+gJ1JRMexyeo06S+2aw2gb
         N4EJZjiOwtvpE+nFn5BkwAbfkp+8K5VhwRdXCPoUnpfRczgprwqze5jtEZJlBhK2DCtq
         YSOIAIgdtKzYH8bdDy4H4r/xQARIpX0ec7j1YFcnVZHmx12YjtNWwXNPHsQejHEGqP1z
         LqiNMp5vIF2kBmOlrsy/LXnI2ZD0klA2C95GIVh1DOlQ0VeqogrNUfFUcw4Scbhj36he
         RYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nUYiDfAhgCZXRYErtoRQy6/rVWr7Gr3L/ebDcQHtW8c=;
        b=ejMEfus6/1tPrxeQzMAz6JGHpiq37qEEMB3l56P/g/N/pcBpADiJ35Xtt0H42cpu2m
         6s/WsSbB/wSvIpMCLYAfObpmx093H80lzhqTtgE0/NEQkBDw/LQIDoFIfyc87FV3c3Ww
         q4ewPM9Gn23ug26G2GndV+8A/9NCxbLdqZe6VyjOIckQl+9BvBAaBHnau9zoHjG4C4HK
         odH9xz9JyJU3K+teKuAgKXG8rCU2p0Klcmdp0v53iM47QxPp4SaOywdZy3wArjOerSH3
         aaEly2MCwDKuFHLSL54qf+qtUY0etiMj+PRVGbRK+Wp9KeRW+yVUIvHgsSCxnafhSJxM
         MG9w==
X-Gm-Message-State: APjAAAXUA/+/fyluycFN6kK5LjGF0kP1Lj/M9Zeu7S9B55TMWqT9w8lU
        DWGS5NcSD8sv31zCxWE62/xJ8g==
X-Google-Smtp-Source: APXvYqwWXd+xCIFH82pgvzLUel/qSAxcq02npWNuT+UV/0x2XRvUupDPcFmEm6BmLWUk12NmYXKi3w==
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr29789882qtp.209.1580846334248;
        Tue, 04 Feb 2020 11:58:54 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2610:98:8005::527])
        by smtp.gmail.com with ESMTPSA id o187sm11852053qkf.26.2020.02.04.11.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:58:53 -0800 (PST)
Message-ID: <ef94a7c141479622ecc499dba4da0583a4ea315e.camel@ndufresne.ca>
Subject: Re: [PATCH for v5.6] hantro: Fix broken media controller links
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>, stable@vger.kernel.org
Date:   Tue, 04 Feb 2020 14:58:51 -0500
In-Reply-To: <20200204193837.16021-1-ezequiel@collabora.com>
References: <20200204193837.16021-1-ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 04 février 2020 à 16:38 -0300, Ezequiel Garcia a écrit :
> The driver currently creates a broken topology,
> with a source-to-source link and a sink-to-sink
> link instead of two source-to-sink links.
> 
> Reported-by: Nicolas Dufresne <nicolas@ndufresne.ca>
> Cc: <stable@vger.kernel.org>      # for v5.3 and up
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/staging/media/hantro/hantro_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c
> b/drivers/staging/media/hantro/hantro_drv.c
> index 448493a08805..840b96bee082 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -556,13 +556,13 @@ static int hantro_attach_func(struct hantro_dev *vpu,
>  		goto err_rel_entity1;
>  
>  	/* Connect the three entities */
> -	ret = media_create_pad_link(&func->vdev.entity, 0, &func->proc, 1,
> +	ret = media_create_pad_link(&func->vdev.entity, 0, &func->proc, 0,

As for the m2m comment, some local define to name the pad index would make this
readable.

>  				    MEDIA_LNK_FL_IMMUTABLE |
>  				    MEDIA_LNK_FL_ENABLED);
>  	if (ret)
>  		goto err_rel_entity2;
>  
> -	ret = media_create_pad_link(&func->proc, 0, &func->sink, 0,
> +	ret = media_create_pad_link(&func->proc, 1, &func->sink, 0,
>  				    MEDIA_LNK_FL_IMMUTABLE |
>  				    MEDIA_LNK_FL_ENABLED);
>  	if (ret)

