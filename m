Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D40C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E449121D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwg59ndA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgIIEnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIIEnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:43:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8738DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:43:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x69so870461lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+Frc88nWVxqOgZCPp9FgZZwYWNAXmlsLlRS79TyYt+k=;
        b=Dwg59ndAo9mc/agQv3gjaaTTTXm3bY9/MK2VVav9f0jLsrFgS/IgWdT3iXx9vNbh/Y
         +pD/8Ke6jvFKF5u96ZWQ2R+DPbXrG6/LCJ8pe/jvzVdDJhu8JFJvR/ka67UZ29NH76WS
         bWKLCGHBIw4/FM6iWwPx18/5ggjzH0i97eBmnIynlOwW6PejaXL+kcg9D6Nwx+BOcgFM
         pK4kFThqV7gh7UDqd+swg/j5b15CVGpXICFdV9RsyHPS8Q65JiUsRs/LdkU17Qy+z2MU
         lNwSP/MvzQ1AgovvvneyL66HhyeHVXIApzwakXQH4c2Gfk0P1M8UUmZ9UtP0YvOCdJGO
         uU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+Frc88nWVxqOgZCPp9FgZZwYWNAXmlsLlRS79TyYt+k=;
        b=rXaeMcXycDANyzoEVmQI6wVICwwMG5ZhWQ1oK/UNqVu2YvhTJHRabrpmZcYfGxFMu8
         Dh9SOcfi5JbuNJnquWVX21fRlBkFoN5kiDa85I4us3gtUKho+8TzTZ6uNnnKu+qHQGbb
         T3sjvfUgMcJtuy8pJ/sXI7TTUdtXy7HQHP+E3ocX4VjbZXs4EllrlGwA5fzA+SgFpVgR
         dMSk/y6CwB8HhhGEG954vzdf/HOEniFfvs4xNYUkyvMBP2nkvAWC1slPEKB7h2vvhaT5
         9Jpb7xuuN3DqWCldWiiv+1mYbm1alq2wnRHIJyyY8mKznBetDaOYopZjzHYXoD4up/TA
         38AQ==
X-Gm-Message-State: AOAM532B1MrUNnw9C4xx8QAGfXgcvvKGEBVFBINNW0oqUZbT1365BEJb
        TNUOIEIUq5mFlN0Yt6MBjNLy7S4cVbtT4mKAo665JE5afgw=
X-Google-Smtp-Source: ABdhPJy/WnFcessueE4ZbBB4HUH7HGp4dNhQNDK9ta48C2nZASwNJyyVij9IU8oMNnpEvGF0SEfdKgS8aCDcOcNLt0A=
X-Received: by 2002:ac2:5a5d:: with SMTP id r29mr1024362lfn.131.1599626626396;
 Tue, 08 Sep 2020 21:43:46 -0700 (PDT)
MIME-Version: 1.0
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 9 Sep 2020 13:43:35 +0900
Message-ID: <CACOAw_wHONVJL438_Akvo3wZewJeVKiT_8LqW0EXULxAscpGjA@mail.gmail.com>
Subject: Question about STEP_DECOMPRESS_NOWQ
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I have a question about the below flag for decompression.

STEP_DECOMPRESS_NOWQ,           /* handle normal cluster data inplace */

According to the comment, you added this for using inplace
decompression but inplace decompression mode is not being activated
now, since we are setting STEP_DECOMPRESS right after bio_add_page().

                if (bio_add_page(bio, page, blocksize, 0) < blocksize)
                        goto submit_and_realloc;

                /* tag STEP_DECOMPRESS to handle IO in wq */
                ctx = bio->bi_private;
                if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
                        ctx->enabled_steps |= 1 << STEP_DECOMPRESS;

Did you mean to deactivate inplace decompression mode on purpose,
since it had an issue? I am a little bit confused about this.
