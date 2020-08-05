Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A242177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIlbbKG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHEDnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEDnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:43:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C673C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:43:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l60so3742486pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQ39NfCRpC8old6W/LK5W1TFVyUKRmxvr/lOL0aiW4s=;
        b=qIlbbKG9h9yj25xaWWwslH5pEhAoXFvHvxxdw1Lh1QPQZU8yZgiaKSSZO+XsBwLO3J
         G9rr6Qo+kjErZl0BXLMensSNIEAHM110mIuipHLfCax3qtPL4K3UOxdHndx4RxuWqTYC
         u5Lm+wo8vzZeubksd+gF5yl0FATX/WAkjgvQBr8N5sgvFRwkFtjOivoNTaGHqKs/kVS+
         5ksKFDdTm3OyzEH/RgiiTds8n0fs+AUtam5cKALYneqHx0XA+juoBXXQAc5k2hDdO37d
         av8tQClndNBX0wGCNWWreOaQJ/aExs5UDhWiK9b1oQO5knq08q+RZZw57834nQAxNvB8
         R3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQ39NfCRpC8old6W/LK5W1TFVyUKRmxvr/lOL0aiW4s=;
        b=o0yAD7Cu+6O+USHUHZIZp0LhVFNcoONwW+4wjz+1dfuh8SyM57TIkuSpQsfi5DTmWY
         YSO3s+PxMmT5+4wLRAS+fG0IvWO78d5HRknWlxsqRUWv7J2ORMpAMg76uMoNeQT8kiet
         kUvxj/fB8s63mqUZEBiSFTokL0xazanYTIvPAjmbf3E90x4WG6GRyjeGOCvDPfpC9GG8
         UO9k8BUj7bGLTPKj0s7nAJZb1FHbdYqjX2IOoG2tzK3rYk4hGxZUTdkgpxoOJEaxksRX
         tpCNkgGLsmOOhGQMVXlH83QAbVhjRjWMtOdP9cSTkhFCYgXJ9TRJsmzr/UoDBXQW4BXP
         n1SQ==
X-Gm-Message-State: AOAM530CAXpBRp6JfgegRLLYg2VGwQGKt+iXAdYyrlwYieplaB1JwCQB
        Bmz5xccwiEf/yztFTGLbGPI=
X-Google-Smtp-Source: ABdhPJxqLYWvll9i8XBUjWuZrkB2d4SKoLlGUSOgZFb5VKeAkUJl9BcJtGw96aePleICT4meo2KXVQ==
X-Received: by 2002:a17:902:9f85:: with SMTP id g5mr1222539plq.13.1596598994895;
        Tue, 04 Aug 2020 20:43:14 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b13sm879344pjl.7.2020.08.04.20.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 20:43:14 -0700 (PDT)
Date:   Tue, 4 Aug 2020 20:43:00 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: fsl_sai: Clean code for synchronous mode
Message-ID: <20200805034300.GA10174@Asurada-Nvidia>
References: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
 <1596594233-13489-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596594233-13489-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:23:52AM +0800, Shengjiu Wang wrote:
> Tx synchronous with Rx: The RMR is the word mask register, it is used
> to mask any word in the frame, it is not relating to clock generation,
> So it is no need to be changed when Tx is going to be enabled.
> 
> Rx synchronous with Tx: The TMR is the word mask register, it is used
> to mask any word in the frame, it is not relating to clock generation,
> So it is no need to be changed when Rx is going to be enabled.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Can you rename the PATCH subject to something more specific?
For example, "Drop TMR/RMR settings for synchronous mode".

Please add this once it's addressed:
Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
