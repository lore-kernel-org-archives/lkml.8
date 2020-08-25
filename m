Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB12C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D878E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTtlXxM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:28:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19701C061574;
        Tue, 25 Aug 2020 13:28:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i14so5080518lfl.12;
        Tue, 25 Aug 2020 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScwefOF0IlMENPyIZhCD/hmv3+qRcSPN2swhgn0oOR0=;
        b=iTtlXxM4k6LBcoR/F2FfFJ6fkaIScVRj02cFdKoJENO/JAdd9ubNUbN4pzzbsn2wlD
         kIP9gqDEciZw51RWNO9Ad8O0mxr3ZX4qVWiwo2USKJpGjvnqqQabISJ1xmp2ePd8GXLD
         rO700yEmTngQUywPqGEcfrgKWOjkYPuhn8ICNOMe73gomUgiEuarBmmKVBaaF1VYMrpS
         lxO1Xl6opKhKgGJRO2VRtQyBYK6TtTPl8mc+R3bYA+YsKaSpXI3BDaTn/Jc4B50O8yn2
         0ZVAitu4i5fqBhA62yUcAZATy0Y7y+VahmKs38PqGlb6GoUV4pVMjMBdmQ3YXEe0UyIa
         kOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScwefOF0IlMENPyIZhCD/hmv3+qRcSPN2swhgn0oOR0=;
        b=M78oOnku4MeWpFbE0GcrpG1wc41Nxb1nfbAqp2PNbExoJQnz8e5z1kNmNMdz8ZLnIO
         vVOTB82fwa6N5oojNUlWnB0MqWowmR+ZfC35bTPe3lQfZQhEUTz1msCh/9UF3xXkXxPo
         6JRvcC9+70ehE/KghUR6Q2bx9vjQLLVtnqm13rafg8/HKkAoZw+WQ5mYu9cW8YGrfGr+
         EaifXqY3huRSeEu0sUIehN9NEHG9nae0ncV9YTPLL4rdrduneF9DWGTu5AqtOML2hYjZ
         DgnR7Wl1f1nSyEKzSpxWT+LJ4HVx02brG7E6OU7WqHSPseqJZBfMHIU21qaZxq7AbUUx
         cI7w==
X-Gm-Message-State: AOAM530zk0qO4aygRuFroxzEWGyaoYMLgqsqagULR6GTkjDCIfDQtsIG
        XHjxUVx5HWx68wKwgjH822VJBVdwwAZ0/4zTD14=
X-Google-Smtp-Source: ABdhPJzDq9EN1YJyQ6bL5cSyprPRzjQ3T05GfVShr4z/GIN1qVC5M8gJSRlxmobsuAAQFJaYAWbqi3TmEmQCOYMOG18=
X-Received: by 2002:a19:4ace:: with SMTP id x197mr5620754lfa.70.1598387319510;
 Tue, 25 Aug 2020 13:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200825050856.29616-1-chris.packham@alliedtelesis.co.nz>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 25 Aug 2020 17:28:27 -0300
Message-ID: <CAOMZO5CK5wbEkTDETfiaWuNHW_33RCFW_qsZnVOMcoDRi49F6A@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-espi: Remove use of %p
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 2:10 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> The register offset is already included in the device name so even prior
> %p values being hashed printing the base was redundant. Remove the %p
> from the dev_info() output.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
