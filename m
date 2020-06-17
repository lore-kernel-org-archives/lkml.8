Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F60C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C9B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Sgeh2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgFQGat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgFQGas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:30:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25EAC061573;
        Tue, 16 Jun 2020 23:30:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v11so766960pgb.6;
        Tue, 16 Jun 2020 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IuEEwJ04EBGcVHdnYAuzzOkyntyIEkeUlotMcthbmkc=;
        b=a6Sgeh2Bm1vazQsOfe1eW9TwV0e7aO28v2HKFX7lXlSDMjM2Sm6ez2eo8Td94zie2x
         sLzmCPgLe+ugdhipeAo/JCl2PPh+epJPllLKKjKUF25kWvk+SMbv00SZ1cof1R/vFUHu
         VP2UwX084+Q6tXIPO6Y3OvK22yTWg0qHERGRfQ9mLAB2bvJk3Au6ZxMn9vX0gwKGR/Aa
         PSWrCVRSdjxE2rxB3xKIVdMryqWo0LtQw/4u2FtePnA8rsZq7uwgpqi9XEYfAgfOBRFl
         foVFSSvacYmHtXCSzndCe+5i13eIvuR4dGj0xcFBhiklDGgXKB6jBbjYOM5mO6rWu3lT
         3KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IuEEwJ04EBGcVHdnYAuzzOkyntyIEkeUlotMcthbmkc=;
        b=PkuRhLJ9RYzrM6j0+LaK4LMJbMcLkfQ8lQhQQzt18UUE13Ifb2UUzPhZVj+I7iqxbg
         N+6DFqzRMptHa9N4dH67d9Jleu1PCiBB4wIojUNooqnJonTTriee8LEjad4+0odbtdUL
         ITKnpnckshMT+y9V3fzq7nTsCcOSYYK/tLv5naEt8Hr5D7d6Zqx/DkWk5SHFWy4g5dr+
         Ztm1XhxybL5VxF+B2Pr4GgHh94RzZ9J8oEFMiO+vC41rsbzWfHufguoVIl9+SOiCYuYq
         Rbl6hJsxVtp6U4dGAKRaTocXB6+USLTUPOT4Nj1/qvBE7E980muf++6l6Y3SS2PczNkX
         iG7Q==
X-Gm-Message-State: AOAM5317c7sY1cR6TwVXeZgx1SxBnzGPedaLFyFElPJdAvVn8QhHrS2i
        HqlHgveRdeVQnVDAXb7rEWgD6hUI224=
X-Google-Smtp-Source: ABdhPJxFKo5k6eMIrz7WX/mVTR86nWQvTVi0bPtFQJ1sYGqHcR+gLGs6ETf3H4OPj/RJCTNuyvo53w==
X-Received: by 2002:aa7:952d:: with SMTP id c13mr5315206pfp.125.1592375448136;
        Tue, 16 Jun 2020 23:30:48 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x3sm18976602pfi.57.2020.06.16.23.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 23:30:47 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:30:32 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: fsl-asoc-card: Add MQS support
Message-ID: <20200617063031.GB6411@Asurada-Nvidia>
References: <2185a3ec866bc59f82d93b73d1a732a896fd8f48.1592369271.git.shengjiu.wang@nxp.com>
 <918505decb7f757f12c38059c590984f28d2f3a4.1592369271.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918505decb7f757f12c38059c590984f28d2f3a4.1592369271.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:48:25PM +0800, Shengjiu Wang wrote:
> The MQS codec isn't an i2c device, so use of_find_device_by_node
> to get platform device pointer.
> 
> Because MQS only support playback, then add a new audio map.
> 
> And there maybe "model" property or no "audio-routing" property in
> devicetree, so add some enhancement for these two property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
