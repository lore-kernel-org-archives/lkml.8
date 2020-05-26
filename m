Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1178C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0A32073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OjBHhlsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgEZJLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:11:50 -0400
Received: from mout.web.de ([212.227.17.12]:40165 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgEZJLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590484301;
        bh=/E6hvivA05+qc1qjF8glQbdVCkS3pOI33LGy9LvZcBw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OjBHhlsSjrq5qBmqWjzzLzEasa/486Rmy23w7FUyqw3/HinHOB/kd0kEivIamh1c0
         uhXVwEpqdtGjH+4AH8vJo/nTU3B28U1fEmVN5C1Hn+Hell1ONY+eVd0MpctuFaSYIp
         Zc/RsNTbqg0DRP8YBq7qXbCLnepEhLodfCUgRd0Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGOC-1jWITr2vuQ-00YsXm; Tue, 26
 May 2020 11:11:41 +0200
Subject: Re: [v3] workqueue: Fix double kfree for rescuer
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Zhang Qiang <qiang.zhang@windriver.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20200525093019.2253-1-qiang.zhang@windriver.com>
 <CAJhGHyC4XcNL8yzWZKZ=73wZJej4JwCaAHGV8qjYn-AqcEAEjQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5e1582ac-2f89-80cb-283d-57ba5003890f@web.de>
Date:   Tue, 26 May 2020 11:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyC4XcNL8yzWZKZ=73wZJej4JwCaAHGV8qjYn-AqcEAEjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:MN4RE7QSo/P9fckSg8VfDd5UiNXTdNAVQXC+XN4bydpj2dNbUru
 fZNtcT693mWEOu2anGh6MXMqD+FZ7G0mvCj5hqCpcDJxMAujczTyEarhbNC0aTCfbeHdHny
 h3QO0tEDQp7+F1oxLinCJFJrUZHZkh7+oSSvX8zzroOFazmQjIfCqXNhi9BgKPkeLElLqEG
 3iKQNnA5Q9+campRUIfhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xo+kCO12k20=:Sb7BFVxSbdVrGRCCBICOxf
 O2OUWMCNjfZpPG9yNgxsIvVHYvaurLFbd/MZ6BmBXfX5pxeBxRJxuZbgNcBqnUoIUx4xoV2On
 eE8nXxIc41CvKY1Ui3cwJPbvJ/QNmXaLTS7VzDR/7UtV/DVEjFcoECye1+yZzXmidhScbcR1R
 720u3MkNR6a9kSiPQSzQPbZT789rHHdcbEGaGEskgfvgFTquu7QCBY932ISrUxRL1ihR+BwSx
 A++nQb7nsWJg4Gx7VGtqY9W5DS2tAnFAstge9s9ke5EFynj9pbs4Pbl0BjYkLe/5B7W1CJHim
 tW0KrA/6tbVJXoSNKpAhiiFHPQOMQeo4EktohQQPz+OVPTlOQ7P8cInCH2tc/JlwVYnX0xOGm
 lUEKSbzMDLBTk94WOgu+zdv9fzE7/2yu2bF6TpHKLKmzQhmTxPVWg9HEswYd73Z2Q8tm/dJbf
 algoWDA0RH+8H9U06Z7DNQon06d+oR9q+OrthEW6wC7lceUCmFJ827Wj3VXO4NAxiEqCQhKg1
 XFyacA9pBEZPfGlzeXhbwulsdb0dbxXNKKoo+5wSVex1MqIHiUYBHx43l/8pQMO1BOdVXCKKZ
 ebTw3GWOASUYCxXLqci4sqU8YtCvdmH651cS5OY3b2TCrj5OBjtnxh1ABaYPytt/8U7BXSKYh
 uR2npvSnBgnXV8JF8VOFqUrOL8Bt3AmjtwNeMNHm257k8q1/a2wq0zxiQuwA48fBv5E+IiEwo
 BubExafiM7ripUqRJJXz/6SmZBRIQxErr+uullBl1yeIZDQQoQQcPamAAENjzD23N47m/AK/4
 k/GBysCqnIRFjO/ykyLvU9PaS74wcwIU0+ZrFXJhqFN9M2ixO2fIxB42D2+eJUbtyDSV9joWP
 uVy2ysFvYgB1xvREzc7DSq30zIbR1sNFoO1e8cI/FGucjJqRqNc11TsnjGhVxnstZDUUnvrMY
 +lI1nyxs1MJeglSdregplOh0heqOBHzuKUjvBMd52ZlOnEdUjnUeMR4GkDfBj5kRKJcLrLLiw
 OLh7m8yO+4rxdzcT94gcHX8qa/WHRw8URbL5O2izvcIP6HOzSCBgSSlYWXvT4KnsqtrcqKKLE
 gS8LlibQ6Ar9GbfgrnSjAryn40ryMiCD8AdIb5UTSvfz4/7WLU7OhwCNoMmywmbnG5GBNNwFo
 AQxw3Sgoe4vjCK917HWgt1ffxoWqvP94K4i4N6Ik4QosPgJQcrRLvXIcYK/qfg1YhtVs2rKYC
 AK2WBu2OpivWRer/Z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> wq->rescuer is guaranteed to be NULL in rcu_free_wq()

I was unsure about this data processing detail.


> The patch is a cleanup to remove a "kfree(NULL);".

I would prefer also an improved commit message according to
the understanding of the software situation in this direction.

Regards,
Markus
