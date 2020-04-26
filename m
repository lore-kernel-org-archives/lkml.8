Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF77C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92B1206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 19:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="d1h3gsq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDZTuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:50:17 -0400
Received: from mout.web.de ([212.227.17.12]:57805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgDZTuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 15:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587930608;
        bh=0JC+BCyKn3TJbrT0mWlmn3gRjDyBipyA9+WtQNpVUPo=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=d1h3gsq6qgJQcmHKL+z5ZTPh0FBw3fOQr1nmT6lKScMS7HrQRFIzMOCnMne31D7Tn
         Z97S7JQT2aRB76j1qEqeCzyXQQ18mlPNHNr9US8lg2Uvs+G6gPGKrssnTmQsr7bKix
         vY6uq/EhBJUXDt/2TMjW3YrmhTBV6GPOxB5DYJFQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.52.156]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUnUe-1jh0kN3RLI-00Y6TD; Sun, 26
 Apr 2020 21:50:07 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCH] firmware: stratix10-svc: Fix some error handling paths in
 'stratix10_svc_drv_probe()'
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Alan Tull <atull@kernel.org>
Message-ID: <cf6ec3b6-ac2e-e076-2a48-2ed25db4c0f1@web.de>
Date:   Sun, 26 Apr 2020 21:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cA21XoQI/EP1u7oQDaRmuIzhMOJ/oYC5hBvjMb99/G5APnuWy8G
 rQTa8AZkudbo+0k+g3wdxsj/Xx1OBGN5PciZsB3XsAwopyOhd+/iXbP6um7ARZJ32I+S5T+
 CKc2AsXHfQhOs1CHYoj8Lj+JUZvuTMM6DdQ7QASEtasZK2qBwYUP5fvvkn57rgrzV9I2snx
 lWb2UWrTxwuhUqadrC6rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e1In1VMrlx4=:wZ6ahNWKMsQB1gywCQGE5p
 ly1HbRI5+5BTSwK1WIdCeXRBMAsn0issMMkALLY6flhTehLOia5o0pG7tbxPZP72z5iN24UXj
 9KVNSSE47COtOSF8MrXbA2MZBUnM0Tfm0/vEB1lxLm1m7eN7BT1RoiXarSoolA8X8JepLJVZy
 1QeSfAAYcOhuJhXErgvXlbawMSbCpSEnmfIOpxhePikRcRO6H0qJx7YOr7i4GrhQIpEX5pmsj
 f6SyfJ+QcpF1LjiH+D5HyXSaWUOts9iEgaj4hR7XOX2Nyciw0fUpZzQ+i4xwJLKM2oCUcaeDW
 04onUxA7pt8ncEDVOM7qedfvq47PKu6ERcaD9XIdiX4u1RzsIrKl0oIE7A9bTxF+Jdio466np
 2xR/dsN0MZ3P6OUtX49K63K8Mji4oUaHLUZ/jeox+MeH8S/B8JZpi+yG9RLIhA+PVHE8389Wx
 ehPugau4mQV0JuSVmoz6cnBdjn4pPGLDXF1rS8sVGJHoLu1ZQgA3QswxaKySjeWzItECvltis
 LG7/qIA6rr2uXoijr3/85FKN4+Ie+zxSQBanfhmuGCV4MlaLtKmOSZ5x4pYKm9UGcKiaYrJJW
 WqUmRkfPsRuOmHAkz/Q+MC7F8NxwtGh7Wb3Utc6Qjd1naWsEjzJ26w9tqkUW559kiy4trHTN9
 dU70HuSUMr5afFAliEeKcmACtC/Gc+lyNc9BcYJhNPRMW7TkTZYM+ctQny1X7LmO74TbyTDsj
 E+v0v7TYAq4J7JsQrWCe0PF6ZQ50OVoxoNV7lQMSGYS4FvdiNRkX8yPd6IScGR9Wwp9MkJPur
 dXnfi+UPDpeUmwes2h1OwHlwJuirw8EkztE9HkO4arN5+5YMsv8be7hkjcJnoSlJh0riwBQpp
 bw1eZKKdmeb/3xmL6cPhRlDvgz+mr8JC0Q5F97dDhR51Aj6PczloeYVVm+NcC935RnRtyLloN
 kFNJ0x3T9FpRCi482lt3P9LE2CpyX65zZdBtTGPVG+XbXOs8bgSbR5PeMdv4VD5l8zM0v+NX9
 jwT19MBNKNVHN1UElTUtc4NcHEG0S96p0QTVxGEasqBHRKiLSRwJcOBLJDrOyqYVUY//jiKNd
 lyPoIaHYZ1UKbqAoOjoOGgT1VrHYNlaqdjXhlqI275OiI2Ev1S+HUOrTkvACo13rU+GRZyuYB
 VGwFbqOgpghVzHo3ucczuJpgHmlruxcS/Y67OvAHT8VnTRAiScpEum72xdCHUwKAUZVgh/rIE
 j2XiC+4gnPmYmIT6b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If an error occurs after calling 'kfifo_alloc()', the allocated memory
> should be freed with 'kfifo_free()', as already done in the remove
> function.

I suggest to reconsider software development consequences around
another implementation detail for such exception handling.


=E2=80=A6
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1043,24 +1043,31 @@ static int stratix10_svc_drv_probe(struct platfo=
rm_device *pdev)
=E2=80=A6
>  	svc =3D devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
=E2=80=A6
> +	if (!svc) {
> +		ret =3D -ENOMEM;
> +		goto err_free_kfifo;
> +	}

Would you like to take the possibility into account to avoid
the duplicate specification of this error code assignment
by adding another jump target?

-		return -ENOMEM;
+		goto e_nomem;


>+	return 0;
>+

+e_nomem:
+	ret =3D -ENOMEM;

>+err_free_kfifo:
>+	kfifo_free(&controller->svc_fifo);
> 	return ret;
>  }


By the way:
How do you think about to omit the error message =E2=80=9Cfailed to alloca=
te FIFO=E2=80=9D
for a failed call of the function =E2=80=9Ckfifo_alloc=E2=80=9D?

Regards,
Markus
