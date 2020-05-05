Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C109DC47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B40B20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PLxoH++/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgEETAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgEETAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:00:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF8C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 12:00:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so3456750qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GL8YJhagmr0tY88vQYg8nNJwc2RX2WgsOSH+iUm5Ykg=;
        b=PLxoH++/yyfuORzgoSUMi8+9wHSL4/iBxLjFFQCziWAODruKOY8aWMCJ3PL63O01p6
         25TvRIvBTL0olryOCHVe+rJDB+YKESxFqnzLRYdheZCWTBmQS65FAbJo/A5bNrcJMVQv
         QQzx5+x4xfF/d6+LvRG8TE9Xa1Hv54kUYu4MicCAIpMjQahvcqXH1u0eyzSC3cKgSx3F
         sXEQiZIomrwDrNCWwdF7BvnYl3TWqNWZjoLyULrJwJrksYIHaRh8ssyT8Ea41CJG5Wsy
         Ry/9MZrQT0KIwKBBvYn74fNzfBhHkrqCqMUQvFyvNzQOQyzzeugg9I/zXseBfcma9J3e
         xzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GL8YJhagmr0tY88vQYg8nNJwc2RX2WgsOSH+iUm5Ykg=;
        b=Lm2lcKWIy/8dqp7kSesKnOyRZZFYAfq0bxf4ZAB8H73ogvA2/bVC4i7qkvP9WebWyw
         W0lsNfYVbqTNgWbhERbw7kg9ID6BsGR80m9GKVTdTefncEpGM6h9AXw6EbkOcNaDWfTG
         jGx3pY8VUC5NFnBHOdMXcP0li3H9R1pBd6fw4Pf0LL38moqiyBmMH3KF2GXRFBGsU3rV
         4ddHMR+I9nU12v5C3iX18oOWx18ICJ5dtS0D8XEvLy8BJv2i8b06Mu1Zblcm1HCrkWPT
         GKqD4W36nPXJ0EpXIvpwDfu/zP1dE19y1l+t4SaVVmWpx/o2NjSW0D5yuSDqXG2iiXqD
         qKSA==
X-Gm-Message-State: AGi0PuanFpFnZEftP2wbaEUbd5S+VBy87Foah643Ish8EYNLEL3Lxw0L
        WBTMGmg2EYtehufiwHzE6wf9zA==
X-Google-Smtp-Source: APiQypKlB2SJjOgo2QNo0+920N+E3iInb3Z7GmJ3C4z4rOKuQVKs3mtv8XHi42+Up8m6GIZeLEq4Bw==
X-Received: by 2002:a37:6145:: with SMTP id v66mr5004657qkb.458.1588705235839;
        Tue, 05 May 2020 12:00:35 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z65sm2563832qka.60.2020.05.05.12.00.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 12:00:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: splice() rcu_sched self-detected stall on CPU
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200505185732.GP2869@paulmck-ThinkPad-P72>
Date:   Tue, 5 May 2020 15:00:34 -0400
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8678900D-8D52-4195-A767-9E6923EE0AAF@lca.pw>
References: <89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw>
 <20200505185732.GP2869@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 5, 2020, at 2:57 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Mon, May 04, 2020 at 03:11:09PM -0400, Qian Cai wrote:
>> Running a syscall fuzzer inside a container on linux-next floods =
systems with soft lockups. It looks like stuck in this line at =
iov_iter_copy_from_user_atomic(), Thoughts?
>>=20
>> iterate_all_kinds(i, bytes, v,
>>                copyin((p +=3D v.iov_len) - v.iov_len, v.iov_base, =
v.iov_len),
>>                memcpy_from_page((p +=3D v.bv_len) - v.bv_len, =
v.bv_page,
>>                                 v.bv_offset, v.bv_len),
>>                memcpy((p +=3D v.iov_len) - v.iov_len, v.iov_base, =
v.iov_len)
>>        )
>=20
> If the size being copied is large enough, something like this might =
happen.
>=20
> Is this a CONFIG_PREEMPT=3Dn kernel?  And is the size passed in to

Yes, CONFIG_PREEMPT=3Dn.

> iov_iter_copy_from_user_atomic() quite large, given that this is =
generated
> by a fuzzer?  If so, one thing to try is to add cond_resched() in the
> iterate_bvec(), iterate_kvec(), and iterate_iovec() macros.

I=E2=80=99ll try that.=
