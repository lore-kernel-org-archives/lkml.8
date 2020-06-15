Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E86C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FC720768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592248221;
	bh=4ZZaot3vOXFQ4oupOtC24lNN5o+DJ/l8xbn0qgqEkJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K/AdcYdoiGElu94Hj5T42ZjZde/CeU5J+UGnpGKNqbpzSSja0zWUOYKDU1v3A9iqt
	 MndZ19Z/hOUWpjVcSdq/olV/wc/+la3iBofgasc4ELdo8bBcwF1L+5cC5bUCGsr7hH
	 588Mu5OwC/vUeYhydIJimuhrgBQOZt43yUmwtpvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgFOTKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbgFOTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:10:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3473C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:10:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i3so16010302ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLrasL53j1rcRe899kvLmCMS2kS/RWB75sihborwOiM=;
        b=DU/av6GzFEWftb06S7JjYSuQL7mwTQX2oFzubBhqTr2gBiqg95+qQX9FqcOTm9AjwQ
         Yq0zZ9x9/hOq8rqWpgeww9tEr2/8p15ZJQPl+E1hFXLI91NsEMARowGIpz1YT/Hxq+Ec
         tVOtVB/wETKIX+FyhrN8QKEePGQgISImY71OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLrasL53j1rcRe899kvLmCMS2kS/RWB75sihborwOiM=;
        b=odEMpp8WnBSOL9lKU31bLFH22p356tEcwzezDZJPSwRnpHZFSBVmQNTNl6SQ3WqNDC
         Y21X3H8aDs3lwota8ElrH2oaxjO0OYRnMCKB8Oj3HY3MSn6ZdAoOre1CWHUzgLINBTxO
         tXrXmaBOdPeFdGgMynTyEvfUfm0GZJpCkW/ACySpJRwR24kxV8GVaVQQZlFXRn4N/WJ/
         mzQPsRzG8sr/bDn5DOxBw4f1qTyGPbtbJiGgep7Ru0tomH22hoYfq6GPJnIQu9tjvWQC
         r5baa9ZIRAxzyd46HinxRUDUJA+dxvzvr5EjVB2UIqPszbYuv8Uk2WtAE3i8ViZjkDYA
         b3WQ==
X-Gm-Message-State: AOAM532Vu/9ltrhQVFBlydvy6f1UFbtQZA6w/kWhHmfhbCcGh8U+lgjJ
        ggsThoAiZjDTyGl2fxDRSOehFIU3Lks=
X-Google-Smtp-Source: ABdhPJzkYSIuAkPff+g2+RfU+hzz/xjjDjWe0zmuZis7QiW4x2LNBYVcgpS8GTJGPbN/0ff6igXcWQ==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr3860134lji.59.1592248216530;
        Mon, 15 Jun 2020 12:10:16 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m14sm939012lfp.18.2020.06.15.12.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 12:10:15 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id x18so20510598lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:10:15 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr14454425ljj.312.1592248214672;
 Mon, 15 Jun 2020 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200611040453.GK12456@shao2-debian> <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
 <CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com>
In-Reply-To: <CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 12:09:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAH-yXX=1T_hqenVVmQPVKP-dkRKKkHYcWAXK0tRzz6Q@mail.gmail.com>
Message-ID: <CAHk-=wgAH-yXX=1T_hqenVVmQPVKP-dkRKKkHYcWAXK0tRzz6Q@mail.gmail.com>
Subject: Re: [gup] 17839856fd: stress-ng.vm-splice.ops_per_sec 2158.6% improvement
To:     Jann Horn <jannh@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:33 AM Jann Horn <jannh@google.com> wrote:
>
> So in summary I guess the test was just really slow up until now
> because it was hitting a slowpath that you wouldn't hit during normal
> usage? At least for vmsplice(), writing uninitialized pages doesn't
> really make a whole lot of sense...

Heh. My main worry with that commit was that we'd see the reverse
effect: somebody implicitly depending on the continued sharing of
pages in some odd splice situation, and where breaking the COW would
result in a performance degradation.

The fact that it went the other way instead is somewhat ironic.

But good.

I guess I'll just ping the stable people to say "yeah, put that in
stable too". It's a fix, and apparently it _helps_ performance for the
degenerate cases rather than hurting anything.

             Linus
