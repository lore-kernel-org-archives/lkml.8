Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE6FC433FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB2204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Co88SDhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgG1PN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:13:56 -0400
Received: from mout.web.de ([212.227.15.3]:45731 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbgG1PNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595949206;
        bh=4eS2iDAsbrOdOLLedYtvazSxMT8ynSJcUjaM53JHyJU=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Co88SDhC2gL/zmdY+fbkzv1NAfIlGlgv8OG5TVmg+KxuZLX/exIKgJNw63aIEMbrB
         R2JfqcG9nk1N/mQG+CNv9LbnBhYrr0Ytbq3WiVjlNMQo6FVRsolJqv3cgZRJcKHy4+
         sYjA2R1FfK8HW3YS+bmtPyDAfxQOVSmIQ/fEDdmM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.153.150]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrYLd-1km80R0Qtp-013QFs; Tue, 28
 Jul 2020 17:13:26 +0200
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Nie <jun.nie@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: zx: remove redundant dev_err call in
 zx296702_pd_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3b237263-33eb-d7dc-b6cf-d341f35824de@web.de>
Date:   Tue, 28 Jul 2020 17:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dp+alhTncV94SLwTQ3joEOA5CSU+4wi6zTlpmB2soO0qYoLY7EQ
 Ei7YHEMRHQSXPBsYYWZRl7w4XoqawrDBfamWITQw4c51hchbTPFiBYa+FBd7m6bwaabahcn
 83070brcjHLm/ayy8pq+n+nK0s7q4LMIiZtGAgnUK7B/kjk6N10T13eWZjN7gQ2PG01/EYd
 zcAp1gpGVaKejKqH33OXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k6AZQT6+m9k=:XtkfNmNpgqv7oL3BLW+NI5
 IJpKGKpvKVDvRVvWvXz7xbSeXvJxqbNDQESPx87zCDEMQCZT+y6VoUruBeR5UCKWTwNmbupAm
 xl2ULYN8ZQihYHkgs6RoGjG86fex81LHnB9fb29UbmpydjRHG/l5Epi+aAjBaNn7eXp59AfPx
 ysU+wMXfJdnNQdsCjdxmgfVwhxMyOaavrnl4DnPIxzqyBipo/bx509tBjIxFOEUbORi/TeemZ
 QOluhHrs1eBGDBs+ESQ6rTrsbgi8+7RPKannWqpVIBjIVzC4sJRiWxaFGLALzOiSdOWSrCMMx
 zjJkEPMVsuBDf1qaD/slMmJhltHTu0KBS0qJxX1XwKCQbBVGM2NjfEoBDxIHMlaa927hUnBJ5
 B+C6nJK42uq4EvTuSndpRRNPcV4vn7Z5ebXP3vvHMqbr0wnx7dct84vRYm1uW3H5l0sWb2YCB
 VQ6yOwodhaqBWzVj7+qr3/NmzBI9Krt0UIJqLz75LIfXKNtLX7tnoXdZmHLcev+xB7qHTmFz0
 s77Locnou4W4rlupb2/ak9ST1TZvms+gusoicUAZ1RNueqOJ7mlcXKDVq3uzVD3xiDT79zsGb
 7CLgyQS79ZyaLJwYZI4ZvGQ6FXjpjgGMdIE9e+4TkdqhVC9DGa+qy6KbPNDno/y9e01WKGuyI
 I9Oz7O3vkZm8aCXkley6B9/V13nASED2HpJfvPQJyUsrIhdX/+RdMTGWiqjqp0zlsTctCRqyK
 66Itp8B9mTWiMYxjIN0no9IuWRrszwRCK/wFwYSBjY4JL6mb6Hgyi2M+MIUEYCUrAWYyuVNCj
 cqtm0D7+ECzgUBWsDsnovHch2k9IeCvtkb+bGIgiJxH7LWW10dC/+gP0THHHcljaX6ulCg/0w
 QDxFl8UE5miFEZq+iaDxHUR5EO6T4lsooQx1/ojzfeX/B1LwM76NsnVmLay7gQFfeKcPtum7z
 BFHR4fQ84MZbR1Yr87Q55rWV+bkufI/uybCf92SWjyLJN+e1XwOfAqEGnMC25cQpy3LKqfhzs
 UNP4aR6gkwYkMFhJgcufdIu/SXoaJMpIbNSeDRr9Qx3UhXWMQmxeNpsmg1x5Ra/kTC7+lRE6V
 sMSCkIAtVaoxCzCk1So4wPw4tIJelTUvT/h13qZ2jxe8Dc+q++1VKUqcP1atdozHOg6ZzHLJf
 Np9IJliwtFoDj7XAdgafLbisHvcEYLE8dOM/1iAXuFvQ11s9VXFomgPaZ7bfnINDVOCam0gbB
 oPI0lu+9IWjPrDYnZGjLqIuftsCCB+Oe8zcSY1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/arch/arm/mach-zx/zx296702-pm-domain.c
> @@ -170,7 +170,6 @@ static int zx296702_pd_probe(struct platform_device =
*pdev)
>
>  	pcubase =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(pcubase)) {
> -		dev_err(&pdev->dev, "ioremap fail.\n");
>  		return -EIO;
>  	}

Would you like to delete also the curly brackets besides the error message=
?

Regards,
Markus
