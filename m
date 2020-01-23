Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860AAC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5161D21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579808687;
	bh=UXHCieH+qdIt10LtobtHCDbxgtOhZG+kimejOWM/wmI=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=Yk5JFF7DCswFzUa/K4dYyEWfxs2Vc/AvLD5QrlLM+HqnyXSEbna8b6mIyj7PaUYV9
	 KNy6D1r+au+xx0AXXC6WeZaD/3Ej6Ud67/FndR9ioYz2uJLyxS+BFOyteFkw/J7lE3
	 U0h5edV5YMfdFPUS02G5uP7z0OO0edLFpDo0Wa0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgAWToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:44:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40097 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAWTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:44:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so1778241plr.7;
        Thu, 23 Jan 2020 11:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=WyxbAGrKMxKf8dZitmu6cKPMSnHKtEQpit0i2sDj4/s=;
        b=mEpjL6/xj3I7Uik5MmvCvZecsUt9KlqBN1vepUl8BtNTw1bfk6P31fhOb3mOwQzhM2
         PTGEJywOih12AHfBuOrpqDMUDYFMl19gHliSe0eGn529awUsuZ6c0UvFZqCsDhvq06uU
         RO226ZSYYM0mBLwEuPR/EiPRqWZbEn0lhZjyzb+8FMp59kwDbicbtGJu4MD1IVE4PIkR
         tovLYB9Va+ZD5mK2nhiUYdHQbFUrgVAFOpnNILwCvHGcE5z7rDr1/EUE19bpYgIVsExq
         Wq+ocHjjKd5qyAvd6JBypUlDu6ux02gFS888b5iFK4i+TGxEDm40lfR+CRiIoxNsymKn
         xOSQ==
X-Gm-Message-State: APjAAAUqfNbIAW8dcFXgCzQ63JtTvQkNWqm7w2bZYXzl8SwmmQpCYl3u
        u4c7lOW4cKRGqBWD9ffizuU=
X-Google-Smtp-Source: APXvYqxjRorsbk5SBO/J4vgOmFCsvGdtVWavmWrgQsY76cgp07w9JXpcaiDwJGkvh2FFrFB6qvv7rg==
X-Received: by 2002:a17:90a:ac18:: with SMTP id o24mr6401850pjq.33.1579808684886;
        Thu, 23 Jan 2020 11:44:44 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id s21sm3571104pfe.20.2020.01.23.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:44:44 -0800 (PST)
Message-ID: <5e29f7ac.1c69fb81.34b3.880c@mx.google.com>
Date:   Thu, 23 Jan 2020 11:44:43 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Colin King <colin.king@canonical.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org
CC:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: octeon-irq: fix spelling mistake "to" -> "too"
References:  <20200123005422.2834063-1-colin.king@canonical.com>
In-Reply-To:  <20200123005422.2834063-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.

Applied to mips-next.

> commit 636e9d23dd45
> https://git.kernel.org/mips/c/636e9d23dd45
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
