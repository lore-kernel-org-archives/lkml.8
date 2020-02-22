Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8263C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C007920707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LrZLayjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgBVFXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 00:23:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43707 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBVFXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 00:23:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id p7so3955294qkh.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 21:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=IBBznMQ3bpiql9lX29jMw8rTRB5UTkasssHzmZ7+M1c=;
        b=LrZLayjPzm6EQLYSudY/2Rq4gWifOId4PQrAAT2F3r3h4NRgVvIhbC9wOx7dlx1Tyk
         WYPz/nHQ3vkybT2k2xkip3nUM4f72z609ZgHuowVvxaTzPOYtt/rzDEr2NC84AIv8CXR
         U0opX2VzCXA/HJ/qpCXLc9V2nv5DRytdGovTfs1rZAEOs7Y6qmGvGpAdfto34hIsA8Ra
         pkfe+e2+ciVrJ92OSsP2KnSO+hNJDpQYdRs7y3RPJ+SbfCtXmkkIIvCahCwn6T2Unqfv
         bBKdNSO98xMr8l4tnMagKiMmWhHFfKIKh6j29waM9bi1stIdadM5rNWv1myS2PUTOZqY
         FLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=IBBznMQ3bpiql9lX29jMw8rTRB5UTkasssHzmZ7+M1c=;
        b=RocLhQrvIgIDtM95DdG7qdNG1lG2N+aYzhLy1KWu+DF8hdF7Djc3L9gaGn/iqmF5O1
         coxuU8MK3b+uJHj2AexrmoTdi6PfKYgr9utsvUNryUyrpfRqejqoJyqoGdXIjWwejKSA
         DpjLY+qhr3SGVlzgV3IlC9czXMLbxXYAn9O81iEdoiQ+hpLpi1Q2zqOqIBO4JvvrheE5
         A7h/zxDVfMLtMaQm/reSGkNRFuEdg64poBAQytUi6/TNrDt5Ohab7fUnBo40Qqzsq/J/
         6YTrN0ZOue8I56RlDwqSUtrf0QSl8zxFwlVMfEB23qbmnqh/9qUiOC5RjNvi40DFiF0S
         yVXQ==
X-Gm-Message-State: APjAAAUE6JCI0+DITJ5MZZa8p8Se38MRcaOmdGpWJPIl5DoAvXEIUfYN
        rwWlpkvXTJ6RgfyNB9AagNfopg==
X-Google-Smtp-Source: APXvYqxGJcaAbkb93bWjAuEqI5MWehvGgfWEWF9ozw2izn5dANYgU464h3LFov9e+Z+7R98DjY8LlQ==
X-Received: by 2002:a37:bc06:: with SMTP id m6mr21225596qkf.383.1582349026611;
        Fri, 21 Feb 2020 21:23:46 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j30sm2612022qki.96.2020.02.21.21.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 21:23:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Sat, 22 Feb 2020 00:23:44 -0500
Subject: Re: [PATCH v2] mm/hugetlb: fix a addressing exception caused by huge_pte_offset()
Message-Id: <C4ED630A-FAD8-4998-A0A3-9C36F3303379@lca.pw>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, weidong.huang@huawei.com,
        weifuqiang@huawei.com, kvm@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 21, 2020, at 10:34 PM, Longpeng(Mike) <longpeng2@huawei.com> wrote:=

>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dd8737a..90daf37 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4910,28 +4910,30 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> {
>    pgd_t *pgd;
>    p4d_t *p4d;
> -    pud_t *pud;
> -    pmd_t *pmd;
> +    pud_t *pud, pud_entry;
> +    pmd_t *pmd, pmd_entry;
>=20
>    pgd =3D pgd_offset(mm, addr);
> -    if (!pgd_present(*pgd))
> +    if (!pgd_present(READ_ONCE(*pgd)))
>        return NULL;
>    p4d =3D p4d_offset(pgd, addr);
> -    if (!p4d_present(*p4d))
> +    if (!p4d_present(READ_ONCE(*p4d)))
>        return NULL;

What=E2=80=99s the point of READ_ONCE() on those two places?=
