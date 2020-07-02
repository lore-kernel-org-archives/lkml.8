Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D157CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD04E206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TAEAY8wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgGBPIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:08:13 -0400
Received: from mout.web.de ([212.227.15.3]:40521 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGBPIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593702449;
        bh=ZN9Z+dcOH76mDiydr9cvfJYcms6wDCXm7O7t301RXOI=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=TAEAY8wy6qa5nd/1qRCCBMM0cn6TexdlrdxIaJdBi4pGWh68UKSC4TSCIO0kwhXxd
         0B6v+/aH5jTTa1yhNJn9xMUHkktoSFsJrIkCpt48LwJLz4QCk5xShJUHRuHOJIF9rK
         I+x+uBKcKAo7u5x0K5sfOC5Qj6lvvd9sJj6bT8zI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.52]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx7OL-1ikHDk2i1R-016c7I; Thu, 02
 Jul 2020 17:07:29 +0200
To:     tongtiangen <tongtiangen@huawei.com>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH] perf header: Fix possible memory leak when using
 do_read_string
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <de57c10a-1dbf-098a-27da-6f16275e5979@web.de>
Date:   Thu, 2 Jul 2020 17:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/SOuc7GfRiQJMJtrmFqz1/zIoBMxNwPKAfPPx9UCmpAJeAyoYnE
 E2Z0zwWikpPilLMcN28gnlHQIeqULPGAFZCkwL/1ZDrCAgBjDU0s4H1f8qPfnZLN3FZZQaT
 i4cVSltA7EudzgkQcQp7AKClmKQfD1Fk0qKVlZskleJfsgxg3l+Alzs1z6mb8krOydPIhKP
 1BUoSMYx2QwDKXqBHYxCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Wcpzl6P27k=:SWxtTh+K/vKyPSV171TUVB
 UsE+s6NC7DtHZZzf7zfVrYTgIzDQPPX4HmwqeW5MK1TK4NFHqPDM5keTZw/W6kbHLr3MJPTTs
 /NphTN1V321ykW4AUVqXdvdXvGwC0DlDgHcKy4nyR27NLYYX+AE20oV2M2L71P3eeZlJkf3gC
 UwJQK1QmRvmSWGbNHYzY2ihFx8KwjRVFogG+313/Ia1EGD8hTmfBioXGp4XiI0v9WjomXm7L7
 7WjDCQ/6sjhoi6UQ19Vh3Lt194rNvNoNtOwM7jQnLh3d9v3Gxg7e1VX8ccNExcY2OHf6+73rM
 yyNRHgqvUZ4M99rdJSM+QIE9NK6bxA55phTrvn505qXv3TYh2/H2DgHoISbdQ6b1+gY3V3zs7
 UCs8LskqlM1CPalqg7m7u8ZXQqtMcN2zHQRxaWl+gWeJEkiyJ0ms/o4O88JZPUPCscW+Hb6MD
 GkN8SymE8XviIjmKnUXfLo6X6AQ7Ueet0iDVPU7r/M7mVt3q978J7eOvoCs1jmpUYOYSfXr+P
 f9wBe5LIV6XAFwlnbJunMIF2AW23bSllkwASRAqAPE3d2m3Rnnx1nbVxigwKi9tHIqy6hvcRS
 57TQcc2xTmYk8YfC+loBn/j2ppPUpawcEpY83vqW5I4S/9joK5u/h6jFhQP7R679nz2DJobEx
 EvAnO+MJ0dW8UR4uY/bzVDRxF9KIfiNXyIn8lWD48Ei5iNFLoV4ivD1dbXTh37wwjPtc5EG15
 7gegMqDn2lUwKQgL2wftFxTk2f+mVuPEWUoSfhj4QisllH76bq6RLxB1T6rKTLQk+mqM4UWcR
 DGtg81M9ZftlBCs1kPyQ1aFpkKK/XaqA1fepinFHCJGyK8Y5nezFjVA5aCsefokky5xU9jwMi
 Xs5kJgt97Eit96Cos7Ki86KojuKiSoBV2ZMqcUO2IQ5AlI0IwGc5hen7LQ1AiHEz2LcxmOkx/
 fJopWb4ezH4aN79Fix+V18wIeyq6oNBHdh9FkSdGdbTXSiB35v3fyJT3/wXrqKkYy/NPFuH90
 Pmdx5Ki8goTwJ3Jf5VAL6nO+P/OEGNuLVRQsWIQiktT/8giqHU/DbuXHBAtOJnVGTfBQfY1qI
 xPcX9FCFiyRbKaVPCUThK+RUYoSweCbkNCz8s15lWgPNP/IKrpBpVsnKlIGcGFbwjWQ9chgKz
 z2cdfgJ6Xkq1q7uWOv5R+5P0kzIsgVB8HP1urwTZnwAObB58SwwehLSDYpN+lrOgDki/xfuHD
 HfepaReQxOZSD2WNS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the header.c file, some functions allocate memory after using
> do_read_string, but the corresponding memory is not released after
> subsequent processing errors, causing memory leaks.

I suggest to choose an imperative wording for this change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dcd77006e01b3198c75fb7819b3=
d0ff89709539bb#n151


=E2=80=A6
> +++ b/tools/perf/util/header.c
> @@ -2307,8 +2307,10 @@  static int process_cpu_topology(struct feat_fd *=
ff, void *data __maybe_unused)
>  			goto error;
>
>  		/* include a NULL character at the end */
> -		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> +		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> +			free(str);
>  			goto error;
> +		}
>  		size +=3D string_size(str);
=E2=80=A6

I propose to add the jump target =E2=80=9Cfree_str=E2=80=9D for nicer exce=
ption handling
in this function implementation.

Regards,
Markus
