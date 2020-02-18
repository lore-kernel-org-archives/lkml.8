Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31556C3403A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E49206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GB/rqqA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBRMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:40:09 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:43859 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgBRMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:40:09 -0500
Received: by mail-qk1-f176.google.com with SMTP id p7so19290537qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LWli3K53CEX1HNi+Tv/g1jNkXhayZEjclQo7y9gNLIg=;
        b=GB/rqqA7hJJg58RQqIcDEtDMUPNqc/+XnLUPmx/2fCLTZN+/K/5yEloHg1bvKV9zlC
         AA/KMkY98nxFljPtm17Vm0ox83jDH5DsVGWLqwHhwrVbmI9/KQST8UGrV0H7CQQSvPzi
         7tzCdVtXXWD7ONqp6UnggxilWwkOnD++koYl+FbVKiIM+aeH3Jz8GZNzDFOzBopfQQjR
         Y6UpifbOccA1y2UyL1AmVasK4x3ljvvSdCyux4ACz7XKr1W7xlC49rEpOFEKbwrRvkyX
         DMDRmLEOb4xW6cPwTKzM1Q8sUsyAOdhjk3xDaaFRCoHn2NLSLMwa9GRDQCosW3n+2tHH
         Ym1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LWli3K53CEX1HNi+Tv/g1jNkXhayZEjclQo7y9gNLIg=;
        b=bZ72aR9UVvEOm1KxcTbIr0GpiCjs+ssefMuTW1P++k9WNrDFRTewOPw1bfard2oH41
         eT99kEnfFpv1Lsz1QkyjyNqCNF8sX4F0+rx8Nf/cepsInFCzuSNLRhfBpVvO7mNLMlTZ
         K9d/5A1BkvDkLJ51yM6IYa1BzSFRifvPJ4FshgRSWO/o6gWzyu0gWbQLOkrSzln5TnuD
         zWnHIt1L6KMZ9S25zqJ1xa5uKFtU1JPEKz1Ou2wVFA2dq+5RVt7wyE85/4yLAKgGlYtP
         TCDJI5g4wtWOKlMShGTfcuHPtJsrgaRngkae9U+faCf4Ix2yKbEEVoSklLvl6nm7czVl
         ceGA==
X-Gm-Message-State: APjAAAVEtgI3muzfF4q4Trm8g+bbMX4pxWIIFF710osCIvWJ17+qyMr3
        x9o+/WfgiQGPQlGED68xj3FHiWfTcl/3lA==
X-Google-Smtp-Source: APXvYqyd3eazdTC7HD2pIOmHzLCRMhVj8/vlWUZ0zIP2gj/268N8Yf0idWhkqlXqQcmCRcrvbt+AHA==
X-Received: by 2002:a05:620a:4cc:: with SMTP id 12mr18079991qks.153.1582029608059;
        Tue, 18 Feb 2020 04:40:08 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p18sm1846908qkp.47.2020.02.18.04.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 04:40:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
Date:   Tue, 18 Feb 2020 07:40:06 -0500
Message-Id: <93E6B243-9A0F-410C-8EE4-9D57E28AF5AF@lca.pw>
References: <20200218103002.6rtjreyqjepo3yxe@box>
Cc:     Andrew Morton <akpm@linux-foundation.org>, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org,
        syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <20200218103002.6rtjreyqjepo3yxe@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 18, 2020, at 5:29 AM, Kirill A. Shutemov <kirill@shutemov.name> wro=
te:
>=20
> I think I've got this:
>=20
> vm_area_dup() blindly copies all fields of orignal VMA to the new one.
> This includes coping vm_area_struct::shared.rb which is normally protected=

> by i_mmap_lock. But this is fine because the read value will be
> overwritten on the following __vma_link_file() under proper protectection.=


Right, multiple processes could share the same file-based address space wher=
e those vma have been linked into address_space::i_mmap via vm_area_struct::=
shared.rb. Thus, the reader could see its shared.rb linkage pointers got upd=
ated by other processes.

>=20
> So the fix is correct, but justificaiton is lacking.
>=20
> Also, I would like to more fine-grained annotation: marking with
> data_race() 200 bytes copy may hide other issues.

That is the harder part where I don=E2=80=99t think we have anything for tha=
t today. Macro, any suggestions? ASSERT_IGNORE_FIELD()?=
