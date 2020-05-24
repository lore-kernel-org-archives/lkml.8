Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298ADC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD41207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eNTRFVPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgEXPdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:33:14 -0400
Received: from mout.web.de ([212.227.15.3]:57735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgEXPdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590334384;
        bh=RvgPa4HlNKsPOWlekAAfTVT3667QgjoEs86JI0r2Qeg=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=eNTRFVPAcfD0k8Jgb5em/LgdMeU+YlNZ8Qgd8JbhW2S2pFuv3bvTPH+VpX/iQSzpz
         1cCt9LsQTPro0tmPVPaJeMRQvI/oLNinUDe+NOWXbemvg2T/nKKAVfybJaR2Wh1Okz
         AZvUQh5FMcRuQ1JS8bU8uh00aM1ceH//hQh2OVyc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1iv7cc3Phh-0101UC; Sun, 24
 May 2020 17:33:03 +0200
To:     Zhang Qiang <qiang.zhang@windriver.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix double kfree(rescuer) in
 destroy_workqueue()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <96b49f22-50a7-9c8f-7c9d-f178195de717@web.de>
Date:   Sun, 24 May 2020 17:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mOD4CB+9dD1DHW4Qao41dV9PM62AVLbj+yo4k9fbpMtKkcvfpEk
 DVg3ALUHUigWgIp/rjL6mv7gF/b+r3j/YBENYb6uF9GlRmqaD5pGEI6cN5aYpXO8JZFTvB2
 jaR2SAQjjW0wdBsiD+TSD9ShZsFKj4RTRwHOQVlwIBh9O5ZyzqSlqbdfnp1VUj6hgjTWplh
 gqsmI0JYFW2Ob3Ls1fS+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:peOpKegWxJI=:U28k7U/C75VtPYdRc2nV37
 w926RpLs7NjWfbkEz9+n5osTFLWAPTB5SfCIZ/lS3YOCyGeG9/BCevDlM8HdfqVDhH5zufOfP
 ijI8lI3qZqmcnt/ITwL2kQIyrRyxE7rcF0uF1+i2gL/8/fcHyooaey4HyNeLMFvFP642zvMkm
 15+oNVq7snnxLUF7MYbC02bIDbMp3Ox56SQFYNzWr5DpPYu8JhIK18Yc0y7BvVbywgSVnTdJU
 WDwwotyOkJ3Dkqwc01V28PVLk6hdkTClGF9QWe0oBDjIR/3yk8GZKvaLhiAxfE3TXSEI7cNs2
 lXNoqsinenrQa5nzrKFnzJPeN3BRvLfCinVJ0kKFsh4tNDpoAAe8deAuTv5LfbJJoo4ZLlR5z
 WFzKmTFMGsMCjmfKYCVo32L5jMInnc7/85856id8rZB6YkiD2WIk3nzIG/f71AU94o3NVoTvS
 mRTfxx0PICE5kCRjVCp4I4xH5eTJohH9NCw9vm/RaUtj4AbyVCGDPcTZfdWpZTdNPEfbWeZAX
 5yWKQYOzlBENL1Fr5sHDu+wnmpq7uIW5gJNfCTp5IRk3Y3Kr7WSUSrL4Kld+nf9ZUkFralGI7
 RFn8bv2oWxGqnCiJU2dPKx3LArCkVTO7aZcwQPGkO7Ww/EjZrE6zxQMaT4QmLduv8Ynm7/rY3
 8EKXWW4Mui9rr5RI11XPG94kkgRv+opEPbMav0toTp3rW2lXakewbwK4c/mlCF7Gl5jfIKwjh
 AFtMImG53eO278ojqYSsNr6puvBzR+AzHd7s5LlVXVi6hWDj8gUBBsu2EMQWIRNEoEOseZ2zW
 jHdCe7ocVL+g8W8w10kuCTr6fUZ9XGKgqMZwmS9l9iJ7xRuJnF7bm0HmYuBSO+yIFPhVW+d3l
 TzTL4/2xMcBsZ86gq8JUSeDdP3BDUaVZvNNmw0HRSSi6lDBA6p+7W7CyeTF9JvpwT0xot/yxQ
 YVoweT4wXyY8vntujWYCXsa99eY8EQOPcJsnVdU42+XSpM/yCyJCkGqHRB/6VPI3wLkgX5p5I
 JLWwlH5FQcZeFTxSKvURgXBhZ3plcYIVqMo0mkBnsRnLclTbFyGY+p6Hp9XqOD5sqcS3GeSTN
 hV2zTW+vmboeZdPHhIBrkttQwpoKJnd/8syxi8AUZLrv9hf57g1y/OeCWuwSEl8W3u3auaAC/
 yhyAqk344nrqJB5oxWNWVySIMEebFIBtHa3Gd61CBCKXBOLNFGxWBIIFQ/V1jS/aX/U4tdFDZ
 X/RVmd9KwcQXK6b4n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When destroy_workqueue if rescuer worker exist,wq->rescuer pointer be
> kfree. if sanity checks passed. the func call_rcu(&wq->rcu, rcu_free_wq)
> will be called if the wq->flags & WQ_UNBOUND is false,in rcu_free_wq
> func wq->rescuer pointer was kfree again.

1. I suggest to improve also this change description.
   Do you try to explain here that a call of the function =E2=80=9Cfree_wo=
rkqueue_attrs=E2=80=9D
   (or =E2=80=9Cfree_percpu=E2=80=9D) would perform sufficient clean-up of=
 system resources
   in this use case?

2. You proposed to delete the function call =E2=80=9Ckfree(wq->rescuer)=E2=
=80=9D from
   the implementation of the function =E2=80=9Crcu_free_wq=E2=80=9D.
   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/kernel/workqueue.c?id=3Dc11d28ab4a691736e30b49813fb801847bd44e83#n3482
   https://elixir.bootlin.com/linux/v5.7-rc6/source/kernel/workqueue.c#L34=
82

   This function name should be specified also in the patch subject,
   shouldn't it?

3. Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mes=
sage?

Regards,
Markus
