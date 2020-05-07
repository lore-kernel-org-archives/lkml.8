Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA6DC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA1A208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CgX1hfmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEGUaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:30:52 -0400
Received: from mout.web.de ([212.227.15.4]:46871 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgEGUaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588883413;
        bh=q60NAPu4JTUrRuU60qiN+V5aGjYCl6aKIElHv/6o4kg=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=CgX1hfmUsIujjPH7cZTeiJXtQVndukpjLbIxu1qnPdikdA00pO/RMNVLdK26+wQp0
         Nykh6CCBn7nF2lXP+6R1c/Ohgai+xlaNodnDnk7gDqf0aAi9g/GmrZ16oR+UbWPDNR
         9bjrL6FpowXC8UD9FBJUmq+vJEPmwdkitRlDd3Dw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.29.220]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mb8h9-1jrKog0dB5-00KdLe; Thu, 07
 May 2020 22:30:13 +0200
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hewenliang <hewenliang4@huawei.com>,
        Shiyuan Hu <hushiyuan@huawei.com>
Subject: Re: [PATCH] tools/bootconfig: fix resource leak in apply_xbc()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <63755ce8-5e1b-6c54-2f74-649cc2546371@web.de>
Date:   Thu, 7 May 2020 22:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PVpRxJYeS7yQVoNUDAga99j20ZbPA9xj+AB8inkbm8kgT/QzZ/K
 o+fDq3EA6YZe9rnoyhYMb/ypsBfYfi1cIV4kxzCXd2ibl5ydNMaTX6K2e6V8I1xqxZmgiRN
 /NhPCznR779J5OTsDTwuoeBsuN/XOhTTzNs1dFMQl9gYI8RYbQnxE/LjPoHOcAfUEwXOiN1
 3sB0d52Lj5T5m/y1JRn+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zco9H5dHjvY=:4HlzXo6lhw19tiwTI3254O
 UsjDsyVBa2aRXhms9EraGDB4/LFjDCez2BmDZ8RcGKFigMTBPFtZSk8R4pZ71kKpBZDkTn7WS
 nssdDt/ouy11RKWto1JeBO9IDMuE5HzPIVhRtgqPN4puKAA7YihArOyG0iusDP1P9Um3H8VL0
 Ir0dT+7Nt6hioyaGvCvRxnqXtsWQrxZgGeQI4x1KZBC/KIAi+TZwYsllN+K7S7iYCCPAQ/I9P
 Aq3xB9j04vaJKn7563sJqXs0Tg3RfWDU8bcMj0KQ2pcgq/BImiTOwTH3wHGUFRy3hBLk/H2vW
 515vqu14ejEks1PK39R8yMsOf0wPXSl8LheIcnKFTwAEmYKVUmiu1Ev4bVu+/CqEZ45GAW8fY
 j15FrpGrdzsMwHv8syPky5pZ3a0+Rg8MUaR/rfa1BK6R1w13JLylRTKlWPrTVPIs9CqFZh6eH
 96inEPcNEexxQcW28LlNpVRaFAxIKiIv5h2FFbQRztqWq+3+jqOq2AOTCqo3FKNuJiE+AuOya
 VXOdeMR24ApQ45pMIk6izGXISs8gCrjWHl+MWiTFXTgwns5eWhHEGItY1GGQ5mqW+UQ91ZQxQ
 fl2o+YMn4x4th975OHDuI4DK0LoBYk4VRVlZ7lQRT5DXhJ5r6ypHnIGy7GrCdVZ44pirJgKXA
 W40Z5mGp21rdZcfzjGv2N238Nv/4pf+won+qmXlADeiFUQ2zC+y0ft75t0UPsEZwHrM2dw7wd
 xg08IJrdclVgxJBSuzKM+b11p1SCCv14ZWQxcUxTZlZ8cfcg8yqf6MnPKj8LvpIB1V60j9V/C
 DwrDtG0WXk7U6zmwa5c4nqxw86bxa2gw1r9/cjmVRa97WCRg8tO7ezHEactRmITvsXIQ3LccU
 LZU84NFo0S1d1OjhBKudWDrBneS5EbFWzRPYz/7tUhWYVnFJYrE/8GXRjsraD8J6tLiF8JmjF
 /KpJMdLzM9bdxpCqYtZDZlWe1sNVdM3iTDQYI3Pz79lxtb6f58kndzrYRKNJeVYt+bN4JpfCg
 n4+2WDPM7ur9oIlmLISamJLYt1JazBegt+vxKsfy8sDZZhruUHlOzXnD/9vQKx26sS9q8fqPs
 kZkJmtxZJtnKSnxgS3QkNIRtkEFty3pyH7xsAGLl3LwzS4rcZhuqXJ8KGqyLyvNkOBwVvjDbX
 E/sOSc/jFg1KvlPwU3/I6ywODfGPeRCiEGQwCvb/Y3PRetq7EYu02hl8IPUycWAH8HG8gIa2U
 CuAzSFZWsNSDPVPGY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The @data and @fd is leak in the error path of apply_xbc(), so this
> patch fix it.

I suggest to improve this change description.

* Please use an imperative wording.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?


> +++ b/tools/bootconfig/main.c
> @@ -314,6 +314,7 @@  int apply_xbc(const char *path, const char *xbc_pat=
h)
>  	ret =3D delete_xbc(path);
>  	if (ret < 0) {
>  		pr_err("Failed to delete previous boot config: %d\n", ret);
> +		free(data);
>  		return ret;
>  	}

I propose to adjust the exception handling.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D6e7f2eacf09811d092c1b41263108ac7=
fe0d089d#n450

-		return ret;
+		goto free_data;


> @@ -321,24 +322,26 @@ int apply_xbc(const char *path, const char *xbc_pa=
th)
>  	fd =3D open(path, O_RDWR | O_APPEND);
>  	if (fd < 0) {
>  		pr_err("Failed to open %s: %d\n", path, fd);
> +		free(data);
>  		return fd;

-		return fd;
+		ret =3D fd;
+		goto free_data;


>  	}
>  	/* TODO: Ensure the @path is initramfs/initrd image */
>  	ret =3D write(fd, data, size + 8);
>  	if (ret < 0) {
>  		pr_err("Failed to apply a boot config: %d\n", ret);
> -		return ret;
> +		goto out;

+		goto free_data;


>  	}
>  	/* Write a magic word of the bootconfig */
>  	ret =3D write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
>  	if (ret < 0) {

-	if (ret < 0) {
+	if (ret < 0)


>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
> -		return ret;
> +		goto out;

I suggest to avoid an extra jump at such a place.


>  	}

-	}
+


> +out:

+close_fd:
>  	close(fd);

+free_data:
>  	free(data);


How do you think about to complete the error handling also at other
source code places?

Regards,
Markus
