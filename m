Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB5C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6C020809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FTa08Jum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgG0Uzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgG0Uzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:55:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D0C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:55:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w126so9580601pfw.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bhP8c3ORdPWDlqnnbGuCZRHV46MZaJIZrpgZrFhGf0A=;
        b=FTa08JumHKpL7dCKC6F3Y/47u+bsnLr2xoLj/mrKwMm9jY+pMPtRfLqaiYH5ajOiuy
         gwazm9DFfePxGyl1LYAaSGP02ptms9TKzvb23nHDTO2FYNuIU9JcTYHTlwu84rQ516tL
         nTujTvdWrvTobCmmr/ve2s3jKy/eDqOyoG5Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bhP8c3ORdPWDlqnnbGuCZRHV46MZaJIZrpgZrFhGf0A=;
        b=fKQd7Z2Nt4vpl/RnvNnY3LRwtpxzc4JigZmEImUselMsXTprurStX3/CROxwa8QIAv
         fIIBQyigEL7vuP8EA+jdeigppeLba4gcXzvgdcruESn8OunknK473kqfqB8RpcIIJrpY
         p6xIEDYE+g1ihW+hU6/yPgOTu1bykYQpQsyoXqIplyulzfBfmHCs9r5Y2sksKfWswyVY
         gcO3KwcYe8D/pqO6wfhJETHNung1e582f7rtJGAP83y6MkYFs9KNSSECBe7z6jVRaH7p
         3r+gjGogY6Q8d6TpGZQTu9VKlYEqYeeE/nFSPe2E6zCNxlF62JrRcTkLzFw8k5hM9TL0
         jzrg==
X-Gm-Message-State: AOAM532ZjNWbiOCGWmajrxe5DKANaNr0b2U9Eq7ji/b19Z4aQRZH3Mrs
        G/aU9jbGuJWq19v+nMuyZV2L3w==
X-Google-Smtp-Source: ABdhPJxjpKz+El+vxYGRCL/Ty0XO15gWn2h9AfLlj9O3/ZH0J4sph2IftFtarPwxqF/aRzxx/DSE8Q==
X-Received: by 2002:aa7:848b:: with SMTP id u11mr21353847pfn.72.1595883347093;
        Mon, 27 Jul 2020 13:55:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id d9sm16200235pgv.45.2020.07.27.13.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:55:46 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:55:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sdm845: Increase the number of
 interconnect cells
Message-ID: <20200727205545.GH3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-5-georgi.djakov@linaro.org>
 <3c8c4aae7697d9d5a052b9dfd1ea0cf4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c8c4aae7697d9d5a052b9dfd1ea0cf4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:28:35PM +0530, Sibi Sankar wrote:
> On 2020-07-23 18:39, Georgi Djakov wrote:
> > Increase the number of interconnect-cells, as now we can include
> > the tag information. The consumers can specify the path tag as an
> > additional argument to the endpoints.
> 
> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> 
> https://patchwork.kernel.org/patch/11655409/
> I'll replace the tag ids with the
> macros once ^^ lands.

Great, I was going to ask about that :)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
