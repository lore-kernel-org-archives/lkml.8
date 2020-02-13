Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C7C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2523218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lREixcYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgBMNhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:37:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgBMNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:37:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so6788535wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=sxsqagGeLumUFdcq50AfVMoV5tnNdOJIUWrTE3Ysc1A=;
        b=lREixcYxXZMd+HB4zB2kgeqIErnl7jdpIIkpsP5+/IOc4ptokJJUQl/hcsgLXyPMDo
         TeXUfvTxntS2PHa0smS3c6xXkpt20cclIbqaCcenZWG2Q11SNIO4WnQHdY/f84U0p+05
         qb/JgE3bECvD7RWiTcxt7s3ZFmctiS4R4ZIAiDAUZRABkajvcukxMsBHpYgOKhw5Upx9
         4ZfAgPiGZ+w8utqHIqh62/tCiGB0qBVGXRLi7dk6olziJvetq4jALpcZDBug9m7QvdTr
         4qsD+sxNrkslbVOIde4Csc7qnI8jUDm02AdAZSTw0nF/m7/5mA9Y72Q9R8LeNQ1k9anM
         W1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=sxsqagGeLumUFdcq50AfVMoV5tnNdOJIUWrTE3Ysc1A=;
        b=DKFF99/Iwq6IP7yb6PsYNg/5Ie0rPwjz82X0tp0x53unu9ia2DwhOAbqwWO/gU6viA
         0zExi+r2/pIvgiWHwPUaL3ZGPPptqL2UxJsDkkdYdoPVE97unfjRoB2Nl3c1D54D3h3E
         5AwnfdAzX4LXWmTQ3dGccgjDMmtPcPrKUPC6qAWnq1TrqS4kQv8/3BgwtyODiv5ZU8l2
         k98hDRycWi95fpAmjOOj5UIALKan6C7pcUWw3W7zQgbocMExsNHF26L9m1ZBIg4H/3os
         wufcFTuvXHrR8liLxOjpbCwiinOJK//7QQSN59qHIEWHWjyWmrDpt3OqFBIqUopTi3oo
         n7Dg==
X-Gm-Message-State: APjAAAX52CGRTRRDabsJdA6M/5xpcrsg3dJAEXuLI6YTlN9PnBg2601A
        Y+Cui19pqS9A6Swh3xYy6F8SKw==
X-Google-Smtp-Source: APXvYqztiV9EvOZIAj+NxxlShIkxKNbZk+0M4SW5L7q87rWhDfrwA1ZAf1ZxaTm0hoeyiyP9i1JGSg==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr6164468wml.50.1581601039822;
        Thu, 13 Feb 2020 05:37:19 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g15sm2713097wro.65.2020.02.13.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:37:19 -0800 (PST)
References: <20200213061147.29386-1-samuel@sholland.org> <20200213061147.29386-2-samuel@sholland.org> <1jr1yyannl.fsf@starbuckisacylon.baylibre.com> <20200213113701.GA4333@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: codec2codec: avoid invalid/double-free of pcm runtime
In-reply-to: <20200213113701.GA4333@sirena.org.uk>
Date:   Thu, 13 Feb 2020 14:37:18 +0100
Message-ID: <1jo8u2a9rl.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 13 Feb 2020 at 12:37, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Feb 13, 2020 at 09:37:18AM +0100, Jerome Brunet wrote:
>
>> This brings another question/problem:
>> A link which has failed in PMU, could try in PMD to hw_free/shutdown a
>> dai which has not gone through startup/hw_params, right ?
>
> I think so, yes.

Maybe this can be solved using the dai active counts which the
codec-to-codec event is not updating. I'll try to come up with
something.


