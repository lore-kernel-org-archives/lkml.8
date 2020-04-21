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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1972C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFD2206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Cow3/mZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgDUJBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:01:03 -0400
Received: from mout.web.de ([212.227.17.12]:38449 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgDUJBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587459634;
        bh=i9qqRHH/gQ/tpjLWB6OOcX+EFap4tRoC9MqZWSmvZyI=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=Cow3/mZo3cqtvNBWid5ewA0QdHQp+CAhSChfxIuyQOXpPjHeQjfoMkxljctpti4mT
         GsHb6CQVK7IjdR+5vxmsovt1PLVAiljzvjOq68IosLOntKJx9E7445JV+n4vN5rL7m
         WQb3HsxbccIp2+lFMArvOX8mT6c1lOUcuQ9cBpBc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.91.59]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2MYq-1j82xq2TtE-00s96P; Tue, 21
 Apr 2020 11:00:34 +0200
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Lyude Paul <lyude@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] drm/amdgpu: Return more error codes in
 amdgpu_connector_set_property()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>
Message-ID: <34ec6ec4-77aa-9514-f9b2-62c3392d0473@web.de>
Date:   Tue, 21 Apr 2020 11:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mF+qzRE4SRDVlXwec+OYaFAiUF1EgVtaqInoesFFWRe4wwm4Vb/
 omDEtz5AWTjEOprkILeyB9KF6R/V+i/Qx9zBytMZLe6HBs7+Dr8RT8IKkx/8v4tUyByNbBR
 ry0SBgDFHkmAXdmiMKTL/tUCzTuvK3Ii5v72Nqi7vu28X/H7hVmO0TsgW5fWWD6k7+Iyte0
 zZiSS8F1U2XHvzzz9nl3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7FeXPKwSq8=:Ka9lmR0h3998Kf90fq4v43
 PSYEDFuUzjoQDEmYjegS5n7j3pXAZGmdYAnEPHwnwfjAbUauNAkYuwKHa1Fd0gQ46ceC1imRg
 7CTBfWd91pDlCS5JYiPWUsMNgL68C2SF8aqRIv9gDP26hQDBbIZQ/5MnrG8MG+mO07gxJZ4Em
 Q1upfcp0MQ6FLkCRovMVTAMbJVAHzE3DL1U+9B4T2drvcE/C57xwfTRLE+qhxzxsGZzSBRyd2
 tSvt7sAP72G1SNstt+hbTBXesrHrf1cuvHE2eAqQVviqOMq8O511dnk0CCHpQeioDUQcx6G8k
 +Q0FhjSRXzlKf3EWgoI9VMpetGgFWWnvmVTTjS3Dm/ADGSVQPk3Go0DT1a5JMlteJq1k4pfMl
 2IgxcvvQ/iBFxzjy0RtV+3/7Fkd4x5ID7rCTrB/xGOz9x9INAbNqvVaJiIIrzwL2CsR8z/tzv
 czc6Ik4cR4obnbsbnhecSQOBOyE2dm59glWTfZI25KoXUP4vzP6Zz9h8BjCe33smtKE03i5KB
 w0OQazCnKtQItxFpBHEzXSsXPAz4DaDHBBAY1pAIlumfBgT5TqtmvUhlskMX90vFPkAmqP/HL
 Vi8nr8AfAPUBC9pZ1G3HCvNcffdCo7W11wxf1bdm7iUbOIAtkkVt3Mb0zFeYxFAip/EJ5yxKp
 RrHAY/YJqQzgk1VJfsW3OnN4gNc5vI9hSvxAOsT7oOQPFYxYeLIbthbWWckuNgCRYcDMFIUMi
 GTGMpIHWVQIRHVmPgIpvCqZvRnOVubI5DHZsOjApNeCzfz6BECM0zMVq6MK53mzVhbNOcOYeO
 CDc1kxjTCWOWKMl5H+iZOCxwSf3TJOE8gBJjoqUF4t0SjC9p1KPQWj2EKbZ1iT1bLeljHFbrr
 XwvsdO+2RL18G8YoSutRK9Lu5riPbXltAhRpxkqwq28Ca25QLZBt1eeJaiyweYQahQMeQRZes
 uuTvKeTEdggnP1/yJgcKnynFL8wMf7ky9mDh6cesOjON+ZswGGE/izm3zP+OQUk6loOR083ac
 uuoaLbEGEf/1GcFu4Ey4kfolImIRF6ZIir+WVlHbh1mqm5dLWKLdHvdJbIcXDctWDuJYZbhXG
 bay3BmPY77O8K42CzatAXedH327mQBh+NCH+h53nvjFvN844XNHOuPUuM7B8hSayppO9CnYKC
 k3xERCbUYmcSly5vO4GuLjOaLprq5KGhUvsiSCC4aJQeEnP/dmhMPF0AY2K9pfTchzBcZVYEK
 LYOXKMGKMSIqh049W
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The "if(!encoder)" branch return the same value 0 of the success
> branch, maybe return -EINVAL is more better.

I suggest to improve the commit message.

* Are you still unsure about the next changes?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3Dae83d0b416db002fe95601e7=
f97f64b59514d936#n151

* Would you like to adjust the patch subject another bit?

* How do you think about to add the tag =E2=80=9CFixes=E2=80=9D
  because of adjustments for the exception handling?


It can be nicer if all patch reviewers (including me) will be explicitly s=
pecified
as recipients for such messages, can't it?

Regards,
Markus
