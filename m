Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFB720714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q2bpaFQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgEKRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgEKRKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:10:30 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630EFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:10:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb4so4765573qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s3MqmJBPH7DhM0m/q2Mzg7C6aYh+j9doHOTSnhJ6rpU=;
        b=Q2bpaFQwSLabQ46lMjS4T2LDI7Qd+GxFXvBEohZUuNClYtWo4rTAsLLXRwo63GSq6U
         eGos553fK0vUmynlLWGWmDHsaitdAoNHDiLZNFteh8XeFH677nmIn7hp0nrwHTa+eVuS
         +F998gEJu82Aoge8UdY7lQRiRnuLV36extqly56wr4U35dg7UwoVTvE0hTpbE4J65gC7
         g0exhPLLNqlEeQQGqect1xaVM61WNmZ9WxG7/BZb0EVEh+GmS20SR50ShAU/h6+FJhhh
         YRYI647Qtm04IAGC3Szt373Yaw5x/v7kETdoPo7udtvAGUFJvOY3BRrPdUjr24g5hu3F
         /BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s3MqmJBPH7DhM0m/q2Mzg7C6aYh+j9doHOTSnhJ6rpU=;
        b=iRIG0OE2xtrmZdExNReXZKAxg/P1/KURJKJ1+AeUouHYFubeSo9dFHgUEEp/tJa5tc
         AK5p52Bc7gEnguCCjHEPr76HnpdHhiI/lylWPdImp2IQsHt5Ba0WvBEA0oBPCCgOjYRu
         k5ZQG4zMj8zK5jpKWmEKn5iq48eH+yrBITAyXQiGyJ6PeLTgP856LWxsNvDbHoi/thWy
         AnLyCn7QI2VyqwWRbRR1gnp8rjjp6CABkxjJVtM+9j1kv67wAlVqtG0P3egYCL6F1KcN
         ms3TPeXvoJPwaZMiYbkEM6wgJhMaV0k2+/zm/99yH0To+nB6mlGOvcBnAz/bb3ol+YvG
         Bpvg==
X-Gm-Message-State: AGi0PuYgYp1+vbVFIVinohnz6XBbD8Yj1IKqGJ3okHHUtV2LmCcQYUEf
        63yYxGv+aUPR0fvawcUxx32QfQ==
X-Google-Smtp-Source: APiQypLP+Z7KDvamvwcS98cH+8t9lisBxi2JtdbnhaEoj4iwvx9kJ8aatEx0APHQqPJ1iphG8fR+DA==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr5256344qvx.104.1589217028474;
        Mon, 11 May 2020 10:10:28 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u190sm8777818qkb.102.2020.05.11.10.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 10:10:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in osq_lock
Date:   Mon, 11 May 2020 13:10:27 -0400
Message-Id: <D9C5B7E9-5927-4015-BC7C-202585C5649E@lca.pw>
References: <20200511165441.GB23081@willie-the-truck>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
In-Reply-To: <20200511165441.GB23081@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 11, 2020, at 12:54 PM, Will Deacon <will@kernel.org> wrote:
>=20
> Hmm, I don't see how it can remove the cmpxchg(). Do you have a link to th=
at
> discussion, please?

lore.kernel.org/lkml/20200211124753.GP14914@hirez.programming.kicks-ass.net

Correction =E2=80=94 if compilers could prove =E2=80=9Dprev->next !=3D node=E2=
=80=9D is always true, that cmpxchg() would not run. cpu_relax() should be s=
ufficient to keep that =E2=80=9Cif statement=E2=80=9D been optimized away in=
 any case.=
