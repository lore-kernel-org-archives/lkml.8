Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67397C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D532067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP/lIbWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBRUJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:09:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37877 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBRT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:57:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id w23so4340759otj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1jO1q8kwMNU1sHidaXu/iTrKUxw8olHFqB5ddcj+Hqw=;
        b=ZP/lIbWIDHAZrYeCHKe+6oiU3ofC3zhTeALfX1J0x/xrTLivu9MPaImW7bNovjJX3/
         /Tj6h5WwJY7zqiKulKdNaATXoZPSIhneFljhHTJCHGzy5JXSnsf/ZPoj3X1j0blwxfB2
         fVMNJgv4nAxWPR/8wkTivlqXPViIc+4F3xRq0f5ZSIAilPOMk4uLHOKgoMYt8pX9M0TP
         48Tx6Y+NyXrqOCwwRTfNbF+OVoxTC7jUNi8hJPsVWGJLxPq1XZyPZlh8ASeLBk2P8+PA
         NbAUljEjPlWNu0KIrJ6zRaPCOwl0PlMu/JY0nSDCZMeoGuN5KbXoByugUFhGqrK5yN7M
         cBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1jO1q8kwMNU1sHidaXu/iTrKUxw8olHFqB5ddcj+Hqw=;
        b=H6SkTE/fu+GwFc5lLQlAdCY7PzGTPaP9uDm698RakqC43C5i4GBTJMhCDjN6uv26RI
         +8U1l4FjIxqyI5WbMDOkMMx+jYF7UTYqUJomB3AZWUjpUCr4/p+A2AJH+flDP6I5e5Gf
         myvYU8Tk9Rvjwnl997aRI0YI1m9uu+tQ/5267TnVtiic61/yxEUguhcbWskOMspff8Ey
         k63WXB+IRsO5zagWKSFzh6vbNX+Da5uakxtqvvZFiVLICQudmEgwwS739Iy0c/lj9NUt
         aVyXx3Oo9Voa38CsQPQcPVsPx3AvnWHdRtfKWITGe17HkipotSBKFwA33+0GyN5Kidem
         HOWQ==
X-Gm-Message-State: APjAAAVFUo67JWe2ROuSXyquQzUzp1aTaxg0bRLAt3w+rl+f9xqEp0P+
        59lJ2GZjNPqw0k9yHeoHMP8=
X-Google-Smtp-Source: APXvYqxHVDxt3kjyDTyqT5LZv51VcsPvFV/OaAZMR0D36jEIKH62WVF82+ArplH7Do6LRRQV6RppCQ==
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr17020995otf.11.1582055827276;
        Tue, 18 Feb 2020 11:57:07 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z17sm1506069oib.3.2020.02.18.11.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 11:57:06 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:57:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] objtool: Fix clang switch table edge case
Message-ID: <20200218195705.GA10545@ubuntu-m2-xlarge-x86>
References: <cover.1581997059.git.jpoimboe@redhat.com>
 <263f6aae46d33da0b86d7030ced878cb5cab1788.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <263f6aae46d33da0b86d7030ced878cb5cab1788.1581997059.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:41:53PM -0600, Josh Poimboeuf wrote:
> Clang has the ability to create a switch table which is not a jump
> table, but is rather a table of string pointers.  This confuses objtool,
> because it sees the relocations for the string pointers and assumes
> they're part of a jump table:
> 
>   drivers/ata/sata_dwc_460ex.o: warning: objtool: sata_dwc_bmdma_start_by_tag()+0x3a2: can't find switch jump table
>   net/ceph/messenger.o: warning: objtool: ceph_con_workfn()+0x47c: can't find switch jump table
> 
> Make objtool's find_jump_table() smart enough to distinguish between a
> switch jump table (which has relocations to text addresses in the same
> function as the original instruction) and other anonymous rodata (which
> may have relocations to elsewhere).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/485
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Tested with clang-11 and binutils 2.34, a combo that was previously
broken and I no longer see these warnings on either defconfig or
allyesconfig.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
