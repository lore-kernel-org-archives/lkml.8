Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECE5207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FB17ez+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGAIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:40:57 -0400
Received: from mout.web.de ([212.227.17.12]:51527 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgGAIk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593592836;
        bh=eoZXVuPwrXpUh4mYMbAjgn9KOvWCEAKdB4s1f+uosGU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FB17ez+wNxPIXtxU4/smdqehczCinZQgT30B/hfjz0rUde3KurLJDaHkxGHkhUNcu
         gIIsgvbgDcJfPNK5K58zbdbRc98511Mvvq0uQTesbEUyX/+3W/QnZCUMhzT1wOtjgU
         mFEMqWp1rrOIOzhIafIbFnIwYfJKH6xaWjBQql+k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxOHm-1il1O22x4c-016wFD; Wed, 01
 Jul 2020 10:40:36 +0200
Subject: Re: [PATCH v4 02/14] irqchip/csky-apb-intc: Fix potential resource
 leaks
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
Date:   Wed, 1 Jul 2020 10:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S4EgZBj8e7mQDOmZIsBIbSuc5Y2irbiz+K+XRonPv+1h3Cfog3Q
 QFHSqT13LSf+AtXFFbOPHEjka0k8xKFPUIewayOUKn60RLYGGDWIlbxoPJjQ5ni9DCrA66t
 liP9yUzT9O9V7IVa7rXI1GoQuQFkV3pT240d/NDo2zUYGsmjdjw2Nw6ZIsHkN4HbKIvV3eh
 ksgz925KCB0/qUrs+YEjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7GR720Ufx/U=:Tl+QK/ZoMe2Sk/Gtm+ftbW
 3kz6OFa3wrQIqirJAHUtiX5V+c9+kd8TwdJnBSRow0qAlRS+Gip5GW1pb+nevicDCRusoeJ3K
 K3A4aL2Kqd0TEf1evu6n6gDeVJCgPx6CuXCtPb+vA49hA8mg4XkO+2Evcd9/oPle/R3Lm8eWv
 e+p12oQ1hKY0phXTYEu6x3sJzgWfHRTp2Q/ZsD83q9Rcef964a9Xb0xaaHMW6vWgYjdGyTSCf
 UYS6LAZyzn22oSfqhTHw9XZDsil73HdzwX4W+p3Gyi8WLnZrUW+dG9c+2gEiO99+g2eDrWL99
 y3/qJV2+U062QB0zdZ/zpIT9hKRvYVwD1AuCT2RIpnNvLJi7eAiUKqZ8zUtmWvLBwo3xuBLgr
 FAdtPaAXdV1r7UL9Raojw0NN/PziA80SG3Z+qx+EUt76vDdXCDVxx7hhjcqX3mg0UXAZMkha1
 6b5Mw15m0u7nUzGNjP84FldpGWGvYGsmCbR1+8ujiVGNtGfMG1b+eRKH4vBtIuersHe+LTnxO
 zZIlhVtY54ZrRqFqwAvV4lUtIDa3b7MuxXvyMSDNR9huLwUyxFen/sy0UeXMptDgDxR5NFRuZ
 /eI7DWZ3bnArHCAZuZMawEfL85MI38QzFqub3HFKw48/HSc1AM9aEdxKk0MNtPJkKxw6OtCfY
 1ntpjmAw6n6ryuI57/EFdXwGK3KEPPby4raz0dk9aphZ2CTRZ/WYel/TUstYOP85ot3nOa8Pj
 qW0RDJSDnWZakT8dTmjUILgr2JlNduDxsl1xGmvEzAjqpw/PYvTDca5e5PrPBa/QHtoUgvYZG
 MMqWP43YBbgLdomCimJWoiMpywr4lwY0ONJCyptMO5Aw0WaZHfxgOlp53oelF9pEgc62MhrUL
 A2DeeThxIqSs1SV+qq7UcWn2MYteH/kl6jjTyT4XcQ+ImBE5oKQsKTsR6zcj/o/NGPnI1yAJ8
 NnhJDH+YZt8ge/C3vHcG8O3qr+pq9o2/evbZQEET8SHkUpylhMUabzBIlRQ4sO3i3Ux5rg0ng
 kpl2Nre+njUAW9VkCSG1/HA9v5IECkKxlZofgEMZziikc1G6x3tRu6sRV6ENEiq4vGbpc9/0k
 GbCHuZr8Zgilz0XmYQir34oQ05XecXgxm6q5DcuCo6rLSm0WilA5AX7hIkyqKBMQ5yJosZr+m
 ccdatjqdc/7/wsdoMz3HvkDz+6QQWqvsSvi0/RpNW2B3zoRUWH1TQ2/OhybdPfI/o1LxS4qQx
 5Yao0NM6WKMHF4ykF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 were not released in a few error cases. =E2=80=A6

Another small wording adjustment:
  =E2=80=A6 in two error cases. =E2=80=A6


=E2=80=A6
> +++ b/drivers/irqchip/irq-csky-apb-intc.c
=E2=80=A6
> @@ -126,10 +127,17 @@ ck_intc_init_comm(struct device_node *node, struct=
 device_node *parent)
=E2=80=A6
> +err_iounmap:
> +	iounmap(reg_base);
> +	return ret;
>  }
=E2=80=A6

How do you think about to use the statement =E2=80=9Creturn -ENOMEM;=E2=80=
=9D?
Can the local variable =E2=80=9Cret=E2=80=9D be omitted in this function i=
mplementation?

Regards,
Markus
