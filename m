Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD95C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456C22464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsNJWYKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSJqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:46:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33890 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBSJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:46:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so9349161plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDAG6JFVrPYskd8aHZ521nfnKHBDBTlAbBs86HhuEFE=;
        b=KsNJWYKGACwLVdmFRK6FuekU0fw/ONdIY3EQhDhueKkURN2D9wswtwzMPjwvewDFrP
         2U2cDASEErOnGZEqFeI02oP9NN330fDGBZDy3f07AeJ5632ruMO3yBCp+sDiXUPUwfk/
         qdQcMcSywuQS9Q7/oWKgbi3/TTermOqPxhCKv8xPZp758x/D9BD3jmnTIA7n1vFFeMIb
         n/P32WCP8bp3B0LTBj5rJrF6u1p7t53bFuBo8s2zM9vx5hL+83cv6TVM1zkur8tAIrY1
         Lg+zz3IWGal64zoo/MRjpswolmwwQUFrZsKNugpyPSMGIBiPvqRtUk3gH0laYcR9z6Gl
         BQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDAG6JFVrPYskd8aHZ521nfnKHBDBTlAbBs86HhuEFE=;
        b=QXCBP0SUihN8JneXHE8L6S3KFNU/KO4cG8RDhGFCRquufBolyRxL1DH/hfQhBDh6BX
         3ZTSs9DKfJTjPiaUGLM5c4wue2hsUOc4NQCVF+jyI3VjXY+/YTxPkcrh6KJO6yEp7ZK8
         ElGoSVUqy9z2rWVBQnddWudFNMHQKdO2wWAgAcqeBq8wdMa5EAkA7INIEPypLONIuO19
         kn2xO5q7PSy/XDv3jr8HCz2IQ91f4xMuy/A3cJbj0awzrQ/TfgvM2/PkfN3OS84i83/T
         tEBq7HY6f4l/eNPr3h562bmS7yTuLJ8LeigxSF7HM3MiB29BoWnBlfq2X/3/0czUqqi/
         ovwA==
X-Gm-Message-State: APjAAAXfaN+3TVmZX9OrujsqLeE9eUHnWgyGnlzWQTMgE/zg14w4jaWD
        LfxDU09kUf1z87jJa6LoUYIGGg==
X-Google-Smtp-Source: APXvYqwFmN27fscSw0fvFXNy0A2cynMcRf7CbFFs9OltJHXQAydBfyTTQnxbuq0NQUpEXOyPLOhUwQ==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr24824685plj.184.1582105565778;
        Wed, 19 Feb 2020 01:46:05 -0800 (PST)
Received: from localhost ([223.226.55.170])
        by smtp.gmail.com with ESMTPSA id g10sm2182824pfo.166.2020.02.19.01.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 01:46:05 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:16:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 10/14] cpufreq: dt: Allow platform specific
 intermediate callbacks
Message-ID: <20200219094603.2yfat5xxyabunlja@vireshk-i7>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-11-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-20, 15:59, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Platforms may need to implement platform specific get_intermediate and
> target_intermediate hooks.
> 
> Update cpufreq-dt driver's platform data to contain those for such
> platforms.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 4 ++++
>  drivers/cpufreq/cpufreq-dt.h | 4 ++++
>  2 files changed, 8 insertions(+)

Looks fine to me, please lemme know the patches you want me to apply
to the cpufreq tree.

-- 
viresh
