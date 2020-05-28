Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF84C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F572075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IsgGFPf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403998AbgE1PCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:02:51 -0400
Received: from mout.web.de ([212.227.17.12]:41941 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403912AbgE1PCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590678139;
        bh=XAlZ9NlFpmpE4T1vzDKjCyi79kivASTGD6nypBrWwyU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IsgGFPf7bd45fb9vMm5tRv2jjsFQXKrY+PEODjX0mtbq1BOoGkk5/A1+y88O3fT57
         sL7leqDtKPS1Dw0903JlCHlN/q2wBJIwhqYkKgDsRXR2S8UlSAC4wXh9slhFU8bmlO
         MDaaZlHsujpTds+Q/0rdY5LfAy7YAvf/qjrv0iik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG9DC-1joFex1Uia-00Germ; Thu, 28
 May 2020 17:02:19 +0200
Subject: Re: [v5] workqueue: Remove unnecessary kfree() call in rcu_free_wq()
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Zhang Qiang <qiang.zhang@windriver.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
 <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75afce2b-cdf0-b917-cab5-f36d105abcfc@web.de>
Date:   Thu, 28 May 2020 17:02:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SyQea2mcR7kZajl+TazE9ttwxonaCGfXKQ2UnI3DIy2jOqVknLK
 NSVku7ElU39PDHnalEfvGxWNU6tAlz1UdBstByK+owtpPhevM2ebWZT42GToGdUSLefjgEk
 qAobBy4LQUAzBOfiDdTbhgPFWcyk659vL/mLrG157mff1nZUu3QvN3fFskluVpM/5J8hjvl
 eV1f3zHQCUWn5cxQH/yuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AczgUwj0+1g=:fqQvrpBy7yOvwjP+2RzH4P
 GXMkj5L+E3sKg/4fyrvsjXFe5zyhN83XHf/jXbe+JTakbzzOX//AFUtZSatUF9ajfu/8F+DwW
 b7p48G1ZSEkqPqAkoGmbJFeorz0cghvcUwTMeTIZREexTQo6lEpBIm/76os4dbwdqCEh60Oqg
 uw3Bp/GH7JnwkTVNeBFV1V85Q1VIq1n3XvS+vuVJGnRkO+TlY72XvniyH7md++5Z9gOwlR85p
 LdLRektbUJwmAYsRVtC5MqgICkHH56lNVTWMhbt3NziHv8L8ZliMposRyi15FWxAruEq7O7kQ
 nsiH24y+a80+ZzfEeqchBqGaSY+vFOnT0YYtHKkfC9USCMpZduEtPRlIjDbBcjcKdzpsZsoyI
 RYRyie42/X98bz8xfjhM478JDes7Tbpuu0Ik9zA8JymjN2IUhKWllODqojK6Q5ClvMNgEzaK3
 HX8o9UdGst60qGVgXEfCC3qKsmnDJmWN1iWx5SCJ0w18F1ClyNSHVdCDv1ej6SLJ30wniLmS2
 zs73ttW7Wm1hZoJOE9D0K3bfEAOuZOUkBlM7qhRoHMbbV+wK6/xeEw1Xw3wpgaMqC4AzTiCFo
 mcXaECKEaqqXCni37sJ/Wi/Lxo+LZvmxv35OW0rB1bfoW9sDii/71oG5O/aEnuufGpp3O1lCV
 b+B9397ZLcm5u3DzvwEVOvLG2LIaeR3jeJ6x11iRTpVEYZuHmG2o7D5dPUO8Is+I5+m/SGp9G
 tPmU70gHqrPssc8xcwlU+HZqEn4mP9VySol03OUvLl7pS5Apbo7gB8u7CzXC2pntNOrBFVcy4
 gDostiZUrRpPsnX7XNFn7ISZGlVERHPCVppGi4cSw3Dwi0MhEFxffSep4XR6nfJMG8PWzcxIB
 FgRztVuevYe0164+mlwfMz9V94AX0bAwzAI3PkN7LYiA758lZJUyeLgu7s2zxsWmEOlRlg5N7
 ffpNziy+0IKYw1tf6Q42sF3zDqnjvH35YAMa4GlLa+j+EaFkxhIWFlBpcB0d+EETffEyfDhs/
 SCzbZYZMv6aUs+u/gqE2H1ea+EetoS/etoyK6HTejr9VAvMUd17KdU53DAVt4GCR75kwaRkbE
 ofjxia0hff2wqvWEmVAqxZg0wHaEvyADgR/x4j+Jj2GHXYwhN639AJ0UoTaLsU2QL9caDXL6q
 Ki4pqpD1oFeBiTIi2B8yK8O9CY9jR19Tle9Ra0/qG7PIf+dlb2bHiWiQ4niTMb05sxrZTO9tJ
 8S5EKNmYYE+r9Zv1w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm also confused why they have been debating about the changelog
> after the patch was queued.

I suggest to take another look at the provided patch review comments.


> My statement was about "the patch is a correct cleanup,
> but the changelog is totally misleading".

The commit message was accordingly adjusted, wasn't it?


> destroy_workqueue(percpu_wq) -> rcu_free_wq()
> or
> destroy_workqueue(unbound_wq) -> put_pwq() ->
> pwq_unbound_release_workfn() -> rcu_free_wq()
>
> So the patch is correct to me. Only can destroy_workqueue()
> lead to rcu_free_wq().
>
> Still, the kfree(NULL) is harmless. But it is cleaner
> to have the patch.

Thanks for such a feedback.


> But the changelog is wrong, even after the lengthened debating,

Do you expect any corresponding improvements?


> and English is not my mother tongue, so I just looked on.

How will the patch review evolve further despite of this information?

Regards,
Markus
