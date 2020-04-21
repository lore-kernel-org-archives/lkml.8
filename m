Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3208C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA869205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EtruUq/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDUIUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:20:50 -0400
Received: from mout.web.de ([217.72.192.78]:52545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgDUIUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587457234;
        bh=y5hPKTU7r66gyV9UKIkcFxOr+eMe7e4v7CrjUmkpEvs=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=EtruUq/qPP8ybHJDIlKGfvQU3QeuKk5GtkyqCq1zfBZTN9xRvfi4hvY72+xbXj6q/
         /87M7CuHkFTrTd3OAuvSjCNbYnbWBTJ+E/zHEH3IN+PiybUgEUDzIxgmNiiysgIzfC
         e4lMdDsGgVmGkGt6nD1izKKP2od6sTsflxvNUIXM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.91.59]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcV4-1jJfXE0fQg-007Fmw; Tue, 21
 Apr 2020 10:20:34 +0200
Cc:     1587180037-113840-1-git-send-email-bernard@vivo.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH V2] drm/amdgpu: Remove an unnecessary condition check in
 reserve_bo_and_cond_vms()
To:     Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c972a800-9a38-8f17-09f8-12058bf4491d@web.de>
Date:   Tue, 21 Apr 2020 10:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BnJHv8ylf25jOwixpSvtf4Uz1FQN46jWqrLF0PXKq6379rLW90+
 90e43xyLUxDqGi9FISO/MtA6xz/Oh4FMHdPfDdHvPkQE8ac8/j9D68d3FLya41luid7nONk
 H6DEFTC0QXQYVSRgMtfAxy3cpUM0hLBU1WqBPvMWPMXQbSwQ0Blk/IhM0KtkAU98dw9AF4l
 Wv1ATWHpB7ZVD/cC8sqMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxDFhQYhpK8=:Lwbwftss8nIPrnj3u5OhK1
 zTpA9D0qjY/+f8wR+2EfENUHn4O3/8wa2iyYEwnoF8jmaopZp7YACx6UQ/E8dqijXuJdiYJTh
 8QSJYXl3WJNs9YY0XrL3mqV/CGmQmiPiMKd1PXMJ11UrMQ9L7FoLcTQfTr/R520I6TuRQyw5I
 D6Z0vH+MOse/q7srIW1shy0Sv77Mbzvf2zRaDkUqIq0q+nQp1gkAzuhIfOSJNFDlrZDLMlySv
 S9EyBd7Sqk0ISWgXodLD1UzmkFceh5FkuDCXcA3xjJ/ogqFOc5Fzrs1LrCZzqukIxZAdj6rjB
 VnmbVD8DjFv1xrhxUekEX9hgFcO52J7lbtlxVJ1tHR9+mGLJFXAe+NX04P6pjufxNk5lWcGIg
 Yx3HsODtSw5GXec3HttE37Vp0rCiGUNkKQe37Ivy3mIzHAmNI9kI+IfUgCF/YC5gdtCPVcfUX
 d9EI3VG4coabftpphoVX5O48GwDh6ZtbLXSt2jDtNaV8ubtsYAMQ9UZQAyZCWaqlAc4wDI8B5
 3AmLlqnQExJ1DM3yio5m6CdDk7Uwj72HKYye7Vl2qIXUJJEKTRJIpS+QCHT1CSZxy514Eieec
 rjs3NUz9nqceQKcymF5gjPtVceUO147+LPIBiyhpbiiCqnxIQibjld9qCfjpo+CGrS+Uit2l+
 m45uns1IMeJG5GB6FCtYnjcPXnWFRwI+KpsaZCd+qmlY6TMfnc4lVPvKP1VjH/QGRzzowexbc
 aMdNWMXTN2cn4YGts52UP2v9MfHxb/vC1/fzyYfA/YcqueOKStbDIYObB5NlJjzKGmfMpLDp9
 sUZ5P4oc9P/YrpYLXYsIDXB7J3PjrqJWKnBmeOOrHTQIRRqQUQyL7+wRn+ZbxJag43jNxhkkQ
 DgV6Z6uPk/hpobE2TmcXokA+cCGXLvesyL/Ieb+zFSTFEkErIed7h0Q4j1jPoKqem1E+8OWoY
 SLqRL3CsQaFGjGGmrBhx78QNUE4w4LFk2giowKe8LUV25vR2whuq0RWwLE/G8PZUsfhuJ4y3w
 ocnpEN2+7sAvoAjsbPwqvuI6perRpBCmBB+duSBldSbuLDPFGtc4W1L91O9wQ7gPOfabSGb/j
 uIUpCNDHD209zn6GEVGJADDtQYhyMkZ2eipWAOmsR22fpEPoDpL/NFWVWS8ikfh5ZheI438z1
 ThdGwt6UTcIjzUeak+uIG2gb7Y3VM0T/BWAXNkrC1aqX93pvTVnjM3vPqLzXDCiJBztOSJKQl
 Dcp2ZIsXADW80Qwyi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no need to if check again,

Thanks for this information.

* Should the function name be mentioned in this commit message?

* Would you like to adjust the patch subject another bit?


> maybe we could merge into the above else branch.

I suggest to reconsider this wording.
Are you still unsure about the next changes?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dae83d0b416db002fe95601e7f9=
7f64b59514d936#n151

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?


It can be nicer if all patch reviewers (including me) will be explicitly s=
pecified
as recipients for such messages, can't it?

Regards,
Markus
