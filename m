Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7B9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D749246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ryL1Nsde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1KB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:01:27 -0500
Received: from mout.web.de ([212.227.15.14]:55949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgB1KB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582884045;
        bh=nScl4ks49FZ81tgQSWXvTIgpT2a2Og6YNvG+91fML4g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ryL1Nsdet6bRT8gRGc9UVIZ9rZs5Qgle7yHHOdSY4hkZu7XQnaGV2zlUWjUS6m7H6
         k9iYmu5hh+G466IoTjf67++/crom5lUiO1Pu5WXXid8X/cxCiylc3ro5t4dfDtqz7x
         YIfglghQdos//Mjp9mVQZOZSG1mCWQyYFdOWAUNo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVty-1jpzp90tNq-00ijnz; Fri, 28
 Feb 2020 11:00:45 +0100
Subject: Re: [PATCH v2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
 <158287862131.18632.11822701514141299400.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <57b79bdd-36f1-c8c3-e1d3-7d21db47a8f3@web.de>
Date:   Fri, 28 Feb 2020 11:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158287862131.18632.11822701514141299400.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkTt5J0ZniET2GsHY3I6zMBBtbCETSg58GoZSp9aMglzsKS29CU
 LjtZ8SjBcW0nu5zklU6MzimHLm/kIRTxDN2FvJ48wQWHIxKCntkJJiu0sQwsCezK9TLsUMm
 pCPaadT5qzYBUZUAvccQJc5jLKNrVjESPfvgAWPisWqOoiLq9D5hhss5HPx0bnL288+9+SC
 yr5aX5FQe52gs4MEPhYwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xxt8L9JJBuI=:8mD/vYEryeuh8VouzHU1lc
 d5NE0JTanOyVqrGHGj3aSFzFZ1QxGLyDBYCFS7KjB4FpRJYkC6c8Bov067n/Gfj5JMhmi0z0M
 sR+hx15sN/6n8nWWqjc5nrlzrc9cngJHoy7fR9a1OgggkJ2fBx0oPaRzNfs0GB2RMqUAR4rZF
 +6ebC2uWARf1Fk2ZaliSK096C7+mGpE5kI9KK3tQgG39eNS7vajIvcUo+F3nQURgj3dqQpzo6
 HFUhsbsJx1Ttzcvx57zNy4aIci23MHbalo2soZu60CslqbyTseC9BxGLCt/4r0SV9+kM2hktP
 KdosKTTugCD/aoRW9v4OrMq3IJRsRU384IxNFrWgjqfX+zKBHYLb1RunnNahMFixh+fR8FeHB
 HN3Xs4dZBS9NFs7sgwStEeOpMdn+6AccJ7mFk6lg3iVNYYo3732L8KAD0ZuegC59a9Ed5YaZ1
 vALI7F40d6xchE62bEZmSUQkT+q8BtxAClf1YUmyduogXGT8wZmgiJiKzC/YVpv7i/SMNN239
 EiH+hayWK0K8lltDRN2pd1ro0P/2xsnltbG6EU30os43szc41e5/N0c86TlGTZypwfKfjc4hQ
 cyeOakgsKNwtFGsggjwviFqiplNj3a4rD2xlxg8H2ynzGrKAAAM/jlwDO9KvPs72DKosqGriI
 s62cSRg/RM52QZANQTNxl3Rs3sWhGzdhw2YIAL0Jys8us3k0FI5Af0eM4S7RWOZbaBpqyBoCl
 x9mB8Wheu8H5k7m8a09ddFEbezcMdx4VV+svteKnRZljy3xtJzj2ZUoH+dhtvpEv7RRtGdLD9
 Sg0rueBp0SMzVip04Npr14jdBhYr6UC9t1ihTOsOn5UPtEOAzb0nrIugWppUitb+3kMFMBaZ8
 C1l/GSZjDZNk4eZkTfp21tyzMCuOwoOJJlKFu0zUAzA2TOJrsdiR+gzybDbizSLWsC4tKc3dO
 I9V/tJbgFey4qxVg5MkhEokRaqXdFwsdIAqrr5bDj9js03KFTqW3oxw4wif0qLnr4okkzyn3T
 llYn4NKn1Bi2ULQL3VC2eMybnvSjnowvF4ZkR1gZEuIyrJq6BBFBHpm+1zD8yeOOexWu24cnl
 D05lfZGViOLiafv7BBQ48aw/TqDVCjivcmAJQtloEFiUggmTz/aK1TKPn/DJTJr9s712xT7LX
 a4EYN5ithozdrB2uUj2lhST1HrVAzXjBUzEZzFa0CssBbZ0WaVHFjLR0oawkqbKJu2Krsj9Jt
 AoY/zeP5NuJ747kbI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
> +=E2=80=A6 All sub-keys under "kernel" root key are passed as a part of
> +kernel command line [1]_, and ones under "init" root key are passed as =
a part
> +of init command line. =E2=80=A6

Can an enumeration be clearer for this information?

Will the distinction become more interesting for well-known keys?

Regards,
Markus
