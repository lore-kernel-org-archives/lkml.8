Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C01BC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3175D214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyWX4Emr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgBFRPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:15:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44003 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:15:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so4639140lfq.10;
        Thu, 06 Feb 2020 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDKiaCf3ZWSIx1zkWLA7ZSXVihlqFh0aVDFgMk5ixMo=;
        b=ZyWX4Emr9pFEoNGFD10TYSRW9qYN1c0ShrFQ9dDXuoXtdOE373z6p4ixyACSxD17O1
         8cGGIY1nQWNoeSg1jdsHgYymI2+Pxf4Glnb/uELxUoCq7ttHEuGwip+n82hWBI3aOwCv
         FYWbVuWr7GNGi+E6FAlb2PTVpG16vozdDmCkLcsnmZ7Q7TQqr5NOUEpmG8un463GyUOx
         avXpZBsfb72tETgKHz2yOVvvk0T3256DIiMdslHAlYYjovJ4byxd2zbkY9nbOZQkJDnY
         XcEUxuOrkKrlUzagQ6X15E19vgfjZBdRONNZ29uaLDgEsv773bjcpf+N1rIJKZTnBUSE
         wgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDKiaCf3ZWSIx1zkWLA7ZSXVihlqFh0aVDFgMk5ixMo=;
        b=aYc8b8avD4+bCrtHJwcFVaDkOHvKXQ/sujLlQDPVVixFf0LeQyiCmy0bAsJYyTgKd8
         HXJweyX1KD29iVIBR2k5kGiS3M0GtpjhhmHN2/UTvkkeAQCz64KPiWZHI/bYFXfc8sLE
         E+5enmMNIE9a/RMLdAFC3WzIXJPpwbPahnswcn5D0g6ScTQQpRbXr+8Di70VjXuYsDp0
         DR13OlCSGyLerqoNwEgwpQ8u1vWoBlHaVZ7mUEu63x+T1SvhiyTuYEk+rOabYSrvKlhS
         bIf1CYkmFExQBM1MrxPl4pgdaw8dzuoV2a/jHRUbD8PcIZSESxEjxJcYzXiSjdkt4NKC
         DVIg==
X-Gm-Message-State: APjAAAUsp+kdXu5LgE7ozhBE+QTxYhwenF2AEwtP1I1JNqxX43fTN3vd
        2VF9pq6TGduwsYO02/O9yYQ=
X-Google-Smtp-Source: APXvYqzfPy8cc2Cd7kvDWo09wusjOhcwxocF4Z8NcvdXhaSCd8XBCArT0CfOOeEwmm5lKmtRonx8Dw==
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr2362606lfl.125.1581009344755;
        Thu, 06 Feb 2020 09:15:44 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y11sm26174lfc.27.2020.02.06.09.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 09:15:44 -0800 (PST)
Subject: Re: [PATCH v2 6/9] ASoC: tegra: add Tegra186 based DSPK driver
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-7-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f8ed8c4a-af40-44b2-b720-4d3a9b660fda@gmail.com>
Date:   Thu, 6 Feb 2020 20:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-7-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
> +static const struct dev_pm_ops tegra186_dspk_pm_ops = {
> +	SET_RUNTIME_PM_OPS(tegra186_dspk_runtime_suspend,
> +			   tegra186_dspk_runtime_resume, NULL)
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				     pm_runtime_force_resume)
> +};

Could you please explain why drivers need the "late" system sleep?
