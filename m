Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6ADC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70C924695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Eiv1f//y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgB1IrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:47:17 -0500
Received: from mout.web.de ([212.227.15.3]:59253 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgB1IrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582879599;
        bh=rQjLTBlvunSkxyu3YphLUHI7fI8eF/7rQkELvUf0t3M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Eiv1f//y9oKylrqIwvF2RwuiXVyJARB96hwEy+OR1ARaxaEER0vJM6PI1fnkuy8nQ
         R+qzH2hCIhyju3OrJD8Z/b/LGreSKbKuu6hWtjkMtvmBVQ+zFqJwqDyFcqDKsAyq1P
         UOlWSr3NyyjXtB1hj3OyMu9eB4WUsYUfu806nyHE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPGym-1j3BRm3ptA-004SEQ; Fri, 28
 Feb 2020 09:46:39 +0100
Subject: Re: [PATCH 2/2] Documentation: bootconfig: Add EBNF syntax file
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
 <158278836196.14966.3881489301852781521.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6a60e891-ba13-8137-1594-f958923f7513@web.de>
Date:   Fri, 28 Feb 2020 09:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158278836196.14966.3881489301852781521.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/pZezKS4zO08RVgrxyQbwr/WqO0ghf1uwz+EmgLP70wgsSWlerX
 dWsZsiuNsV0nFaCepAy1Zy3UDONlf2KEoeMkgaIbprfzggSlfnxvwl3qwlNdlRKpwlsFdBL
 8jro3KKNJwNcc6IOMkGVe6Q4DDBDMYT0PRaFC8d17AeLjyvp2mS1RO81K84PR13Ff6D3dov
 Z2mWCAkCYsOBlhz8Py7TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8TRmWpVopBw=:eDLfYuTD2Dd2yWf3la6uZv
 WoyJZd0HkNg6In/4KwEwpMlf8Hm5tV4b87cu2B+SKUodFlW9aOQNLKARbLjCgri4IiLUbx/wz
 HUKE00g/md4bHKj0dIrwTi2oIRrsO0sWr088dLy9xCkIVv6c+DyQV5zQ98/VYKZpPM4Vmp7bU
 xEK+Lrp7FEnKEH9AZKMpKztAOnSz+JmK5EGHQVCMz4UZc1pBdQyPC/y/nPsg8H2IoIHmw79hi
 48b86EWb3xrpARA8pVshKnoBji1vTI4zpcygE9u10t9aje9tO2rMWFL9i3R9c3Z/+1pEENopq
 3a9h8/rz+qmSGvLDg9i3Cg9aQ4s+daATzqPGVV7lFjOWGnz3Hy41NbaMu1sQvFUNni4PeWLWK
 2cQvXQNFlDZcOkN4nO5ElMh/i9NsCVUfr19OyANT4/spToDt3kL/spuAeNxF6n+yrF4Y0jyfr
 JqX8GUCWRft/BWD8Beq6ZrVUEcqsPgFgCWsXjwfT8QRLJ7YD6KdeVIIvgzbJp62xKxLNiE4as
 UZpnyXH7NfWpk1vT2qJOeK8lDAMzX/k0MBDIuYXhZtKGZ308VtOBnw2vbTjT79fBF8CmMV1cM
 nispwyOtbvcpn7h6JXW7tBR7QIP9V5wjot7tgi2jNNpCFpLn+jkQHimdiBA0HVt+LycajY+nJ
 fXb6Ygq7HHJ8k20COrS0bUWwKZ/wk0ojyKnE8tG558fkmtcsI+Iokt7heF0x5iKUZrkRnVB4H
 vmTD8kFf0MsFkruVcr+A9z1jdNUs3d1pAdh+06rJM0+aRILJ1UnPbl3sbrLtUUNMWy2qCcWqS
 RWOqc6A+aCa/c4XHni2yIoh8dnnZfiXDUkxzQwxZDQQ+m7hoG20ybOutJ8jhCQuFGqgmjTRfY
 YL3XP6EhQDtFNTY7v5gcC64y6fWT64jQs7alkfRiUERQvGuPBtWSjQeoeAVZbaY2enPid9LK+
 vd0Bkacya8xqBDq0x7SVF15FTXm8B9mi0ZYqzYbB7HW9gTKHMmSWCpPcXeWoieMB3qetdMMdr
 3wWZ9Cs3dwJHW7+rUnCDt1velZYstqIhYd1SuyQDkq0m74Fi28/+R/yveofsy6fdCKUDXOvFF
 jUgvX+TaunN/xo8dIh0zrW2NovovXVNdLz92dNYk6kIXhmo7v5+0VZwynKIlh3NxZVf25yM7p
 RnkMqjlkgSJ1EErDJ4qSXlzpnUO5riiYHbEsVSWYhk1IN/3/cBnw9ktjmCQJ3rn9lZtQTw2Pa
 2zRZCMo1+XlpITP/c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
> +.. include:: bootconfig.ebnf
> +   :literal:

Can the markup directive =E2=80=9Ccode EBNF=E2=80=9D be more appropriate f=
or the discussed extension?

Regards,
Markus
