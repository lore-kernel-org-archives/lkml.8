Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71135C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422942080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnzDLWcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgFPUs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFPUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:48:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA89C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:48:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y17so8937957plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nA38ms2uzE+ajHN4rTksYykHuk1GjbJIu9tKcx5MOhg=;
        b=MnzDLWcOISl371mXt6Ags8GR066pVOClRhnToFqbXpLSS9aPwHtXSCutNTSqwajaM+
         sLvpR+Ivu35ckuxbPZsKGOuOP/z+WXMiDmyvddTpLfk2O7hN1F7tOiIFcWnhrJhFarrl
         6XB+n2IJhv2+sKG8aQir3lnq6nslyCC6mmFT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nA38ms2uzE+ajHN4rTksYykHuk1GjbJIu9tKcx5MOhg=;
        b=d+0otTvZvlVVsGDNa3+OWk05KtqWvm86qetnw4VHoDzEr5yYZcEkNkw+nhhSAOxfRo
         eImRi3l5dwOcc8tQIPFe+vtF45T0LVt8usfsgUveSZ9+om8iRTbr46/AiKlh2YHjxYel
         lAbKyr3xLtxDs4nJxwirTr91FhoU8xyEV/EE03nHqBgNlTt8xrrCMKkj4zabo97bXHvn
         1aErf2Jn2jXHz7P3PapdICNgQpbpsuej/TaHsa087z2ee+tmIGcNuFrof4H29qvIhHtg
         hAqw48jMal4PdahqyzMN9CiZDldbO6YRw2TmKlIizrS9nv2SJj3DcpIbNC2NqRbB17tY
         uKrQ==
X-Gm-Message-State: AOAM5334J7iM9cLKoVIBTM7izG0F6sqJ0Wu1+WNH3+3pl5aLci09rm7f
        O7AyllUskrp92GjD85vc5skXrg==
X-Google-Smtp-Source: ABdhPJxOcw99TrdviCnuRM3FcM2K6qA7B/TiKfR0o/09FFN1um1MjQFAARC1qL3y1wUsGAHOXjoDxw==
X-Received: by 2002:a17:90a:7409:: with SMTP id a9mr4527105pjg.107.1592340538167;
        Tue, 16 Jun 2020 13:48:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w18sm7604075pgj.31.2020.06.16.13.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 13:48:57 -0700 (PDT)
Date:   Tue, 16 Jun 2020 13:48:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH] driver core:Export the symbol device_is_bound
Message-ID: <20200616204849.GZ4525@google.com>
References: <1591123192-565-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1591123192-565-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:09:52AM +0530, Sandeep Maheswaram wrote:
> Export the symbol device_is_bound so that it can be used by the modules.
> This change was suggested to solve the allmodconfig build error on adding
> the patch https://lore.kernel.org/patchwork/patch/1218628/

nit: the last two lines aren't particularly interesting in the commit log,
this could be mentioned below '---'.

It might make sense to group the two patches in a series, which would make
the dependency more evident.

> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9a1d940..65d16ce 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -337,6 +337,7 @@ bool device_is_bound(struct device *dev)
>  {
>  	return dev->p && klist_node_attached(&dev->p->knode_driver);
>  }
> +EXPORT_SYMBOL_GPL(device_is_bound);
>  
>  static void driver_bound(struct device *dev)
>  {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
