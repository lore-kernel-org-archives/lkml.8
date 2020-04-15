Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AAAC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961A62076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UM6SN3Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506133AbgDONM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506119AbgDONLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:11:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:11:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 37so1611562qvc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/QIKserTw79MFF/nc34fMqsusz24lv5rpyROYPfDx1U=;
        b=UM6SN3EqhSwlevYG5up5G/MVKNV8Hm/GmHi61XZrWnjrTGZULze8RumGl1t686X+GR
         9aSjsEtssmzr999FMD7vT7YUE2ApEVTIGixvCA4FK7Ho3Q5bysXzLjivfVZSm3aCy059
         rwBMhWkXQ7narvGATZvHWJBnDP15sE9Otrk/5rwA+FM++vFEECsDKAnZncUD4wlsiSps
         Rc5NtjYoRKBodDcpDxnTvEflEXN6UHh0A72UyWWwZWUe1+dm3ghECsQw3EUyduF06edt
         EhxDCHEZ9QZ9b8BfgDwE8x0g7nFl75RZXnq9D5GhJOTpI+boV8MyEZg5CBO8nQFsObnT
         /tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/QIKserTw79MFF/nc34fMqsusz24lv5rpyROYPfDx1U=;
        b=KLdOmAwSVhjul/ovnde0S82FWfP/zMdlGbsv+0AmDxjkJmed+IX75ijah0/XsVu5Is
         CLMuJfw7UWeBwlh0E/zTw8kid4KiBBLmZgamCZKmtC/ZjtF1pwoBOs+8aFr4pzhlXJIX
         ZtCcGoA1Mq2800xJaxm3sJiz0voAE4FLRE/p4Ku83T+YguW6dcosq9F1H9fc2CFNZfdw
         67ayXaCf8F2OA5+Re27l1Oc9exNeHim9Yumk/JKtBjt5CID15nImXrlxqQFHwvtjG6qq
         r8cwfXii1wJS3npIXGXZ3oSmB7eARNAiaZJWOre6SQLNYigDJhRazm/BNflKd5MYPhcK
         lkvQ==
X-Gm-Message-State: AGi0PuZo/YTTBbFYETZmLku+2UoFAQZ0n+njjyHlrVzBpK6/cmVIGbrh
        ownFwpm5gTGfSxK/LignuAp7Kg==
X-Google-Smtp-Source: APiQypLvrR2fhdDKgLOYjTSA6uEMAQ1Ow6d6ETQz6hmcTm/uWQ+bcsCF4NhpnSFV4V8vhEEcLyEJBQ==
X-Received: by 2002:a0c:f1d1:: with SMTP id u17mr3990965qvl.146.1586956309603;
        Wed, 15 Apr 2020 06:11:49 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o22sm2242116qtm.90.2020.04.15.06.11.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 06:11:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: linux-next: not-present page at swap_vma_readahead()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <875ze1yvrj.fsf@yhuang-dev.intel.com>
Date:   Wed, 15 Apr 2020 09:11:47 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <247681FF-02C3-4FB6-BB00-720114EA1558@lca.pw>
References: <874ktl1p7y.fsf@yhuang-dev.intel.com>
 <A6843BF5-6B4C-4A75-B68B-133E8FC77955@lca.pw>
 <875ze1yvrj.fsf@yhuang-dev.intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 15, 2020, at 4:54 AM, Huang, Ying <ying.huang@intel.com> wrote:
>=20
> Qian Cai <cai@lca.pw> writes:
>=20
>>> On Apr 14, 2020, at 10:01 PM, Huang, Ying <ying.huang@intel.com> =
wrote:
>>>=20
>>> Is it possible to bisect this?
>>=20
>> Yes, I=E2=80=99ll need to find a quick reproducer first by analyzing =
the fuzzer=E2=80=99s last logs.
>=20
> Can you share the reproducer to me when it's available?  Or the =
command
> line you used to reproduce it now?

Sure, the current reproducer is running a fuzzer inside a container,

(It requires runc to be installed first.)

https://raw.githubusercontent.com/cailca/linux-mm/master/runc.sh=
