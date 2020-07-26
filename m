Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D673BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F754206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="THUsjYEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGZPSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:18:50 -0400
Received: from mout.web.de ([212.227.15.3]:39873 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgGZPSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595776726;
        bh=U6ujqU27kbf+v5VRz2WFkQERhb+RZRda0d9NYuyBl6w=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=THUsjYEk1Q5aM0MytzZ6W1R3m6s39gHEQyfXliRFUhkgHTSVoDOvcTywxd8T9ikJY
         8CMfpGc9x4Fia+XEzeIWLSQ+bndusjT23HMIo8GRhLVjfooCrmMpwXL+OYqMy9cgwI
         3w/kB3J4Nk7QgJgFEElJkUG1Mux37S2j0SMtmk68=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.103.185]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCvVz-1k8p6s3mtf-009fBA; Sun, 26
 Jul 2020 17:18:46 +0200
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3 0/3] Update memdup_user.cocci
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <084a4c3b-6344-fcc9-6ab5-19bf4c983b46@web.de>
Date:   Sun, 26 Jul 2020 17:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GM9sJFoH3jIP7Kqrm5ONTTwfjaFXv1FbZUYEccz5xFSm6JVxvlV
 mCDH6bHJ/7Idq6CSHuGd5/HX8b642+z7kWb1SntNmL3OB0i84CO29lq+nPcZ4ipKiKL3X6m
 RUjDbWlNDTMTvFrboDfWPv7fy8OzPTMU6IdD7teiSLPCmkk+Yzv4rIFEEpqn11Tje3hwyJy
 6vDVKMReiDtbFJejycd/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FS6zlNHgUDU=:IuBGfRqGXzfYDWSHzn793o
 WbDkPIv7O8FTzXGhLuwZfj9/DPEbK44CW0PsJtz+7qCpLFtF/YNqzQNgZAaS8llaeUpr6l29+
 LPnAV+YSGJCBW7TZRybjhwrUP3jMf60HXcJusb1azlnCyu1Aq4iIUdFtwJUjlB13Edh1E3LYC
 rnf4nfHfxpzONa19vxfGfbJgjCa7BoaI7zPskLsmxsmRDDOsGJr7H11eS5x4rWsda88obEeZP
 4y+QVD/yS0EDkYvZt1aZdgrsjwoGRlSsyDr23CbJ1cHguHVBcbA7A4hzPo2Z8LXWEHn9KAFoU
 QXceVnFPxssEOAgJLHWKroXN+UfpqXtRQHHhNnklXKDJypDUyI8xBn0gojk73TZN0GwLBUyeg
 zb2BKIuiNFEq/FUdzSAn5l9uu/QDSx+eI5L4i+VjHKdNAK6GyYmCeGz2R6cfTgXRzonRxbC2U
 uMslWgQ6JamP2INEnVfPIyvtCYXIfSDyd6N05dteViW5CgJdNDTiMvG2m5uNwqr56ItMx+Ay1
 pU/UuFSCy1fVcptvAMRv0T/jpYmPOSqd03yKnMcBjRLRA8pM/dLE6uoRvSrtN+4qQHHYs71oA
 bDB5jjDeinUwpKGig91WmlyAqSnGkE1HyI4HCXHal//YN8UNYgcbl+5ctO+l0652qWnC+yyFQ
 YBMzbRZ9keODNyMNG2dc/v7EKiqgF8I2GK91DYSxJQTKRCy8QR/QU1uVuZve8BoFw88AV4zno
 k3l5C5bIL12DQJUwB4Jt62HNDxURmm5s42gVVOYyFICxeKBjUw6UVTmI6sdkRldDuWIXuLxQJ
 rHeLyWrzAFGmDIhZXqtkMntAXiNLYjp3cIqiZ6aP61nwpiDcAxHj0n4RJ1a3MVjInruQMKOEt
 9uqO0VCp5zdqoDiale5UrsYggb4xgydks1cJT16ByucI/JyMxPOU1bOWltfa98WdYnO5udsm1
 nTaUomIJ+g+sPYi0bwOr2AZ7KThq2/EVhlEollkIGRQWKpVxOIzPK4REdCgGxIIglptKEagxj
 hg1idATXuLrXQcLPvyQKvGr0klh9wMBq9YEAQMxPZzy8S/clL/LoMU2ztdcmGhGmlNqNF+g9S
 Fhlm4jUMLpz53uSQi7Otpf10IYRy9jjAe8s9mWD9veenoV1+TwGIAmxFMDMv+N0+yI2EwkGtG
 /91dHOzsq7ZViedxdW9HDEsS3EReQqXOeYlBTArcUUxZGg3M7e9UtyLxNY2Tp+hYeaRyXyDad
 +Uamdrmm5j/ejetwSwxT8SWAtkm3NbpB6RTMt/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> All three applied. =E2=80=A6

Can the accepted software adjustment be seen by the interface
of a public development repository?

Regards,
Markus
