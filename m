Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4385C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43C124125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Wu6mRIJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAUPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:33:40 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:40581 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:33:40 -0500
Received: by mail-qt1-f171.google.com with SMTP id v25so2906391qto.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yQSao6a+Ppy+4IZJ+9ifO0X+dGmBtWenG0uMva+ys4Q=;
        b=Wu6mRIJrRHilWp4LN+ydNPxuYoUG0Uc1A3WXEnAsSL8sKN5yWIYvwcLak7AafqmgjA
         tsJcOMNHDTiEw6xRCt0InkdWJuH70RuxHOyjyNHWILN6/q896hgQgE9qrrDo+rrUdXzr
         MjhnMiAMHUJ3fdlb5tThbxR4Cw2upgniAmPQQMRlM9MeP3R/8XLGK01ZnD61Abtl6gVo
         pN2D8rriMl06+chDE5Nzm4J2HqLndwUjR8qDJNtrB5J8ky1q+zNkXRuqge5lA8TLnna7
         eegGpA0SYbV5G+raQ5Jvjl7s7ygXws+oLijR0GkKFeOkYjdRZYke7CCrSLP858zojU3m
         58Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yQSao6a+Ppy+4IZJ+9ifO0X+dGmBtWenG0uMva+ys4Q=;
        b=UZgKV03fyl+TQgDS15jYiqTfb0uOey0Du+LwTdu3TOKBL7WedMmqnHi5zMRL5bv6FS
         b1lsg9QMHC1T88Gqwk+LQfTN06ErCCai4dB+sDA4GA8sS1lseGMGuht3ZqGvIx4dKP5K
         Yw9O59QBBWGfou+Xq+ezC46vmjI0e4JdIdEIgO5fgU82HWsnwP613yfZ/3alcBTb2FXx
         9man1x8jjk/3DNkRyadB5KFDIc7XKvu86mGxtbxN/eZ3TSMO21UCggdJc2N8XBkNCovd
         ELsz55EOju1+MiBqMArw+TrrP2r4phhLVAF+6O85ZwzKByoHvWrxnjIER2dL+3MiQe3t
         aFLA==
X-Gm-Message-State: APjAAAWqBskSEZI/nZLP4honO6UPjW9r9+OPLDTCHYVHgmqH1bxn6XX0
        h6QX/ilB7xlWgpI1wwsVaAWlrA==
X-Google-Smtp-Source: APXvYqyw4EDF8dlsXzfOhK/eO2nnxB+7zMS3dQiMJb675hngPd+nQbABTuj7xAqrgkIBU7KXGKV1Iw==
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr713587qtp.209.1579620819357;
        Tue, 21 Jan 2020 07:33:39 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x34sm19503703qtd.20.2020.01.21.07.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:33:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200121152853.GI7808@zn.tnic>
Date:   Tue, 21 Jan 2020 10:33:37 -0500
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
References: <20200121151503.2934-1-cai@lca.pw>
 <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 10:28 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Tue, Jan 21, 2020 at 04:19:22PM +0100, Marco Elver wrote:
>> Could you remove the verbatim copy of my email? Maybe something like:
>>=20
>> "Increments to cpa_4k_install may happen concurrently, as detected by =
KCSAN:
>>=20
>> <....... the stack traces ......>
>=20
> ... and drop the stack traces and fix your subject to say what you're
> actually "fixing".

Does this title work for you?

x86/mm/pat: silence an data race for KCSAN=
