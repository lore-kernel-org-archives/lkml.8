Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF34C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C31206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591742450;
	bh=oIZ2SkZvc5i5FZodd8grydWh2wz+gTwpWrtXmJQbZ9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p0L6EoXesyLVL4X00wisy3zjQYmcxBzNMGBNB1KMQUSvUsZSE1T/kxVJUCnsxtN1P
	 Lb+5A1csfLsI4N9Zxv4mLULTrluaCZP9JyQv91MYNSESew2ZYkgNp61iSiGrQyFq/e
	 UxPeBGVK/mf6FFKE0gXx8fVc+cAgxbRGeunjeQU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgFIWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:40:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D83C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 15:40:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x22so288008lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1TRNNjJlvLVpkzYtiyuKXMMAtHYz93D6qUBO+R17NY=;
        b=K1f23i0fqTaybBaIL91PC/uUGVhXSo8qFOrRZ6HkWINEL8dEywUK3T3EhTHBQo1onI
         W2B23FJguSy+2BibfIkn2DkdpPgkPHbOxwkYkGJwdrS+/ZW6LOzw/y+emhKjQsn4I6lP
         cbjUZmLILbknLg40OFWdmE+Q2u7LZ3zRFbcGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1TRNNjJlvLVpkzYtiyuKXMMAtHYz93D6qUBO+R17NY=;
        b=oHyJVOMGAghuq1vHrvViU1NbsCN7rD88OBjy9BBIvdobzX8zsu9+zWicXMtfLR+uVv
         G4VrUDVqQ9UAr+j1mhDYAew2Ef/zY/6jTnIxOTs/XWSTemrxY4tqkYEUGGXEQmUIEpDn
         z/8zcEl+FTmMtLEmbVhx3wEDaFLRKny2/pgJ7o7/QXynCJriJ97QnOozBMAwYfqixSCl
         nlz4II6TYH36Lk4OaaFsV9lOiD7fTOKvqyHSblPNWkkeeQxLFRRI0zfRmhlGTeWwrqAR
         K3cwya6Hjcb/p/2WfHj3iwIba5ThCeWVSSZ79iuz95D0ZEQcFeTq9bAGPuER/g36GPkx
         HC8Q==
X-Gm-Message-State: AOAM530u/VybdnFARYtUdcSAcjoWmsDdKmZyo/AHBy7G4iE7TLkv4Fw5
        /zGWqVjII2XnRhI1tRDpGmX+8sIdTxQ=
X-Google-Smtp-Source: ABdhPJyeo9ASPr+VwVHSVb8IrezczgVHTkgWpaP4c6HDtRlsU9HVdejupiKwjp09gsQ35bIHtZZuiw==
X-Received: by 2002:a19:500e:: with SMTP id e14mr73000lfb.88.1591742442633;
        Tue, 09 Jun 2020 15:40:42 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 11sm4533623lju.118.2020.06.09.15.40.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 15:40:41 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id e125so300988lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 15:40:41 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr73046lfc.142.1591742441027;
 Tue, 09 Jun 2020 15:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <3071963.1591734633@warthog.procyon.org.uk>
In-Reply-To: <3071963.1591734633@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jun 2020 15:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4VjVHkMcALg3T4A+Vwfyo0NBWtPoKwvO8pWe_v=NF6Q@mail.gmail.com>
Message-ID: <CAHk-=wi4VjVHkMcALg3T4A+Vwfyo0NBWtPoKwvO8pWe_v=NF6Q@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Misc small fixes
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, chengzhihao1@huawei.com,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 1:30 PM David Howells <dhowells@redhat.com> wrote:
>
> Would you prefer I defer and submit it again after -rc1?

No, I'll take fixes at any time, and the better shape rc1 is in, the
happier everybody will be and the more likely we'll have testers..

             Linus
