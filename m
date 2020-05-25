Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBEA2068D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YzYPRNY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgEYIU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:20:59 -0400
Received: from mout.web.de ([212.227.15.14]:42701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgEYIUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590394846;
        bh=0tet/MAF1XgKTxPpxeRnsPyYCjI2rjofhsmdK+9nw/Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YzYPRNY0gieE3mZt21qRe8Wm44nhFRfxlzORB4RfmDrPZR77gf/2k9h4I65LrBJmZ
         I9DbgVXNPvBX4oTwknGcswOGiqAtczKT1qDC/G1juToVxkw/lH/iZA3FuMkF0HutAd
         Lat5dCMmNg/lRubRYSjrUki/TYLwbFVvWiM/Vl9s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6fv-1jHUJm48yl-00oaNV; Mon, 25
 May 2020 10:20:46 +0200
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_workqueue=3a_Delete_duplicate_kfree?=
 =?UTF-8?B?KCkgY2FsbCBmb3Ig4oCccmVzY3VlcuKAnSBmcm9tIHJjdV9mcmVlX3dxKCk=?=
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525075901.12699-1-qiang.zhang@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <efe09ccb-914c-6573-b88f-919bddff20a5@web.de>
Date:   Mon, 25 May 2020 10:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525075901.12699-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ux9I03w0FBB/uuLHfUCG2T8Y8rfoUzRVcJydsbtVGjwox42/VuJ
 6sxfWXegnlCdXxxe7Q9CdZ4yidefcgctmvxGAsFmtTy3he3iV+DfweGDswwhx7f72CbmP0P
 kAWEdWb+TuBfpQxZsHUQHFEp9GberC/8YWikKWpQ5Ak/KIMqXWv3tkzzVDQVjTEWP2FGrJl
 nguAaNhSUXnlhnfABbFgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FdMoqVmeSAU=:E5ww2FvZzAnXfZW4Udig7K
 gu19nSyHzLfBHh/RxHwjmtoVlEcPGFlsVQHYmvxMXbw7eptbQTeOKsh7gd50MCBpjsklsVZ+l
 6rsTgPyfgzr8wXt7r+ucCHycmQYyPMGhc1rz31nvR4n9CtfHPfMYHevmpFd2L83/+USskswOH
 JMdNqoM4BgUien/se9tEpqb+zUuBR2lNWjUmEQZpQWoYeUJNjozpg0N6Kx5ZB6+/nCgcbzx2y
 NUAnNRjmsOPuiWcKvBKg5b3DIH9L6eVTGmfPs971WNiK+t45moXIzp6QVS37SKb5OMADUWW0e
 u6kufsUK1yBwRESVVxHfodKlLfIYir7hNTpi3SR8RCfS//R83bs/78N+ZtyJIp0wxxKPgruZ+
 tVJAzVj148w2fCye8o9Y5CTM5Ne5MNQeBukGheppq3cxnM1Aw3NycZjLM1XO1MBUDpqx9qalc
 eeeg+sdj9GYyvJ8YHq6M5Q7WpX0/oChYpQqTKECNJypcacAmsTgsQyD+GMIpLVfheHifMFpLw
 88ALEPrVwBZygaYdFtX7I2pXLQw56bRosCfak4MX106S+BDbsSEwpS9tUzyJUSv4ePmPbnEd8
 TnHiBb7xZELzuaFNHou+YG9dnpL4Fqpm0Q7kfDKR06XOHM+zxi9u3wZCcBI2Fq3fMcPQ1eycr
 cyI51/QTTwc2Ar0B3Toe2Lgw4kT4XUYeB7JFm6FqMOuB9zn5935ffJg6Vi6e4gehUdq8zFIs5
 xHLItoMzapEfgdZ4dagPjiFcYuiI5l1QBU/zTgH7XLIsCyL7Tez6Fl0VoCBwFumLb4wbMN0Ms
 sVuQpmDARjJ/9FPsoakhys4aWQQqpLrL4qLTyby4gWosRLHaMV+Q3WaQZ1leLUmjg/14zWDSe
 lAsN6B/OdpF28VoLKowYwrLUn4Ih1mVocCDH7u8HJ8MICteydL4Hy9vf7o1IXV7WLK7a4w7h0
 FWXW8RxTtzj0h5m3mzrD54fTxpHGOJPoCj0A5ITY3GmYiyk3M11RNO2yNZH1VE7+/6b3VMCju
 nW5Ys1H0cApeu9p+YzJ4dlbFEqcUF0wfiBJAFboYXdJ2fXVEkHDHrDe8kN0rwAdOtny7Aoq2u
 o5ap0fafZOQ/ERCdHZThilDWJLTfjmwhWZJ3P6wmIDfjHrPPbs3pBDakctv8mcLQMaK9ps/ZS
 oirhqJd/RwWVTU6zU4OSV4xpUsdPSFFn4x72VmYtY42rXu9w5bzTTO6cG9SiuwTCDmPQ59lte
 imw7qyuCYVzNds4QR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The duplicate memory release should be deleted from the implementation
> of the callback function "rcu_free_wq".

I would find it nicer if you would have extended my simple wording suggest=
ion.

1. Mention conditions:
   The callback function =E2=80=9Crcu_free_wq=E2=80=9D could be called aft=
er memory was released
   for =E2=80=9Crescuer=E2=80=9D already.

2. Specify the desired action:
   Thus delete a misplaced call of the function =E2=80=9Ckfree=E2=80=9D.

3. Please keep the patch versioning consistent.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D9cb1fd0efd195590b828b9b=
865421ad345a4a145#n709

Regards,
Markus
