Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B3FC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683182067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584031276;
	bh=s/sJ3YAgR5YkJwbOLGpa9jus9ezwXX24JkPT1Y1u6LE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NSruWy/2HdXMsZfNsiSiCBI+/5oZ+x1w/3mjiXO72JuZ6LLwumYEE5iY7aC9N2DfG
	 /EXERoANASnov5My5wP8aoq1oqtrJQppxZTnTal/eVdWw8YMAuZnyeVY+M5Lx2vpEU
	 Y5lzmzos/IfkwtGp/DGUlZFA40XJG+5kGbAGurOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCLQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:41:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41029 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:41:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so7185587ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2sz196/Cs27wxtfRE//dxsR1M4xyc6FsBDBBJltAxs=;
        b=cdQC2dv3JAgsVAdL4pkokh+yfj9tt9IkD9gkf373P1CN2QgninELU3Wvy4TJQIySWw
         hTxFfX7IX/VgILNHfG6vUbqBRg9TgBnfBG+bamXLeynfrIGZ2sAn4gmDJacfJ+zjzBjt
         PDw9j5myuoeR7hRy4P/P91cTtE9LDJ+lt3pvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2sz196/Cs27wxtfRE//dxsR1M4xyc6FsBDBBJltAxs=;
        b=Yw/+NDjqNIWCdG6gos/DRcntskAhKHNU65z9zL/G09yzEiie7pHkfwxJUNsDw1sgHa
         WlFYkRy0GtIVHY9WMAAte6G7eecm07YDud1L0i0Mp2HQefhU/AH7AtMzizrClHBFU9C/
         GpKy5syzQAPzHyuDVJQonwKSQw21ZQwz3fDF1daqgIfilL510FIp7ndrqyeSDZXscF1T
         uqxfEBYlN/tHhvglAOeUMPpl8icqIMXH9PAx+htPPIZ5Imq6hhFc+2mKceYeBqY3rpe9
         lfrCwOCQrOGQE6FRla7RTwhzdGNyeN7uJXoRUvYFSg78h9v8OZSvQHHZ591/21YvB2Fb
         taog==
X-Gm-Message-State: ANhLgQ3BLbVju0ksQK1LxVHThG01Bs9BK3HUNJ88kRugZFWhI/ZeyAwF
        JIiZ72rvPilre3xADng35sUqLzottys=
X-Google-Smtp-Source: ADFU+vtZzgRZ5SqbYhq8m2JPSF5SYhNBv2XrUfcAcbHH95Wymq5vknU7Onslgmi5VWyzV5MwJ5LvhQ==
X-Received: by 2002:a2e:3615:: with SMTP id d21mr5790090lja.213.1584031272310;
        Thu, 12 Mar 2020 09:41:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k14sm13671833lfg.96.2020.03.12.09.41.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 09:41:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f13so7225041ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:41:10 -0700 (PDT)
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr5760125ljn.201.1584031269966;
 Thu, 12 Mar 2020 09:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190916084901.GA20338@gondor.apana.org.au> <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au> <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au> <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200224060042.GA26184@gondor.apana.org.au> <20200312115714.GA21470@gondor.apana.org.au>
In-Reply-To: <20200312115714.GA21470@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 09:40:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbTF2iw3EbKgfiRRq_keb4fHwLO8xJyRXbfK3Q7cscuQ@mail.gmail.com>
Message-ID: <CAHk-=wjbTF2iw3EbKgfiRRq_keb4fHwLO8xJyRXbfK3Q7cscuQ@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Fixes for 5.6
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 4:57 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This push fixes a build problem with x86/curve25519.

Pulled.

I do have a comment, though: this fix matches the existing pattern of
checking for assembler support, but that existing pattern is
absolutely horrible.

Would some enterprising individual please look at making the
CONFIG_AS_xyz flags use the _real_ config subsystem rather than ad-hoc
Makefile rules?

IOW, instead of having

  adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
  ..
  adx_supported := $(call as-instr,adox %r10$(comma)%r10,yes,no)

in the makefiles, and silently changing how the Kconfig variables work
depending on those flags, make that DCONFIG_AS_ADX be a real config
variable:

   config AS_ADX
           def_bool $(success,$(srctree)/scripts/as-instr.sh "adox %r10,%r10")

or something like that?

And then we can make that CRYPTO_CURVE25519_X86 config variable simply have a

        depends on AS_ADX

in it, and the Kconfig system just takes care of these dependencies on its own.

Anyway, the crypto change isn't _wrong_, but it does point out an ugly
little horror in how the crypto layer silently basically changes the
configuration depending on other things.

For an example of why this is problematic: it means that if somebody
sends you their config file, the actual configuration you get may be
*completely* different from what they actually had, depending on
tools.

Added Masahiro to the cc, since he's used to the 'def_bool' model, and
also is familiar with our existing 'as-instr' Makefile macro.

So this is basically me throwing out a "I wish somebody would look at
this". Not meant as a criticism of the commit in question.

            Linus
