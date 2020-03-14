Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8C9C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494920578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OxeaPc5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCOCzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:55:05 -0400
Received: from mout.web.de ([212.227.17.12]:41469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgCOCzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584240902;
        bh=rEGtoola6uO3z4s9evZaczi+STDQ1qJGsouk3YGbO84=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OxeaPc5NxuOWOvcWd9opsdLBxLHUjg4jhRTk5B3hqZ3aFGt7ka6LwjlmkSOJ3MWOe
         TZr3+GuIzHvLlY4gBt7pcQBBRzj1gxOAhVzYY6dtwCdboox88TVfAbWhwcS2TRLt6o
         pB3glDM+txiuhfJWdXM/5GSICYYjVClIVYStsb1A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.54.194]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdF4n-1jdbfO2GpN-00iSbR; Sat, 14
 Mar 2020 09:45:39 +0100
Subject: Re: [PATCH v5.1] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <158341540688.4236.11231142256496896074.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <846644bd-2d0e-f6b0-8447-c01a00934a6d@web.de>
Date:   Sat, 14 Mar 2020 09:45:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158341540688.4236.11231142256496896074.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yt7tpd79q/2kVNTWIoEm5Wf7B1k1FzoiGdsRru2O30j0o3gL0Np
 QunDTFkHSSaR122eKtqJ58kORxnKu/1D1D7MmkIjvyG/GK4CTDiQ6n9MvtA1h0aefehrlav
 HbF78mQF4BR/aPM7ULQVUIROoe8M/zZpB3gclxD7oWGGZOVKCW9NQV1F4NawNYqwuYkJaBC
 BFuvoVNLq+qQEaijLcEaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vsW5n7iddYo=:aEsLMKsQy6GsKClQ19x5dH
 LsciHxWVZVpwDRDgAtjDya0SzNv9qrTVHjlltoEpBLTaQOA+d5CPys0fMQPNoQ9ye9iozQxVw
 2ly01kXHIiJAnXQEtfHCi2yYzDTV4JOhXnmFKdjQx+GfpEpEXh31MYKZyGk7AY/wjoaf285PO
 VlVdNpnqqgQgaa+sxDbsyJu68OFD2EZl0hPan1Z54BrTebp8kH4zhPvdsz3RBsUETTVm+3Eqd
 RITt6w4pAMt+LsNmdGkfj2Z67NhSgJztQPEs53NAsobQ89u3R/nICZFEFwKagg9AVjFZz+sNX
 /wJ7H18p4zqPrFLNYH9Blt2d4JaEr2PgXVCW9zDjfluJRvhiHAamslUPm/43UJFndpIu4dcgl
 TjO7X38eKHcLhPC3chGQqzAQd10Ehz5yEwCiJhHyo/jF91WVEtxvIEkOXfBKHmMri1SjP9Szc
 KqtiQB+DE8aL/5PyoJEfM9rWiJFYSz59NhI4hQq04ThLFgdAtMZcBlBfGRv0+Sgu542gAyfDL
 043OLAJ72EHEevJKjRDORdvRdx3oPiOXsX0uvgWBdT1BaPN7yiGTD+XMB+c/+04FRbaOmwOm3
 jvX4RIKVnAU6zdsb7QmkfO0umyiNWfp+/C7niBD+Xki0cbOkP+aTtFjZO50bb5Pl0heodCYXi
 tWFJHBUKZWoLZRhhkV/u6Jkt9bIZrjAzXhh4KrpjDHHVODvZCWWIwA7jD3NWAl7M4xY3RSWzL
 CO97Zl9PNVT/nAyqGvG5Ftl+G7t7ksZlYAn7YUQ3Ov1D5L8ba7gVujEqDs44wttxXL5lbH6GN
 eEdGkHe7NA0irouY4aKD8GzU8Q3VKcnYtAFF7ORqozH6hZ2IW31OW8nsymqCNtDydFFr5shq5
 zM30tMbbw5MSNrJ23NXEoc2wJN5gwEHe1cW1r2Y2czTOxQFbvLvJ02emkyCZeplPrpOv9uI0X
 NpW3JFRpJXf6j3oFEcKZ6xv34CHb6E54KGAgzqFvTDewRrjTsnNejDR18i4VhYXEERxjcMYeV
 B4+/lVknAYl2IaXzon9Yp3Jme/8uzzZEeyv1WWCyyeibNugX793LWE/hBY9bGtN6obhW1V/oW
 xi5vPj8f/o5CAAFrKH0gOi6fu1fFOmRRfEaZNbo/qABfVvHR591tzVgc8/vpJQGN4wvbQR64r
 aqU8KO6/uJdU05uEU4ZKMbNiYJOpHmvG+KqmuTty0GHJ855Oh557PPfHis4JHTehqmq/ctFEQ
 2oUOVQSW3mUccPRVK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> Changes in v5.1:
>  - Fix some mistakes (Thanks Randy!)
=E2=80=A6
> Changes in v2:
>  - Fixes additional typos (Thanks Markus and Randy!)
=E2=80=A6

Can such information trigger the addition of the tag =E2=80=9CReported-by=
=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dfffb08b37df928475fef9c7f2a=
afddc2f6ebfaf4#n584

Regards,
Markus
