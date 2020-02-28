Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33984C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D482469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdYaaS+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgB1AfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:35:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52898 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1AfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:35:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so1466963wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+y+J6aBAVQm7+lBq+/zozG5JL2IvJJLjLrQfS4QdVQ=;
        b=AdYaaS+z+BmKy2R4hzS0e0h6MCTJzCLfwcVwFY72/idqQIjeHS5Wtnv/QRN0RvFf0L
         Un5qUTpREaru8OKagFadavE5NB2uGDKjRv4UvBNjALauBiwh9WMfJ7+eXNpDhTnmDfte
         bAl+kMgFgAi70PTn10seOYYcZbcfC4OjEoksSakPEmJ8pQRwKU/r8s41tLPGzmcYT7/7
         EEhndo0236jBuNhE3FW8I1fv8sZI+PjgUWlXEt9fCfabeHx5OUBudowQM+2l1m4smH55
         fZg9fZ5Wy0rQuuuI0IHLifpFccz+1hUk1BvyjFJjBfWLOObzXwCHJUOTIaaWEHGnzv92
         aj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+y+J6aBAVQm7+lBq+/zozG5JL2IvJJLjLrQfS4QdVQ=;
        b=toL2P0XHc8Cwbbw/aHzPKGTR/eslRuXT9vp5lqh4qNJ1LuchGHIR3hnNiiZKXXUzWT
         5xlMwVj6D4fv4MKD5JvAu7Mhg8CRQr21wS1GEUefhEsz9xL5K0vIrhkEKHAyY6EXdqZ0
         ke2CXugerKnAf1k74zkO7zFvE73NctCv+tF2lUGq2kJ0sThr2Xl7cj9TFnjGiqW+6fg1
         hdag5TuFmpE9N6NrX/ihZeZh8ED5R4OUarp8YByDrsqLSZuGwRA5qdLJXG5U6cYxseF2
         VgGIhllPzNANksObYw97gJNcRR8uAT2IuNIPAOHstF3Vc10FJmlHq/Hf/lGha118R9WO
         5NIQ==
X-Gm-Message-State: APjAAAU6EbOAWT/FIn6y0nHVo78R/GjUklarj63hxeVcn8zrjfeZGq3A
        McOL6qR/FPA++6XlGz77MJZOxmOJxyRJs3VRtTlYUg==
X-Google-Smtp-Source: APXvYqzCW1mGRZylyx23Rk8Wc+OsvoYXqbmKSb28ENyZ8D2cARNMUch6jMz915hBoo5e4HcHmmudR8qltx0UYXMUbAk=
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr1333343wme.125.1582850100078;
 Thu, 27 Feb 2020 16:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20200227151143.6a6edaf9@canb.auug.org.au> <CAMuHMdVc-vyQfuLUgbF6ei9Qrr+fryA-j1PHsrsjTNiOYvUk+w@mail.gmail.com>
 <CAOFY-A0=AYDSdGq5tf7s6_kRjnDGLfLjCV9p+LdKbLwyw0J9nA@mail.gmail.com>
 <CAOFY-A2CFi0pX1BBsuruntk0AM9doseCMnFCJi192BYojaBUUw@mail.gmail.com>
 <CAMuHMdW-0xuxK_Cd2t3=BZwwOUhrYf-Ctn+frW_1tTsO5eQxOw@mail.gmail.com>
 <CAOFY-A0icFrzHibVrUu04JaiBBqNoNoEDYVjHGi4eMgDT1Z2KQ@mail.gmail.com> <20200228082831.0149e354@canb.auug.org.au>
In-Reply-To: <20200228082831.0149e354@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Thu, 27 Feb 2020 16:34:48 -0800
Message-ID: <CAOFY-A0an+H=aP6vANr17rrv7v5F99azi4UVaYNTAcpRSRsHUA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 1:28 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Arjun,
>
> On Thu, 27 Feb 2020 10:50:51 -0800 Arjun Roy <arjunroy@google.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 9:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Sounds good, thanks. I'll cook up a patch and send it along.
>
> You will need to keep the sparc64 patch to correct pte_index in this case.
>
Agreed on sparc64; I think the sparc32 patch ought to be reverted,
though (since pte_index may be meaningless to it).

Thanks,
-Arjun

> --
> Cheers,
> Stephen Rothwell
