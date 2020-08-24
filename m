Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C99C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DC122CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 06:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598249090;
	bh=oO62HoG/y89P1+Qb5zdibnc21loFmQKsIoGy7ryTKdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A76sG0+BTypbFviJ94+ZELCXvxoGLy580AoGlvA0kv/2//HRXNgr2/yfMC8stsDFK
	 Kt9wLikoGLewFoCyzaZX2Mn0LQ+aoyxv1Rsq068TB+CB1psucJrZmCN2or9M/dnIjJ
	 wI7UDlfOOoA7OiWpY5ZkxMc/AUIKVtj8JpUgUloc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHXGEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 02:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgHXGEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 02:04:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73101C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:04:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so6950373edk.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVaevIxlCqi7lUuDeiLKXM/g9ojJ6Qer3t5MevLqykM=;
        b=b1lwO0dgt+5++URmllA6gNAUTQHDoWhDFZOhjl8oQEenK4nzf+7MoXvMe0qF5vg55x
         FkC8+GVDy9rjwl3KI7lyn/r8f0SNc7zeKJZuFR9HeeI4nggQKm/dqGXDrzHUv0LW+z7R
         E4VgtSYg7+/RGpAX2xmSa0WMB8L2e+r3pd4G+l1WjIFPbYjFPLLs5Ft9bZCiWPGd8rFT
         xZg21WWHqHcnVRG+zG+NNm4M5VC8MmtmXloL2s2/k15fawiAUqEiuftCHYghu8QFAcPh
         +OsOmfMO6p5Pyt170j5GvNXKhSd/AfxMFHFbXgEghHYOEhDQHc1Bnqku1KnYMYAFle9b
         BMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NVaevIxlCqi7lUuDeiLKXM/g9ojJ6Qer3t5MevLqykM=;
        b=O9dK1T0czRP+T+Jg0izB3QwzofMZW5KSBuj1Xt7tYSxuTlOncWZz4e0IXWzxGJELh/
         uhlku0fqI0FASAktHGEFiGvNgIEoPuGpZwcWONM95WE7uQvU23420nUtb7ft17HmEmm3
         vSLfpwp3CJlBWqrp0hz0lAdh0Z/p7uEsnZrQ0XlawlM8sLIG1eXxiaqHMHId3Vs12daj
         IGYFyNQoW39Ez6D7/RBooGBAGU2IBi4oe8UZtQlAr9r25G7sBxBbZOrgjsAkZtBzHo3T
         90ALkeuy0XKceObK+dDfxx7OtRqHjCi9CyYNPlGpLD9FKq9Bq29G3+Jgv5Up184+vlQ0
         2gFA==
X-Gm-Message-State: AOAM531CVid5Oz7a9zdblZ1bWnfJJtnf6mvPBo1IWasZMS3IY8/mKnzl
        sfWEpp8DkVLVK7yVUkhVCV4=
X-Google-Smtp-Source: ABdhPJzQO8TY0CiI7D3cyiyv5xEQ8svEi5DHXrqN1QovTZO+QIzG5apw/WKIWlwBDYknJQ6wJW+z3w==
X-Received: by 2002:a05:6402:17d8:: with SMTP id s24mr3659412edy.61.1598249085187;
        Sun, 23 Aug 2020 23:04:45 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l25sm382444ejg.11.2020.08.23.23.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 23:04:44 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:04:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Run syncconfig with -s
Message-ID: <20200824060442.GA3364641@gmail.com>
References: <20200820063526.GA3278096@gmail.com>
 <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Thu, Aug 20, 2020 at 3:35 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > On every kernel build that runs --syncconfig, there's an output of the following line:
> >
> >   scripts/kconfig/conf  --syncconfig Kconfig
> >
> > This is the only non-platform build message the kbuild system emits that isn't
> > prefixed by at least a space, or is a build warning.
> >
> > Run it under -s - if there's any problem it will emit messages anyway.
> >
> > With this change the following simple grep filter will show all build warnings
> > and errors of a kernel build:
> >
> >    make | grep -v '^ '
> 
> 
> 
> I do want to see something when syncconfig is invoked.
> 
> I will apply this instead:
> https://patchwork.kernel.org/patch/11727445/

That's perfect, thank you very much!

	Ingo
