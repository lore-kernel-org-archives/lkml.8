Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D17C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139442469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EHTtVoKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgB0TNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:13:10 -0500
Received: from mout.web.de ([212.227.17.12]:53073 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgB0TNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582830745;
        bh=3VhfE2m/HmFqn1/f3sCi994dDBd0QMvEqD10y48dthY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EHTtVoKsVd5Bsfix7zO+KbH33BaS3Ss+2+0Yg1p/0Tke4AuuBNFrVKcuMlpLfzfKu
         JM6SUfHwkUaHjWcb7wy8ISgZIn1MG7eTEXWDqilkCEg7H0wC5bNr9E2n1GBb+Hbrsq
         kc7Z13fuwQKJeMiJn8FFeWFpbLKOyeAM7Jr6MNgg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.69.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFL6u-1jCuMf1npU-00ER3m; Thu, 27
 Feb 2020 20:12:25 +0100
Subject: Re: [PATCH 1/2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
 <158278835238.14966.16157216423901327777.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8514c830-319b-33e9-025a-79d399674fb3@web.de>
Date:   Thu, 27 Feb 2020 20:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158278835238.14966.16157216423901327777.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lj0zQWZSdVycjZgIT4JsaCfNVof0yXYLVv0g+ZfuoVke48Ud2j0
 dgkLLVQUgt0MDsK0xIC9q/076QqbQdY0K6IZCczTDTEx+tjwJg3jHd4oR/8Am46iHGfHMCH
 L4/W8K9Ev7czsqB+BT0gZ6Jvaes8W31Et1TpENa1fPLQMwV8mvWqlf+mabFU++41IkN8XdL
 UHIgojhiwf4cB+TWSO/hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/vrFqpjliZc=:T5W0gLco26Q6PKXndeY3rE
 Ma2bYyR66PZG0okFuOyQ4QPHUg2ncmsRoZCpuPJ1ebKHitDFsM9Wye/81nO8DvO1IOj43QEAQ
 fcEWRRTOV812gcQIYkVYw7TdoyWI2qMCSHpZcBZjPQoKdbXRs0iwWK6n6mcD5fksBBwT4Ajjo
 lYYdORbKQla1G2ZywP3nHCI+a9Y/fYvJX8ujYozZVE6gcsJKeuQfyiZd2ByOaLTBNmlsrJ6QM
 W5Z0L17KoBppj4f/+mGZ79eeH+WRgpZkWfV4+d0w9iiQXgUnXji3RQPCvpURvql/JQfsfmi34
 A+bWX28v1Yumx4Vaa1GoZia/y5UIN+HGbs/MnQ6hJugfTfa+UxRnV6/UHoRcxVE4tvaUlsvDa
 ueHnt+7SFxg8UTEGQbMiIcJgVGTDyqzDQsU/27HZCO9nlsujxsqHNbM3r31KSwnbCzhUqroCe
 fGY66a7yog7BuOzTO1EBs9OYuwmGbjgw7BW4DO1y1+nxHn6bzeLceIFM1Gbwjl13LxH3dZIJT
 5euF9G/edwpERSrgX1It5dpKCDffKqK6qBdpisaOPyyNZ474ZICLcpiNvqzgVbs+RjVXLe9aS
 dG6i7W2R7LVPqi5ijGWMuIr32L63S4VWVBYchNJH6EsVi9ugoReVih6yBj0ZOtgI5M+Ce/sTO
 28FniKwXbIM1dQlMYoxh5SIBaeEbot4h55rdsbwFNNpdVLWaGSA6d7SI58JqmjnzqAr6V4kat
 hneoIV2UQj0JxPiIoD+Jue1JBBsAaQ1hpBcTuG2VpUrv93gU1ut7Wz9SghkzzjhXyAhyhoh46
 Ase5Scuy/km6VjBIjclS3NZgIpqNmUBiVHZy8+dPDN7wNvpipoOifJzn1PGxB1LPc2H3cOADK
 Aeq8MnL7jKPpJjnpm0ZkdonR098jDRWGI9/AJAMW56KWwlImjkncODKCPRHjdATL6O3ZSdeQi
 0LUac6CG1mX+bk7p4ZbONXxCu3LLex0WezxkyQvYTmAlrgGbmbJNC5x2NTNRhCXDdATOBariV
 BiOusSBM7yoE5MIl+BXDvogRPdT9q7PnnkNpgD3lxWAxeu2DZJB2r2NR1Z3knv2gcJLrVcrR8
 ZWOwP7aqDhEpwv3hioglh65UIf/2l5YfFNZX6ngMr0o/kFTbFYFX7oFYaslSI5H1xwgcLWK1m
 QR3fGa5DOFejvnqUU7bWe2zw5hDHYS7PboQVgff2xedpxg3poTueko0l9MrdL0/gIoFES6YqP
 uFHiwAMOE/OSv7q0r
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +This allows administrators to pass a structured-Key configuration file

Does capitalisation matter here for the word =E2=80=9CKey=E2=80=9D?


> +If you think that kernel/init options becomes too long to write in boot=
-loader
> +configuration file or want to comment on each options, you can use this

Can the following wording variant be a bit nicer?

+=E2=80=A6 or you want to comment on each option, =E2=80=A6


> +Also, some subsystem may depend on the boot configuration, and it has o=
wn
> +root key.

Would you like to explain the influence of a key hierarchy any further?


> +The boot configuration syntax allows user to merge partially same word =
keys
>  by brace. For example::

=E2=80=9Cby braces.
For example::=E2=80=9D?


> +The file /proc/bootconfig is a user-space interface to the configuratio=
n

=E2=80=9C=E2=80=A6 is an user-=E2=80=A6=E2=80=9D?


> +Currently the maximum configuration size is 32 KiB and the total number
> +of key-words and values must be under 1024 nodes.

* How were these constraints chosen?

* Can such system limits become more configurable?


> +(Note: Each key consists of words separated by dot, and value also cons=
ists
> +of values separated by comma. Here, each word and each value is general=
ly
> +called a "node".)

I would prefer the interpretation that nodes contain corresponding attribu=
tes.

How do you think about to add a link to a formal file format description?

Regards,
Markus
