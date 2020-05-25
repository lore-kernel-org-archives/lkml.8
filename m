Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FAC20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Se7r9aA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbgEYJzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:55:15 -0400
Received: from mout.web.de ([212.227.15.3]:45191 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbgEYJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590400506;
        bh=7r8ZING/UJm6QJnR4xMZWyZcAOsoA7IVK723b7SMWgI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Se7r9aA9U9Odihgl3tAjt//Ub4a9x/QHIgSqbPNi3UWmWFFWeVyNoQ/hMFIMEmOVR
         AdawboeN3lvLduW09hvncZUpBWYCvRU7KWyveVR7oW/lOjgFL71Y2e9Av0DfVmwGpC
         WERC8/uHZaURFSTkF75sevPqUNu29I+RlVAnvlY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1jZOIu2j3O-00WVjw; Mon, 25
 May 2020 11:55:06 +0200
Subject: Re: [PATCH v2] workqueue: Fix double kfree for rescuer
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525075901.12699-1-qiang.zhang@windriver.com>
 <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e7d637d0-06e2-25e3-9af7-8c4668f9172f@web.de>
Date:   Mon, 25 May 2020 11:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A2nqinC1u9ZUtltO6CX/3Ndkld8EOakMcnBsDHbc8x+TGhbw6/B
 ykxWTdMWiXnS7pGPfPCLA87JG+dn5nTdo5EmHqlSMq6D0dwcjCw1lPMa/yXvXaNVlPsVEP0
 BcAay3y7IFvAqph+2HTqRXA08MBC+8bIyjTpnbh4JT3kLzMqeG8qB9+hH74OUaJmUHNuZQT
 rEy3l1IFCxy3t3eAYW0TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aafKFYFSKrM=:M57tAMuitLUmVhpi8928B2
 fPu7gSANOvD/0XHK6YEMRINzcZYQKtmdowwQ7Ooyd2kxudqb8PBVInVXANfmBSIi7JpEmHxzy
 j/Ix+sbZB0GXmhnjfkkp8cATDNaQ1YuKmKl5KnuutUUPjmmupNkMFauDt6dCT5T4okbE0eOQy
 IKgBVqFsXaotWSDw9ES/f2+s1+9oH0Gc+S3s7X0QjcdmN0IlrHII3VmubCs8O4x+77Fw4yU6h
 hCPEM9XQxS8HQx/QWUzLksPim2G/H7HEaUQM2e8bZ/sMR/MXux3V7p8AigtsreAJUJ/RHNJzD
 xdW4beAKDl/gGP0WIaHsSJVH5tPSKr4xJJP4gc43L9/2eee3fJt+9bhgHSKkc8YgUUn9egjiH
 xaIw5r8LzIvvUJC+qbwvJNSURdQt2vxcB1zqBFWb4/hXFNB3/p7P+zgb009YSR6rX/iPOUdYZ
 a1yVkIoIm8NuvfkObFZowZxkHtxYVhqPbJWG1nki/8LRVKK0Om9IVkLOAfWT+h91ceMNN8vsj
 YRDjuS1UKFae/DTcAkAedHc56bCbskM12zAbPCr6Qjbu9+hLpas7kaaIGTuh+soj8S8AZcc1Z
 TvQDo0aKH1q7+4688bYekuJ1ljjg3w3RdaBbnI0tRzbHYIjJqs//J9eaRKxu7uwpUWR7W2Kz5
 4o0f8UW6CsgJsjR915Ra8cGqt7W9XSBD2o07gxqx3Kq+AsIUX5cJliCRabc842TgKOVHcOa9Q
 9aZFTHFKc8FivFL/XjKTwyUBjjOo75D2Pnsr7JSwiCrEchcwV7aCkiqMYlcecApSzM/p0JnDI
 X11GoWFicyED77teEiz3J5j/0xWAo8quvYf+watAmtnJdhCFVBI3ymLdZK5EaYBfZLJjulyap
 Pa0sRrknd//VKxMMJfZsXiZg2aQ6lzDGpSNwy3Jyuc9AqzmHrafRHynZ6iN0odW/p36/wJfBB
 S6HztM+/t76mTxb7IEa2FFnLZRD6GXFPY4s+5a9aXf704d6OWEAlSMgvdYdN879qM30WEsGD2
 wOX8z8FsrI98PqeOvxDopceKa6HJx8JUbbmlmD6zIo4i0DTK82QAjeM5t6DZI1dllXrnR0RZJ
 DCBPHoMImHZCU8ShV6JgaO3gBwNHeuE4RL5Za1ErtzN3ttwCj63qMQguGDvSoD6+4GkAoqokM
 n+kpiecNetWudVteYNfYu42hUPl8jzBQWEvE+KMPTtEF/9Ra0cx4sg4h0bHz2xS+coSKMoKzc
 SMqWJqLusJmsQ71fv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * The function call =E2=80=9Cdestroy_workqueue=E2=80=9D can be performed=
 there in an if branch
>   after the statement =E2=80=9Cwq->rescuer =3D NULL=E2=80=9D was execute=
d.

Another correction:
* The function call =E2=80=9Ckfree(rescuer)=E2=80=9D can be performed ther=
e in an if branch
  after the statement =E2=80=9Cwq->rescuer =3D NULL=E2=80=9D was executed.

Regards,
Markus
