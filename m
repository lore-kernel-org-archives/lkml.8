Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85400C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6202C206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="je56arN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGZBnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgGZBnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:43:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD413C0619D4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 18:43:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so11535611wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHHf80BOPxjmpEN+X9FwZJzbNUdhyeoda8NmLwlJNos=;
        b=je56arN1ji3wNgrNO1MmidDJlSx6Lux7XfWuf3PUV4hadb10JQaRQCNdYHMUAlnB6M
         FqtHQHNxXvT3khVaTcfoI/U7Al0VhkXaS7uOllkTjoM2VmF5mfMlYG8YdzaErZh13h9/
         NCD+s+Gapfk8Iu28vvBTz/aILb3QiFfITyHQI2XDjgH4oPbO77wKTiEbSouBDW3kpSMk
         ngfxqMVikCehPgvIIyu2gWKahON74jJKr7Aiy1aedAFVuA0GggUBvu8RTQ7e6wHMrJNM
         rfJykDCdTwGMibOqNPFPwff/Bl0kxVbOtVhy4PUpZvMgcZL5c2HYiOx1XPEX1ZPkNH7J
         8VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHHf80BOPxjmpEN+X9FwZJzbNUdhyeoda8NmLwlJNos=;
        b=Nhibsa9E4I3DBsGMykRVYaSc4Px8R3PuxzX5tL11xYs1LJUaXrEQy4jkLrho7LoTS8
         0dEEDXzLajFv+5pUPURdlz4jqUOfvCynMZqN5MlzGGA9lIJ82d1ymnfMi9rveJaTRaDP
         pnZPyeum+uc1/3i70eXaKtC4PfoZhv+yXkD/H9K31w+Iq+fq6vApkOAALWLKtRpxFZLY
         iqhlSqv2pfOE87dryFBl8zr+c7swfzN7KWJFvmh4oK4tR0W2xBVf6R+C5mKFbdbzcD3M
         60w2HRN4mvTT/+vQZ1nQxFzSlm8lUS2TKcsVBUsREc+W6L+yNNKjsynZW8kKcUwyo1wn
         NQqQ==
X-Gm-Message-State: AOAM533ak4ofHSVSfMBeOvHpgClAoDjUostJ+X8nAb3A9xYWAALU7/ES
        zXs6JuhNIEvacF9UBBvMfyUx/Lw3An+mKjl/IBR3gQ==
X-Google-Smtp-Source: ABdhPJwNsBzS/VgkW6SIYFjvE8fsMVDeDJHOtstEfwbAGKPThU8CMfBYpi8RLzMhS3sedH0NFp/PKwC5ITo5dP8/nZI=
X-Received: by 2002:a05:6000:141:: with SMTP id r1mr10838721wrx.69.1595727784402;
 Sat, 25 Jul 2020 18:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200725004043.32326-1-kalou@tfz.net> <20200725221022.GQ2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200725221022.GQ2786714@ZenIV.linux.org.uk>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sat, 25 Jul 2020 18:42:53 -0700
Message-ID: <CAGbU3_my8uz0XU5kJ7k20Ex-+nGwSw+0+oXJ3zyGHDw+8ft4wQ@mail.gmail.com>
Subject: Re: [PATCH] proc,fcntl: introduce F_SET_DESCRIPTION
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 3:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> Have you even tried to test it?  When will it ever free those things?

Thanks for pointing that out, I'll try to address that in the thread

I did basic tests against 5.4: set a description, concurrently set it
from multiple child processes, read, demo with ss/netstat.

However I rebased against master and have not tested the build after
rebase, is that broken?
Should I use a different target for tests?

Thanks for your help
