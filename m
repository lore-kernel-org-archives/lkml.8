Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5704AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF44204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b5WY5hmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgFZMaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01011C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:30:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dp10so4359789qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=S0udzLIXNsb1pKVpquCqjhEjdkaBQJ9k9wIcZym0NIY=;
        b=b5WY5hmnBkDE3y2XYtD/XNpCJ64rCr6ywqQ0bplXtpcbBuu1NpQ0Trxyg8UIEeb6qP
         lUYQmRe+baCZRuv8dJ6XPXMBDpzyvPsqfIlGPyC0J7bH+oebIxSOOH/+rHSLPlB3NGlT
         racuLirYwlt4f5Ryxila0pI30g1Bp6xBsAPqJFqYsKmpM3trQt68IZATbehlz607I+dv
         IoIfHdROxwuq/JBedny89gA/ttl9oSi3f9BTG92t88Ymt/1dwKgLKoB5jf3GTWYE5g7s
         S88ARLcPPw0prcPSqlkbkn8s/m9gj383nzG5OyxtU7w7RdgRXU3OoTO8x1VxfoKjoBsD
         oMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=S0udzLIXNsb1pKVpquCqjhEjdkaBQJ9k9wIcZym0NIY=;
        b=MF3KYwdkNX7wXjq7+qWnz86ZH6gmpZKQRG6BPExdpPuca3MqBpAFrW31bHOJCAucgH
         iEH6VofalJjCDCTBr3tvS6RjDKMwIVqqKuFbDcyVeQALTjoHAUWOeBkgloQd+Dy+DQMk
         D9CLLRt7hV90Cw8D1OBjYbLhDcurEWqLD14LifNcfcDkikyY+IFfsrjVo90I7XSyNm+c
         4BJNeujhv/FsjncLrKoKXgrjWx2eD2Vyv2TdxX7R4taEhdQLozSlvxEYK3X25iBsNw40
         Qv7jT2P29F8gd7ocTAG+/TSXtxetmzds4VcF7xrRKa6x1X1dF/nkRHQn7G3WxHymmBfv
         0usQ==
X-Gm-Message-State: AOAM532SK+Vw7gHJgkwpWDu5bqm4vX2PgIKjjZuTQVerDkdrb8C9am9P
        mh4pbbakI6Kp5qV8gHGmvOwN2Q==
X-Google-Smtp-Source: ABdhPJzluXudaRNW5mQfKaLZBkHXd8Fo5a1PihnTT29QwORZ08On9+BQlkXaNj4UJJUksc7io6PA9w==
X-Received: by 2002:ad4:5a46:: with SMTP id ej6mr2895574qvb.52.1593174623247;
        Fri, 26 Jun 2020 05:30:23 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l3sm8723087qtn.69.2020.06.26.05.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 05:30:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] iommu/amd: Don't use atomic64_t for domain->pt_root
Date:   Fri, 26 Jun 2020 08:30:21 -0400
Message-Id: <63D91069-6A2E-4C05-8409-76A56D1E0FCA@lca.pw>
References: <20200626080547.24865-1-joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
In-Reply-To: <20200626080547.24865-1-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 26, 2020, at 4:05 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> a previous discussion pointed out that using atomic64_t for that
> purpose is a bit of overkill. This patch-set replaces it with unsigned
> long and introduces some helpers first to make the change more easy.

BTW, from the previous discussion, Linus mentioned,
=20
=E2=80=9C
The thing is, the 64-bit atomic reads/writes are very expensive on
32-bit x86. If it was just a native pointer, it would be much cheaper
than an "atomic64_t".
=E2=80=9C

However, here we have AMD_IOMMU depend on x86_64, so I am wondering if it ma=
kes any sense to run this code on 32-bit x86 at all?=
