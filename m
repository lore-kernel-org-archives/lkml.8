Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21037C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200F20737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVrou6RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCLJ4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:56:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34172 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:56:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so6579649wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=OgZKLTHeDttLbT/Br16mrT6HF82SkRK4UDqvqoYSVK8=;
        b=VVrou6RJ02jppAuZj5G6brHbhPI2wyw5PI/NdaHb7rQREgtAxNRKRJFmxciD/ERHD9
         IF1zI5RJJG8RiCvyocn7d3op31iH9772k2BWpbwl65lOGP1lBdrZXkLd9Ni+uDstRdRk
         H17KBdKlOAvoedogTlH/A+K5KFYecDDOGcoVD6ipM/q3bkL5zGUyTXI0F6tfzr/AfCkC
         OKI6x/VYhd5A5OV6ZPpsORHuMTOeWjmCNNqQTINJkXPT5WC56bwJRmpBadaOpK2VkJ42
         cOYA1GXaZB9I2x/6inAAjIgYuDzNOQ3WD6Gz3m2cq0cHf+G2VWE1kkiEop1SXiAQ+UpV
         v2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=OgZKLTHeDttLbT/Br16mrT6HF82SkRK4UDqvqoYSVK8=;
        b=H415HKACRTn9X1H0DBLTrWpsyeUKeFs6BctaqukMBiiWjeUyY6M/eEElRhxH78vWEq
         ApfmUiARzUG68fm1Ektln7A0IHDyRMR2oqg8EJeQ1MYNOYdwpPMhYcJF/bal856h6O6e
         3CBRrVs3811mt7lovmhZMGVUTRBq0BRRSGZB1qNVHtlPIe9yuUCMkct54uDyVJnCBztR
         OEET2BKEU7UjrYRuPHPWQdocIiIgjks3cqGoun9wG1flMtSKq0FmVYaCyBekI5f6ZYsJ
         XYs3qLUoVk/LGSSyA+9hdY/44gop/+rtFGbqngTe9pl3aZ84PutYVkAUY0nh3RIs9O8V
         fcTA==
X-Gm-Message-State: ANhLgQ1aph8yxxAyR/lG6XL5yHGatRcVSPOithikPsmBgpYEYCzVLOZ8
        C2ADw0D07h28AeLsIVubBQ==
X-Google-Smtp-Source: ADFU+vtL5hIx2UE0FAWeqDWK7I9/59hEeOi0QLZYvUWEBU6Sj7CD5Xvdt6TJUqRekwYXOtEskpy4sQ==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr10157720wrq.412.1584006970772;
        Thu, 12 Mar 2020 02:56:10 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-15-144.as13285.net. [2.102.15.144])
        by smtp.gmail.com with ESMTPSA id a26sm11998273wmm.18.2020.03.12.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 02:56:10 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Thu, 12 Mar 2020 09:56:01 +0000 (GMT)
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] backing-dev: refactor wb_congested_put()
In-Reply-To: <20200311200023.974009d9a5648b977d5168f6@linux-foundation.org>
Message-ID: <alpine.LFD.2.21.2003120953520.15830@ninjahub.org>
References: <20200312002156.49023-1-jbi.octave@gmail.com> <20200312002156.49023-2-jbi.octave@gmail.com> <20200311175919.30523d55b2e5307ba22bbdc0@linux-foundation.org> <20200312022948.GH22433@bombadil.infradead.org>
 <20200311200023.974009d9a5648b977d5168f6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Mar 2020, Andrew Morton wrote:

> On Wed, 11 Mar 2020 19:29:48 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Wed, Mar 11, 2020 at 05:59:19PM -0700, Andrew Morton wrote:
> > > hm, it's hard to get excited over this.  Open-coding the
> > > refcount_dec_and_lock_irqsave() internals at a callsite in order to
> > > make sparse happy.
> > > 
> > > Is there some other way, using __acquires (for example)?
> > 
> > sparse is really bad at conditional lock acquisition. 
> 
> I can well imagine.
> 
> > we have similar
> > problems over the vfs.  but we shouldn't be obfuscating our code to make
> > the tool happy.
> 
> Perhaps sparse needs a way of being directed to suppress checking
> across a particular function.
> 
> 
Thanks for the feedback, maybe this is a limitation for Sparse.

I have experienced quite often this problem.
