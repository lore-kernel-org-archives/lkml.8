Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A55C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9DD20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585516935;
	bh=henbE984rrlQ2aisAaasFTvuukMP1h2D8fArnHeL2fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a/76OQ64Q72Dg6nfwgwSIh5BPsBTyra3sa+xqP4Rm2zYFX6MLro8F6TyCK64N/EA7
	 /1hr9Jrh5rUF2wFVa9kQ5xbjFBlzWaBAIT6008DfdH0GdPT5JN0VmO0pg2llx6uoNK
	 1mg9EHb0RN6YAMQFeJ8fKz5foEokosVVbXPN7Bbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgC2VWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbgC2VWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:22:13 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5457720787
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585516932;
        bh=henbE984rrlQ2aisAaasFTvuukMP1h2D8fArnHeL2fE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CT0BJrt8haSInSNKAvdzi5ePELm8SItRufE5YA6TDyhxaIdAUXyIAyEu5sCQvraIO
         7B7hzZJj1PWNebSgnBVIBZv/aOnrlDBUYtUuim18NZEbfTQRxiaKzXaywxnEAuaPyv
         axFQSAVAd+ZWaqROX3/J7A50OAG7O8DErYQkjiyk=
Received: by mail-wr1-f52.google.com with SMTP id h9so18779711wrc.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:22:12 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0f5tIWOkYhbJ9pLwxpJ5N14/+cxP1NY/nHXYXRKZptfD6FJ6nm
        B1fU/167A4mYq+J3b4RcXAyWLBvGWJBTkbkKjzPhhg==
X-Google-Smtp-Source: ADFU+vsGnaM2PRBkeXNlpbRPMLa9FLhGvFgbGDJJhYmUAZzE3663n5gDF7Ocr08xsbfJl/xiwczBs3KLpqJZFuhia3U=
X-Received: by 2002:adf:e901:: with SMTP id f1mr11177142wrm.75.1585516930709;
 Sun, 29 Mar 2020 14:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com> <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com> <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com> <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
In-Reply-To: <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 29 Mar 2020 14:21:58 -0700
X-Gmail-Original-Message-ID: <CALCETrXWKE8RMX-mZ=p5T19sfS8Rn+1b_EtJz4TXbmf57_aY5g@mail.gmail.com>
Message-ID: <CALCETrXWKE8RMX-mZ=p5T19sfS8Rn+1b_EtJz4TXbmf57_aY5g@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> But that magical asm-goto-with-outputs patch probably won't land
> upstream for a couple of years.

I'm not that familiar with gcc politics, but what's the delay?  ISTM
having an actual upstream Linux asm-goto-with-outputs that works on
clang might help light a fire under some butts and/or convince someone
to pay a gcc developer to implement it on gcc.

--Andy
