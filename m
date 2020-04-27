Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE56C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BF4206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL2IJv0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgD0G7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgD0G7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:59:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D7C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:59:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so6650095plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNj7owPD+ZbRnStugkoSGfUDDLECau6V6cMguxLHseM=;
        b=IL2IJv0CwAvaTDLiqlc/43W1WRn+mgpJHcQ8lcGu5IP5LESVReGp34dPTQGf6e0LZa
         3rCwR8nNmXOAEkd7Qzy7NviBN1004OJr8Pb5pMjqmfp3qpJihUZhwd7nyTcdErdOInIe
         uT/acoJunK3/lzcWSYlr70GlAd1cL4+5aQRsO6ogXJBgfPAl7j9pz2uqOwVdBWbYe0q6
         lbHRELStH3w+8HvL6IraAq8odymfgvcnvKnG15I3pwiOqF/UTkx28z5RWu01Jb8zRX6u
         8N7Ya3TKyfDwMXJcwDdk6fA1JUwRLmFDLFLl41eCmhPhg6qDStbEFse06rD8j62TGsit
         h9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNj7owPD+ZbRnStugkoSGfUDDLECau6V6cMguxLHseM=;
        b=BnD4tJKzXPsnzRkuN4REVceQRngm2SYoEgcsyMetTKdkloB0AdCl/k5TqCtC7Oc6xb
         bI6MlmY4Xd73fDhTmXIHB/6yu8iy5cs49zNe+kShapG1BnunwsRWVMJhbaw4arXx/TR3
         bE467e5XhVC4Oz7v2hCVi7yDPwF53N3cWPSJNJDOS6mhKgb9DqkE+1hn3QEQCLa3uoKd
         TtujCSJ8QTsQxDmpPsa343+SlapCk48/Cvs50UTAgCtCA/M81PdUkWGW9h3EhsC8Ij27
         BPyYuwcat+5AJ7cDuWzi7WpnImDX22tJl8Z8aAnKfa76nEyR8FSXmNycTxIB8Me0UE0S
         Ck0A==
X-Gm-Message-State: AGi0PuZVp5zSbCG9gvZlQExcIiuH9f6HmUDrI0MFsvC5IHSi7W7IBErl
        AuUisvuVS0BvHFjDkZPq13w=
X-Google-Smtp-Source: APiQypK642idgdGmw8QuDMMdid04wPSy9FsGffFOvsU2o0XwcfqVKE56jYsP/DglCL+LJ7YRbhEZMA==
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr249837plp.158.1587970781619;
        Sun, 26 Apr 2020 23:59:41 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id h9sm11317108pfo.129.2020.04.26.23.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2020 23:59:41 -0700 (PDT)
Date:   Sun, 26 Apr 2020 23:59:34 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_esai: Disable exception interrupt before
 scheduling tasklet
Message-ID: <20200427065934.GA2236@Asurada>
References: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:23:21PM +0800, Shengjiu Wang wrote:
> Disable exception interrupt before scheduling tasklet, otherwise if
> the tasklet isn't handled immediately, there will be endless xrun
> interrupt.
> 
> Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
