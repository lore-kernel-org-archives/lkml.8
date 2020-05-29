Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C942EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928CF20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCDGe1op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgE2VtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2VtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:49:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03718C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:49:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l15so1029533lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LTPGEqXDxaSydGxgEzzcEMymAfzXnH9AqasPPYyZyo=;
        b=jCDGe1opK0flcYhCWpkfwS9zHlLiiHfLgNRJxPA0u46iHf9sYbiAkC3UVYO3vTLDKI
         E03pEfekVUSDo3yg7E+6cXfXjtSlMpOwXzcniQupH4uOuoHuxtOX0hBLPBRPxDIWf3zQ
         hPY5d9aGaiRnUHkJ6KGMiQNQ6dRQxTF6swtj3V0wWw9AH74yhME/rQVEueM42ckqRWqh
         LXb2164Qj+d+peYqxIjbjzVbait+49WSug7uwmq3vASkDv2AyVKEUnSOwq6U2JkRV3mU
         ENN9JrkHPYhn0FG4+vpXrT44ZyjkRofPsVv9ALJEqXV1r8b2zA2nsFX/ayPl81FZpRYb
         gqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LTPGEqXDxaSydGxgEzzcEMymAfzXnH9AqasPPYyZyo=;
        b=Ipw/MHThUYyOHJZdIqBHMp1d6n+oL3/egQ+huvz6iEo/RzLhikhdzrtCqGN2lClFpc
         fDkjWe7Lfqn8uCFLvIaUmvs4DwtXOwillGLOz5027rJNvRicRip2joSknxM/5IYbzv84
         VZEPyf4mzySe/J6oWfaAPOeo148hnCaxk76GfKHtd4oGaUKL1snbEiZw/l29B8JSY4cv
         U0FEZgBySJDECiP+DtyRb3OhdP/h4kmnOaZ/kOfRrm7zJN4rxeMciA8ez/1uT9N23iz9
         AkWQM9gKBcagwSvWmPSLI0frOV3F1I/QmtvE6C0xesir7RdhKSfLjE3U9+accq6G79mI
         UqQw==
X-Gm-Message-State: AOAM532h2nL/9hECFZj/cm5FQmYMCabU6kqaQd9rFAiV2teFsOGZnw1z
        RTDOg4giTSLeAcIaHsvcp5+jD2ySt8JJ/P3LBtBgV8mg
X-Google-Smtp-Source: ABdhPJz6ZhrGhCqsbQi/+YWWS2Rk0jqE1kVrknSuRJbOEDstLnsIPtOPCgL9/nEXKs+TiwA+t2JGUACUqg2rh0LVBZQ=
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr4978125ljn.202.1590788944483;
 Fri, 29 May 2020 14:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200518193617.74548-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200518193617.74548-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 29 May 2020 23:48:53 +0200
Message-ID: <CANiq72nJgGJJoUoJMxD5LTa-A7Rn1UPnr16nf8DbY9HOy7ZKEA@mail.gmail.com>
Subject: Re: [PATCH v1] auxdisplay: charlcd: Reuse hex_to_bin() instead of
 custom code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, May 18, 2020 at 9:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> hex_to_bin() may be used to convert hexdecimal digit to its binary
> representation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Looks fine to me and the logic is simpler for the `esc` increase too.
Thanks for the cleanup! Were you able to test it, by any chance? I
will queue it up for -rc1.

 (Sidenote: it would be nice if `git patch` allowed for a full-to-full
comparison for patches like this since the unified format is harder to
read; I couldn't find the option from a quick look...).

Cheers,
Miguel
