Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C021CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E68A20746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Oc7WxtGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHKSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:18:46 -0400
Received: from mout.web.de ([212.227.15.3]:45059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgEHKSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588933071;
        bh=YmBPzNs6D7sZ/Hty4MXW9rgfOWqv9Wd1YZ1/1LyuE1s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Oc7WxtGyOn3YQC5N1qtl9/+7Htijsjg5K6mxUZ8GpIZiVIgntRin8rLACl+74tAoe
         aVj6SsxRcPYqWeeYcPPqKcChwtD54O6wru7QAQGao9GveoGvcELIuUIr1gk4kuBqmn
         HXHUlDL/MsVoA8htUl11uFOIbREZWMlQG+7IHQIA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTzc-1ji2gZ0zpQ-00SdFf; Fri, 08
 May 2020 12:17:51 +0200
Subject: Re: [v2] tools/bootconfig: fix resource leak in apply_xbc()
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <189d719f-a8b8-6e10-ae2f-8120c3d2b7a9@huawei.com>
 <20200508093059.GF9365@kadam>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <131a5310-5d8e-5eb5-e55f-fa0a9a829ec1@web.de>
Date:   Fri, 8 May 2020 12:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508093059.GF9365@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:khrr+hAbY03hkmvjsudN30FE07p6d0ztwJLJtVP/jIdBRvb/err
 llaEJgT75GMH2CCWNudALNi3uS6H1WTkMn+eltZ83/Le/gyEC6jlmenXJPBqWia68KYf7hz
 qfGnwGy6sa5VH/qSwtyhqXL4uj1fql4BXXGOw6EpDo7O1ZHeGYpCrFBzoSwQZMyF9N+X494
 LyQlcDtsG/F0lN1fBzVAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pEqbI967NxU=:XYHxCcExUVkZDRRqQs1Exe
 7PA7mpyk8dsHUwA7rVPA7/xREvhN7AybgAmJNcFdejBcKsZwAHoLHIOplF6frNwBaL0cBGyNt
 5SFiZ2HTlYc9FCzoVeCzJdumCpGMtq2PAk4UCc8XEipQkzXwrDsOwSS5O3fHrZVFgABxxBldb
 uF00GgxnPhmT00++/qhl5feun7vYpUOAKJ1Q/dKwnFMdQ45obnH1+mjj2FOcLh86z4OBJws7o
 tMSqO0s0Xe6VRbL6RXSBl/oJwoIi47n8GR6B0BOsR1omiFoXDwn8u6DqzP70TvwAsoKf0VUss
 BOVQoDMFoeeK+T9A+olRKKSGurAZngv0Em1dRkuJGTLwHxSruN6QMV/mhilM01nYQuvI+mgFg
 dT00EmTTIZ0VrP0syCdE2DIewEmD+39bw0Ik5qdi3VnX4o42JtkMKMFA6ItOQyKmALD8Xn75j
 DUqyOFs/0jtjT15kX9lXDVmqI9ZzDJvkavBV4Kedz1GRFFVa7XcY5hPG3tV1u++0g53PZMCYz
 6F+H0I3ES3vYZmTPBYnih1g3/+5KiInXU/WtTrZWoYi5m2TXOgsWPsHc6XO1ZyzoOFrXcPlcl
 orq+ereEPvxd/BjH5McbGIQD8QBJkbf7Kr1xlTqAoXF7EcSNTZzvrpjC6NWPhNpRNP/tbxqz6
 ljeitHukCPaMSkAJHr2oUlSO+3kHdY1mCPEgwarN4onUjLau3CCob++RL+jVz8wME+gldkIDv
 4H154LGaWN1CyKV2WatCNYA4/1R4yawguJ3wjbLlReJgYbj4875rS7pa5IsqO5wnSMVyYEgj8
 atJC/JL4OSIAcYCsPfths0OeLA6vRLvxN0nslPwl94889x7hMBNZbsY8i4pBbmuXAq/0JPRht
 5jNo+sJnM9tI3dZ91UxOUPzytb3j8FQQy6dnxtla0w5MTpGaDQ8Hb65ES46lT8kzaul+QsqDL
 eo8jsn/YgJpbGKDXcTzBkvtwTAHQ5hIfz7x3SDvuHgXHwAIYZRe/qVRKtXD/SC/QoQflPITbz
 hN2okyjORNm+gFyTLwNLOfvSyEBhxib1FBX2aOviVoUIb+dGH8rBnfJaMo12Hc+IOGMhsrzp9
 QjXG+lNrA7/6B9qdfg51ZWqcjoGhjx+PXTxESTVOaN7kz0KI2DmOQSdXQpEh7Jly86I0BUN3p
 LXGNj7LRWQBi5cjGv3+f2UhATeRglNYAOVTleKgh3n8FXJrUcrG7Vl6DZnJwMmteIn/LvejAo
 kdAshjhXqycYOMW0D
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, these leaks are totally harmless.  This is a short running user
> space program with is going to immediately exit on error so the memory
> will be freed anyway.

Can such a view mean that the function call =E2=80=9Cfree(data)=E2=80=9D s=
hould be omitted here
for a quicker program termination?


> But the benifit is to silence static checker warnings so that's useful.

Would you like to extend the commit message for the explanation of
the importance of the proposed change accordingly?

Regards,
Markus
