Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC144C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B650A21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRgGZaaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgBFNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:51:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45845 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBFNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:51:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so4465374qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Yp62VZP/TU4EmOXICph4TFUdvh/hYbSj8U+q1EI+IM=;
        b=lRgGZaaRwSTSRspiGoLl4svQOd+yGPep4dvyDaduy1JLRDaMFAHwnh5pSSHmzPVd+i
         CCKY2m8qkIrqsognf/5omzUmWm6Ag6GMdxirURhGnAtbdc/nH8xb5iiKRP8iDlqMsjcJ
         c+neRcE5iDIzJKIFmI4088kKq0V1FQffPRc6xLpKwK+hT4G+9S5TWDm5W2RB/eg5X99+
         abdZEIhptucrgMD9RMbn1lfJ9Ok2DZb+o4l7x74fHkwLm0iSDKL6mdyMZip0bY+Jd8bJ
         DG4kvy6qSKr/iJe7iycW/x7vBGRY2Nt0SjkNg7J7+T3ksxx1KXr+8b9k5ZkAakVIeD3Q
         /Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Yp62VZP/TU4EmOXICph4TFUdvh/hYbSj8U+q1EI+IM=;
        b=f6qCu7hQlZGCN8at0dbQYeVmao9N4OmMysn2SaYskb4iy3nSPvK4gYW4OfdEn2+bKV
         dCAVyRjh2jj6Tven+IgxK8Mxaa+UiD65z9z1hRxpJYmlRlG15jhGGtIlzVMJ9b5rb5Hz
         w8WRdOZW2b4zS7LpbcS61NJRNcW3oj+WX7ZXpPggnpx77cLk/bKQ95X9Tk33FDznaGMK
         tioO5b12Ln/zfG09aCB88Iwv47JcdjWzKx7T7s6nKOT9uKdCUVfZcTaxEHDvVLZxa8Pe
         WceYd2X2VrXwwtqS2wwioBZydt0a5mdH956BN9X7oa4iS/pY9opHr2PlFmZ94uJSwbeS
         2GFA==
X-Gm-Message-State: APjAAAX41oGoxRvulfWF68iCGQZHkr4p4kdqdTRGjgzCjW52UW+jbhrx
        R35TBa1VWKEPRTImTmpOjbDaZqzv0d6wrGlyvaNQqA==
X-Google-Smtp-Source: APXvYqxsLqw/+YtMF5EF3fE9C3DWLc8jrUtlh0iFPiIk3b39txMeWxl415cH6yU6K97xCiQ+k0uvcM16GDcrQDYxwIo=
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr2604233qtb.142.1580997066532;
 Thu, 06 Feb 2020 05:51:06 -0800 (PST)
MIME-Version: 1.0
References: <1580963761-24964-1-git-send-email-gupt21@gmail.com> <20200206113248.GL3897@sirena.org.uk>
In-Reply-To: <20200206113248.GL3897@sirena.org.uk>
From:   rishi gupta <gupt21@gmail.com>
Date:   Thu, 6 Feb 2020 19:20:55 +0530
Message-ID: <CALUj-gsY5dYYMejnYNH1YbuBysEOp=PpqxV-jCZ+hbAgoi2qiQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: da9063: remove redundant return statement
To:     Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        Adam.Thomson.Opensource@diasemi.com,
        Axel Lin <axel.lin@ingics.com>, lgirdwood@gmail.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done, thanks for guidance.

On Thu, Feb 6, 2020 at 5:02 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Feb 06, 2020 at 10:06:01AM +0530, Rishi Gupta wrote:
> > The devm_request_threaded_irq() already returns 0 on success
> > and negative error code on failure. So return from this itself
> > can be used while preserving error log in case of failure.
> >
> > This commit also fixes checkpatch.pl errors & warnings:
> > - WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> > - WARNING: line over 80 characters
> > - ERROR: space prohibited before that ',' (ctx:WxW)
> > - ERROR: code indent should use tabs where possible
> > - WARNING: Block comments use * on subsequent lines
>
> This should be split into separate patches, each doing one thing
> as covered in submitting-patchs.rst.
