Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC12D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6iShYJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgFWXap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbgFWXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:30:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88933C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:30:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so175228pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=89qgK7zoxJ0CxIlIbUd135zUy4sjIO0yIPQYW2bQXdo=;
        b=C6iShYJWie7aVa8GVkryo9BBNF5E6UroklqVgSNbUnmSrvA/2+VZNYJpL3shXp5iRK
         YOa71XUddAxmNPhn1KQICzn6sn8ghlmd8u8IPSmWoIj600lgmpjGm/BJzz2+0x6nymui
         xrNQR0cWvVWYaYEihMFcAHbwekRqpAHoivNOD0YJpsLbMqrfhnomGqCk+9sqB/vNzExS
         xcLmA6sRW5m1GbHyQUampD5E8um9yye/cBHTyQ9xOryjd+talV+Xz97xMPw5blS8EJMV
         g43wyqAInEAQSVWC5w90SsQ8Hu3XeyKxUd+rcxLhypmbpHewByKemSeuEd4RuNost1ls
         W9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89qgK7zoxJ0CxIlIbUd135zUy4sjIO0yIPQYW2bQXdo=;
        b=Lue0S8knD63rUG2MdvPQFGukE4jIu1uWEQUJSHsx2TyrqtXECLdnA3x+ATmEFiOIBt
         6P80NEbR7HE457CvRdxoOYVbf4Ng+ltsnQgg4kQxM0Cy3coR6D/8wdPnreBR0cE0rMRk
         6vfegJt2EpTf8T44OTCm3qqbgO0DLK3Jten3hbHHFs1l146c0aM9HjFNKpQQjQ8IOmnC
         ney874BrGc/XYquIhmZzjrznnoBcLSosGBmBjWlNqSLndU5GaHXPjQAshxsedmpB3hRG
         iBAP1euacW4s65fFfIPhTxZC7lL9FsiaYMOrFsxu3qz9Kj72fmbc5721z6AKHW/Oss2L
         QnrA==
X-Gm-Message-State: AOAM532irlp37aQ8/mLIF9Mk814iAmfkSITr1d5a2EjfaY+Iz+YAcoPt
        CQleUiWh9U9bG79s+QsPusRuZkoL37I=
X-Google-Smtp-Source: ABdhPJxaKkxXXN2/KWbYMt8R19keUrj+/zo74qexOzyZbqDPwyo6rkVti8N8GMoMRPk/tKDyOyMfaw==
X-Received: by 2002:a17:90a:7608:: with SMTP id s8mr27397634pjk.159.1592955039921;
        Tue, 23 Jun 2020 16:30:39 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u35sm14655786pgm.48.2020.06.23.16.30.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 16:30:39 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:30:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add WM8524 support
Message-ID: <20200623233003.GA28038@Asurada-Nvidia>
References: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:52:46PM +0800, Shengjiu Wang wrote:
> WM8524 only supports playback mode, and only works at
> slave mode.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
