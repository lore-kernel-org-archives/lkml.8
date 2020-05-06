Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0BC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8309F21582
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588787535;
	bh=cXyxMf1Eb6Do/xWY/gsssZYFY7/P9CB2JNPGLKs1Lbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G4UrwRGrDTxqKBnZUmkdiALwiJew4hXrfG5dDdH5i6T191gNU+OZCagyjA2LFFoQG
	 MRzYp5UnbxTt7UgIWT/+mfZYqO//wAit5Kwn1k9GFy9+BLViawxAL+vUpCSYzhr8b+
	 mu664T4lKZdb6ewumKfuYoXNQ16O0wCLrUH4KD9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgEFRwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgEFRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:52:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63BC061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:52:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so3342562ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iDM/PlD1cl2Emprrc8UkVlx+lvpjZ6KITj+kMZS4vU=;
        b=Onj6RpBSdppxiHflDIfnU8/+fh2nF8mikY4k8DOvMwZvX/ZFfIXNMSG/+sP3oK2sr9
         mIhcfJjCn3ECmIQwwRaGtud3qgvzJv+DPfXc8ePIDpNWfdp4Yhjfmi+BT3ywIKw7jV7e
         fK1DuRTDXTp/q9VjTTMWhXsXHEy4B8ih7FSH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iDM/PlD1cl2Emprrc8UkVlx+lvpjZ6KITj+kMZS4vU=;
        b=lRnbGxgAQ5GPIQ2uMSPdxynxI6buOcLH3Q7zDWL9fJeyqNjgwNox39r+HnNjimTOe0
         91OtcoUfOUXjsj5rc6yc9NIfTCFNgvmHJzm6kIDnSRv6xSSy/Rc+I/lajZ8YDh0IXzsf
         KGy0eLyAFXT+EuD+857Zc1KBp3p9EagZWQYks3RfbZGP3Q/5P+sp8CtQgoQa1IUiHaxr
         TfMCNsNH1VIDw7KfjMMLJ60eZZIGKWmefcMb3GqhuZHNLZVTfj30qnmRLW+8bxrDEQHP
         gE3w2N/7EhuH+3Z1vN3F+pZQQmFQYA4viFUBw+yqbjFxmh/FS+7xl4E4vhKea1rHaneK
         uDLw==
X-Gm-Message-State: AGi0PuamNBG5Cl2799eTW+dDIBw/Y07YWPuQ65zHdht7uMRy8Xy0A3eI
        hmDTD3fbsIFjouRVd3cakDc97Q47v6w=
X-Google-Smtp-Source: APiQypLugzCJP7gGoJzb0pJ2EFgH/U7C0QU2yg+SXRUY5Uzy62nyRtjRQuWEp2VkWBPchIho4LsIYw==
X-Received: by 2002:a2e:909a:: with SMTP id l26mr5634823ljg.262.1588787529720;
        Wed, 06 May 2020 10:52:09 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p8sm1720754ljn.93.2020.05.06.10.52.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:52:08 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u15so3354448ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:52:08 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5893926lji.201.1588787527821;
 Wed, 06 May 2020 10:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200506062223.30032-1-hch@lst.de> <20200506062223.30032-16-hch@lst.de>
In-Reply-To: <20200506062223.30032-16-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 May 2020 10:51:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6E5z_aKr9NX+QcEJqJvSyrDbO3ypPugxstcPV5EPSMQ@mail.gmail.com>
Message-ID: <CAHk-=wi6E5z_aKr9NX+QcEJqJvSyrDbO3ypPugxstcPV5EPSMQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] x86: use non-set_fs based maccess routines
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 11:23 PM Christoph Hellwig <hch@lst.de> wrote:
>
> +#define arch_kernel_read(dst, src, type, err_label)                    \
> +       __get_user_size(*((type *)dst), (__force type __user *)src,     \
> +                       sizeof(type), __kr_err);                        \
..
> +#define arch_kernel_write(dst, src, type, err_label)                   \
> +       __put_user_size(*((type *)(src)), (__force type __user *)(dst), \
> +                       sizeof(type), err_label)

My private tree no longer has those __get/put_user_size() things,
because "unsafe_get/put_user()" is the only thing that remains with my
conversion to asm goto.

And we're actively trying to get rid of the whole __get_user() mess.
Admittedly "__get_user_size()" is just the internal helper that
doesn't have the problem, but it really is an internal helper for a
legacy operation, and the new op that uses it is that
"unsafe_get_user()".

Also, because you use __get_user_size(), you then have to duplicate
the error handling logic that we already have in unsafe_get_user().

IOW - is there some reason why you didn't just make these use
"unsafe_get/put_user()" directly, and avoid both of those issues?

              Linus
