Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E5C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82580208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Bm0Ppbjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEHA2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgEHA2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:28:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B44C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 17:28:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so619568qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=On99XfF55m8LFqRcIrWhYWPWVDnoOhQd+qVw8VWh93k=;
        b=Bm0Ppbjf22QhOZtzauYqSHzmXAQRBARh868f/Yxl/bO4oft1SEVgTov77GepKoI9Q0
         hI5LUBZCfC4hSVvSKpZWsxqC7kVl4MJ1ESI8nQwWfy0CuKRi/zkSIiGMJf0edNdbDa9G
         G2cYo88LBODiFBzpIGq2Q+4Yf4Hi4EwbGhF0y86zj5cIr7j/VuT2F2cqU0pOzrXSNxUP
         pqYp7PQnKC/4kXXPSoSz3m3xIACA3nfruXTtgCMFGGefAvOUuLGHNJDGnbWpMie0BJ2s
         v2vKU2Ej20Bixshu6ciOiVNaMA0QiCBTCPMrP6NyF6wbxCHVRcs2jMfo8ERIMODr4R3w
         DTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=On99XfF55m8LFqRcIrWhYWPWVDnoOhQd+qVw8VWh93k=;
        b=n81Inbzbyd1zqTTD1RzDvT65ndw5+eZLZCkIp9hTNN9Zro6S1xY6Cv492UvWPbMQx0
         yueD0blnvuf6aAqhCdTvT+jfEM1F2UaGqIgBtLcKs2XUi435XkHJjegqOh3cjGddOfrh
         IbMmwlrdWx9voDrqilpXBMYcY1SmLfasdNzAdXLnponZvlghnkAq1a4gufa/goJk8C3M
         l1EH8atLvKWF2V2hM+q7IX5qAKmEk7SLtNJLRjn9bm436Q5AFvTWAMMqzHpQu8Yn/AO0
         nhl0BTC/IKTLqSONICBtjHFQajFGH9lOSBqI2tRQppTu7vuK+m0gsEaIiZ1YYKd6Vcst
         LT0A==
X-Gm-Message-State: AGi0PuZbvoI/RKiRvJIiDy6MbQogBp7F6MbY7kO3IaVUxaVjQrakG2ya
        IjW3w//GC11H7unOl16dzMBLXA==
X-Google-Smtp-Source: APiQypKARSVBhYuC49c7dbY6Cziu6XEVjzZa76KBnegyK8EGy1U5ojsUPtOggQDBfm9nDFuhGB1SPw==
X-Received: by 2002:a37:a603:: with SMTP id p3mr124023qke.133.1588897722617;
        Thu, 07 May 2020 17:28:42 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p10sm123350qtu.14.2020.05.07.17.28.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 17:28:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] kernel: add panic_on_taint
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200507233634.GA367616@optiplex-lnx>
Date:   Thu, 7 May 2020 20:28:40 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <438575BA-00CA-44BF-8C4C-693DCC00FDD1@lca.pw>
References: <20200507221503.GL205881@optiplex-lnx>
 <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
 <20200507233634.GA367616@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 7, 2020, at 7:36 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> On Thu, May 07, 2020 at 07:07:20PM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On May 7, 2020, at 6:15 PM, Rafael Aquini <aquini@redhat.com> wrote:
>>>=20
>>> It's a reasonable and self-contained feature that we have a valid =
use for.=20
>>> I honestly fail to see it causing that amount of annoyance as you =
are=20
>>> suggesting here.
>>=20
>> It is not a big trouble yet, but keeping an obsolete patch that not =
very straightforward to figure out that it will be superseded by the =
panic_on_taint patch will only cause more confusion the longer it has =
stayed in linux-next.
>>=20
>> The thing is that even if you can=E2=80=99t get this panic_on_taint =
(the superior solution) patch accepted for some reasons, someone else =
could still work on it until it get merged.
>>=20
>> Thus, I failed to see any possibility we will go back to the inferior =
solution (mm-slub-add-panic_on_error-to-the-debug-facilities.patch) by =
all means.
>>=20
>=20
> There are plenty of examples of things being added, changed, and
> removed in -next. IOW, living in a transient state. I think it's=20
> a reasonable compromise to keep it while the other one is beind=20
> ironed out.
>=20
> The fact that you prefer one solution to another doesn't
> invalidate the one you dislike.=20

As far I can tell, the bar of the other core subsystems are quite high =
even for linux-next. People have been voiced over and over again to urge =
Andrew not picking up patches so eagerly, but I will save that =
discussion for the next time.

Anyway, thanks for working for the panic_on_taint patch. I believe it =
could be useful for all testing agents to catch those bad pages earlier.=
