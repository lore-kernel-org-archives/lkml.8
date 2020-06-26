Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2388CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37412078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqnGDrW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFZMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:39:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D851C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:39:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u17so7319758qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Xv6Klq+9PNQeMFnV4+rmSRk5U2o5dHDh5y+Xp0f1kAw=;
        b=NqnGDrW8W9u8YLn1vg4AMfYa48/OGemmp+Tx+Q6dOQU7V6ijbYjyvbjETLuIqe8I/R
         QFBQK/bdtmuSJ7divryBTe6bwdysrrVzKe3xAnVcBOIojVwsDO14WSdWQS1FZDSGT/WD
         KchnF8qJhWieCimX7IV4p3zCQF2s1KOQmOYnR0lbySTRKphPI/VlBqbBDr59RPn+Z4WM
         RXHHIpzmYL2/o4uqMVq0eT7Psmza2eTRM5TFYPdQxlSgEWYxhU5cXMjDggc69cErHkv3
         VvcZtHBJhdGcy2wDfn0awBTiqAEXAT9xeX9a6oDaPrW/77g/4AK9Oe9tzG4VYLBEZPaH
         jWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Xv6Klq+9PNQeMFnV4+rmSRk5U2o5dHDh5y+Xp0f1kAw=;
        b=pEQImcXVEIbU+2c5g4lfRYoRAzxB7fFcKGUfC2VbF0DoL/yXkwSE97ljbhHA3mYbjT
         YCQBJGxKAEjhOBkvpdv7573vgXFYViBFoaLYZGYZlTWqKoKFuI8pnDpXVmFYiq9YxbOC
         iEh3z9+CmoOpr21St0kpxq93uMGPlbnXaP+Bb/CnVhUhaF47u5rhiETfaRJoFDsWHbnY
         CgTa0YxRxTDFqdpJGDx0Ssycq1VWDHZzXKirRkzelhU6nDemaTeT7hYSpN4bfXJRlPfn
         3hbVKz2yUudaKBXIs2IF4YNN16InGM7izlQFNxPuVZiW5rrQwyfopy8M7QmJBTkBi7cv
         M8NQ==
X-Gm-Message-State: AOAM533h6/Ke77t9c7QMER73/SR6v9mokW178Vizz4Dgq0xMkQM3ZsT7
        J3PnCs9JRmzidf3g8Mj71OW4QKGU841MwTQRyzKX2fhz49t6Sw==
X-Google-Smtp-Source: ABdhPJwfkVULN8SVKwRe5NCylLUpygfuGVRRY85kb4wJLGzt6ulfwqUJIVkQFAc+acq85JPOMjaHyVku8EWlKVkhIcA=
X-Received: by 2002:aed:2e07:: with SMTP id j7mr2673967qtd.338.1593175179650;
 Fri, 26 Jun 2020 05:39:39 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Fri, 26 Jun 2020 20:40:47 +0800
Message-ID: <CAAvDm6YDCoqib3oaof03K-JwGNd5t2krc9-L3moZ_cfuQOuQsw@mail.gmail.com>
Subject: Are there some potential problems that I should be aware of if I
 allocate the memory which doesn't have any relation to peripheral
 hardwares(i.e. DMA,PCI,serial port and etc) by vmalloc() instead of kmalloc()?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, list

Besides kmalloc() is more efficient, are there some potential problems
that I should be aware of if I allocate the memory which doesn't have
any relation to peripheral hardwares(i.e. DMA,PCI,serial port and etc)
by vmalloc() instead of kmalloc() to avoid the page allocation failure
caused by kmalloc() while there are too many memory fragments?

Thank you for your attention to this matter.
Best Regards.
