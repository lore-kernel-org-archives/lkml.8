Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B38DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF9E2077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y9pEUeC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFFOFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:05:05 -0400
Received: from mout.web.de ([212.227.15.14]:36673 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgFFOFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591452291;
        bh=unGkSxvmUQrT+JNXkctYfcWReOw/mcpQ1B8NofFQUog=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=Y9pEUeC3fFr3HwPJpovbsSjZA2VHG3BYoaDRzrg6uAJ9C6aiuqcXe3Udyke28vLW0
         aGzne9469EtCloyu4mRdJqf3F+TCQvyeTaDH+mxFz/RaCiC8GnoFEjaQHAitg9L66F
         pK7v+XPGGQDRQY+5zkIWwTvmuUiAvtVJkmFeWQhI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LeLin-1jBFyY2fsL-00qEj3; Sat, 06
 Jun 2020 16:04:51 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kvfree script
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <119d91fd-1ad0-8842-10eb-ee8fa16da1b0@web.de>
Date:   Sat, 6 Jun 2020 16:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fN15pfZJlffXWQW5Lq8rwpPpeT0sxSGN8X/MkP+DExoX3q0VrYZ
 Wsts1djrTn5oidCUJrgt+VpAmbKuKfXJ8+irHncb7gWgf1xOFLPFm4gusikOULwKX0UK/si
 s6Y9AA58HkQ/MNPJRCnFt8FRcP4dTyUjUKmqOoVhyowKM3j7uv3TLP46jhKDmBWxsfd8uIZ
 g8otOytwVIWRrNm+fMNXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ud7vUW+1vTE=:2yTpJHuoee3llDYqeOPo+N
 kFBI5tD7tbCxI0z+4Yj0JSIDq60G9Nm04P7W/vx659ZMiowAAWRhGI/K8kpb4n7qu9YGzDSyb
 IjmWQuHaxgqSaELWxVSMyrbAP2hynD246teLlB3TyrNUVdRnH1nBzs6hU8wgqOhSNrf8XozK9
 LvTLBUBc9SQxBChAV3mX3Y9M4FQ3Inq48h6nsA7eoSrq7Uk+GQLAKgshWX3z/1OLiV3gf7dTa
 orfSbdSWKzF0ckJj/BV1rGIA+sekYgPvP2lnWzO8tl4aKOFahzcvqVPpEpFeWJhLaXBOLcNw6
 AlwBiX6J4eb7bQAdWbU03dYObY/3erqSFVj+80TDAUW/tz47sgixTJLQ+wA5N8eLBVcfUq9I3
 9eQTFCR02RHGMRN6cqcf9ha8D9s1/Qw/e+4A+SumC9qU8ijzfbyfj2fhofpluyAXgLEhTk5CF
 kuDluf4lMmgvHxua8PzZSluHPxLJPihbKSM5DmVM6jzElaAeo3eVAoiBUxww+EeaeeXJZ25CH
 WnB/CQvATYhe+NTwhoWoZHXpcWBC6QB5DHqNTgQZZwGhDVURP9gomrxfBW8gAui46nCRqnqln
 4p6yAfRUTDai2BSDjPHaqlvDD6cXVFB2ufmzwKS1ryNlWLi5bGDiYkzLKgv6/B1JBseWizcX3
 mB6dh8Yn7ZZLIuwq+iEE+6wTeiPSTO22e+TZsUGpNQEN6csVWoE2fhLeziPby/nqj+2Wp/ygN
 llFmpA+sCAaatbHGWYDImMGUXmtUnzKhWKQyFiQw9ifNigI/ao5dgWzQ9GGxG9RUlWMVpmn/O
 qIsQDc3twkivGemg8JAzJcCOSXZAUdIQvEVbVYp6bFSlBoJ1EzQ/SOGoMvuB3OtcO5AGlDEG4
 56JMSSQXq3DRauK9VC8Bnhw2rn+sGSH4keRsiMewZ4JfZ0ZzUjbB27wPYy5mllu3+wy7n1nMa
 gwp/DLqBm8vn4kwbAvtX9W2YFybr2QbgFDGZHyX+Wax5O+5NmMU3IjP2qwdmPJE4Ss4iv/0kH
 79+vzCLmBkKbWUYMMGSs6ceWbiNI2jIo7TXWk7kLFVUiE6a/Arp6zLHGiyHZJSybiEbnind7V
 84/B9nZKrD8qME3hODMsC/yMfl8KRmOczaE+dgLF38Sb613IY1XZeY6XbtLcij1gbizAYkYEm
 Ulxj7dJ55a0eHkLx6h+oDU9S3O48R8LbnS7qnlx/DP8gajklbEcoWhbDFDCdYHuzHDq3lkh2H
 jNWDcfIfcSoqVw7gL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@choice@
> +expression E, E1;
> +position kok, vok;
> +@@
> +
> +(
> +  if (...) {
> +    ...
> +    E =3D \(kmalloc@kok\|=E2=80=A6\)(...)

Further implementation details from this SmPL script caught my software
development attention.

* Is there a need to add the specification =E2=80=9Cwhen any=E2=80=9D to t=
he SmPL ellipses
  before such assignment statements?

* A limited search approach was expressed. Will additional source code var=
iations
  become relevant?
  + switch statement
  + if branches with single statements
  + conditional operator


> +@opportunity depends on !patch =E2=80=A6@
=E2=80=A6
> +  E =3D \(kmalloc\|=E2=80=A6\)(..., size, ...)
> +  ... when !=3D E =3D E1
> +      when !=3D size =3D E1

I wonder that two assignments should be excluded here according to
the same expression metavariable.


+@pkfree depends on patch exists@
=E2=80=A6
+- \(kfree\|kvfree\)(E)
++ vfree(E)

Would you like to use a SmPL code variant like the following
at any more places?
(Is it occasionally helpful to increase the change precision?)

+-\(kfree\|kvfree\)
++vfree
+      (E)


Regards,
Markus
