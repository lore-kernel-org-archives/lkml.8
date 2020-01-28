Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA570C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2C424686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwcDQr5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgA1WkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:40:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37380 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1WkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:40:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so16514894edb.4;
        Tue, 28 Jan 2020 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2tfcV4CP2sbf7T/W7OGLDgrmyx/flLregwSFl0rBGJY=;
        b=JwcDQr5HMLCngjCO/tSNT8Lj+zu3HvGpcfIH137EjhBwP51w0GaUzsAPchhJILO5Au
         /gdzBxmfsLmWwGFz1zIG1LGjJERooWfIeI1WqrgTUEu/740ajDElLhCnLGm7u3lIqJDg
         ZVAwkG474KZUGn1QvJRW2kM40mwaMW3Bq32UsN/hcQHI3p6lW0RurDDo7GN0SETJWfE/
         cWs6cBAmFGUbZy0X7dAIcpQlnfHutghmz+Y3LG+DV8cANCU8s4umLl/KBobaDlXOvL+c
         Ms4JlU7LYen8lc6dpihzPLDBP66noDG8nwZy6kT65f3fafxlqaPkVj7QD7eC9raJ7+Jm
         TbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2tfcV4CP2sbf7T/W7OGLDgrmyx/flLregwSFl0rBGJY=;
        b=AOdtLB3zCvzEr4Uf/WLqssaFhInZFad6O4wCTopjdFKPjUVxr9qeHqwWK8oGAeRMVX
         pOqevVjO529qkRKx10tOTF8DZvoGS7MiDxxKBW/5povc9p3ah9pKHeBl7y18AC0VYnLR
         lyrlOjfRIdQwz2Tn2JrCDerXnD1iyhM5zpX7C+FgpQ11YwEUwtwmVFvSdnghtkadOjpu
         dgAUQ1CZCNAejNBLqEVuPL7JVoY2+KbpR2pzXBfQVy1h9RKtiWGhUiQ8yRiPDgQlPhjF
         CQkb+dVD8C1DQz4Yp9IkV7S20NTToP71Lm82Q9M3bUEDmMiYJuIrcYpTiJ0r5nfXEvjD
         8vTg==
X-Gm-Message-State: APjAAAWYRBYsaubW81Ik/1cDGgkF7lHI5rS+Ax0iZwDLMJbFvUwo8jNU
        hMdNqxhnDr2uzGvHjvbWVZY=
X-Google-Smtp-Source: APXvYqwkTm6HP0VazhnHwh0Fs/tM30jSvUf0/TxYtGpxSY/EOEq2DlLHwxNWmLPEJeRuUY82vXlHdQ==
X-Received: by 2002:a05:6402:153:: with SMTP id s19mr5393125edu.149.1580251222576;
        Tue, 28 Jan 2020 14:40:22 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i19sm550907edy.46.2020.01.28.14.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 14:40:21 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 2/9] ASoC: tegra: add support for CIF
 programming
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-3-git-send-email-spujar@nvidia.com>
 <d01ed171-d949-19b2-3390-ee30eada2779@gmail.com>
 <a8409b81-7c6b-37a9-81fd-772eb2eca185@nvidia.com>
 <229def08-6bd4-30d7-056b-92329e48c699@gmail.com>
 <34917b2d-064f-44a9-4548-ae857e8ea29b@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a3173927-30f7-3957-4dda-bbb662f1ce31@gmail.com>
Date:   Wed, 29 Jan 2020 01:40:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <34917b2d-064f-44a9-4548-ae857e8ea29b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.01.2020 08:11, Sameer Pujar пишет:
> Thanks Dmitry. However I plan to send Tegra30 related patch separately.

Feel free to add me to the email's CC if you'll need to test or review
anything related to the T20/30.

> In this series I will focus on Tegra210 and later.

Please be more careful next time and try not to break the existing
functionality, looking forward to v2 :)
