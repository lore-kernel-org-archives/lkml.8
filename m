Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A59C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8718520775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599148218;
	bh=GwddoN4gw6I5cNrFSkSsAy3d3rVUIuHjm7vMb0dHAVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=whvSBYqFIKXnxuJ/mWq1B+3z7KCxXWkx8ko0EZyxob/W7Me+4n4XxOlP11GzdOZF8
	 p3XvvrHB3MTb0U1GJEBibEZT2E08st8JkpIi+FwEtRxmSIWwEdE2Ht3G2aLPLWqEw0
	 5u7NDDOaVftDRFvSBYmxERTRP4DxNkxVsQxRSmUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgICPuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgICPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:50:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BEC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:50:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so4297431ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uN+gKvfGO60O5JMjCBhAHk4zCyy59uX9CdJNtZFrNw=;
        b=hYB6yqqQVYLw5W4wbNtwYxGosDDACrqFPkFRzSxq5GUdwnRcqWSZf+3pDJZG3l4qpj
         XIsM8mhEThCQIKY5Q71Pb3tabJeQfFtxozky3wgH9Fge0iOyyl06stPcVEls4DGKyFgJ
         F0YpC38xMkAjv0zbD8B0d2Ya5VsmSKKtjzeEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uN+gKvfGO60O5JMjCBhAHk4zCyy59uX9CdJNtZFrNw=;
        b=st5ZpKy7cKtmZrKsOtD2NhxK0Dhq2C9bgYQNsP/GxW9IrIZ6S2pAyCXpAqmEj1XDIb
         JK52NU0VMwVuuZuqhpSyaqSv7We0fi/8i/KuPBIy3pxdUWOJeSHQVDrcv9VLJsxQlfZd
         RcXuQzsVlSqLcW3860xdsgB6QvzO6+R77NYJQp49GnMBHpZt18CHkkRrQtSQ0VpoJLf9
         k/usZyRPwfGy7ZqqmijwAOV7V3Gp7qlIBF9N8iysgMnBpkD5uRF8isnJPi9TmBetXXjP
         dM8ya3bhyWCFkU5Rod7rPO/pLHTQ3zAEscx7aPt1qK0gppEJBXcgOG76CtseUgCgVpWb
         gs4g==
X-Gm-Message-State: AOAM531wRUrgLlb2YirT4cDYBlWNPdz/FagALk+oMwUVT4Nic01kZ75E
        WpP3BfyCRVHUwlctpr5wQ7ztjIXE3efh9w==
X-Google-Smtp-Source: ABdhPJwbkWcl60FkaegmYkaAtCEbGbP1OePL8/9lFdRtMxYPYOcO4/UDcymQ6vrHXhKhgnHGerG02g==
X-Received: by 2002:a2e:8215:: with SMTP id w21mr1563108ljg.43.1599148209119;
        Thu, 03 Sep 2020 08:50:09 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j2sm668515lfg.6.2020.09.03.08.50.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:50:07 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x77so2199735lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:50:07 -0700 (PDT)
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr1627887lfk.10.1599148206752;
 Thu, 03 Sep 2020 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de>
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Sep 2020 08:49:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=jtTcwSox8RY-skN83c40WXZOfwid-91FDgRdk0xwrw@mail.gmail.com>
Message-ID: <CAHk-=wh=jtTcwSox8RY-skN83c40WXZOfwid-91FDgRdk0xwrw@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 7:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> [Note to Linus: I'd like to get this into linux-next rather earlier
> than later.  Do you think it is ok to add this tree to linux-next?]

This whole series looks really good to me now, with each patch looking
like a clear cleanup on its own.

So ack on the whole series, and yes, please get this into linux-next
and ready for 5.10. Whether through Al or something else.

Thanks,

               Linus
