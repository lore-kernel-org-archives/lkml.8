Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A68FC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62020769
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586642581;
	bh=As/dms8j/2c8KlGIIZqSUABAPgw/XOwk38B8NAKXk8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uoqMz34KHq06J4R3d5lm4XwIsNCSMUJNYj4M5lHLugNBsYmVa+PSFYsntuJWsTuyM
	 jtCM4IxZbxZUH2Ah3d6s57OBdeGiR1dStU+Yh7SGyJAPRCiglM4axXzBcfVQ9z7BWS
	 G7djZogldYr49yzlr7HkJ7V0QzQra/XRg/gP9nxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDKWC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:02:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47036 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:02:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so5236686ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxTwvLNyEWOqcyAMAl1px4l2VagsXdtElsWFFoHMqrA=;
        b=MUvvXNsBgMfrf2utiUefNgGNFiz8tc8Ft0POaCCNM8mjBA8s9X3yh2N4pcl2VO4plF
         zgsBnYEca8khVlPVEAnJq3PsGRt3JkvKkINq01m+F2sKy2CBtt0z9Qcz00Z8C59gDQbY
         gKZLgQz//ILFSG7Ir8gaz/C4iH7pzhhrvxXDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxTwvLNyEWOqcyAMAl1px4l2VagsXdtElsWFFoHMqrA=;
        b=HIX968TmpZURgSaA+5M4Z75ArBIbb5RpkdG1hxCULjMlGA4fmQlj7XBKxBsDE+L87i
         +tVUiTGYwwD39u6ZHho1Lzcy/CENwYxii/iRwMLQJ9t9N/BMMLzayqN9H6CwtLYkirFF
         fkGd6+CcHFh+C0vNzcjR2XxvNB7YVL6WQAPfzDMI2kAD4BDL30/6GzkbV4P3jO1xLY+S
         Wffmm23BVHeuAnQAhq0m1ECUf3+kHZhq8eo3DxmrdOeKWn1gMGkIYYTiWJlnSC5QLELJ
         9EvIpo7VZ3Zb2RQIcvcXpipipd4iUUNOeQEdvany0I2N26KTMYmMjKykVFmKGrVC6b5Y
         2uFQ==
X-Gm-Message-State: AGi0PuavQJzKGfQjvIFJc3JEcUW7J3bIGwW65lk0WCCx3YA1NWA0jiH4
        vwdeSmER+LQ5IFhw1bdrbgtu1Lbbo+g=
X-Google-Smtp-Source: APiQypIDEyCurGyD7wuW6rlpckRUcH+41Na58NozoFZHmb3yEgkByXCsL3YX0EZmBfjclYwndgVpQQ==
X-Received: by 2002:a2e:89c1:: with SMTP id c1mr6596869ljk.251.1586642577425;
        Sat, 11 Apr 2020 15:02:57 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x24sm4692521lfc.6.2020.04.11.15.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 15:02:57 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m8so5294206lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:02:56 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr6273872ljc.209.1586642575880;
 Sat, 11 Apr 2020 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com> <20200411214818.GH21484@bombadil.infradead.org>
In-Reply-To: <20200411214818.GH21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 15:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
Message-ID: <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 2:48 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I wasn't entirely forthcoming ... I actually want to introduce a new
>
> #define page_offset(page, x) ((unsigned long)(x) & (page_size(page) - 1))

No, no, no.

THAT would be confusing. Re-using a name (even if you renamed it) for
something new and completely different is just bad taste. It would
also be a horrible problem - again - for any stable backport etc.

Just call that "offset_in_page()" and be done with it.

                Linus
