Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7331BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2BD206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWVn3c8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgFPAaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPAaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:30:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:30:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 97so14651829otg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+i3xhPEZXa0gRiDvTRs3pZ+q40HmUbfs/tMCxOEi04=;
        b=SWVn3c8e2HsMKXeVUuTcfwoTc32Q273CosIMDRrsiMl5ywcgRZPtooEYs2ID/PMZXK
         o8svu/VgECYicxcp0b5gmBXikveqz8kw+1PxYvgfwWqjFNXW73JI9qoQ+wDzPDUF1ueI
         YddvNfVNWOVGKo1v/a1DlZHb2pPIzWTlldT2DtjRDPFdlNxL8JrB/iSOovRNFgufxAdH
         hgUZVAY6Vxd2D2JJ2eQjAaL3JC8aIe37anbrTvvxGHiMk20J+Z/nGYT9R2QDVArjMCEY
         y5pyfILlQsMEcmb+X/jqBsuwPAu4c+MWh3jFkGgCLwuA9IAyJHCsnwjrza83dW/2wgFd
         187w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+i3xhPEZXa0gRiDvTRs3pZ+q40HmUbfs/tMCxOEi04=;
        b=hDzZ/2+9yslsvShUHCAqXKFFu3pPxSe+GlHddubhn4yBvN5iLZNRXCeV3isYx6mcbH
         LXDSrFFqu4ZX767AjIQwWYB98EHskgQ1Ew1KlEbHOnSgGol7VMQmp2iYyyiKu+MyFVfH
         uJyjyXG3lA1CaP22Q5vkEvDEhrIffql4hUZoHF1tdrAOfQfPKQHzMMfMRPlJm6dLRLSA
         WexAUqYwpn3f3gKXf4pn6+keYAhUMy6BDs8C1Z0NFnt4ZM7kdyD23e0UI01CKjTY4dw0
         oQOWhe14khZ1Fpma2gHoHoRKnosQhu3AnC7rmvEamzgNzAjv37HK9V+I9hJnrJVvzkLo
         1vKQ==
X-Gm-Message-State: AOAM533KQYKFevYmZxvl9cCsF2erhoPLxuOQgiBj5gr70x7jllASQG17
        yvam9T7mL3FxQ7W8v4iGpaw=
X-Google-Smtp-Source: ABdhPJw06RVfM4Tq3klBq7MIzX6H/d5DEyWLwi3aPOAJkI2/AgXsus7ZG3QIYEU83OigDQqSemtUfA==
X-Received: by 2002:a9d:22aa:: with SMTP id y39mr508401ota.76.1592267406541;
        Mon, 15 Jun 2020 17:30:06 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id y206sm3608448ooa.32.2020.06.15.17.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:30:05 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:30:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] phy: intel: Eliminate unnecessary assignment in
 intel_cbphy_set_mode
Message-ID: <20200616003004.GB1307277@ubuntu-n2-xlarge-x86>
References: <20200523035043.3305846-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523035043.3305846-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:50:43PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/phy/intel/phy-intel-combo.c:202:34: warning: implicit conversion
> from enumeration type 'enum intel_phy_mode' to different enumeration
> type 'enum intel_combo_mode' [-Wenum-conversion]
>         enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>                               ~~~~~~~   ^~~~~~~~~~~~~
> 1 warning generated.
> 
> The correct enum to use would be PCIE0_PCIE1_MODE. However, eliminating
> this assignment is a little better because the switch statement always
> assigns a new value to cb_mode, which also takes care of the warning.
> 
> Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1034
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/phy/intel/phy-intel-combo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> index c2a35be4cdfb..4bc1276ecf23 100644
> --- a/drivers/phy/intel/phy-intel-combo.c
> +++ b/drivers/phy/intel/phy-intel-combo.c
> @@ -199,9 +199,9 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
>  
>  static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
>  {
> -	enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>  	enum aggregated_mode aggr = cbphy->aggr_mode;
>  	struct device *dev = cbphy->dev;
> +	enum intel_combo_mode cb_mode;
>  	enum intel_phy_mode mode;
>  	int ret;
>  
> 
> base-commit: c11d28ab4a691736e30b49813fb801847bd44e83
> -- 
> 2.27.0.rc0
> 

Gentle ping for review. Nick did comment that maybe keeping the
assignment and tidying up one of the switch cases would be better but
every maintainer has their preference. This warning has slipped into
mainline so it would be nice to get it cleaned up.

Cheers,
Nathan
