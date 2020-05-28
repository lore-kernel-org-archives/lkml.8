Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACBDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9D02075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590678898;
	bh=5Yqhad0g/33BVrHAvgicPwSPY+lu6oRrk5lH0UOOyrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oww8BwWQTAeYrPdKcQE2FIORH5Pwu43QLXeZT4CSJw7KiQMX2zKqYAbukh0iFPP7R
	 0eDg8DrDk8oQc8kLR0Bh7G+ROyGep8HVkJx00rHHmHlHU9AC/NYlrxyfldrLmoK9k4
	 5jcQGIvzwtYqV7j8CUPwS8B65RJkxtnl0CGSOGL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404293AbgE1PO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:14:56 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41155 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404282AbgE1POx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:14:53 -0400
Received: by mail-il1-f194.google.com with SMTP id d1so461852ila.8;
        Thu, 28 May 2020 08:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yIDw/uV1HgHlRds6XnPkvv3A35C2qOGXIu1RjiUeb9Y=;
        b=U9+U87MKo8R/lXKKTeFNzcqdA8/irehaAGSR0PJP7+mNjO/m6WTqJ29/iBl4UomE5K
         1eX5dcLfz4/86tk0IoxrT4JVf3SgGQxiY4g2v1Sn8Z89PrTTRDmr2SrIxr1AkJCN2NG2
         /Z8EF/iwkVdPxW/5aOr4GAed7tXoOdS+GcbKNukFYRDD6Zvyl457j1b+mkLtj0zszm0G
         JTZ36WMVb9juCgLvpd/blMCj09aFM6jgDhqd7po6tcCgZUYxJm9XXmGMc3jcDWf8COld
         vpSV0YKkenoNntdaB7R/rjveGHMrYYpzy5c5ReIoBqga7fK8OP2JGJIGf18Wc9mUY2+H
         ZMew==
X-Gm-Message-State: AOAM5300OgFr9OZ9ClxIeuTl9pZzPc02uejd1AWSqip+DbjY6AyTkmFU
        0t/YyVH775pQwJqWyqZy5w==
X-Google-Smtp-Source: ABdhPJxAz1lpeRppgpo6BunFloCZvsPY8jFkCiVKE8KLqTvD/f0TRuU3AhQ7Ssf3Kpzq9YR+oZzPRQ==
X-Received: by 2002:a92:d151:: with SMTP id t17mr3335382ilg.101.1590678892145;
        Thu, 28 May 2020 08:14:52 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i13sm3442788ill.65.2020.05.28.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:14:51 -0700 (PDT)
Received: (nullmailer pid 82662 invoked by uid 1000);
        Thu, 28 May 2020 15:14:50 -0000
Date:   Thu, 28 May 2020 09:14:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     devicetree@vger.kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, dri-devel@freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 6/6] dt-bindings: drm/msm/gpu: Document gpu opp table
Message-ID: <20200528151450.GA82632@bogus>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-7-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589453659-27581-7-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 16:24:19 +0530, Sharat Masetty wrote:
> Update documentation to list the gpu opp table bindings including the
> newly added "opp-peak-kBps" needed for GPU-DDR bandwidth scaling.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  .../devicetree/bindings/display/msm/gpu.txt        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
