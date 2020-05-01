Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43813C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1B20836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ndTZ3mIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgEAQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:53:03 -0400
Received: from mout.web.de ([212.227.15.4]:51991 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgEAQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588351974;
        bh=cnuZXEO7YQJ4tZE4Noa6guYPZ0C58F4v2mKLzJWyPpU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=ndTZ3mIWudo4sTnqrrbKBYDhEqpbL3xAbueCmUK6u3L3mLoGQONHKszD0kZq+fMKh
         ZgiyHBUgO3glkSsVJisumeDRSXlqdDtBl9o5pm5N7VxBoKld14dgBB8iQzKGZtll8J
         O8PS8xH0O0J7cddLl/iRVXDgdyUID4XxV6sBNYiE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.136.146]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8ai-1jqTTi0Ds8-00M49M; Fri, 01
 May 2020 18:52:54 +0200
Subject: Re: [PATCH v3] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200501154033.GA25730@udknight>
 <3aeb6ab5059ec753d922051d7732e13322188e7c.camel@perches.com>
 <20200501163440.GA19874@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <b2f44460-dc42-1606-519f-2886c805715e@web.de>
Date:   Fri, 1 May 2020 18:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501163440.GA19874@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:+2KKWVMN+yXVS0/JfNtbhkKi41xfjFGWEQX1Go/5xaAiXPI34bl
 VzguRycw5yoyq8cN0D5+1inO7MdyqJcqCQqh2gOLuD+wnYYPsleP0p7MbJh5lfU2+e1i+no
 RZMYzUZcOmb9G4k3Op18vmVz2cb5QVKVRH1jfV3fZNFTwoYMhC6zdG2lEOm0xrWn7zwiqAe
 XPS/oITEi5JSfB8TuhRDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qsy0+JTT61c=:y+QGXQyUrYhb7s1GAPlY+F
 cQIfkc9FNaCYU0qwoOdQnHxZCGx5BWg7McWKxyEG7wmvfc+Z0yN7APa/AcRiOZeqCKaE7J/Fy
 zrBr2APbmBy/iLzGAnF6AfmZatU2vJC+LpKtuRj46a7NBacTA3gUnUNjVXMpmw7ArWlX/tSOk
 fNiW3fdrSm8dUMEJQbeQuqU84KPP8GOmNjMa8H7CcrmfB4cwb0G33EDgveTG0r58ofwpO214z
 /CwBXHpDvS9+4dZ3XpAGeRVdttev2S8Cxb5qYVOodzeIRCplBLRiswMWMWepdvMfXqvbyWelx
 rFCbxNVfo55S6NfQNI5nB+CDXbQ90upSGKiSSLrOD0OPwho0yI5NJx9KjTRsrlTCRzeiP/I1d
 tUq8Si4pzNaUUpaTwlSA7MVw71JMUd1P6D1hsTGKVNoTaKCOMQg1Hv1/5ml9DQwyNy5qZzqK5
 /vViUvFsuNj56ibTFOhCpTafxj/4zgI0JMNKYXZdVq+MfhasZJirfOg+0XCeYJtB+of+ugQ0T
 h/otTWKC4V694zE09NOu6IfjwAJuHPTDACh4dQMavSA/7ywdabh2VZolxIlXmAGtasWr9ZM1P
 pUYcs7vkbuJ2r3MKDKGS3RdmSd8QKdNrhjaMPI0t+f0eUpcoacFZCLCihwzIguMxcnIukXUm1
 Fs97u/i6Syx/QL31DZawO/rabIMCRpYWK90kb58gnlEzQ7QANbkft9+blkJl04A6srrgb4sQ5
 yZW3D5DuM3JYznV9Itx9k6Drpnn1U0asy/yUq9VQbSgV87ezulxWkUng3cGpaR+B14QyN7j3p
 p2WaproYwKxTecvJOLQjZeuR6VMlbSQfI1UbwaFU9xCWjyv2q+GnJD0Qr9nEifzWADKK9pJAj
 gUUTBM5ElLMOpPTSpSE4O6HN0AdmTTnCHzeHp/+hFopjTR2AOL4Qrqzkfk/28abJW3VE61Lby
 5g2UBk0RDu2StcRosZgRYWcrDyQVwdTlqBd47lYhv+pj6kIygwXjTuVLKHYTzNct2xhMwpdaD
 6NW3453O6dIdkfdCAWgtr0g+ZALV3r3/DWb3m7vsbA3xzd5rUbIOwg/BNPoQ756FzxkNHWGrC
 JyFOmv+PjW8KOzz6XXdCbQtFJnMuFjJQLk3+Jnwkh9FxaOGmnWx9QYcoxEj/IFM15/8xsU7uS
 MmxCpKgBxjGSw7Dth8/ugyuCcPzEO8Z/voO5vGMOqF7LLwMwDzmsTAZOxncnsd75nlx8nbaKV
 NdElEqY3Qo9dp4zAn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure whether I get your words, you mean we need to emit warning
> for incomplete title line format? For example:
> Fixes: 277f27e2f277 ("SUNRPC/cache: Allow garbage collection ... ")

I suggest to increase the precision for the usage the ellipsis at the end.

* Triple ASCII dots

* U+2026

* The commit title should probably not be abbreviated too much.

Regards,
Markus
