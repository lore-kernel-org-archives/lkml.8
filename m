Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF7320732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xgmtiae8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392886AbgDOCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392857AbgDOCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:12:58 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F8C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:12:57 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w29so11670192qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=weMkaAzvj+hNbtrjRlRPzxZwIHavPYeWyFMYBU25sik=;
        b=Xgmtiae8nUbIEdgsCQHld1vRSUyRZ/ofQvJgNxnN529QqtT2ZKXEOsBLjnaM4XCdeK
         5+1Rjg/vpOy9/MQedL5PAUK+LW6t0uc4HEv+uVPiVF8tQsPBPN9r+gqzETnGqId7oAaG
         Lov1fTdz0G0CDQGUk3tuFtVkV/m0ab01qgqCwybUrc/A9SrfHbS+gqyJ+qscuutZH1a/
         koVjEqQ4mfi+D8VKtfWD+3PXB2i3p7Vsz0qAcNMj7Fffv7tGMDGI2Jkq761lMYal0FDI
         PhfReT3ksKxk65S7MxhLm+Z2+IUFPmL6Nle7QNs6zptcFPOovTu0r4sej4Objx0WXbsP
         vofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=weMkaAzvj+hNbtrjRlRPzxZwIHavPYeWyFMYBU25sik=;
        b=jfGwFoGcS23Ft/0yQMi6rkre8Z53YAJNC40J5ZTB4bFD1h+cq5kYQKJnuQMAuaWExG
         FSKmDGhwSsWHO8Bh0H6GVSl0waOz5IF6lEMhnO+e9gv/xv0k91MXZ4km6s4SKYy8NyBv
         2mnfg3V1py/UtM6C1W6dGWwigB7/atshSAltN3VZIs9CSfJ0ehM0YYwd8TWl4ovL7O6/
         LvwM0rcaAmGqqApmTn5OOxmsJbEAie0dpCKzaNXBGqTT3RJKMiTy3xvpeXOH28Aer3fD
         GmajwnJ1WLEjjVwhDZEuN9OoxrWJ6NiuPgxL2ZwC7lCQfZoRsDEcrtb7ncLTeCezd4Cu
         04LQ==
X-Gm-Message-State: AGi0PuY62LLOhOMgCewPVRmCoaHpTKcptGDvH/bMVhNU6l2R/l1hZCwO
        TkQ6WiZLEiD8ZU2DSReaiOx73A==
X-Google-Smtp-Source: APiQypLAjQWB+0il0HKEp74O2EwU16oS+GcYNyazJNkeYdEYPb7fFVtkodIl1ixmtjnUze8zo/dbng==
X-Received: by 2002:ac8:164e:: with SMTP id x14mr12376094qtk.196.1586916776684;
        Tue, 14 Apr 2020 19:12:56 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x16sm10973949qts.0.2020.04.14.19.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 19:12:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next: not-present page at swap_vma_readahead()
Date:   Tue, 14 Apr 2020 22:12:55 -0400
Message-Id: <A6843BF5-6B4C-4A75-B68B-133E8FC77955@lca.pw>
References: <874ktl1p7y.fsf@yhuang-dev.intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <874ktl1p7y.fsf@yhuang-dev.intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 14, 2020, at 10:01 PM, Huang, Ying <ying.huang@intel.com> wrote:
>=20
> Is it possible to bisect this?

Yes, I=E2=80=99ll need to find a quick reproducer first by analyzing the fuz=
zer=E2=80=99s last logs.

>=20
> Because the crash point is identified, it may be helpful to collect and
> analyze the status of the faulting page table and readahead ptes.  But I
> am not familiar with the ARM64 architecture.  So I cannot help much
> here.

It happens for x86 as well where the trace is in the first email of this thr=
ead.=
