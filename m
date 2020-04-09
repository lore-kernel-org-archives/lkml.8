Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0120769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="M4yy6a93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgDIQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:58:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37491 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgDIQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:58:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130so4686811qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=J5ERjFLP5xqFeN8/3i94zOv+u6SnOXsIfVlIg4pSrz4=;
        b=M4yy6a93PMYzrhjdkcfjyqhPHS8f2pNI2DXw5EM5+GRvKZo2cCRFdcPVmn8DVcYL0y
         c1mp9LbfUz/uX7ipeb9tZM8OfcoaY/6eE2XV1b/tGIBcNs1vWMN/HdvJMUUr25lM8boO
         qcSC7ud0bgqLBOYvXtuUOQ7i2IpP/xbmhZgKAnfrBR2wUrmOHskUvKje0YMHMmwsUeaa
         4Lp+Hw/jxYYKZOWGgUlWHvXnxkzlC5Mn9yVKEsDLd0VhOOzVgZlDOF2gccHWVejVrBGN
         A+ZskN6t8Nq/xps2x+PqzU1MaXHgXOz4owdrHY9bIoLV9L42CRjcZ00bnlm/sZb0H7k4
         qesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=J5ERjFLP5xqFeN8/3i94zOv+u6SnOXsIfVlIg4pSrz4=;
        b=fZxy82Z8IulMsPqknorsIHdcjxBdm+I94YNVKak8IXfu9YzPDZSUb888yANHJhlgkK
         5+ctCwY6MmdkiZ350ydLIc/xm1c8dxQtGsrXRA4XNxzbuwOvTcK5AaJtQKkM457/OE7S
         3wlerYtGq3dYvs51pps9U3pFyQ0KRXytdTpEJFbB1WcH6KMOgHyw+EAnKkIvfJZf/ODE
         3har08BYK9DhpaIhXJ5mnF33QZnBCkgwxO5m/aFgL05jJ76Z0ctoz6zvX9Endzqyb8mf
         9hep6pEcoX1QgX1i5S17IxyNQEIs7P9s2ENKZ/tCKeS3jolDfKlXoeYFSyUAkWvEvLus
         meAg==
X-Gm-Message-State: AGi0PubYfDBEjrZDdzBrgjyohikbR0PCW0z0yALzEiKmgsUSICWTyD4I
        y1aEBOPim/SQf0KWJOcuMaOL2g==
X-Google-Smtp-Source: APiQypIKZ8+GVDvTdjCYwLEXKQ5Tk8oytwFqf8PbQcVSRgGEDjIuZEJ//68S24Is0Gr1Jt+qOIo94Q==
X-Received: by 2002:a37:4d88:: with SMTP id a130mr743031qkb.443.1586451526904;
        Thu, 09 Apr 2020 09:58:46 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p10sm2801072qtu.14.2020.04.09.09.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 09:58:46 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Date:   Thu, 9 Apr 2020 12:58:45 -0400
Message-Id: <BB768A53-4A6F-4C69-8FBC-8BCAB1F4F280@lca.pw>
References: <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
In-Reply-To: <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 12:32 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> Kicking trees out of linux-next and making noise if they cause syzbot
> failures might also make some maintainers react more..

On the other hand, this makes me worry who is testing on linux-next every da=
y. The worst nightmare I am having right now is some maintainers pick up com=
mits that only have been in -next for a few days and then push to the mainli=
ne but then it is becoming my burden to fix those commits in case they intro=
duced regressions because it is much harder to revert patches once in mainli=
ne.

Kicking out of trees in linux-next on the other hand could make the situatio=
n worst unless we have a counter solution that make sure commits must be in -=
next for a certain time (a month?) before merged in mainline.=
