Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E30CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE88E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdZM4QZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgCXV13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:27:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45120 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:27:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so160962qke.12;
        Tue, 24 Mar 2020 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=1QM8CveRQhCE6XJRJPAlMs7ApDPghnQQSQVpjxsUQj0=;
        b=BdZM4QZuz9C2CEPCw0eLZ9854zPru32+2mw6iCPsknrDFfoR3g6XnBgpmZ4YTvs0vg
         QtZEd1asA5kIWaZz21+QYV7klCNZPy9x/4GI6fXE/Ty73Zc2jIWi1FdGPxea0oTcUreM
         cgIhC2Xo6mJrs39PkT8QbLeE2bIfhZNviRS6lyRT0vH0rIIXoXOZYKtMq1Bb73ONiFWO
         DMiK59/oGV6hpjvcxFq+ySy6J/t4IRfVoYgCGLZ8EW3qgecW+MuYLwVKhHtE/suD75T/
         LX7o7SSiiNm8l0pidQFckgmfn4Hjh9jx2DEIPT6Am5poErc4OGuZUzKH0nGuWGja8npF
         sTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=1QM8CveRQhCE6XJRJPAlMs7ApDPghnQQSQVpjxsUQj0=;
        b=RqrZrMMl2m0hXway5VFAJna421FXz81NVQuWSEf4D0cp8xc5JoEx3PIAwoxBjJF316
         OtT/ZIQNBbH4tR1mr0rny3SZOiI+ssFbIiTtut+penspS+nn8NDW7/+7PuvMIvR5l7J5
         CQCYyMztkKyVXnO6Y+2f8U9sXWQUts/7Wrl+pw2mcZctKt0XGxdUq0IbY/xwRO/qTA+k
         Rlb4wGF6j3WY93S6Rixfcp2P62OOxLZRtXXPgfvFbDA5lxmfS6BVdYAmY+yeyvckaJof
         408CSRuLuPRCo9PlFt2QqWz2USKv+GRg2zNnh6aa+econyYdFMozo/jHHf4agwoR0nbo
         jvSA==
X-Gm-Message-State: ANhLgQ3EvE3nXqFne4H+ks9W0iqm4i9YAlX38Kgw3cdJEvIarcv/xB8p
        l3DcD35mCZ/Y/NaEZVaL1W9H0LaZ
X-Google-Smtp-Source: ADFU+vtXNdvfgJj9BkbhIMMi7iTvUPc4Q4KRrKCGBYbFXoVqvFFRyh8q88hsY2Y767R3U/TL7RiEuw==
X-Received: by 2002:ae9:eb11:: with SMTP id b17mr27974091qkg.501.1585085247337;
        Tue, 24 Mar 2020 14:27:27 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x89sm15080681qtd.43.2020.03.24.14.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:27:26 -0700 (PDT)
Date:   Tue, 24 Mar 2020 18:26:29 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com> <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com> <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf script: add flamegraph.py script
To:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users@vger.kernel.org
CC:     Martin Spier <mspier@netflix.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <BCB65A54-D7A4-40DC-8862-B98422ED107B@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 24, 2020 4:05:15 PM GMT-03:00, Andreas Gerstmayr <agerstmayr@redh=
at=2Ecom> wrote:
>On 24=2E03=2E20 17:16, Kim Phillips wrote:
>> On Ubuntu 19=2E10, where python 2=2E7 is still the default, I get:
>>=20
>> $ perf script report flamegraph
>>    File "/usr/libexec/perf-core/scripts/python/flamegraph=2Epy", line
>46
>>      print(f"Flame Graph template {self=2Eargs=2Etemplate} does not " +
>>                                                                 ^
>> SyntaxError: invalid syntax
>> Error running python script
>/usr/libexec/perf-core/scripts/python/flamegraph=2Epy
>>=20
>> Installing libpython3-dev doesn't help=2E
>
>Hmm, I was hoping that I can drop support for Python 2 in 2020 ;) (it's
>
>officially EOL since Jan 1, 2020)
>
>The Ubuntu 18=2E04 release notes mention that "Python 2 is no longer=20
>installed by default=2E Python 3 has been updated to 3=2E6=2E This is the
>last=20
>LTS release to include Python 2 in main=2E"=20
>(https://wiki=2Eubuntu=2Ecom/BionicBeaver/ReleaseNotes) - so imho it shou=
ld
>
>be fine to drop Python 2 support=2E
>
>I tested it with a Ubuntu VM, and by default the Python bindings aren't
>
>enabled in perf (see=20
>https://bugs=2Elaunchpad=2Enet/ubuntu/+source/linux/+bug/1707875)=2E
>
>But you can compile perf and select Python 3:
>
>$ make -j2 PYTHON=3Dpython3
>

I plan to make this the default soon=2E

- Arnaldo
>in the perf source directory (libpython3-dev must be installed)=2E
>
>
>Does this work for you?
>
>
>Cheers,
>Andreas

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
