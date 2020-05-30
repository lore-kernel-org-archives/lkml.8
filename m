Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A386C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F482073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590866476;
	bh=ohQQH/83dlIVFr25ebXzZos0rN2gILRJAfkJl7OSirs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JN+ffr9E96Bmlj5VHkZQJ4I7VHLYVSUuO42TNPvuURZPngPfDWhNfH7ugjqehV5ec
	 Fpq8UKJkCo+y9IYN7XTTPK7vok507ppRJvoXqjTKWAnuteykCCvwhqJuME9ZNvcJ4d
	 DEfNWyXNmSpn5dfA4WJcOetdYK4ltr3KAxaLHh1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgE3TVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgE3TVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 15:21:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EEAC08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 12:21:14 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id e125so1665522lfd.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NkuvZ5wxpI0d7nxM1p2cSrZBIeJuPPcRbcbjWmyFH8=;
        b=L2gQT40oxwSdo4IdQediVzzXaQ9+LxXAgiK+MMr6jElRXz3IKpxvX2gNiIHXz8954v
         HtaR/MNXCphqAEFosDyOPCVSqQ3rs19dQLOuWT74IQyI0O7DyzRaJ/4J+KBp/TRoPDSz
         g1kWwuqmvYPoA233IXW/7crOLzFd3q6p7ha5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NkuvZ5wxpI0d7nxM1p2cSrZBIeJuPPcRbcbjWmyFH8=;
        b=b5dA926KYTOU6lUG5zeo1Fztkt8bHO47ONB1pqnwoqR83KT8nu+EDuP6rK/oHjKvwa
         XuafDFCRXnxkJ2o+AiIhNCspCGva8Z9DXz4tL0EDanf/yYC5/1X0X8k75LlnXTFqJ5xV
         fsrp/8Qf3642rCvZwXcaWjnhoAQoYGYKz+6cOEHSRwQiVVHVjLrUwGT+If0DG8BjuBxi
         DmlyVLaHQYy2ZFgFl2VdzugFuTexsy6h0yOJqfw7bBYaaA90+Embn2i46Qn7XvcunN8V
         C1ASRudw8M03GTk/7vZDCQQyCv+LzBupQ5i89YOC+0160mk4557WW1vao6DG/r7p8xlN
         w2fA==
X-Gm-Message-State: AOAM533LnokqPyRhWk0SKY7xE6Eee4h17xmLAvZZa/VIfVXj3wumaKDe
        mEKTLS0EAv7EtlVXJcdSJtcQeWJLtK0=
X-Google-Smtp-Source: ABdhPJzL/0TGYOQXmZS9gVfIJ3Ei4HYUv6koOA2X3TlG2CrSzF10hrYjgpFRUrTljiyfo1nQtSqWwg==
X-Received: by 2002:a05:6512:20d:: with SMTP id a13mr7471798lfo.36.1590866472146;
        Sat, 30 May 2020 12:21:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h2sm3194732ljb.45.2020.05.30.12.21.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 12:21:11 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u16so1641649lfl.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 12:21:11 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr7258369lfu.192.1590866470633;
 Sat, 30 May 2020 12:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk> <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk> <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
 <20200530183853.GQ23230@ZenIV.linux.org.uk> <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
 <20200530191424.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200530191424.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 May 2020 12:20:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg03AwbLH0zLRbOOQR_cZD89dM0KMU-uLMkG2sG9K_yag@mail.gmail.com>
Message-ID: <CAHk-=wg03AwbLH0zLRbOOQR_cZD89dM0KMU-uLMkG2sG9K_yag@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 12:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > And none of that code verifies that the end result is a user address.
>
> kvm_is_error_hva() is
>         return addr >= PAGE_OFFSET;

Ahh, that's what I missed. It won't work on other architectures, but
within x86 it's fine.

                  Linus
