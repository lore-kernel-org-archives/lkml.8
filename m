Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7548DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464B820835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAk1xYzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgE0Tu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0Tu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:50:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EA5C03E96E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:50:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so13245931wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5UMxzsS/A7fHxpEGv2BAIFrOJ94NXArnFHPmKBj8V0=;
        b=jAk1xYzHrYllHAyb2tJGBpdvqmrlJiIn2R6dQksKVcitqXIN9pEiYjgq46DPtqbIT7
         BrcUXbq2B3aGbr10M+zTw3l8kWi+fpvavDqeE2Jrv4oEmYgnIdw+HIV2mX5lQdBEyVEQ
         BPr0lvAHG5CJfsujOa9Qy54qyczNpRY4DMk38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5UMxzsS/A7fHxpEGv2BAIFrOJ94NXArnFHPmKBj8V0=;
        b=FcdP18bV9jqGJe0HkOHfvNdFKv//CWw9Y1YvVqIwxBhlvva/RVZ6jqV0Egw7KHLW+X
         ZcNRTIBbaXNZYicXb/iH3BdjPvhmcXBRDViF+feZnzF/s6bcsDUFFDiBOrY2lIwv1VZE
         S7MoX/z9BJne5+QqdctLyRHlYZkXZcUT+0t5HhRtvFfgb0EGM/hPt/AXK75a83uxgZ6a
         dIuK2x3IVGnHFcR+B3PS0pzidrDKV9vwl8rHquo5Sv6F6z6SRHg47+pZfGjprASPetbP
         HDVMmntJAJ2lX+JQBv0G/Y5Dg6ewgf0nUNujn/Q/rxLDPRchdSFlX0VoFoCLV/fPsPe3
         KSbA==
X-Gm-Message-State: AOAM532JIkah04ka4aJ65M4uq2kukcF+cR7kgufxlWHMkQYa1oGHeqXX
        n8AC2HnyVbwJuuWcvDV2f2SCRX03F4uD5Dd2r+GdQhhyMlU=
X-Google-Smtp-Source: ABdhPJxQZzHuBd2fNDn1DgqffWs10SXs7xya1obkJmi+uRdPu3hKtz/ByHRxFBjAW1K5Uv8l0DcBmu+cg4njl0FORJQ=
X-Received: by 2002:adf:9c84:: with SMTP id d4mr4295373wre.327.1590609057271;
 Wed, 27 May 2020 12:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200527141753.101163-1-kpsingh@chromium.org> <20200527190948.GE23230@ZenIV.linux.org.uk>
In-Reply-To: <20200527190948.GE23230@ZenIV.linux.org.uk>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 27 May 2020 21:50:46 +0200
Message-ID: <CACYkzJ5MkWjVPo1JK68+fVyX7p=8bsi9P-C6nR=LYGJw04f9sw@mail.gmail.com>
Subject: Re: [PATCH] fs: Add an explicit might_sleep() to iput
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 9:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, May 27, 2020 at 04:17:53PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > It is currently mentioned in the comments to the function that iput
> > might sleep when the inode is destroyed. Have it call might_sleep, as
> > dput already does.
> >
> > Adding an explicity might_sleep() would help in quickly realizing that
> > iput is called from a place where sleeping is not allowed when
> > CONFIG_DEBUG_ATOMIC_SLEEP is enabled as noticed in the dicussion:
>
> You do realize that there are some cases where iput() *is* guaranteed
> to be non-blocking, right?

Yes, but the same could be said about dput too right?

Are there any callers that rely on these cases? (e.g. when the caller is
sure that it's not dropping the last reference to the inode).

- KP
