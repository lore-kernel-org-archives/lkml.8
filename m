Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00835C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F8420721
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="A3QcH1cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgE0GkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:40:25 -0400
Received: from mout.web.de ([212.227.15.4]:37985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0GkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590561613;
        bh=mfI2hFQ52IXtARQa6rbm4h5ZXG+Qg/KVDv0kdctt7Q8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A3QcH1cpI3UOrlNshLuZl5EnEOgCbR5NVHZ9RB6HxTCwsmEGxUp+3Mm9bweod/5vB
         5l8eJrVnj3eCIt5R54IaBCGK0yb8EeW65YxXSGCCO2gEWPSzy2ZCV5vSF9mfq0ztgT
         ht9djQDS7EeKLCEvU3bANyWxZI4mZC99i3+Pm544=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.185.253]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRl2f-1jTCbs281R-00SzHI; Wed, 27
 May 2020 08:40:13 +0200
Subject: Re: [PATCH v4] workqueue: Remove unnecessary kfree() call in
 rcu_free_wq()
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200527015054.34796-1-qiang.zhang@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <067566d5-9392-c155-fb8e-f2662fb5f60f@web.de>
Date:   Wed, 27 May 2020 08:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527015054.34796-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkKZNRBgSgIeD86dJGArPlxO9RkBDSPymeUmxAPqA88QollIOUi
 9cLWAmWYa0hZZzkbtnOEi0tPJrcPKRtXUxWVjH1PCVbcpe+n20ykqJEE/hnYBEiVNUjvRFj
 wg+2DznCQDfEJKDTFY26/Yg/7kpF/DUUPlYSyf2OsBw5CsZAWrrQHz/duKMQuv5iZ5oQ9GK
 +UzoG4TiSqFDqmncKZl1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qXYxUwt3wCM=:PfzgaYyZGNxv9+YCr9OBH9
 92GZX2OV3GscVsB0lIWTn9Twqx0sDZp7HBviMutkgG6ewtXG2IjsoktNkd0jv3/++iCF9zlRB
 rH+jLF0eVOE/H/oAd4b21Cf1DIEHGtVkUK3nc63Ix8c3HUI3C29BKRzzEc/yl/t1Q5i6KSxp5
 4uNM/GY7WkhWrTEwJBRkdopZRwT1za4GKrMMEOqR4Fu6M1TpuIEs1yw8CvhdWfY4vb9WuvQEM
 XgRuOSPOI381qekenTBNtVLAzaPwVyLzUfQ/XddPKtAGDfIFxRYZP5WReNf28CB3mJwT/NwB3
 E6lYHevD4YxX0F2/YQpUIxAMRhh2dYuvhGsj91QkEdgXcM+oTKIbPWgSNJvnBoEdcyyBbFqbM
 Y/gNRDZtMq2x/xOTjEKZ13RWtTr7evzOJzSFMTxsgqbt4NKaZIjBv2Ky1gTEaMlAmwbXGaxLJ
 1P273VCpKpiZ8/goldpeOG46kmfLB6Z1m4vvPbnnULMoxOW+uzvpZJ9/7ARK6mrsM9mXFYvWB
 rXjUfwN4F8D3YoEk+4cTuPJh+vKNQaL9GFB/E10rOBRcoXhpzuF3sbMzCUHblL6NRrhONoWfa
 6QKiYAYzN6e4DGjkvh1gW0OlZ7HyhxitZDaUsOaZti4spRIrLEvJPkFItoOTBCaG7MT0/FTWW
 3J5bdt0dwQCtjZSpMzNGxTdVCc+12D0yjXyqu/RvZ4JQW01nw0Ns+JL70aqdiqoeb9JhenMQD
 XONGWy0+BOjvkfXuxBwnlrq45RZXRdtyE9uaUIDGT5qV3QNdGW2ufX2uNX32KaHO7B6YAq7SI
 9ricrEVb0jLM00T/QSPT5x9s9d434AABj7ACTqWYlV69m3ZWPCTKk998z3XyQQXy53Yxp/+3I
 BQa0907b6Vtm/voVApMNeTxxJXEVFbpYgW9O6uSzc40Z66GzRJaMKGniysBhB7MJP2msQA27M
 uXpaOx0uB0MZOGCBeacgwxlHvlnU4v1fvPyF1E1/YTX67jGI9kU9VpzdkkiCSeFNAxnmEwwut
 pdawq9O9a+I7Qq0LkB8uWfeWFMrmsGhO8D4/6o4qCBmyZdsxKRcqHP/KZ36CPddhCAI+X6YBt
 UvuzQkYtN9eZKyF98g0kz37rpLFWWRVFdwFfU/4H4B2YC43QH1kZmdWnfVGNHtYlioqxFMfYL
 7Mcu0g5Hy8bKviG1sy8PIn0Pxm/Zje2TDEbJLRxyh11Bq69ZwZBLRPAnnU1OdDEMQ8cYLNRk8
 aFEQAa1Bi2KTsN/Uw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The callback function "rcu_free_wq" could be called after memory
> was released for "wq->rescuer" already and assignment is empty. so
> remove unnecessary kfree(NULL).

I have got the impression that also this wording approach contains weaknes=
ses.
How do you think about a wording variant like the following?

   The data structure member =E2=80=9Cwq->rescuer=E2=80=9D was reset to a =
null pointer
   in one if branch. It was passed to a call of the function =E2=80=9Ckfre=
e=E2=80=9D
   in the callback function =E2=80=9Crcu_free_wq=E2=80=9D (which was event=
ually executed).
   The function =E2=80=9Ckfree=E2=80=9D does not perform more meaningful d=
ata processing
   for a passed null pointer (besides immediately returning from such a ca=
ll).
   Thus delete this function call which became unnecessary with the refere=
nced
   software update.


> Fixes: def98c84b6cd ("workqueue: Fix spurious sanity check failures in d=
estroy_workqueue()")

This change triggered another collateral evolution finally.
Would you like to detect similarly questionable function calls
by advanced source code analysis?


> Fixes: 8efe1223d73c ("workqueue: Fix missing kfree(rescuer) in destroy_w=
orkqueue()")

Please delete this tag from the change description
(because I find that it is not so relevant here.)


>  v1->v2->v3->v4:
>  Modify wrong submission information.

Will it be nicer to mention the adjustment of the commit message?

Regards,
Markus
