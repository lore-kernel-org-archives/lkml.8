Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA4C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E458B20781
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GijluJZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgDXT4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgDXT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:56:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC6C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:56:02 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b13so14572881oti.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mxyNAcrpAygdl0PQUuE7YWHqIPwtRko8aJ9V9gG70nQ=;
        b=GijluJZWWp+LFBb7h6DeNgHOUecBxi1OD1hjb1vB7Iy4+Kc0JoPmtDax/Y20FupRuB
         FC3NU4SMoI6Fdl799BRM5BErL+sM7F66CeL4m93b7RfJ2UBMuhjPFL9mWWtUECF+bn5R
         /fBFRf9252j1gSjzpg+ifbxcmQ7dQIuXqMfjVbtCbAiO2cEVIcvkHom/B22omI84P9cj
         C5BUksbGxK1dKwTb6fTA5k0Rty3wKtgcEsdCc6kdDQCD7oZMMNqIPtJbyCpbnOFNkYWw
         COw8AwCgEBjo3Wj9sItt/5LNsOyhX7XQSvPJpSYwfIiI4V5aIGTtWpOTqTHKyzpOux+N
         FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mxyNAcrpAygdl0PQUuE7YWHqIPwtRko8aJ9V9gG70nQ=;
        b=uiQ/NjNitw5Cqpc86b2TWaYl6uusyncYLH/rJfGvM2ageDihiszX3XRoEWGVEXDAJA
         i6NuQdcJ5cL8RHozhBXwCbBYSllW2cbd2O1u0D3K6fscAuwmRM8HRtuTBHjJKRJKfngo
         gdDTxhccz7Llz0BJ8MPI9E+bsLv0BtQbbp2EBFB7Q+mjf63/7oxnCbekST2VbOf8SYfT
         wDK1/7xvpFNdtO6a5C1uoBUJh1oG1sAd7P2l7dxa/x4+70SWQ0dypvB2sLGN3qpsxhUp
         8qAyG61gmkQM01TuKR3G6DeRc9pIUlFSeAfX0wknz0F+dkgmJqxr6imtAqa6kDQT27c0
         lJ8w==
X-Gm-Message-State: AGi0PuamS2gTPrrRWVdT//cl6ftfx6UMdNtT8x8oFwMXtMNRMf8YCf3W
        +pS5Lnb6M5DvM41MNsjEJPo=
X-Google-Smtp-Source: APiQypKG99R9/t7a1R4PtD4C2Aa45HoghelBN5DZhIdQpZzDWtIT9YE/s90axTBUiQUGswriUfMh9A==
X-Received: by 2002:a05:6808:b0c:: with SMTP id s12mr8412430oij.163.1587758162094;
        Fri, 24 Apr 2020 12:56:02 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id h24sm1767443otj.25.2020.04.24.12.56.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 12:56:01 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:56:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] soundwire: intel: Remove unused function
Message-ID: <20200424195600.GA45659@ubuntu-s3-xlarge-x86>
References: <20200422190815.5975-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422190815.5975-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:08:15PM +0100, Sudip Mukherjee wrote:
> The function sdw_intel_init() is not used anywhere, remove it for now.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/soundwire/intel_init.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index ad7053463889..2f37dad06321 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -183,29 +183,6 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>  }
>  
>  /**
> - * sdw_intel_init() - SoundWire Intel init routine
> - * @parent_handle: ACPI parent handle
> - * @res: resource data
> - *
> - * This scans the namespace and creates SoundWire link controller devices
> - * based on the info queried.
> - */
> -static void *sdw_intel_init(acpi_handle *parent_handle,
> -			    struct sdw_intel_res *res)
> -{
> -	acpi_status status;
> -
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
> -				     parent_handle, 1,
> -				     sdw_intel_acpi_cb,
> -				     NULL, res, NULL);
> -	if (ACPI_FAILURE(status))
> -		return NULL;
> -
> -	return sdw_intel_add_controller(res);
> -}
> -
> -/**
>   * sdw_intel_exit() - SoundWire Intel exit
>   * @arg: callback context
>   *
> -- 
> 2.11.0
> 

This patch will cause two more warnings.

$ make -j$(nproc) -s O=out allyesconfig drivers/soundwire/intel_init.o
../drivers/soundwire/intel_init.c:152:20: warning: ‘sdw_intel_acpi_cb’
defined but not used [-Wunused-function]
 static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
                    ^~~~~~~~~~~~~~~~~
../drivers/soundwire/intel_init.c:51:2: warning:
‘sdw_intel_add_controller’ defined but not used [-Wunused-function]
 *sdw_intel_add_controller(struct sdw_intel_res *res)
  ^~~~~~~~~~~~~~~~~~~~~~~~

Removing these two functions seems to be enough. link_mask should also
be removed at that point.

Cheers,
Nathan
