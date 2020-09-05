Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF2C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3220760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599324953;
	bh=KCVpQIkRfqk75kLPHTuJDni6NSqWOhUvpOq5UmDg0jY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yCPYf4Sl3hhBUVDQRgg6Y9TXiYjSQ4wVt2kjLdw70jfpGbJKU6Qv3xO4kgp110qve
	 kgZoCecDzKVjCjo4IALUjWnyJbS14uLmeeKST4Z+EAxaWMQt1ThEGhVpqRdqKB5bIC
	 HsbqJUb1zgxw94KZeixTu/EMizkFTV2pGEkuOx6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIEQzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIEQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 12:55:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45738C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 09:55:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i22so12553637eja.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiPzQYToprkedvPvy23+d8Sogck/PPDXaDM0aINUTxs=;
        b=IbD/06LcWNINiD1qQx76yuC4NnGDIsm3+GWIOtgRCjshaVtDI/A02DI5qKetncQ5Eq
         ETJ/AP0MURo4tMxU2BWA9ZqY9wz8byBe5Nb/ZFb/npAfuJhH/nO2eJvqX1EnmPNcLt9a
         /DIWjA8HitbuHHT5Zgo8zabEuZouEGY3xlN9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiPzQYToprkedvPvy23+d8Sogck/PPDXaDM0aINUTxs=;
        b=GzgljpL2hbWsiRNFl433ZhpUTmS+JAcIhp0eKuXhwBy8L0xLp1CyvYfAWQQy91BX0b
         ErrwwpHs0xbSpotSIPFkxKvtlFTh1Gr39chWK8mHVuz8a9NljqboikRLjW6agUeVARSR
         IPpTN1l5JoVca4ZnbO/DBkOw5vovNwOEwPIDhcHUpXbqSG4Eh50MFmiOwpiwqlqpat6U
         bGZGPeQQCsuYIqS8k6vsjkKWBpTs0scRJAiUbG2hbv00fXA25UkNMCKpgfx3EJ65aOwT
         u9GQ9Y3zELgnDfzpBYyBEwVr2b+/Fv0KA9E/jwsLxlUMV2SiEHuANEb7/kuzyDBMs2ve
         90Cg==
X-Gm-Message-State: AOAM533OVJkOmQ1sKimMplnunl//7UHBGOxCadJ57st8VoWoqhy6PGkB
        oP64qpz11pL7SxMPe228rnGz3TsZwVjDWw==
X-Google-Smtp-Source: ABdhPJzTB2MEJXywltGAfkGRv/ICdFGAq5frxVPc5bWwBrMVWzBhfk1c5PqpAo99We5GUkzbTjldzQ==
X-Received: by 2002:a17:906:17c6:: with SMTP id u6mr4498635eje.95.1599324947293;
        Sat, 05 Sep 2020 09:55:47 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a18sm9513497ejy.71.2020.09.05.09.55.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 09:55:47 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id m6so10509289wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 09:55:46 -0700 (PDT)
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr6480035lff.125.1599324489251;
 Sat, 05 Sep 2020 09:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Sep 2020 09:47:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Message-ID: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 5, 2020 at 5:13 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
> when the user hits a COW fault.

So your patch is obviously correct,  but at the same time I look at
the (buggy) ext2/xfs code you fixed, and I go "well, that was a really
natural mistake to make".

So I get the feeling that "yes, this was an ext2 and xfs bug, but we
kind of set those filesystems up to fail".

Could this possibly have been avoided by having nicer interfaces?

Grepping around, and doing a bit of "git blame", I note that ext4 used
to have this exact same bug too, but it was fixed three years ago in
commit fd96b8da68d3 ("ext4: fix fault handling when mounted with -o
dax,ro") and nobody at the time clearly realized it might be a
pattern.

And honestly, it's possible that the pattern came from cut-and-paste
errors, but it's equally likely that the pattern was there simply
because it was such a natural pattern and such an easy and natural
mistake to make.

Maybe it's inevitable. Some people do want (and need) the information
whether it was a write just because they care about the page table
issues (ie marking the pte dirty etc). To that kind of situation,
whether it's shared or not might not matter all that much. But to a
filesystem, a private write vs a shared write are quite different
things.

So I don't really have any suggestions, and maybe it's just what it
is, but maybe somebody has an idea for how to make it slightly less
natural to make this mistake..

But maybe just a test-case is all it takes, like Darrick suggests.

                  Linus
