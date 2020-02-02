Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5CC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB01E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 00:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L8wlQXKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBBAQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 19:16:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:53859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgBBAQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 19:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580602565;
        bh=Iz6JnGq++RMIHsnw+FCQtg3vRLAqepeZ+BGIjR4JFrg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=L8wlQXKntARNcKFFfwBJh+0xPAOUQs1/q5LBfpyJmlgBMyvhJaapsylinE2lAYS0S
         5JakKh3cg8/ZvcsCO0AMX+uVxkm033aoDBq1OOmtZo3H1Z3CgyVcjwTeqE/y8rDzLG
         B+gBh6USNNyQwYXtg4cfe2g8MAL880wzQjYdwqHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from chef ([212.114.254.236]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1jBISj0fNQ-00M06l; Sun, 02
 Feb 2020 01:16:05 +0100
From:   Julian Sax <jsbc@gmx.de>
To:     Joe Perches <joe@perches.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6ni?= =?utf-8?Q?g?= 
        <christian.koenig@amd.com>,
        "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdkfd: Make process queues logs less verbose
References: <20200201231101.2127964-1-jsbc@gmx.de>
        <b9b671508d478469c1ad43206dd29d770bfb7818.camel@perches.com>
Date:   Sun, 02 Feb 2020 01:14:46 +0100
In-Reply-To: <b9b671508d478469c1ad43206dd29d770bfb7818.camel@perches.com> (Joe
        Perches's message of "Sat, 01 Feb 2020 15:37:43 -0800")
Message-ID: <87lfpl4zgp.fsf@chef>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:XjKgjo79yS+CkYFZyTj8MqnkUUEbS8HMXP9NflgFBKb9W2PPEDF
 weuvBWkVjtKfrd21VgGpBZyxTSpanfQKcEdTRev4+VPYFz3h1hkTruiVbpuUcg0c+5Ah1mk
 N6MuAW3+dOSqp360Z7kTxr66j6wyGT+pxn2sC7qAMaGJCPkwIjRJ3KjRRYyaj6Fo+ateOx7
 fFhIWVGSvfDfDAwOjJVXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jv17eHekCmY=:WvngTvut/2R2v8Wi/rxAi7
 8wEY/UPppVYO4XdOjeNZy1sgoRb4QgA1v27t6CUhiC9egpSBDe2zmCuU70sga3ntGrPJcwcD4
 lxVE2f44Gv2eFJkeXtmbXURHYkO8vUE+RIlMWVWxp4/ha1kljK4RBLq4RZcac/PY+DVVszvt1
 ufwLl0BZrBmBT6/a5UcHvrsVREgx0TLTNUB3BndHzXs6niAVTTal5DPF2u9ZK8xlK1Zxor6go
 L6tSs5vatLQ1Wbs9/eL+O80vJxhOvksMHjuH4s3FNWQM9deiAEQiffBF3LWpNpm/vSyS4eslJ
 CgLaLOKazHAl/C5LR1ePjkBTsb2TfDgx//ualRo9kYaXWm0OVlOvbVt2miWYhWABzxnZjP3dG
 a4b5uJCfR36XfxAiiBIJdiumNCgrfWF5l2RxohjSNsLdxZG7O9AdV7jP+42JfSyHRnV1DGcpm
 nvM41IwnR/VCog4qv4qR/sfmW1m4INremGiemtkeMjz8seuJq+D5mP2jC/1rJ1Zq2d40T5KBc
 BXJUnHK/vpqYWuD1t3GX8gINLTdahNcGQnki/5gT3LTFdesySPLOglIzTD/b9sjHFe0bHb7+9
 bfX5f5fre55Vx7KERbCZ+q4Jir2/r5uHORYiRphsst9KNe0pGr6jqjRkdlE3Z4i2IlGPezQdw
 Loyl5pnUJN2rkKeLJuQ9wy6lzFgW2dyOXM3GJImrPias5ZgWysTSVIuTyybwpvDcGa34uANat
 2ehWFPOPOFQ2YK6isyiyrmAdA3HPa8q6FIC41qsKSG51prgjXYGf9KiwDZesCyvs7zkdoIxuo
 Lf7cQ1TAjc5nY8tzuwvO5mzF5OfExnnIm9Q/1PBGpacHHW5sdxOIH3lAPQdmZ9zd9tSy9t+6y
 qSXnzzldH++Rc76WK4qsYlFYs5gjsHy0LqrrMRj/Vt/sWGXws+HHWEmqtmCOQtHVOgdEr5HiT
 fpcvIYwNiOsVs2vpjXuaZPLWfNt2qkWDRy25WsMdlSSIcScddVUGcZlOV31zNJ3NF4pHOPMfE
 Z9hb52jAyljGC8YHxEWHH/GJB5ralt8gmorDtivWWpqOJ1yX51uzWKWDY6Qv3EuhLDnYSH3T7
 UUkhrWVvId7DYddMKxvvW9IJVjbf8aZcqeCTwSin0M0kN70ylHxZS2io9X0c1wEP9HULxq+Ws
 Pjqzo4bKEI/+BSmRLQIjdZGzftiC0bEfWY8wARX0SUjHRHRhY2xWRBbsiiM4fhdDB8bOU=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Sun, 2020-02-02 at 00:11 +0100, Julian Sax wrote:
>> During normal usage, especially if jobs are started and stopped in rapi=
d
>> succession, the kernel log is filled with messages like this:
>>
>> [38732.522910] Restoring PASID 0x8003 queues
>> [38732.666767] Evicting PASID 0x8003 queues
>> [38732.714074] Restoring PASID 0x8003 queues
>> [38732.815633] Evicting PASID 0x8003 queues
>> [38732.834961] Restoring PASID 0x8003 queues
>> [38732.840536] Evicting PASID 0x8003 queues
>> [38732.869846] Restoring PASID 0x8003 queues
>> [38732.893655] Evicting PASID 0x8003 queues
>> [38732.927975] Restoring PASID 0x8003 queues
>>
>> According to [1], these messages are expected, but they carry little
>> value for the end user, so turn them into debug messages.
>>
>> [1] https://github.com/RadeonOpenCompute/ROCm/issues/343
>
> trivia:
>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> []
>> @@ -604,7 +604,7 @@ static int evict_process_queues_nocpsch(struct devi=
ce_queue_manager *dqm,
>>  		goto out;
>>
>>  	pdd =3D qpd_to_pdd(qpd);
>> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
>> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>>  			    pdd->process->pasid);
>
> It would be nicer to realign all the subsequent lines in a
> single statement to the now moved open parenthesis.
>
>>
>>  	/* Mark all queues as evicted. Deactivate all active queues on
>> @@ -650,7 +650,7 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>>  		goto out;
>>
>>  	pdd =3D qpd_to_pdd(qpd);
>> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
>> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>>  			    pdd->process->pasid);
>
> etc...

Yeah, absolutely, thanks for pointing that out. v2 coming shortly.

Julian
