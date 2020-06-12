Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619ABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A94D20578
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R11IQyFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFLIBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgFLIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:01:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED432C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:01:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so3928624pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XY0Kd0MAkqDRfCM5CZwaoAipfMsQ34/pTBpRI/Gy2M0=;
        b=R11IQyFQgzW+BqKYe1vGc5m/TGV1nUF3yS0d9X2YdzzLgQvGmpqWtSlt2WHNkFGldE
         y9qypcAtZXJqHYlXT8ehuXtsZioZogq4k75/uIGWfO01i0Oq7V5cq1ngdX2WJaHYdxTZ
         TT0whjl1FkxzVmAmL7M7MI21/j0lkQPyYkKURTZqWN13e2+o8L1H5V0XsVmXX3DcaPeY
         YcfodIYDi6KsHmdoVNXTfdWs26XMXY0oq51KF/yYl8wb+ofQVq7NEberAedkBIhxF0p6
         6PHM1G44pm/zeWT3a+0fobhfRR/+nO81qLcqGf2DfYegDmBSdldi3eFJqX9G4SX31fu7
         WfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XY0Kd0MAkqDRfCM5CZwaoAipfMsQ34/pTBpRI/Gy2M0=;
        b=DPhsjNWDTe3+46GqKaberMqo740bzK43d4NHjer6D0iawonuoTQQbs4FcKETMQb7Ej
         k152upG+jYmv0szyQ7zeg8YWol826afW3wqqVAH3bZzZYtSpxGzUS1Xi+x+En7PAs/XI
         racFR4l0Yp4Ul7TdsudnklwRA3j6DC+D0XBl5mg3QYc1UNRMv/FBREJOdnbkPe/7MGf2
         p9pYWqivrlE+wxd7LF04OesK/L/zjhpC+fIIW8UyRo3WhNEiMdQRediWHmxasQhsgDVE
         pTUEqUefeBJm5NlEbAx0c4NBjfjeAruxnQSABbbKInpqG5be1YSP073OhSOgC96oicAo
         kurQ==
X-Gm-Message-State: AOAM531NU35GNIXuGSoq324HTWxF/12NRLoQBd591O4k/C6H2thrKMi+
        T1y7e6sOr9PWygnYfFPoqQI=
X-Google-Smtp-Source: ABdhPJyfSjW4igzMKRqt4hjfUewgh1f4ezU4kuzE2PczkbgWn387+h2coH1BunsDoAXhJ9nnMiqrIA==
X-Received: by 2002:a05:6a00:1592:: with SMTP id u18mr6469145pfk.26.1591948894330;
        Fri, 12 Jun 2020 01:01:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id gp4sm4590235pjb.26.2020.06.12.01.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 01:01:34 -0700 (PDT)
Date:   Fri, 12 Jun 2020 01:01:25 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 2/4] ASoC: dmaengine_pcm: export
 soc_component_to_pcm
Message-ID: <20200612080125.GB22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <429c6ae1f3c5b47eb893f475d531d71cdcfe34c0.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429c6ae1f3c5b47eb893f475d531d71cdcfe34c0.1591947428.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:37:49PM +0800, Shengjiu Wang wrote:
> In DPCM case, Front-End needs to get the dma chan which has
> been requested by Back-End and reuse it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
