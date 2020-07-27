Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E90C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D56920729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J/Vg4qI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgG0UKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgG0UKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:10:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F4C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:10:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so917975plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdLyNGTWMHvHhwOJiAVBynAmD0CjHGQzhSi/nggidvs=;
        b=J/Vg4qI9eDkBhX0XginvSJghLnUks7HG7oSMGZrNKStY5y3R3v9/fujqIbakw/XA9G
         ngFsdubO0Fsnh6ueE1f9sR1HTzu0n4v5xMMj/2sBd2bHfHtMuNXTvSBKlrKSYwYKhXe/
         S9/4UA5qFjZ/sftKUkyuU6MoXy+Ch8HR+n+dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdLyNGTWMHvHhwOJiAVBynAmD0CjHGQzhSi/nggidvs=;
        b=IH1PI7F5miR2ULZW6kvWG54m34qxNfFF8yFzkL35AE31nFvN4fAKncv9PfHiaCD2Z0
         ept1vCK2TmV0Z+ARoYNEFmJM2B4u7v9RbQrpV2Pl0meefApPi2IJuortZJZu+b5TGWFm
         GsJaJAizrevaO78MJWmVoCJ496TnyvM1zmPxcIZdZ8XyGSyQThb28i3iVJYRf7/papy4
         N9z1VpitNRazUn+ZmqZjngrd86V3eZMpcWgFMwyrVDSOIwnR85uQSlECXhylPVzrYCEs
         47A+PmKYvJu1IBUmlFvZs9xFGguCoEjVsXb9nvIFKv16jfHIr9h+ZO6VUcqoJYUz3/3n
         UwAQ==
X-Gm-Message-State: AOAM530ZuECkQM4dkExH22zXlmwcQ4qN0ilguOLUZMk10HLamUFqOKM9
        aLLcrVsLBIvpYjR7PFBWt8/kdg==
X-Google-Smtp-Source: ABdhPJxBz1FXycwPTXTy/WCTt2NjfqcLLzcYIy4Yx9gFDji2WBixP5lH/qx3NIthBdl+34zBfkswGw==
X-Received: by 2002:a17:902:680c:: with SMTP id h12mr20030463plk.86.1595880623009;
        Mon, 27 Jul 2020 13:10:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id l62sm469449pjb.7.2020.07.27.13.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:10:22 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:10:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] interconnect: Introduce xlate_extended() callback
Message-ID: <20200727201021.GE3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723130942.28491-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:09:37PM +0300, Georgi Djakov wrote:
> Currently there is the xlate() callback, which is provider-specific is
> used for mapping the nodes from phandle arguments. This is fine for simple
> mappings, but the phandle arguments could contain an additional data, such
> as tag information. Let's create another callback xlate_extended() for the
> cases where providers want also populate the tagging data.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
