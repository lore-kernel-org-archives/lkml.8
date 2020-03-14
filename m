Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC692C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7322074C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584145571;
	bh=QCJXaWayMi2OcBWL1p7X8+K0nBPYK7qrl1KuOk35RlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1tKIBQdwPTkMqzk+bFZKlqt2s9l1+AdvhbGsww6kj1sn1Rruqdcw8ynKXMYxMhrNt
	 1Oj6QHjk6OOcMxlJdnZ9niD9vNP08ltTUR/qVO5A2ucVNxKzSKrtTt+6RFeXwWeYOE
	 1xoex6ZxdW8URU1fIZn1jiLrAmFZSQ+tayFJnNm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCNA0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:26:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43489 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:26:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so12492192ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSh28SDxVzmezso0eCx9OLP79cE1ODkRapdHxbtQ29k=;
        b=BNv0AIG2vvEkCJhWjYAFISduPkxT8Ox6Ts9OSN0YQy6/mTiU5c1VgmXW9TIdC5BBr0
         KYAilKkOKlN+NxaDs6MkVZ5h/TBABtDs3eTS4Nt7RYDT2QWUsCchxU4pciiLd08QlnBa
         KZT/V9/rFMliX2+Xv/SYsgO+HqZN1TDNaV7gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSh28SDxVzmezso0eCx9OLP79cE1ODkRapdHxbtQ29k=;
        b=cZx5W19AA1c0zf/5Scodfk99v4Y/NKm94aFj6lE5PXtiQQpXdCpDIbntuTWxg+vilm
         mLLOci9GTfcKIu/pMLbd4w0f4aO4c9ZcLaQ/ftdn6OHglwQwjVptE2sbkNpa7Iiel+HY
         3vtT81FcveaNaX34HwIgLAUaYmALno7KSAcIAU3byL91NQLI91lhFWRhgcpryALtSnDJ
         RlFLtORTtPRjxrOvlDhmFdkfm0mcuQo0WQSubXypkWbnJ4JFZGv7Ffabkxc2TBCg1lVO
         hOJdO5QuDHSZhPrXvVvjPnvgVUqASbbrDOcxcERiQ1kn0NJTgwoGUy6BhbgdqbrQ+wyc
         SuPQ==
X-Gm-Message-State: ANhLgQ30y6opJnJWT+3onnvm3iYuHIaRr3/wg7z2271cM0hcng7d2bRL
        1xaIuWWItaUekqlSSh3UwgNstxCp1Fk=
X-Google-Smtp-Source: ADFU+vspjwA8cfiiguRvGhuudFxi2U0FjvNx9lCWdh0f43p8/jO5KMASpJSPZR2b8Fu/B1Qq6cCuAg==
X-Received: by 2002:a05:651c:445:: with SMTP id g5mr9846279ljg.149.1584145563688;
        Fri, 13 Mar 2020 17:26:03 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s7sm12588064lfp.51.2020.03.13.17.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:26:02 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id n13so7518297lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:26:02 -0700 (PDT)
X-Received: by 2002:ac2:5986:: with SMTP id w6mr9900471lfn.30.1584145562223;
 Fri, 13 Mar 2020 17:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-11-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-11-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:25:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnpnUy7OiiDbE+Bd=x-K6YyRV_1mvsoP-fhTC2=ez=+A@mail.gmail.com>
Message-ID: <CAHk-=wgnpnUy7OiiDbE+Bd=x-K6YyRV_1mvsoP-fhTC2=ez=+A@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 11/69] lookup_fast(): consolidate the RCU success case
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -                       if (unlikely(negative))
> +                       if (unlikely(!inode))
>                                 return -ENOENT;

Isn't that buggy?

Despite the name, 'inode' isn't an inode pointer. It's a pointer to
the return location.

I think the test should be

        if (unlikely(!*inode))
                return -ENOENT;

and I also suspect that the argument name should be fixed (maybe
"inodepp", maybe something better).

Because the "inode" pointer itself always exists. The callers will
have something like

        struct inode *inode;

and then pass in "&inode" to the function.

And it's possible that I'm talking complete garbage.

               Linus
