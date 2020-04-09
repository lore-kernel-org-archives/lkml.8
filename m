Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0279C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8F820784
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="X/lXzVm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDIGDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:03:14 -0400
Received: from mout.web.de ([212.227.15.3]:40973 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgDIGDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586412156;
        bh=lYJRnlg/wqX7fIAnkK5/0AvxGdwagOb7JQMylKhjSNA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X/lXzVm1sYyYk8NHrXJ4aLs3dMQHY4q210M0pddvzPSI016yLYbsOSlO9kE4aOEEs
         HegjclF06BlbQf4gNZqAd9CvDy5caGvOAisIDLm6Zm3jzz22pdIzuK7eR2amphCZuv
         UNSCU5p0UmfXlZ771GLRqoW/7WN2vZqCyofE+pUY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.77.56]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQO44-1jjYDQ0f3E-00Ti3C; Thu, 09
 Apr 2020 08:02:36 +0200
Subject: Re: virtio-mmio: Delete an error message in vm_find_vqs()
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Boyd <swboyd@chromium.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
 <03b19e72-0021-dc6b-77c4-ed3c4e13d526@redhat.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <96031fc7-dced-95bd-fc57-a5fe890638f4@web.de>
Date:   Thu, 9 Apr 2020 08:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <03b19e72-0021-dc6b-77c4-ed3c4e13d526@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EMWukozlN3wH+VwdQCTCGtYSfB9wY9UF7L4rPFXSSSSYz9ornFd
 xYxnvpnQCkrQr18gj4R+KBtUY1GmS9EhyNuh6pRnADqggoqIKsCgPL8ZveoLXOUb5lyHk+4
 OkuoZpspkaYMEgXvibr/8YtC4PEMV41hKxFhAt9jvnHLP29Q+r4raipxv4TnlhBLmvrloEW
 fk6ryRRqpp15AuaPzdHig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7PKTovR3zGY=:zJNd2BvZLIZZWMBkNqsQYb
 bRDkoEIZV7C+TTOXKXvkRZMGGgbryB9reQa97TMpcFsKegKGftKU2Y82Z3TyQvijPURG0f0oi
 iizT2fMjcDK3M5aW0SmwursS6DB/4yTaTnwi1wBKskDVpLrnthynEIJY3ERArUNuTMnHwlG84
 X2MG7zl6FKIRi0T1gxnJpncJuq+VvsXWwPpe5Soybz/cT48GrDqrOX0pSf5YI/0lgowuc2Ft8
 bSvWvms6o0I2Tml0NHdY30F54m2me04ISNG/s1M0t4WpDrpfVsmoitGrUMstyRv1EZt8pd76J
 oClZIBTD/BGPxJeaGIr4xsF2ceNP85qEVQTyAtWsHWv2hdBCfRP4ntO6fNSmgnm0snYRBgKVE
 nPBQHVUU1F2YIZKo4RLmjtIzsGsaevpDA2o1GEdEi5s3s+7umB1MYsG0Lw6vqW75GPdHHqWiR
 rHX7VxAQQbVF7P5OXhcM8mjk1RibgSXbN+QPbrG9I2nf3yDMvhCUhyQsLHsoFzl8xqQ8igFoT
 dcizzhFUMxfGEO+XZ25OZxTGW9wEpbFlNUVsNe/cwnxBvARC0Gq/UOotM1u0kAqbxyJVcNlgX
 XcmvcytXkc1mMnns4ZsTLC1xJ0NFoorY2u4pau4lQJVAsyS2ejBeP5K356iy16Qup1qGQp3hM
 BSYJyqSORCZqPq4A77OkL8rq8v5Rcn3cdv0KVS+ieyhZ2/v5u2OpxFOaEAGKsfYYqkqdR1g14
 b79SG46wlfi9fQyvofmoOvfX9SCTstNEmdFnnlCiJobclSt+Hd3nkvJZ6jfFnROiAzdVqX7Bv
 Mo8EHE/Pr0O0y/QMFAWF5afxk6bc7CJOaBctpPHbzBivkpHcgrrbkUK4F9FraBgc0RLLvDLfe
 3WGXBleblmgAeWMmJVqfdTyGOo99+zRUaXnuF6jWqNr+I0VVnqqMSwV65as3uMWkwqP3sVqvH
 tCYIPxjyXJhuKeh6/QK3eJDpaF44JU1v/EjYbAdvQUPpsEZxv2RvKlJm8MKSuI4dK1c2GZ5Xr
 fzCZmqIDy2NCCRlOm8CM6IjTnZxHRQk7GLeoDt0LZhXuMQOlMmKZVotRYTvo7F6QusztKoHp7
 Edtq22P3ZfSY8T3ickGxRszvLCyZbHfP6+RmBxr6AKJ15r5Rx+co4EAQfpjmnEh45UHsnDSkE
 awwRLpBJUjn8pd8vTN2y63GPZ0pk9jwab3e4cSLNm2Ssx4IBF8YQwd/QyjTqt3Vd6/PVvr+tD
 mbMa4/WI5bQCxAmB+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error alread=
y.
>> Thus omit a redundant message for the exception handling in the
>> calling function.
>
> It looks to me that not all error path of platform_get_irq() were loggd.

How do you think about to clarify the handling of the error code =E2=80=9C=
-EPROBE_DEFER=E2=80=9D any more?
https://elixir.bootlin.com/linux/v5.6.3/source/drivers/base/platform.c#L20=
2


> And git grep told me there're other users of platform_get_irq() that che=
ck and log by themselves.

Source code analysis can point further update candidates out, can't it?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
drivers/base/platform.c?id=3D7723f4c5ecdb8d832f049f8483beb0d1081cedf6

Would you like to achieve collateral evolution?

Regards,
Markus
