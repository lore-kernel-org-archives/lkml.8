Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F03DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8172541D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv4KyCep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFVGj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgFVGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:39:25 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B50C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:39:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 64so1275168oti.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNuMdqRwrLz9vD8xRJNwtGlXJp39SHPqNF0e6VyJIxM=;
        b=bv4KyCepxXxyrUB07sqH9I911+MDHV9RKlAjq4QDoSgiSZCLomrGM4kqhCvgqbIm7w
         x2cWkwy2Krx0Y9QOlBsAlJ6SjOlyuxDncP/pKu/83xR+NkBtQ2aZdoH9bsO2vsGLmq7/
         DoIODaVtZPysg9dV78iybpIHuMrxrbPvwDiOfkJOh2aB8KlSRthYpFKSMOXaGr/4y8Ox
         UkHhPvRFEpsyYr932fUEedU2G90zwQc7Rf8WMfx5EdWBDJHZCCyPwzwYOktLytK2+LX2
         B7OpdS+q+tBaaTSK1BOzaxe0iUkKbz5oAnQypR/G41UqpUPCDQBv8nr0St5JfmymPvap
         lPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dNuMdqRwrLz9vD8xRJNwtGlXJp39SHPqNF0e6VyJIxM=;
        b=somBJifjxApC/plgnE7ic9QjsG/w//3AEPsaTL+PoSkC/kDcEKiBoLBBDGgstIVeT2
         Esv7G6r9W8HZgz45T6aSZSqUIeMjct2KC03uVLk6PrJNeDPHTTAHy3N14x1Vlvk0sVAd
         mFCZ77nEyBsAwHpvDWRgwcLS+N/nBg8nkGvrBQPtzFgzGlSJSbpePvBO0wOX5FOYC5cw
         uJcYAiw1v6QtJbgd6jJhWByPpRE6YUDue0za9AfZjMSx2+xTUijQ0VBGQGCSFwuZNsnY
         h40Di7cWc51UiJXu6y/oS52MxvI9K8+yL5j2iyt+X8ncBdsXr6e1dzA2Z8b7b44Srfdc
         AnDw==
X-Gm-Message-State: AOAM530j7gF/finR+eXg1Yjcva2BkA/pUPSEuPDDjiypIAqWDvNRQqNT
        GvUZNHtdm3WGnu7uU4DfG12nsQ==
X-Google-Smtp-Source: ABdhPJxZt/4YFmgo2Vjb5O1nD5Di+/baUjXE79Mc3ZjNakah/nGTgnxw3LywvkYef71WhQyQxS1EDA==
X-Received: by 2002:a05:6830:1e61:: with SMTP id m1mr12271701otr.13.1592807964696;
        Sun, 21 Jun 2020 23:39:24 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g12sm3271301oos.8.2020.06.21.23.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 23:39:24 -0700 (PDT)
Date:   Sun, 21 Jun 2020 23:36:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 2/9] remoteproc: Add new attach() remoteproc operation
Message-ID: <20200622063638.GC149351@builder.lan>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-3-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601175139.22097-3-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:

> Add an new attach() operation in order to properly deal with
> scenarios where the remoteproc core needs to attach to a
> remote processor that has been booted by another entity.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_internal.h | 8 ++++++++
>  include/linux/remoteproc.h               | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 4ba7cb59d3e8..fc710866f8ce 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -79,6 +79,14 @@ static inline int rproc_unprepare_device(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static inline int rproc_attach_device(struct rproc *rproc)
> +{
> +	if (rproc->ops->attach)
> +		return rproc->ops->attach(rproc);
> +
> +	return 0;

Afaict we don't allow the registration of a remoteproc in DETACHED state
without an "attach" function specified and as such we shouldn't be able
to end up here.

On the other hand I think it would make sense to have a system where
"attach" simply just means bring up the communication with the remote
processor, so let's keep it as is and we can adjust it as necessary
later.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +}
> +
>  static inline
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 21182ad2d059..bf6a310ba870 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -359,6 +359,7 @@ enum rsc_handling_status {
>   * @unprepare:	unprepare device after stop
>   * @start:	power on the device and boot it
>   * @stop:	power off the device
> + * @attach:	attach to a device that his already powered up
>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>   * @da_to_va:	optional platform hook to perform address translations
>   * @parse_fw:	parse firmware to extract information (e.g. resource table)
> @@ -379,6 +380,7 @@ struct rproc_ops {
>  	int (*unprepare)(struct rproc *rproc);
>  	int (*start)(struct rproc *rproc);
>  	int (*stop)(struct rproc *rproc);
> +	int (*attach)(struct rproc *rproc);
>  	void (*kick)(struct rproc *rproc, int vqid);
>  	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
>  	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
> -- 
> 2.20.1
> 
