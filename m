Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D42C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B13F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="spfabpwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437534AbgDNJR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:17:29 -0400
Received: from mout.web.de ([212.227.17.12]:59631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437500AbgDNJRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586855838;
        bh=6697LzT05QB2vWxGR2+6HHm5Jxfu/XK6SRemGQs3IPs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=spfabpwVT+s7KhhXJzgQMphV9zmr8X3dPlt54mOSCMxG8JZ9DKiMz7un9HJYUQJU4
         dgDJYw/YrI8b1RsgMbuGIwaI8g63HDsuqm/akq9JHYpl2MnjwvyxvESCjgg2ZylnOE
         EZrKdu7kNXjeZxM/BWShdR6KEOqcT9CVG1HTDui0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.66.171]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPYNR-1jJaj122fh-004jsY; Tue, 14
 Apr 2020 11:17:18 +0200
Subject: Re: [PATCH v2] mm/ksm: Fix NULL pointer dereference when KSM zero
 page is enabled
To:     Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200414075622.69822-1-songmuchun@bytedance.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ff540216-7f3e-9841-4896-81907540404d@web.de>
Date:   Tue, 14 Apr 2020 11:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414075622.69822-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:DOkhi4BwKFOQ2s2dM0MhSJSupuY8nYp+WtL7iBe9viUoua5rB2m
 DTme6jSakZgV2rvhQLtDgJFFdZQtTStkfJ2HfBHk/qjskhrye33n4NhiHp/1j2KdcZ0T4qw
 e09vJ+WQX5cJtRz9HhHHpDGKoNaPyJqw30DasU4TjEp2gydwnWBNDsGSd0me1kwOQXgTuRl
 zrCX9N0gwJBqGlLBJy1lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J5vTnck+7xo=:PmKQpUcJWrTERWG0ufoe40
 P3/6kN1h0gnzf4pUwry4i3zNP1dYTlnbCzch6R6GPuSQ9HV4soGvUjXJ312pjCyCo1bcb+qYQ
 bZz4FiRPcTsChd487sclIj9/cHqgr18EqLiXcHsobMH0HosdyrQXVQnJ4KARZAGaeVj44kSri
 dIEWrk2Ca1uACuRlvdx7ucBdtDY3+egEaV9ZX3FKTsT5mhuNIz5aRQH/3GnYUEzh3ySyzNFmd
 aLY2ox6r5sgQBP9k+6trgqL5KzJ+0PeEbEIYGcKu5ATLK6OhaVS5CjWXKKqiTD0d7+5QE4PIL
 WKEIOtIyLv1zCA0h/BhXyCNwmSIm1Jb0JeG2Bt5FlvvGc5GkKVmZebpgngPpnUrnPXH2RzsFK
 Hoq/q3OWH4hY0oE8qzCqgw9V5squgiTVwWeLs0CV8SRQpi3OZDZjI1LeqmlZFIVBYFiFmGU+X
 R3lSHm3Jh36YjM7UY/ydAwfxuSRpEwFMYjdAcvhjYzslaHKPRRGfq25HJ5Eypnav24jcJYCD7
 uq7jNunFlEUByJPl01ftXxvDITEjnJPpqvH5/XHZNz4e2c4ujvS9VQS5fgiXvX3VhSyObI2qB
 R8GsJ0H7n3o3atQ4JsGmmv2yr/pSb6H19jsqz4dSuLtcte9nmo4ZuX8cS0eapKOqxHLCo9dCB
 zIL5xjz/tVUBWR02iW/b36Pu5gStG9MS5W2tw6AxhwrRDAaKTyPed6LdHyuOoivnynInEoqJR
 CdHn7VZxsP/e+JL+yd9Rr+T08JCzv+yTHuvMNMSBBIS9nqRmp5FyV3bevqZ0zcfM0xTUQQO47
 SYn7jhBEi+ZfbQdaQk9qzEtrIZY9o4DIlQV9mK1vooQ5eZs53TWJsBximCEAeY52H/7Gi2wQh
 sOLWZ5audRETpubazU+Z3/HMWnJF2wxQcmAufSKunAJRf3ftjYRrjNRfUnbW5O1mlijfJlBYz
 DTnXGsYuIYjnxBBqregRgfIbjEwIsLZ7eY658XHDQgBo8E6WBmpXwgpWqhOQjHaVMhGMIiFbQ
 hHE8E7ta00waXhLuCppUY+sgNqaJ4xsdnDeb24z4sha02XXPa2G0jOpJVE/8lAo/4RIIhPtZ9
 YmQ8Cs3ayBJJIaPSjqdjpkufeOACocOM1+uLT4hbX7KXKI+5YDoHwOKDDWpn4qXotBF33GIIi
 PWzGZ4xt0/5iSBbRlzr7rWhNQg6nePuJdj+pWr3e+iAPdgz490IVINc/WpC0c4pnhuw2sLLB1
 +HeEti9Gkk2l6ladd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> to crash when we access vma->vm_mm(its offset is 0x40) later in

Will another fine-tuning become relevant also for this wording?


> following calltrace is captured in kernel 4.19 with KSM zero page

Can the mentioned Linux version trigger any special software
development concerns?

Will any other tags become helpful in such a case?

Regards,
Markus
