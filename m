Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACBAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C13206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6JVHoQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404501AbgDOTVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506493AbgDOTVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:21:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB262C061A0C;
        Wed, 15 Apr 2020 12:21:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so5034270lji.1;
        Wed, 15 Apr 2020 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ceph2IeaEjNXlv8kF7Vc08ScVo4hOK+Niuv5P5aPoWQ=;
        b=k6JVHoQX7gCVPi30Hb3X3dztd4RHj2MHZ80uLjW0UjXHwFwJDR6nA4BkWMhyCwYhY3
         rPK1ckm1Lmi3UWFumP8T5PIEdgBjtHpS5sNVyXC8IPEyGUDfcZPIzgE6f2vzQFw6ESa+
         7nYmDloEa1YOGmP2AHBSipFCv5ozM1q+eStBAV9klnEVvQac1F2H4evs2RAQFk/uMDcz
         hIoemCK0TdCyZUQw2vlaYIv2btU/5oqMFiJQf7RWjb8S0M/6Nyispwjh8SmazvQuqycq
         rlR/5tb51y4NgeBLTuk9imqsAKkglUELU3hpGJyXj26GsJD473ufr/a3/Uffj8OajxYZ
         GEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceph2IeaEjNXlv8kF7Vc08ScVo4hOK+Niuv5P5aPoWQ=;
        b=PXzDT7IRUkb53Bo38fVCNKpu/jODfnRHlfVC0NXNkxOXuBlJ78EXKwnxw7RDnMq75C
         4GVSqAxKjH30f8bBLC07wm+Fsfc7cxRgBtF1m0BWZTJmo2mJfU8lotSFnvWLedfSl6El
         O0FJ2QWlM7WGrx3I8eJ6pGrvt3F805CAjLT8FX767zfWLy0QJgLJwp7KFS/w0rEFXtwZ
         bhmISVle1V35t4R9QTMu+pqtaLbvNqw/4Kb647wfazV5i6nT6rdw3mNoBIr4OhhzE00z
         ePT9G4m/2JVa7H+OKLeA0+Hj2jUC6p4NOmZN6IN8yp5Hq9lF20OCghy+bbtBD+Z9ByKa
         mB9g==
X-Gm-Message-State: AGi0PuYlpfxaEC4UZoN+vmCiIwp5bBCvCppxx8Srf5KcSxm62FZ7qRVA
        d4mP9Nnt7AGpIThNpR9N683LKVM3
X-Google-Smtp-Source: APiQypJKa94Wc+Qyg+6OmleCPlfwn8YZOss69+KxzmFGWV8nb0nU3agrGVoCgfA5KA61fUHD0u/l0g==
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr4178286ljm.49.1586978473089;
        Wed, 15 Apr 2020 12:21:13 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id l7sm14099870lfg.79.2020.04.15.12.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 12:21:12 -0700 (PDT)
Subject: Re: [RFC PATCH v7 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com,
        sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1586919463-30542-1-git-send-email-skomatineni@nvidia.com>
 <1586919463-30542-7-git-send-email-skomatineni@nvidia.com>
 <4118112f-f865-5460-6319-d71271fd78d1@gmail.com>
 <a69a8b34-beea-3ad0-e08e-f7df8b9e7047@nvidia.com>
 <6afa951e-d904-f3c0-053f-82a02fb18979@nvidia.com>
 <b1c78827-13ea-0c94-a575-97b5afc0ede1@nvidia.com>
 <5954a7e1-910e-7f48-56d3-e671b56ead74@nvidia.com>
 <d6a9e07c-474a-a076-8313-32f5f4ca8d64@nvidia.com>
 <786949a9-8507-7723-f29b-b91a216bfd28@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f831408b-bbf4-3047-20e3-5bebfa9fc1ad@gmail.com>
Date:   Wed, 15 Apr 2020 22:21:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <786949a9-8507-7723-f29b-b91a216bfd28@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.04.2020 21:53, Sowjanya Komatineni пишет:
...
>>>>>>> Have you tried to test this driver under KASAN? I suspect that
>>>>>>> you just
>>>>>>> masked the problem, instead of fixing it.
> Tested with kmemleak scan and did not see any memory leaks

You should get use-after-free and not memleak.
