Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB405C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A6C206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OCiuS6MD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436734AbgDNIY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:24:57 -0400
Received: from mout.web.de ([217.72.192.78]:41197 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436695AbgDNIYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586852667;
        bh=xYmpjD3b4g0+uRWfz6ZucD+8z8VMXMdEU294FPLBGDw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=OCiuS6MDsv9C7UUT7Q0JZyw17KAsUJDdSnwsGfZZhlAwpkVZIbx5Hj9QJEhyoSVrR
         l+nLv4u3axnO8pdnqr/TMQTP2gs4ywi0lX8/B/bjoE3us/BERe0Muea3j5/siNMq5t
         6309TORDTwKMbju1S4rsJKndEZsV9AjsevQ+abn4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.66.171]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzjq-1jTAPA3hZa-00DpHE; Tue, 14
 Apr 2020 10:24:27 +0200
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alex Elder <elder@linaro.org>, linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/4] remoteproc: Fix a bug in rproc_alloc()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e459f807-4c61-257b-b7b5-dd767202c435@web.de>
Date:   Tue, 14 Apr 2020 10:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x3pdaU8T+pJDvPTFMHeaGE4NFDXjx/oIl5bqFFTbxRwj1inj0Ds
 tccARXNh0XLP+iqXBZqa+oYIL6Qp0SXzOCdzwQgA7zkMhgU9/gD2LJtlRLewApYYY5A5neR
 OtsauIzyL5k75EJYnHwuMXdWFPi5uJSSensDTfI4G8vewDnWX0hwshX8b5QwtiwbHijL8LP
 OeQDDOaLbYd5qCsa/Xs6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8YkSqLQf2Ng=:eO37U/FXPCWPJUy/sX82K7
 0K8+vQULu9iyydiGNH51uxY/ezTzK8AuUuZ5DyOXRCFqd4D/ZTJrDESvDbkEvVMpgMcKxE1oT
 ooMD/ZGf3US8iZruJHIvZEI0tGLBc3s/89gEfQ+C4nx17z6wazfqNQvkncXIgeVDf33y+LAJQ
 1V69d6Wj6BHq8PeRlxfk9vf5i8WLuRkLtWpgF/CEVA1iwf2OwNW9yoEqa40LPoCI0Ukfnvylr
 uiR8q2FQht1LiPUNS6UoAe/GjpnBeIxaFAAZLTDste45NI3UhcN7a06lODlgq9EG5g9VzmBJH
 FmAoke6FpPRM1Yp60emMFgCb0eoYFrHmsDfXWgV3oQnVFjX5IVtSPGqV51E6LBT7UQx5iMOrH
 35a3IK4PQz4aI5XxR/I7VhqyABlDjHeKUT8HWyPWuoyCYUMAvhdDxgNdYxkVFXu70VflKS+sa
 gmTjTI96pYt3HDpEawk3AqeqJbIiLwr4PeQPyejEDmnyRAJRr7s+8eE45JrbbVitpAHgdXSc4
 v+9bNtpQ3Sa6qC3UYNg8qpk/vS82t3rcEH49yXAfsY6iOb9MnLdaZJ5szWDJUCEgvbiwTB2Fr
 j6NCTUYr7gupaB8oYeKcxpG3EvtuLiAWUjbsHCIXPskWO7e/Y9uAD1n5d4tciZn6LYFPfI/bR
 mjbuuSaZPVsG01ZZGwCU5L3+6P3DnufEXWhKr3UH4dsJAJgxd9M+eQvgy9MvsRgQuWb9RMUvS
 +p/DjN/4cuJ9d9CkJQYJgoR+zmDSk9et3WS0QbCiF1KgJJzFlBkoMjfKaxSzSPK2QfFnEzR/F
 lpbNVeFfvghx+BdJ20Qw70Q3JzznW+bO0YHYbYx/dkLk8xw5UMAH4vW4CzNCmQ3RogoN3R0/6
 wkEqbZ9dCVlJ9iG4+FlvRC1gnuB2wmisTlnULg5Dwn956aDliwLxEapNvc+hhhIrl7foxqp5n
 ZrbUrrkJqZXiUOOcMsOSOFBhk4k5YikgBqmOExDvW6u58vgtqaFSetj49DdN2cld46PNnMZAI
 a6fystAJe2FkPGCO27xOcPicAzDbAw5fijtbveDe1u33BBORhfcn03Z6RRr8B7FK8OfwsQY+k
 Ug4/wL58vdVpdjZ0kIs1JN5+egCPEKr0MC3bbr5WVUpuu/branPjPa3c0zRlc5X+r1IF7OQjV
 kblWrjkFesJkND+qCGpIt6tpGMJwiq/tOT6M87LTZkSvdqYnA3I+vPKq/RnWufHZCPqdBghap
 kGZbmDN5IIXq27gtN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not actually sure this case causes an observable problem, but
> it's incorrect.  Fix this by initializing the notifyids field before
> calling ida_simple_get() in rproc_alloc().

I suggest to improve the commit message.

* Can the information =E2=80=9Cfield initialisation=E2=80=9D be more helpf=
ul than =E2=80=9Cbug=E2=80=9D
  in the patch subject?

* Will the tag =E2=80=9CFixes=E2=80=9D become relevant?

Regards,
Markus
