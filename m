Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBCC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBB320678
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 20:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFquqcY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgASUrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 15:47:01 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:46257 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgASUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 15:47:00 -0500
Received: by mail-vk1-f176.google.com with SMTP id u6so8009827vkn.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HKvSiqAJ3SCEpmUIQ6/2HzMosaLFXFREjvtGa9eXZ4c=;
        b=DFquqcY8jqmuZQ/J+PrzS/X9kQ8Yiz7ms9OfPD8d8T9bCQK6DCTjBIJjfiF0sUfw47
         vP9EpyQ/cS6bEbOS26gCM+tJVsRYfsJyRFhXqsRlG2yV0x3eyrXMpbnbmZmzdDEGs6B5
         qxMb4TEkJIIPTitm6llMo/oa1HjVuBoYhHAfufS3d2HelJUc8teajSe0eGBQAWVa7nex
         2KzJNJ1q3XbxqZOKzw4p9BvqF8YcrChUQOsHZ/IcpmUFsj7mmbEAYmhoqI2DAkUtKT+V
         bpIrDHESnlUAFj3bYncsHLtiEaQV3faa0CfbCfBhkL38NzyDHFCl8aVaIVbhmFB0GgwJ
         V4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HKvSiqAJ3SCEpmUIQ6/2HzMosaLFXFREjvtGa9eXZ4c=;
        b=kmVcto1rMVxsFsbNbtGpBXxwahG886Uv/hN1XPS+YvHXD6i7VqjWy9ky7K1jCwG0M+
         ytoKT9Q47NMuUaSY4qaox3jRKCJbDa9DdSUGJ8+mDcWXLrM8s0jkQI8bz6iObxDRalfD
         JdIJMcCqWTLNWG24CeZNkj7ztgMbYrd9nMOimpurRgHxUwe6WY+JiLn1XjOqfvAi3eCY
         mhW9tpgLnPvhe3XovI2aYVopJrp97jIvnOMUvuy3bogsV323EcduOX8y3q3tYQKEnjYq
         rwmiHZ04yb0Ef0v9esDfjARQPoeLjZxbjHR4NO5fzB/lvBImJJ7yW2EzBqkZpG/sU8Nu
         CUUg==
X-Gm-Message-State: APjAAAUX0+1+xno2Zz/9XgYThnUKydYdH+SAXN8Vj0n+O+fqKQXch/m1
        h4Nh6gnVYOv1VGIK53H5aFpshgCoicKuuMNJClw=
X-Google-Smtp-Source: APXvYqxHDHDR0Rt0o0eZb9OmUptS0EeMJEGo1EGK1LT7KZo+Ztgo9YCTEjEi5GyeMI9Ny4QZ5xn430Cu1j7ROmkJvyo=
X-Received: by 2002:ac5:cd3a:: with SMTP id a26mr26984652vkm.42.1579466820078;
 Sun, 19 Jan 2020 12:47:00 -0800 (PST)
MIME-Version: 1.0
From:   Mihai Luizescu <m.luizescu@gmail.com>
Date:   Sun, 19 Jan 2020 21:46:49 +0100
Message-ID: <CAKRdUfOT9E55tuxiU6au7DGyHL_BkxknVs2BS_DuvYsSAOdnFA@mail.gmail.com>
Subject: Re: [PATCH 01/01] Add VID to support native DSD reproduction on FiiO devices.
To:     emilio.moretti@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Mihai Luizescu <m.luizescu@gmail.com>
---

I tested the patch today on Archlinux and I can confirm that it is working.

I am able to play DSD files up to DSD256, the maximum supported by the
sound card.

I only compiled the snd_usb_audio module with the patch and replaced
the stock one.

DSD playback was confirmed by the green LED on the soundcard and by

checking /proc/asound (altset 3 is used during DSD playback).
