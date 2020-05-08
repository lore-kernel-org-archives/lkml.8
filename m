Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFBAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545C921582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EEZ/A21u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgEHQm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:42:59 -0400
Received: from mout.web.de ([212.227.17.12]:46103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEHQm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588956127;
        bh=RMnvIO2pfjr68s7Le/qhS4XDeqiKe90+5ZTv7eEL7xM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EEZ/A21uwKbTER/4MHPCoXZEmmqyY9eloXuyWwSwgpDZD3/SlURAgWljnhsPiYjrK
         vgwe6ZXGI0WDh33i6qes30I8Vhiot6B796vElWwz2NtQQdhzE6sniwqCnUP6obyU9H
         ZKbkJzbqTqsG4Ve3d5HL3R/T1UMHXRMO5l3Ah2sg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1jqPL705Tq-00Lh2b; Fri, 08
 May 2020 18:42:07 +0200
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
 <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
 <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
 <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
 <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
 <20200508090053.430d28d7@gandalf.local.home> <20200508144527.GR1992@kadam>
 <20200508111449.575d176c@gandalf.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dbfae758-c516-dca1-5511-9618510e49e8@web.de>
Date:   Fri, 8 May 2020 18:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508111449.575d176c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYUkUfOdJ2IcPc5l4kaPfsMdMYNc2QlWZSLHQoCG0hXjvamaSWN
 Z3sdXpVJsOTFfBC+0Kvc8Q9BSopFOA/2RhkCroBvPatREL6e6Sqfj30vBuvpm0v1aU+HDL5
 zpRcMA1mBembgQeTA0X6NuUgFG5LfIbmwQpv/+1I8Aq7FG9qr2oiEBGAm1wZF7Hgl7kK8if
 TAzKcZr2HkujBvZfD/znw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+QWiQmkbP4=:iy+x8Nr5fC1VL1AIhvG+VJ
 kQQQRbSsU0LjVwWLqDYgDJQ8XEuLROCgBjmzrDJTpScjGA/BqGgsTuXQGtMqrVzBV/nxWxb/Q
 lycUCUKKr9o+NymnT41Ec6InCPWg6lDtMVf38ZA8HSJEQi38bkf7IFjWJRXtnWWw3rgte38iw
 7eTytrkCTqMa9fBC/NFnbBP0M3sEFsTP5eCqIEkD9xgX9hVR9+up82hIHExDWcHt0w1e7ylka
 YFskC471aQxU8Gvx6R/JEFIjReHxbyO3oxHxFZCm3QqRVIlA+dIl/L0vpu463Vaq/LAZlh1B/
 kb9etwlMoUBHwiOGQWHTc9NCv0QkC0PMatsDD1MX1Almy0+M/kpjorEvsRoALEfVn4DY0j7ol
 +dyvZFsxnIn7vORVvyCOf/8h/A8C8lyUEiXKziLImllqEuIiGwzTnsDUWj7k3VHOt6nICthMu
 lJaKzwyKqvbFewa/hLZ1YzPdGZvLPiXkLGmakrrIfZRzX0/stGDDT1YVtqHC7BCUi4WYIyLOd
 BqP+NjpYuTlJV5eI8M6YclZcBDO0xuQP7IVKPeXKAou9JvFXQSV/jllPPZc3PKXLDyX7nev1I
 oxhOfazNYQ07Z+dwz5gEaSfz1zqpi1ojLtpn45Zsdog/rJ1WaJFpTvayOuVuNwezmJCACBnWc
 b/sxV7BEGkl5NY4HGMhXh18SwKwcu84QwHN5f/FS+RYUwPhyUmK4xxuplzqrzSLI5X+20uQZl
 Smki4Pvjwg0EoSrCW6pRhHpJcX4Yw4vEtR0pSDHnHWYyzAJV/zyo0fL3fAfOX6MbVMFoGHao8
 Ty5LJsSObbuLrQshQAS2tymILGwODzK/1CRmX5YL4MM0xTkSMELBEgXyyad/13vE2sr0NDocX
 6lGDZ4oLj71VgbXtYrBR/5QihZmLbhzGmN5odQE4GiW0ZA+LoaaUpDkEajR2FT3Vfo5KZtNOX
 3JueANVsoGFpMasc0KoSCZqnDxWaFDIS420iZVnL9G67yVALXcKbcDsLm0HL6aP+/pDoa6Qka
 1EYeIrEE+9k5xRScdDyWBMCnP0b0Kw+LZc/sb7+nl0QDkMRY7al/MAcqd8SY0Q/Ro0JB/x1u/
 ACVP82q80CxYzhKRipc/Tk3ooGctElPsUHe3JrevBcmmmIKhFtqaOYOQQbzGcU/GZIFZHDFCS
 DpVr2FXTXlYaCSI5ilRM4C79S9m/mA27GL/B38DK/SfKUaJMiT7G9DshH58Q4pQlSm6B0eLdu
 mJKmBKjLNFvMpJ+RZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> There was actually a bug in v2.  It exits with a non-zero instead of
>> zero on success so it will mess up people's scripts.
>
> Thanks, I just fixed it. And because of the distraction of Markus's
> bikesheding, it was missed :-(

I am curious how the software development attention will evolve further.
tools/bootconfig: Fix apply_xbc() to return zero on success
https://lore.kernel.org/lkml/20200508111349.3b599bde@gandalf.local.home/
https://lore.kernel.org/patchwork/patch/1239092/
https://lkml.org/lkml/2020/5/8/1342

Will additional change possibilities be taken into account?

Regards,
Markus
