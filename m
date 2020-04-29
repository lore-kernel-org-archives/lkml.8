Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B267FC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845E32076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="l3KuXR/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD2JNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:13:41 -0400
Received: from mout.web.de ([212.227.15.14]:36297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2JNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588151596;
        bh=1BweQgHasxQrSjF5VALSrePBAU5svFDbgB2qktIdPgk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=l3KuXR/Kyp+tLbmjrndpLlCfOAnsuXq4ZhSq9VWIWrUgAZxUkdA7cFY0IFIWeR2/I
         UWtlag43otra08l6XZDtvquA86TrbVuHYHO47QuRKr/fjWKzz/SX77ON7W1GApQEJr
         4lglfleelSpNsWIx+lcjonueSe07CnkEZNAgWGgE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDjw6-1jOpUI2HbK-00H6ZL; Wed, 29
 Apr 2020 11:13:16 +0200
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Wendy Liang <wendy.liang@xilinx.com>
Subject: Re: [PATCH] mailbox: Fix NULL vs IS_ERR() check in
 zynqmp_ipi_mbox_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1931070d-77fe-996c-3ce4-5400b1bd72cd@web.de>
Date:   Wed, 29 Apr 2020 11:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:ZdpsNbZsm1yoJZS2WFw929GDSRy3XKFwqpygIHe3Un5tFDlqiXp
 0HLLT4H1nbT4JE+3tM3UZo83CCefgnkd+pJLUiMXFUb/BKrBfyP9mDPpnuDuebnyNjYU0v2
 pcas02sj4nqZ3ZDP13TQQ95D8SO1qUFKFR2A68cmW7s2e+DTslP0F0wO813aeDT0TxAXPLM
 LvHWVn4bX9fdLIAzqaDXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EjB9z6PByP4=:R/Q3h86k0Jjry4eHCX/88u
 WZMkZNJwE5om2HrBaA7rRriUfmAd4v87EEE1f3ED/2liViyO7SKYgWSe5TWYgeiga8NXHDff0
 2EXocLCNFM+5whBeCKZtTOduzH4FguFXjy/11HU9ezAvUrSIBsOvo1vtdYb7Q/Yr746vCj8az
 Raxd9/sp2KNYO0tF332Cu6REIRudBy3e128p/t5aYFbI6A2EKLc+g5FYaDJIEDL0Uipi+7bsl
 eOQX+/WYtwz9ozlDn48OVgxb0wPNzB48vjQNsZUkMOWP7kGALyGmWtub8WtRSp35GJxkJ7Aqr
 kmCl6eBSh5EfQqPdty4urQyfQ3mra8skBEIk6mUIt8NEYhkWb++DtETcTa1EZHsjdOcaxxaD4
 86wq5isjmsnUGX0QbaqPoxun3jIpkjodV8JT2yn+h9MKn337VxKA4aFRUuqdL2L8d/byAxSBp
 gSIcuEYeDe3X/Zg0SyWNOFhVoAyBzUhJjocy/dUdnmy3aqmGL1I8xwfln6BVWuzXXOSNb3REw
 FK79TGj0dlIDAaYAXhR/0gNAVLM8fzUPB/LPn+ke2GSm7DcM3t3iDgeeF2QUhs+EecxxxDVky
 FWs5SZQm4Czu8uCMRRYIZifK6IGQkKA4sgOmB4n6/oINqRNHJYrVkWbFVgaN4RZs1IedKd5N2
 lc5BC/H45NJvVfflGhONtZtjgBvlKCgPaPmP39r2PeZ5R7JMbMHCfw7PX4nQCe/viZZnrto4e
 NDDd3rZcSWy0tBv7tRpDIe9DKIbUoaRtf9ZDM6MHA5AHlZ2iSj2ZkSQXSqOWkF08QodbziT4b
 hjVFzvHs/TX7BoE68lAurCa12Re2K/nocXSJ6A19da/DLCKxOwE4KwcgYV5mzr4aExTh6FsLB
 QULh5UVtSFK9rTjNpxKLwAZNmVP8TjTETvUFyQjZfTggxjG+/HtTPchsMt/knk3nnDPSoTZYS
 hKr0Jepplan8GWu/Ylgjk3c5g7HQFAhHcKyT6BNzOwQWmOlGK7z6E/GAb2f1qeZ7zYYPF91i5
 R46UByCYKTUqh7IeAkTVhlPBnK5x1B5uxy86EAJzdlgbuNV6WqhQ9C226RzQ4lortCWTUfhjk
 Ohx5ETmeaqx6Fjd0GrVB5uSI6QY/ZzWQLxK/niHe2KhcMVlrPJnQA9uHXkoEHrvuYvJ5APeiS
 xUymvGIbu+RmCx0Z/KyCFVs2HSE3DhWvsOEtvwBIVO8ADk8uAwAYfC7LB02cqjJpn0ugYUihI
 eccgYt+Mz1dRRcTPn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR().

Such information is helpful.


> The IS_ERR() test in the return value check should be replaced with NULL test.

Would you like to convert this description into an imperative wording?

Regards,
Markus
