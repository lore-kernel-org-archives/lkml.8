Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B533C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB01620709
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597797866;
	bh=9AZNmJ/YfGcrRAjyOFJ2NvgMUIdInjkVbrwCpErqI1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LEauu5l55NYPxYpy+NBAHrW8lSV/MM+GXpHO/5DoD0SMDMT35T5kwEt2fcUHsayQK
	 psxCS8r6uzCebTTyNEsDrihNqmH7u/yayvOfKAwmVdVGeSnnUwXb78OnAYoF+3VrtT
	 LWb1OcgxMtQDyJg/ZOoXpmeAcn1PuRzH47OqwGIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHSAoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHSAoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:44:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6A6C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 17:44:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x24so11153047lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2DynlYRISsaYGNYsitlwb4+khyZlyAf5FIqSKM75Sw=;
        b=ZWjTUpPqeNDFZ5App1PKI3BTysWeld/2SgkPFZEQq11iPN7vO/wNK5oKv6EG7MF+QJ
         7xi0n1OxTlKsaQFzGElnBMPOv4og7mbxTlw5Au6CKtjV9v4dQJ1BJYjehwKKf75/ulbt
         DPWNZloSONUhqNB49PEiskUtNkKaIzAiBDQr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2DynlYRISsaYGNYsitlwb4+khyZlyAf5FIqSKM75Sw=;
        b=NWqKkpf+0I2WvNdvjprhos5Zu4r2gbOIahIIUKpvdZ62/Ox10XWc0iuHlJqRO74+0w
         fVfebyuCnHrGBoX7z9vefadrIe8k/hzAtqVu48E7OdEhRcjw65FKAlh9MW98/6Oh2NrL
         zZwfO5hlXMV2gI8HAI54eBjRDH2kyrbMb/jPhX+djAyCaKqhm8HR03rQuKGDuQZx2UoC
         vP5SrH7oFwCoyZlWAg/9JRxmNU3bxgF4t+SFORMZBPZAE5XrhnQQ9gTWEe/cVmJ8Hm7h
         JiXa5/CL/YiDD0m618SdWfCxdAEBQv7OMCoVRvjx6qgFHonEmz+K9E4gOHCK78fdxArK
         uB0g==
X-Gm-Message-State: AOAM530adj3hR0c+oX4Bcu+tQua9trxFQO1bM5Kkt95jC4iKU8MMNt/A
        tsU+fz9MEP4jmnjAeIRT7cv8UjzwlG2tgA==
X-Google-Smtp-Source: ABdhPJzKqS29ScFzqBxjgVt3SJZ35SO9y9KETdnBLu4MKMNu2hV8pYaLULRWwDi+1J2FRlEaWO4jjg==
X-Received: by 2002:a19:c1d7:: with SMTP id r206mr11003926lff.2.1597797861009;
        Tue, 18 Aug 2020 17:44:21 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x17sm6388105ljm.0.2020.08.18.17.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 17:44:19 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d2so11183074lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 17:44:19 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr11162480lfo.142.1597797859441;
 Tue, 18 Aug 2020 17:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200818234307.3382306-1-nivedita@alum.mit.edu>
In-Reply-To: <20200818234307.3382306-1-nivedita@alum.mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 17:44:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik-oXnUpfZ6Hw37uLykc-_P0Apyn2XuX-odh-3Nzop8w@mail.gmail.com>
Message-ID: <CAHk-=wik-oXnUpfZ6Hw37uLykc-_P0Apyn2XuX-odh-3Nzop8w@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: Disable tree-loop-distribute-patterns
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 4:43 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This by itself is insufficient for gcc if the optimization was
> explicitly enabled by CFLAGS, so also add a flag to explicitly disable
> it.

Using -fno-tree-loop-distribute-patterns seems to really be a bit too
incestuous with internal compiler knowledge.

That generic memcpy implementation is horrible anyway. It should never be used.

So I'd rather see this either removed entirely, ot possibly rewritten
to be a somewhat proper memcpy implementation, and in the process made
to not be recognizable by the compiler (possibly by adding a dummy
barrier() or something like that).

Looking at the implementation of "strscpy()" in the same file, and
then comparing that to the ludicrously simplisting "memcpy()", I
really get the feeling that that memcpy() is not worth having.

              Linus
