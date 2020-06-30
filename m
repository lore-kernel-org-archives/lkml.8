Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0401C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B3E206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593528094;
	bh=DKOYeYGw+Ol0mvtQbyZ3eKFa12XjDoLn29NlAzzypKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=No2iihNLfcQhOgJLcXmH2yQ7cajnCs6GjRT3mQSv+g1CpB2II3KfP10Cul+3G+yI7
	 eVR+CJPr6DkLBU8WLV4zxZfl4+kKMxzORykP9l+Q5SscbgqHRnsxP0N3SnJ6ceVEY6
	 sQ1Ik5IDoHg4VhLPByZgIz6qNtlUkz/c7GD+9ys8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgF3Ole (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:41:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34648 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgF3Old (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:41:33 -0400
Received: by mail-il1-f193.google.com with SMTP id t4so4738641iln.1;
        Tue, 30 Jun 2020 07:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VDqveuYp+/5vPaCCI8/yc9DsHxnIelTQJyDQ2EuqkQ=;
        b=uZiOA1126vNtiS/IjIYhzHWCnibkAeK/3DPriHvcC7zTtzmL9M85OguQGik/93OzaP
         KXuPwHSjLOX8goQKCjNFbx1G/CEjFUrCA0GL+Q2q9VFJyOTLJNNbblJQ3OERWwwkCprv
         G2XEveLq2/pwGeC4sepY2hjCdpmthBT631eseHprAzhrqsQXv2gLA0RbTzJ/e6A/ygKF
         Wzr6nfiI+Ea5kZPBZsVLwM7ThzctIkDl7ewqCnPwhbEAsLdaTZ/xj7xr3h7I+ze8W8Lx
         l+A5XHc9PQEdIHCCYRpHQfYPekHWZ/dX5fq9cRVz+ZtPJcgw9+OKtbdGI0SE37l/pKss
         H3fQ==
X-Gm-Message-State: AOAM530Y3LuYECl4GhTgvn5jUVY08QlonPRdIIHgcR3utaIhf+2ANtTU
        AibDntj9LL8mlw4Gx9omiA==
X-Google-Smtp-Source: ABdhPJxGqnWB8o6bHhv/aVG1NS7A8tvELK0zFjb0R5s4gC8JQ317bgQedIAUTNNxTWNoGnvNfYLexw==
X-Received: by 2002:a92:48d5:: with SMTP id j82mr3070450ilg.167.1593528092510;
        Tue, 30 Jun 2020 07:41:32 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id u65sm1585732iod.45.2020.06.30.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:41:32 -0700 (PDT)
Received: (nullmailer pid 572829 invoked by uid 1000);
        Tue, 30 Jun 2020 14:41:30 -0000
Date:   Tue, 30 Jun 2020 08:41:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rui.zhang@intel.com
Subject: Re: [PATCH] dt-bindings: thermal: Remove soc unit address
Message-ID: <20200630144130.GA572716@bogus>
References: <20200630121804.27887-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630121804.27887-1-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 09:18:04 -0300, Fabio Estevam wrote:
> Remove the soc unit address to fix the following warning seen with
> 'make dt_binding_check':
> 
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dts:22.20-49.11: Warning (unit_address_vs_reg): /example-0/soc@0: node has a unit name, but no reg or ranges property
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-sensor.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
