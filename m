Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A0C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A20A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxw6Ec/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgATIkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:40:55 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35111 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:40:55 -0500
Received: by mail-wr1-f42.google.com with SMTP id g17so28509979wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YcyMDNxU6CeZD0M4XJTzTVAVqgpQcDsBZ5eIyxVur50=;
        b=hxw6Ec/TOFHL1uviTFBXvHVns2s9jWeNiGPGY/t1nMnDss7ykWrKFU5OtlWIUYN/rn
         CSz/bR6YM4gxEe17MPUqY2sokNN+JOcvbUGn2uDJDb3DIau1C1LqvB4qjiulY/yHM1CS
         d/VfmvGC8KOnS0AHEyrqYUnG1QVsZgPJcxH8+tQSNrNuhR6Cjtso48v5pIUyorrMwyrg
         VXYIFb27EiVo5/RXvhpRR1RlvZZU5jsohwFCoBsLc1fKCk9sUkeNZgw1v+m7IjsYaOo8
         nQJWeVM7a+vNKAp0AigC4Y1uuJ067vY4nlXZ2IdjfSeym3L/srI6T/cKHXIb0xUZy8jY
         gJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YcyMDNxU6CeZD0M4XJTzTVAVqgpQcDsBZ5eIyxVur50=;
        b=SMb+NcVh55OS3zO/e9wWnqe18fjljeJUK5G8BbjVQh9tr8xk0j3KayIDUEcOgAeIxq
         ibidO0SjiufS6x68BGQXtTmmCQU+qgKIReoVRSwta0MggfU9qmiSBgdD8U3k95A3150I
         AlkEtPXyNd24I9mhOXtAnX64WO3XlZWB+U21n8OY7NR94h6vXsdA9bAPfeHnQJrW4QUI
         Xpb26PovELcwRjSuCaGd4Xdva8s5x/Ei25p0gDTrQnvmpBWgQ340iAcEB+HIQdSZ5k/I
         mian9wVOzt9zcSznkzs6ch48/lIbsPHyLziRNkgGAU2xIpmHAxW0SDci82Nx3WH/x2/U
         9flQ==
X-Gm-Message-State: APjAAAW53u6SEmzuucKsaOH/6gnWtdu6E89RRCH4zgESkK0H8F5LwduG
        OoDrJ9oaVx/S3C4fPa+EImnBpu0Qgdk=
X-Google-Smtp-Source: APXvYqyFzecxKx1E4K2sGz5OeZKOZDc0OJZI0IE0kmHpxY+jcimDKMgxHvzb7SXw0xV4Pn/XfxamKg==
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr17024029wrr.421.1579509653290;
        Mon, 20 Jan 2020 00:40:53 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id x6sm21451676wmi.44.2020.01.20.00.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:40:52 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:41:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND 0/4] Add Support for MediaTek PMIC MT6359 Regulator
Message-ID: <20200120084108.GV15507@dell>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Wen Su wrote:

> This patchset add support to MT6359 PMIC regulator. MT6359 is primary
> PMIC for MT6779 platform.

This is not a proper cover-letter.  Please use the correct formatting,
which can be provided to you for free using `git format-patch`.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
