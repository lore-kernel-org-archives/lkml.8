Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD020C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E922074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ct9Ob0fV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFAOAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:00:52 -0400
Received: from mout.web.de ([212.227.15.3]:50265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591020034;
        bh=e4M583n+ndEFe7uz2Jqv6SloIP8i0ix03FxgdPGGvhQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ct9Ob0fVIXFHh1FpSun13ZCyN6SGRqjW958I+rXjkNRBFcH4a+vUB9JQLnLli7hhV
         Mc7DXeXJks9HkufQx42nTt1HEnDeZqPitrreAekK9aX3nKQiawVZiyzzFdPPUWPHGd
         UQ003s8kf9SMzmGZ7IgI1DMmnKjivUqYj+Jfhayg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vNQ-1iwuDG2K6m-010sT9; Mon, 01
 Jun 2020 16:00:34 +0200
Subject: Re: [1/2] ubifs: Fix potential memory leaks while iterating entries
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Yi Zhang <yi.zhang@huawei.com>
References: <2bec05b7-78d3-fa36-134a-efbe977933e3@web.de>
 <45e2cd69-93ec-a0b9-b2a6-d170eee44055@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4fe27809-552e-ea98-ba1f-cbf68e625d22@web.de>
Date:   Mon, 1 Jun 2020 16:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <45e2cd69-93ec-a0b9-b2a6-d170eee44055@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Obc3LXDUWzNYAR7rOJ2xt8xMNqUN5H+O9DoGw784fRwgkHrQVxb
 oPmoTc6ELoffvar2f6rRfG01a9xxHevQlOSC4JPSHtoHGwgBhAySkqqvHyvUnF7mNewo3f9
 ccgHkfs68V3O/gOtGExNbcaL/IGXFSuUfLEjJ7tiCuBu1ogHJPDJizn3RfoB+6NNm3Ho+Pu
 ITaeuSIa912MCrFB1Xxlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VXWDgan85Jg=:B9USaHgU53/jTmeGtDUtib
 me6ZCwodrgs8hm3QQ/V+mJguGfFFkYvs1AYNUi+ekCMD1a/ylJfx7eAYKkNAwnGBy5U6p14lC
 8BMyu3+W+aJ3zw/3JVfqm+jcedtUPzya/7fWuc+jfetDinHEtp36rvo05KTbYwGo2HHlBFEEc
 EQJfGl3drXju9u2Cer6DOIU4RZ450Rs0v8C2YSayaG4GxSVwBpF+jwK8UoyHuG4By6KiKYrvx
 1KE/4nfc9F3wigtmCjQ6L/r7wpuIz+KgQJyDWJqSj7YW/VBmLNA01DgK0mjdmcZCu7SjGTvLP
 vtMAs+zdlEtHlRq1sNfQhBJOTTiDhFWbxKKWNeJXNjjN9fXFKfmKC89gF5O8NxmTLP0MZYWlp
 7RHa+3qeZY6ex6TwkwW08irGIV63EpzUSrVlYI9iyX8QLsiFbuPiiZ8RcaU77Enrnmj7EfNma
 gIqtVahHyxcliTBLdy8h8jfbfJM4sZP6fvpVTM/61IHx51wpuyw1nwtBkf9J+Qw7+Il/S/NHr
 rD7z7JugvB9jIs65yROpUUA2t2oYoxc+VlZkJtf4KCfxpdA4slvJMbxEkZXqxTy4k56lXBveg
 cmqzZLlroNOA7d1yMMHdrUQmXUa+gDedhBqwSICXcMdsnSxDZq1wObbDlWDY0kAwO5pwwy1RQ
 NhyHAlJP5YxmHGE+nOFWm+uZr/urxwy7bH3Oh+BDZnW5gZT4PxCE6lBEiw26c4M+Bnn9IXwzY
 ER3pzly8diSAd6EP+f/wByP377lVAFIzsHjP26aoTX1hZorG4pi4occqIF+FfT539ZZsb6wST
 GWfb0Sm5bFzl7ONb0AYWnyMtrrjcmL1eW4oqNQBFafsJBnLurg8SZLXXujsb6YJIGjfE8RoGQ
 iDMpFimtNUEpZCGJbiQKDx8oYESxnNo4fbHa/A4TQY+818VnGapYBfKgrZLwTlRSUIAhJ6C4M
 w+FVHQeMc+GW765Sbolp5f8S6vkPVtzONe/lgWgPCHRm07rOPwOuxDNEN2zqmMw2eOgT8b50/
 /aQKH1ZLBBu7DMhZ3go/azhu5Yiws+8q/G/ufUZEd8YU/qQ8aVWLS2Reda5iXFsUkHmNBsw8Q
 KsG8WIWuvDzaG1LbHhW7nRihjcQbFrDQEF/6RcWC1z7CXtHDOiFCYEZbTg7ChA46DOvZ3uM8/
 gQPh9hmDxru6oWfFcvgKXRR14+d/Bbtk5V/Kdvm/72AJoiOdkuNnhKCkxAaNiZVTo029uh7xv
 j7DOmAzaUpcVdd/8E
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suggest to avoid the specification of duplicate function calls
>> (also for the desired exception handling).
>> Will it be helpful to add a few jump targets?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?id=3D3d77e6a8804abcc0504c904bd6e5c=
df3a5cf8162#n455
> I've thought about using "goto err_tag_2" in kill_xattrs code block to r=
elease prev xent,

I propose to choose better labels.


> but later it needs to jump to 'out_release tag=E2=80=98 for releasing pr=
eviously requested memory,
> which can clutter the code.

Would you like to reconsider this view?


> It seems that two consecutive 'goto tags' will make the code less readab=
le.

How do you think about to try another software adjustment out in such a de=
sign direction?


Can it make sense to combine changes together with the update step
=E2=80=9Cubifs: dent: Fix some potential memory leaks while iterating entr=
ies=E2=80=9D
into a single patch?
https://lore.kernel.org/linux-mtd/20200601091037.3794172-2-chengzhihao1@hu=
awei.com/
https://lore.kernel.org/patchwork/patch/1250456/

Regards,
Markus
