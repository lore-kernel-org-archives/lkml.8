Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BDC35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3B20707
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424427;
	bh=fh0ghmqLt+Xg1QeG+q9AT83/CM/LT5QxvSqKgy1dIgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PaztftibwGTxCDMyYy81aYKDE0GgYWp0xFWo74hI6+fopRRec20zwy4J8O2DlTc2x
	 aXL5sKXR4yY+IydUBRyH9R7CfWXrLSGIGUT6NgTkv6HOqEEJkv5u/wCpsbQda5szkA
	 oWYDKzdi8592t5/99wXK20cM8QmIMVeuvBsFdpuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBWCUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:20:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42051 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBWCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:20:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id 83so4292212lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlzDCWKnpP64oLtQaBAbzFOIcuprG8j5G+iWBrmKVrg=;
        b=J87BUl1GAtEGuqJhlVY2/k9SfnX3/EJ26CnJ5zhPvKO27Ck4gIMAaEcEp6RkXK1CoH
         cYeUu7QkJG+o7g82QaU04EprymxperNTYgWURB5uT+eAQBNQAFtc9siHaFRsGCPU/lfu
         6B0xzEvBpPVHL7GX3USuIS4PmGhz5I5USMHYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlzDCWKnpP64oLtQaBAbzFOIcuprG8j5G+iWBrmKVrg=;
        b=qaKBSOpNdngtBL1bZC2lzdBNkYUldcuUzKu/XljZUgOcHO0Rdo/bFpn4C31FXYi1L3
         jEPCMNG81gI8/nfdqJsCcQL/pB7ZkgoL71fnAZiTZM1WpbmuMBRkcD/Z5UpGCTLzhQBA
         G5lQyiaVz7INU8jjonc1GWwkQqaPK2a+nf/c6jmF2eCZXnA6TtaBlzIyPdrzcV1CWJx0
         qFV2nnSgQ5tgRxyzWgRSRe1WWzzU0+MPU2WJFqtmiSVNfiix+oU6JrmnOmZOjrO3Q5yA
         iV8P7vgcUnxSxHOhq2VWMf9s1jgsMsHAeSWMkvY5nTDIaAhJfKFjS+DzQvBnFpxLHbd2
         jCLg==
X-Gm-Message-State: APjAAAXsorz+eJFftFLV5oMzpixKI4WzW+oebBT8EwNwCCsZy23inmBz
        BKcMno4rQWptV637r/VKpKSjqQ9bIk0=
X-Google-Smtp-Source: APXvYqzsterecWQv6U8m/FI4sVMpz7ciIXtZf5v7BAoTkOR+LDssHeDjmHuUm3Z1AfJmq16sT1TdQw==
X-Received: by 2002:a19:ca15:: with SMTP id a21mr8258634lfg.67.1582424412309;
        Sat, 22 Feb 2020 18:20:12 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w8sm3947170ljj.75.2020.02.22.18.20.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:20:11 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q23so6237481ljm.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:20:11 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr26028515ljj.241.1582424410837;
 Sat, 22 Feb 2020 18:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-21-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-21-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:19:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikzXu_Veyj-H90HmLRof5vyMVZCWp03J_pC8fjb1_N8g@mail.gmail.com>
Message-ID: <CAHk-=wikzXu_Veyj-H90HmLRof5vyMVZCWp03J_pC8fjb1_N8g@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 21/34] merging pick_link() with get_link(), part 4
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so far I haven't seen anything bad. But I keep noticing these odd
stylistic things...

On Sat, Feb 22, 2020 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -       return step_into(nd, flags, dentry, inode, seq);
> +       err = step_into(nd, flags, dentry, inode, seq);
> +       if (!err)
> +               return NULL;
> +       else if (err > 0)
> +               return get_link(nd);
> +       else
> +               return ERR_PTR(err);
>  }

What?

Those "else" statements make no sense.

Each if-statement has a "return" in it. It's done. The else part is
not adding anything but confusion.

IOW, this should be

        if (!err)
                return NULL;
        if (err > 0)
                return get_link(nd);
        return ERR_PTR(err);

with not an 'else' in sight.

              Linus
