Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA2C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326D72072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fMjNShPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgANMt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:49:29 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:42329 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgANMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:49:28 -0500
Received: by mail-qt1-f170.google.com with SMTP id j5so12274868qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZaV4m9Wcsat3J/nLpMI47qepAUKn/rpOgZEXzjgN9as=;
        b=fMjNShPSngStx8oxOMaBNnubnGn4/wL7TxocQ7D+swB+yGG94DrHkwunzEeO1+a04U
         9oPA1wzfpCCekcvi79x8tolKz4/99WwDs10KimzHsnuSRZCehJbS/TjVIpiYaA22/sI+
         yWyCd9tLK9ib8DrgFFbhuee6nfuBeIZNRfcaydckJGIgYSAjcj/F7IvJc0CHfhFU2uIL
         L8pxTYHxIoaka7mi1ohfQH7mNEbwrWneS7GlbO+Ae3MHyHTEM0IsNLlr2gtD8f/SDe/w
         HZPhmFremm0QFaTmCdsEBRybj2yUuQXJdTNGLZhEjiNZLwEmxtV6gENsnK6u49OoMROG
         F9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZaV4m9Wcsat3J/nLpMI47qepAUKn/rpOgZEXzjgN9as=;
        b=h10+kRA4HrjTiC2SeVWAkxCLw237vU+fxfyM39cy89Wz+/+0N+XRbIDNFmDBw62JDQ
         aiPnV4L6tONnTUYebHlBCVngYtatoBAj0J9QWqs/t7+0Jkyqh4yhWgvS/8sMTTBivL5D
         uKmo3vRqFIIl3x8lWb7A+wgMcIVQQCI5aWpTA60No51Vl3dj3phNCWDWCeSQoln7JVVB
         xHgAA63EqPMvuAi6z/maucl5M7TiljcbeUxfWsV6wdS2nOXAttNFZT4/sgUcu/Sn7+6J
         VCW8MWY2Ewjw/mwCLm1sWnVS/iMRmUAW7hgqmI74quF642RktdRii1RxJf9mcyyswSIc
         BLjA==
X-Gm-Message-State: APjAAAXlJfwE5uR1oMgEIev0XV6iwx2b34PaA7Q4GYehaPejhAkqWf0O
        Jcba9f/qnRNnjNVO7g5cDscSnPTZ8lqoqq9Y4C7M9Q==
X-Google-Smtp-Source: APXvYqzOPmOW7qGGhKbm11KAVGts8ygNrKgXlvvd5T10h4JhosA+oMMdtItFss4YhevQwFIPoVAMO9oaJguXa0ioggM=
X-Received: by 2002:ac8:2a06:: with SMTP id k6mr3417568qtk.145.1579006167842;
 Tue, 14 Jan 2020 04:49:27 -0800 (PST)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 14 Jan 2020 20:49:16 +0800
Message-ID: <CAFRkauBRi2g_4b3wUnmwLkeogTyWjX4=6VfyDLJr-REf=LeC-w@mail.gmail.com>
Subject: regulator: mpq7920: Some inconsistencies in current driver
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

There are a few inconsistencies in current driver:
I don't have the datasheet, so I'm not 100% sure.
Maybe you can help check it.

1. It's unlikely MPQ7920_LDO1_REG_B and MPQ7920_REG_CTL0 have the same address.
   I think this needs double check.

2. The MPQ7920_DISCHARGE_ON seems wrong because it does not match
MPQ7920_MASK_DISCHARGE.
   I guess MPQ7920_DISCHARGE_ON should be BIT(5).

3. The MPQ7920_MASK_BUCK_ILIM seems wrong. I guess it should be 0xC0.

4. Not sure why define both MPQ7920_REG_REGULATOR_EN1 and
MPQ7920_REG_REGULATOR_EN.

Regards,
Axel
