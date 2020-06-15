Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343D02076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YHoIaWVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgFON07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:26:59 -0400
Received: from mout.web.de ([217.72.192.78]:44431 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730155AbgFON0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592227605;
        bh=yAKWgp/Tvaiw5OQKWpFzUE0F/BMcjcnPIYvMRZeg5QA=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=YHoIaWVirvDxZJTUaDvamyB975dT8z34Xk6KOJqyQH2zkymHev45fSd/Qho3UKM3z
         xnG7+Aqh7DJw9exnGzdgJ4WrSWxZqpRayctjwaXVDmdAMUXjNO8l58GV0KiOAO63F8
         1ef+r2IGG0UE1yXykTpvCfSuCB/dBw6MljWplMGU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.107.236]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1iykt00ufH-00zVfy; Mon, 15
 Jun 2020 15:26:45 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: api: add kzfree script
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
Message-ID: <a316f076-1686-25d8-18fe-1bbc0cf9a701@web.de>
Date:   Mon, 15 Jun 2020 15:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/b4Ia59bBSMcrMDs43+fJ6k7vf7kjhSkOQx7bo8OBNwNrZoQ+lB
 rwB4iPY8PGA86WfqZQdJ+G/aEDqERtWZxaJqcfC9w7YXFctf5VFfNGBKNSYzM4kwdjnMkui
 apFmordzThiX0VQWSxZKtorYZyavtE18AGyr9Kkf3MoQnRxUX6d1kQV7Bkl87UvmHjrTG3z
 IQH96dNfnGEm2d/+NHcrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MdkxZBBFxJc=:klYJ+Q9XiVvPxdzbm0WtFL
 pXYbJy5+gSNAY+inWrSfy//afYzlGY4/A+RmX5IINaY4BQc3apSFYtzH/lOYPJVA6KnKASBjd
 swRtayiY98AZCoLwM95DPImiwGLWbgnJX6Q+DHCldovSAOcZ57C57RVxZfQuBfLUZtdbXbyIG
 n5v75sQhF29kpT46JbLpW9uMiWzFyK/tyirH8tgHlfOvS4n08PwEdHoC6qBbBajLdZ4AtY7pJ
 h79WjBQ297GWABXMQfBpwxIetJ8TEcCzMTs9uI26Hju+iCvlzbHWW42w4NMxMaYZDt+ZDoOLR
 FBcamsBhCnyhv1wnvhduDJprT2Deu2LLUxRfb08Zu/+98TxZ6MU1yV+IciCk9YzrPgBz5ozii
 19ws3oPG3+DQF9xemXyaEOW2qO3dZC9bY276ScdiXoUUR9HXmP6LEvQl3txWZ5kekJnECQe5J
 tYcPCAs0he6ImZU4uXjelGyJXLnEOwQS9f34MZX2ojHDZeLhZwsO8Zi1q60nVt788T5XqPmEf
 ukspI21XxufI25vR2EY/4wlR25r4m1J+TdRKprfAm+G6qIQqJ6EusyEdgIDoBxx9yjgjZ5dVF
 k8jpgv2X/wTRoZjf2yiXkHr1uVgQs4gqgqnKItx7znXAiCIPmCI7UEVRclFwlwJdwQc8alNxH
 YC84KkHIXh3QPyRzw64XERLZMAJ4LpXuOGrDj3uuC1SHYiikF1f4NZtKWpdaCmfuzdsa1nGc6
 zXz6LfIky19D36IHlK0N4LnX9zOzyf20G3j3G5avValzpcHWA8Oyfm35yOFkkbRQf/ppg3T9c
 5R12u8uftmPejrhh4qSW9gasNaul+Pn5YNX9IpxtrWpW3YMZqXZTjuhPAjQeACR9VCCPdnlWo
 HeyfiERs0JdPQJYeDILGWUOyOi7T1zLgRt2fdWuwbmyR61CaD3nwactmOIiVDr2sR6XWWFXyK
 gspk4/UnNouwkD9Sm4UIJcH2sPS2bkbFyu6uVehBZeKo88iE8ZZJc4clFghuYA4Qxp88sH7Ci
 t2XSDD3lvkZ+QRN/yXPFEwdEMLYkZWyHZL5vF/UD+Z0uvRc/IgV2SIKmgfOaQMVkkk7UxmSj4
 QKIoLNiRMJ2sTGW2WTA6/2kklI7lDSg3k8TCiVlcOGcDQ3JZFEGlxbwW3ztXbSZeJyH4vfsH1
 eBSMvKVD2rj1ExUHnn7P4J6YXUrk3QL9m1qFbkyJxFpuAiJ91fPpUSCtchI74DlHXGSl6cgXy
 DRWoRanyG6yZ/+Oc4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +virtual context
> +virtual patch
> +virtual org
> +virtual report

+virtual context, patch, org, report

Is such a SmPL code variant more succinct?


=E2=80=A6
> +if (...)
> +  \(memset@ok\|memzero_explicit@ok\)(...);

Would you like to tolerate any extra source code around such a function ca=
ll
in an if branch?


=E2=80=A6
> +(
> +* memset@m((T)E, 0, ...);
> +|
> +* memzero_explicit@m((T)E, ...);
> +)
=E2=80=A6

I suggest to move a semicolon.

+(
+*memset@m((T)E, 0, ...)
+|
+*memzero_explicit@m((T)E, ...)
+);


=E2=80=A6
> +- \(kfree\|vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
=E2=80=A6

Would you like to increase the precision a bit for the change specificatio=
n?

+-\(kfree\|vfree\|kvfree\)
++kvfree_sensitive
+ (E
++ , size
+ );


=E2=80=A6
> +(
> +- kfree(E);
> ++ kzfree(E);
> +|
> +- \(vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
> +)
=E2=80=A6

+(
+-kfree
++kzfree
+      (E)
+|
+-\(vfree\|kvfree\)
++kvfree_sensitive
+ (E
++ , size
+ )
+);


=E2=80=A6
> +coccilib.org.print_todo(p[0],
> +  "WARNING: opportunity for kzfree/kvfree_sensitive")

I suggest to align the second function parameter.

+coccilib.org.print_todo(p[0],
+                        "WARNING: opportunity for kzfree/kvfree_sensitive=
")


Regards,
Markus
