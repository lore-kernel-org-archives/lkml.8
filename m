Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8EFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7956B20714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 11:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RKUhYc0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFNLbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 07:31:34 -0400
Received: from mout.web.de ([217.72.192.78]:40233 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgFNLb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 07:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592134272;
        bh=99e5fUmdAPxpyhSRJewC1/udHxWyON/Mb6axo3Pi7nw=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=RKUhYc0rWQnux02Ro1wBTLVZ620PnblMZuUuWhzu7KyGcMPzXoBahzGOYt9IN9HXG
         zMG2SQsNxuOiN/HwWo8U7yMwbQgZ6YPAWM6zqhDDvy/pma2JpMLdlws99KlcXYQM7q
         6JfGX+shsCiswN1PhQRiAPDsf+dkgyVAKkPmEh8E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.103.145]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTPn1-1jIlXD1KH1-00SQcV; Sun, 14
 Jun 2020 13:31:12 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: fix ref count leak in
 panfrost_job_hw_submit
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <05cb6c2f-35f3-b81e-4fa5-f7ffb874176f@web.de>
Date:   Sun, 14 Jun 2020 13:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z6xh1iUTXzVCSOqHzQn6PVQwa3iPFIfZQwM3pQV6Ce/NyLwG1Cq
 TP5NiOAYODkvwU9ffaIpQPxoxvLStmbjBDfNZjJ9Vub8g4VG+CzvLXSj9P0oaxOVXbDS9IV
 8pJuuJfkW5yZ+k989gqzGPA98Uj33d126EhV5jEbN/JKa/U1Yzb01mspcfZIoUhp0XAfiZg
 XkFWxaQvLf3HZNBO+9UBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NN9mbHbgHY0=:bS1cH616vmhrC+2bgOfIk4
 Lw7U49GGuNGvPZzaUQ0uPgQilBpePK1q6WBy9QBer3nweOCAMzGPDfRTz2rycJrKEz9zP+lkX
 J1d0DcUfVvUGIVgkFUozOB0QYZ93BjNUTppeWvY+h4/Gqhg9DeX39wrlGGryGn0vqrJZoGzt/
 KL3/wJ6hCOofyofUdATmQeR7XMJJ/iQa+SsvLsYClEXiYSe3JlU6D2rrE3S4Fom/rfFuZcBg9
 jEcEE3EBoxWXQEM0tcc/dBw53X8H7d5BEJTpFX/UrLQ/mwsr/n+g1Xtc5htA8oG+AuPDxr856
 0NeDhvMn0MEKhaSs+KsLyv2DB05Z9qTkbUH9ZlMSkYr0iKlOfBuR8wkFN66yQq7p4ld8QxNO+
 CT1naDkT671+1JN3TReZnMNZqqShH/dDkKaWfQLBB+pVFzmYN3hhr83AWTbWXbF9de2XGOtUo
 tBqJAbADbuD38S8h9fP/eGZoE5ecdTVwdCGkqChFCktMQVa7CPNpZKcCkRMgcHl2ahWVqP+MC
 qTS/pFQ1KaRjXig5ANzxpxx2dBv2eRHHDjGyyb7fG3zCORVZjd2s7qHASVvNLreqOHDaiT1dF
 hF4D/5PvZxozqqr7k4bEeb7qfZfK4ncRwrW3OF+3k60nhJDVebvOkMM472Vs2Q2kSK6qMAkmL
 UU8QMP9DHbMgg5+ssfUV+fCBe+VdVkk7Uwll1NaWq1+UI427hd67zJohCYca82BMZ2qcGhC6G
 5YROICxx0TItoApI7+apfLIDOoYY9WbUw+YQWJUc+oKKg3gBZ77wLCSW4QqkLGmI6LNiQ/NkG
 tH2PYNKVZ8XA8D9vxv8ja+FOFckYgYn7/tsbiM3tFIHirpFqfJTjKgTzydwNbiJr4pCDgE5RZ
 EJ5iHTdoy9BvL9lwM3OJrFQCEG2vDZOsFdDIVv3v2yYSSOCCTVUKexpQ97wo93LH2y4oVE1dC
 QClWD++FjeilTGQJ9KbBG3AhN8G/60OT/UN5eMmbXbBfaperbdtYdHi1EJd8yHIHHpqO2yg9J
 1NiuPcjuVMshCyK9aRZ/hAr30xrcDTrR19Tj/S+rr58Ta0eDJUHH6u63AGIdKaylBSBrlxj94
 CFSj/wUv/tIoJisPDa7W3P2PyyH7uXLfs+jYJ9KclVor1bAS/x2geqa2hGRyOKwGIh2f1+H61
 ciqUFWFff4Dt2yPo9pErsrKo1ypxpLPHl29xJLjR7XP9HzLKBE3SkXuzy3Jth/5ghJ9/SQFKG
 AmILlXm9efKbrMkbO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> in panfrost_job_hw_submit, =E2=80=A6

* Can the term =E2=80=9Creference count=E2=80=9D become relevant also for =
this commit message
  besides other possible adjustments?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?


=E2=80=A6
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
=E2=80=A6
> @@ -184,6 +183,9 @@  static void panfrost_job_hw_submit(struct panfrost_=
job *job, int js)
>  				job, js, jc_head);
>
>  	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
> +out:
> +	pm_runtime_put_sync_autosuspend(pfdev->dev);
> +	return;
>  }
=E2=80=A6

Perhaps use the label =E2=80=9Cput_sync=E2=80=9D instead?

Regards,
Markus
