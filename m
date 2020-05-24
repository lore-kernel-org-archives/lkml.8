Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 05:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7264D2078B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 05:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du/akGfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgEXFdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 01:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgEXFdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 01:33:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0CC061A0E;
        Sat, 23 May 2020 22:33:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h16so12468137eds.5;
        Sat, 23 May 2020 22:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=mUlXuaPdGF8MyrNkvvQ+W8qtB5P6ns9XkeFGoT1hV9g=;
        b=du/akGfRVb0CNDOxQ2VjUqmu19WuellI8oCk2MEGLZ+NLsAAh/jVLvXIzqu9Qg+wSv
         as4DoCMSHRpbFXQDIEn8o0tfVu4FLHTn6NYXaZZ14sbQwFroe/9chPqi8KR5tS2zRFny
         dpNg2YpFuUhntjlF8bqBt+4IJXgds0dxj/LQq+8OSzRDlFESv2+iJyXgEuEdGdlqxFWF
         BYq+eNFttygKKgAmiSnEhojzAHCGTsNangGDBuXJmjOFLv5+Us3ApZ1gDkQXt8aAof2b
         0hWcTubRBuyF+javMxVQIRwj1mFRpC484aB9wcfqLbTR9mfzvSHqbTo6YTK2XUtGoxJa
         S05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=mUlXuaPdGF8MyrNkvvQ+W8qtB5P6ns9XkeFGoT1hV9g=;
        b=AJ+4kvtUmCbQ7yoUxNh9iC1lT98n8bprupPnwLd1A0zN02syKarxkC35nL2TRYV1oi
         qu91VvdThgKEqkr6o/3adQKb+MTztwYBijcDBN+Gp6UiFU5LIzexM6boxaYk0F4WU3FU
         8JYrg8eNKO0R7y1S1gZ1iX1wOMupdVkgpW+p+Qxic0ZondyTu+3Q3fzXx5CwcAR9jW2D
         BEHCtWXbHQZvSIENKJJ7mliXPMTy2GUZt8Fvmqpn6y5oIXLwowL9OMGwNyfpCd/YBr54
         tu/ane3eO6OVvb979nqcStx8vh4hbmdf0oLhDXD0+9Czi8kvPD0cOTnsBJQbp24Smdzh
         +t2A==
X-Gm-Message-State: AOAM531EH+MsXM0tVj2T3TOgdpaOKmfCNCFNLKIWugdS6mJWbBvgQNog
        mGEQXdLXI/IYZ7ExsrTVCm4Z5j2XCJ0=
X-Google-Smtp-Source: ABdhPJzGvODHU1b2elyOcjbhnVj3d36TWrWRd5uO/sMjFW1GM/baq4IibwWvKOcTNfWv0SdqfR16Kg==
X-Received: by 2002:a05:6402:946:: with SMTP id h6mr9956287edz.245.1590298418966;
        Sat, 23 May 2020 22:33:38 -0700 (PDT)
Received: from felia ([2001:16b8:2d08:1b00:68f5:8079:cd02:67ba])
        by smtp.gmail.com with ESMTPSA id w14sm12607719ejk.13.2020.05.23.22.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 22:33:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sun, 24 May 2020 07:33:29 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Jonathan Corbet <corbet@lwn.net>
cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: reference to Linux Foundation NDA program obsolete?
Message-ID: <alpine.DEB.2.21.2005240722560.5201@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

while reading the process documentation, I noticed this reference to the 
Linux Foundation NDA program in Documentation/process/3.Early-stage.rst:

-->

That said, there are also cases where a company legitimately cannot
disclose its plans early in the development process.  Companies with
experienced kernel developers may choose to proceed in an open-loop manner
on the assumption that they will be able to avoid serious integration
problems later.  For companies without that sort of in-house expertise, 
the best option is often to hire an outside developer to review the plans 
undera non-disclosure agreement.  The Linux Foundation operates an NDA 
program designed to help with this sort of situation; more information can 
be found at:

    http://www.linuxfoundation.org/en/NDA_program

This kind of review is often enough to avoid serious problems later on
without requiring public disclosure of the project.

<--

The link is dead; internet search only showed some references from 
meeting minutes in 2008, but nothing more since then.

Has this LF NDA program simply been phased out?

If so, I will provide a clean-up patch to remove this historic reference.

Lukas
