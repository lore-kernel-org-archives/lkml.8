Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A76C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD96020753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mpEcu9oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgDIVOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:14:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42241 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgDIVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:14:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id x66so229566qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mPZ1Crw8eOW/x4DBqeSZklPBJbmwIyV+b71mBMMt/XA=;
        b=mpEcu9oqPI5v1uDdoflpAfmaGrxhmS3S92KsvTmM9/mPRZ6sAfeRS/xV4EMeO3bziv
         eYfF7Zzv8nX8BdTm1ZOghvn0jCBJcsYBO2dMEB+x4s8ys1WJ180iQAJWe6yvkuJUVwMG
         rNkrRuSzIHMFjFEX5AFO7PASr3qM+MejJaQAEUDANOkD5rZIz2pzT9DtS9FyhVl+oJVb
         kkR3iBb25CeeXXxQI3nbShg1JZWREKE8bHN9cVtP32VE3oH80SeKqnFJmtSBpcVuiRa8
         JiP8I6tCsmP6bqG+9th7armJ2YN75rHQiDjExNhtU4KPp/8Wu26fuoZ1JqQjf3JtQsqW
         uMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mPZ1Crw8eOW/x4DBqeSZklPBJbmwIyV+b71mBMMt/XA=;
        b=D1zv2wnKBlkiOn1saLEESdgyNSz/cICQcoiULMAiGC2dW7qkeUWEN/+Kk/Dpm/JWYb
         ZuKVDSr0e4Op6yIPV/c3FOwzpcAie00JwdZICnylrOBJHMEGgTpLUKfcd32FnekFCzl5
         +s5Mqtwq/HOOArMEKYL91Ng/aO488skYf2FjlDE4/AkL6+EhEXDvSNaDs5vLBl4kT/hh
         csyGgLUnXt60dtZAkZ+rsBaaW+VJ7ommQWL6H80bPN9bqFibqN8qcO2PhagZ/v6sHlwf
         tMafBpd81OFwD+E4tdmWg2OkCQWdEXMt7lX8eE4jCEfrhPSb2uyWTEjVuxWsYT43wwyz
         o4pA==
X-Gm-Message-State: AGi0PuYSiWMA0bP2HpY+MXT0Vhskzz4EJcuzFn108XdX/myT4opFjjmP
        XRbD9rJt39emH0Dv41fMWuSvrQ==
X-Google-Smtp-Source: APiQypI/mjrS5BMQ6tlVRk1yDVd5dIgAzGv/NF9nAs1y4Eo5vYcNPLLmt8C6D6aw+4HbEjaECyl3TQ==
X-Received: by 2002:a05:620a:11:: with SMTP id j17mr859091qki.117.1586466888215;
        Thu, 09 Apr 2020 14:14:48 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p10sm62002qtu.14.2020.04.09.14.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:14:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
Date:   Thu, 9 Apr 2020 17:14:46 -0400
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C21961E-24D3-4C97-A5AB-B70451E4F952@lca.pw>
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
 <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
 <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 2:06 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Thu, Apr 9, 2020 at 10:58 AM Qian Cai <cai@lca.pw> wrote:
>>=20
>> Agree to make a big deal part. My point is that when kicking trees of =
linux-next, it also could reduce the exposure of many patches (which =
could be bad) to linux-next and miss valuable early testing either from =
robots or human.
>=20
> Sure. But I'd want to be notified when something gets kicked out, so
> that I then know not to pull it.
>=20
> So it would reduce the exposure of patches, but it would also make
> sure those patches then don't make it upstream.
>=20
> Untested patches is fine - as long as nobody else has to suffer =
through them.

Excellent. It now very much depends on how Stephen will notify you when
a tree, a patchset or even a developer should be blacklisted for some =
time
to make this a success.=
