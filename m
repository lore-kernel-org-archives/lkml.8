Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D244C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9C920759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q43nKW9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgETXeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgETXeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:34:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2465C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:34:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 142so5515455qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YN/C/nPSeqwpOmMsu0A2/GbXKwpRdgogY0506hnF2AU=;
        b=Q43nKW9cYrcnDbWaXj0WHNqTytEw5KpgnX8SMGHcivqlK52J0+zWIWuu3rrJl3OKFn
         NrrPyJHbz3I1/9whPwE9ICxAfS3y05q73lf40fgNiCMDpCh9CZDVHJGAMeO9je/ECs11
         5q/D/6Nkuvknz9pfIOu1aDkvmLcK4MM7gorLIP1JlxvJQ95a09Wmp3TSfVVDd5XDtKv4
         I+6Zatj51eVt190mridJ35FnoDykmDnsiZhTeqsM4U2RnpNJIQ+4MajBAe+m9EsdCMjO
         llS8jxXWJ/Qx9kNZ8e84cZw5f3VIfFFLiSRxb60t+2lGq6B9CtQwA9nxCQyk1/WdnNjX
         nNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YN/C/nPSeqwpOmMsu0A2/GbXKwpRdgogY0506hnF2AU=;
        b=hozLa0mmWle1CshE7pLCfYjnrggoQ2RXCbK9+ICzxR3PjgTlRiTgx1K0yU7CoVTxgj
         ajeujqGqOsk4XSxdyiysQLUN71PBNIzZGugZq5a5w0dopBHDM9ELQe9L2KAoXOqcIfF1
         M6AfEHh3DwbnD7PAw/ehNsDhEMceGvrlQ0MwblbcmWjXV6HcGoGQoR6pEO8m/RZ0MLGl
         Ii/9JhutUqefaOY+OPcy0HnxhfZubFvwWyXyntMZpG3cgWFqqIz6qKZxVU1vSR5yMR+o
         umgS54nb7UP62Nhv8X3PBHv77C7ynMdEY2Xb2bYKoANFPJgYpqugxmfiLqmzhAMttIaz
         mYIw==
X-Gm-Message-State: AOAM533h7g3Oefh6LSn8aibeIEzyX4PDRRy4ZjVrOBWIW5YoZNRkCpgH
        tDd2iincN688S4RfMPsjVW0=
X-Google-Smtp-Source: ABdhPJy3lsR8y97bWe3GbLi94RgqKcFsjZ572pj5nCblnmDnj3mgB2iYAo4+AM4CUEqu59pKBe4DGQ==
X-Received: by 2002:a37:9781:: with SMTP id z123mr6946590qkd.266.1590017639870;
        Wed, 20 May 2020 16:33:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t21sm3856926qtb.0.2020.05.20.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:33:59 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 19:33:57 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     clang-built-linux@googlegroups.com, x86@kernel.org,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] x86/boot: lld fix
Message-ID: <20200520233357.GA4160490@rani.riverdale.lan>
References: <20200520225654.4144534-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520225654.4144534-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:56:53PM -0400, Arvind Sankar wrote:
> arch/x86/boot/setup.elf currently has an orphan section .text.startup,
> and lld git as of ebf14d9b6d8b is breaking on 64-bit due to what seems
> to be a change in behavior on orphan section placement (details in patch
> commit message).
> 
> I'm not sure if this was an intentional change in lld, but it seems like
> a good idea to explicitly include .text.startup anyway.
> 
> Arvind Sankar (1):
>   x86/boot: Add .text.startup to setup.ld
> 
>  arch/x86/boot/setup.ld | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.26.2
> 

Actually I'm not sure this is a recent change. I updated to the git tip
because on my system (gentoo with gcc-10), lld-10.0.0 segfaults when
trying to link the compressed kernel, and updating to lld git fixed
that. So I previously probably didn't get to the stage where it links
setup.elf.
