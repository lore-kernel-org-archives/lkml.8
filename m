Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861DC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C485206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="M4OCk7h8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDYUZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:25:02 -0400
Received: from mout.web.de ([212.227.15.14]:35829 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDYUZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587846288;
        bh=rSJ+snTF/+b5pc5x/SxKxsrl+KZmrC5NPlxtGj1QIPs=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=M4OCk7h8VaZAvpEVeo/e38GXnm5iumxiqS4WqvuCxA5WNmRMsyLfE5wicRt/VUPo/
         9k7euKr1j8sRHhsXWgEyVG9JizC6XZl/ED+x6No5uhkRKcYaY4EJNaUFW+1RNI/mmJ
         rvRhHNZbM4v2dR4DnGq2jEL7rD+AASnum8o8jVsQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.160.204]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbQLE-1jj0Id3TzY-00InJ6; Sat, 25
 Apr 2020 22:24:47 +0200
To:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm/slub: do not place freelist pointer to middle of
 object if redzone is on
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ca36745b-1939-2640-aeed-390c8c39114e@web.de>
Date:   Sat, 25 Apr 2020 22:24:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:1mwfetGZNOZtlsPji7sJNMLFJWaqEpHeX5Jbd6dLkiTQ1DNZsoF
 AfnC79mNI95b3deYaw7R48gsJaFTPxtVjvoaorIAMdgXQ7yVA303Bj8Lrl2HJwctyTOibpn
 16JR+mvEODTkwu/0XwKNDId8fC0Jz47jVhiKWDhUX0b6jmGL/9XEh4yDFeHu/kfNWVM5XD/
 jAr7lu0QiKu9P1qy+ztkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JvCTt5YtcBE=:NiVQu+yrCgNrDWiFbvLgcw
 yyzo5GdjJNHr1bFTmsTEWRqLUKDvKtnDQDP3LJDaD+s3d0YNPkSyI6DnQdEQwVspyhHfVHqo+
 tG/P1cgP55qau6wCtSMc+jLb2R528j3eusIbP80teCXo7KF9JeXNH5lnuq77P+V48JgFq0Lr8
 vnVvJxEoC3H864TuHSxCF3kfzAiJD9mxFaQ5QgzSvHpb7WHc3TiGkNKJ8ZBtPRbDL3tJw2o5k
 uEFf+8YPnzZG24zK1HiNMEm4/VNdLP3IvrzN643uDP7y65TAM6Jt3YnSyUlHRso5C5khzczLX
 vfUQ/6nBEBe/yLFuV6H9fPilbgZkO6OjyxgXlJhmlyHxO0aQO2yGLNyAOWmZrB1PZVxoaRH8a
 CFe+xmhUeguF7xqqHMsX/Ji1WJ2gmj7LyEMeJOYZC6NkZdGnDUZUa8CmD7hvIXzwXEAwTMGF0
 BsSoFRVMOIw9tBgPOAyy0m+39c8bm3kgc12tV9v4BydDmjqG1j0tb5NsrTQ8xvi57Ih7azg5K
 mEfNJttbwKqbECT3RCndrF7P8+Mtc2iOT5m11LwB25+MEoR/o5uzG6LDKGovTLLhpz9hXdLzJ
 SfhFERkryvTFA5LKBUZ1AhZAdLKyGXkxPHHW3A/2bKvO0f8Mk8vF9vq1Y09IRU2bVOwP004yo
 hZUUAUE6Ia6GvEUskVWJCMshjtPjzM5PgQ/IeTmy/q1Sl5vaQeGfbh6W0KdBpRsFXhZ9frROL
 BB8BTxh9lEFn9Xvf2gI1nt6oVURaQCZ38OZclKRFVab9NswJfnB2jK0x8N/78+jPnRd7JH6mA
 97yIb9G/ErmP99Eowx9b1+fe4S5j0oneZZxiVBKcRKhiirH8CSCpCQ1zLdRmLzQG/cRnCkinX
 D3whHwtZHJWli3mjd81HfsVm26f3osQ2sy7qq2+KSZ6rp0aDB4VWxDQ3EVKhZ+993kRBdsmSh
 HXDI6qftA+h1Xvs5GZcl6eOcmdMTm4wZgwbkLCtNVNMPIGBIwPXhSpk7OT/iSlZBe/q6I72m1
 uGic0+J81ca+kd9Rax1OKgCp/Nylb54LIfWXOoHFQXNQu2dh0HHuDs9qRDYhej8hQeNXFYC6P
 DGIxELsDiHRf4BjNfwRFQ0nOFtaGj3x4l07jALTY7ZDPxPsGyPgycKEut8ExXdeinPlFAyEW/
 PGzAlzlG1p+/YpwHAs3wWedMr1m358Q7viZpQKVgtAx4535RVmn4zoRphENIgbO+Emif2IdBO
 MxpuZvh33AjhlIt5V
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes: 3202fa62fb ("slub: relocate freelist pointer to middle of object")

Will a longer commit identifier be safer for the final change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b2768df24ec400dd4f7fa79542f797e904812053#n183

Regards,
Markus
