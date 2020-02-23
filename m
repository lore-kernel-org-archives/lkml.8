Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A1C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B76206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ZnXU0AiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBWRR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:17:59 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40751 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:17:59 -0500
Received: by mail-il1-f193.google.com with SMTP id i7so5777658ilr.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7SmTtNPBn2T+cb23Q+tOWXTb1iD23pHN7RwXvfrkL9o=;
        b=ZnXU0AiYUqDbHSfyrXM/7uT2bHICmi3a4U4nFQldVTYotEN+5e57QiIPpx2j2zSfOD
         3zHezfkmTwch9bXv9L7qNVZUISXIL0ZasnOGiPhmqKXqeiIVBh77ikdN889zLXA/s20t
         kIe3/boDVkpoKbgdUfDmkRZ+yGN7pFsLsC7uPiX5c6B+IT72iz4zcMTO2mqIXA6QSpG0
         3IzPiqyfGN/L0Zek8hJCWHEYpx2GRaDD6PYYsl7XSj9fzpSniygzvpB35hW3mOvkoSUQ
         R3ro9r1cbIxool1PKW0MSGoomdwH8lDS3G2/ySGB76ZVesjXakuXvUgH4TbBHPkGAURr
         ZpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7SmTtNPBn2T+cb23Q+tOWXTb1iD23pHN7RwXvfrkL9o=;
        b=p03hs7J9kcMgl+zJWUUbbbyUqSUqLSlmuEJiULjJnEp2+4WS64DBxKo6ER6Yq1VTD2
         4BTAibgrjIm31xYXy99X/Nq+77GWIDppy2X2YG5cd1U8sHATA7omdfV9TupFvpznppFf
         YmafjHDQSDIFnB5NTj62cZf5jYttaVkbWhtHAw/eFUD37Cvdq1SYXtjRfIGYh/OV+Y3Q
         mm4kLVY1b+4jzVfI5HPjpilV5uPGP7SAfXTKVh6sxLDT4Tfovodn47jH4vdPkfPhLoPu
         /ejNvkxnSNNqtsp3dxoAGy3HyxcHl6D5AGFQgGxtKCu9gFKmkNguOxmKz/LNO2SrsK+G
         gHXw==
X-Gm-Message-State: APjAAAVnCtJS7orbRSiiFpinQCYbp0OOBVEhLHCL9lCMSzNsCOOrZdWk
        Lyxj9fODx/+pySrHAvO7jm79GvPeAtE=
X-Google-Smtp-Source: APXvYqw63W2EK7XZYK5s2ZWoKQ8ad6sFR+En3xfuokU2Dmq5tIeMmY7/FNGj8fKk5l4fl6ybs2iYuw==
X-Received: by 2002:a92:9a47:: with SMTP id t68mr50874060ili.155.1582478278014;
        Sun, 23 Feb 2020 09:17:58 -0800 (PST)
Received: from cisco ([2601:282:902:b340:8001:28d8:b4a3:8673])
        by smtp.gmail.com with ESMTPSA id q1sm2430745iog.8.2020.02.23.09.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 09:17:57 -0800 (PST)
Date:   Sun, 23 Feb 2020 10:17:57 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] riscv: fix seccomp reject syscall code path
Message-ID: <20200223171757.GB22040@cisco>
References: <20200208151817.12383-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208151817.12383-1-tycho@tycho.ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 08:18:17AM -0700, Tycho Andersen wrote:
> ...

Ping, any risc-v people have thoughts on this?

Tycho
