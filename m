Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C879AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A328D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBnTtUAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgG3BNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3BNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:13:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7CC061794;
        Wed, 29 Jul 2020 18:13:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so24200763qkg.5;
        Wed, 29 Jul 2020 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=29jI3ci+a7Sp9d2xnBWnJDwqEUNpCdqc7ZH0hJFRuMU=;
        b=YBnTtUAF9rZY2tbC6ODuETMDGQDuNtrq+FlAGUKdQm9jZnv0UGMruYUV0RRme+vrrV
         bwvAHFXDbCcDaxEjLzfFXQA6KqomF8scOa+ss8EBzhTHr/0wBQ5T1rIGc89PaIHjBJ1M
         rjfaQ9ZDDEwWkzybyscEgShEMeToKnAQsfHuC8n71Yywr/dVewTU9YYtjIpeN8Xktf16
         T8qnIoLsUx7APgfCXee96lq8PAyFamdS/JUgsSOnPve9/a7RhGccbdi4KxDCIYRRrake
         U21XWbNO32efXdZcDVUxvgdHE2432M4SXLbQRxwn9CrDXnZj8cPmF6uFaJ97uJAVOI67
         f3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=29jI3ci+a7Sp9d2xnBWnJDwqEUNpCdqc7ZH0hJFRuMU=;
        b=g2WwfBgvhbWoI4MsL8CvmFjdQpUuiSlWSEADdo68OIdjBMDMxUJHX1IUT1daZfm0xY
         2wtBuUDVP1a3GsmhcwY6eyeVk+CnDCgfvR2v+VHgDAdylZI732vB/vQWfQVOe+t+Rqy3
         GOgdfYEMfT1h0zJKn9pXvKYba653JliHTj/UWJrgU+mfNSG4PorBVB47pO9BUVSD5I9T
         INw6KtCY8nPGBrtuoKcanOh0DtIAOTLuXIlvtgLH4iN5s4APASxKQBCCjBlzQevQ5Tcw
         U6btO/6TYk03fU/dPYRudNsp5eFlaEdE4Xo4xmYt3sUPKgo5SrXcVPIkiKrKY98xTPPj
         Kisw==
X-Gm-Message-State: AOAM530WzeOeN+D5dhmyNqvoar51lLaG69i2rrub+fKrRejGnhDRRQah
        2kC2PbvYedV5UT91ITl9qSU=
X-Google-Smtp-Source: ABdhPJwIeYlm0bFYC6MAZFPYEr+oPEI2FVM3K2DH6xa6lTaI1M9nBwNTygdSVOvfjQAaUnR3//PQ2Q==
X-Received: by 2002:a37:4048:: with SMTP id n69mr34076346qka.421.1596071590282;
        Wed, 29 Jul 2020 18:13:10 -0700 (PDT)
Received: from RedmiNote8Pro-Redmi.localdomain ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k31sm1838251qtd.60.2020.07.29.18.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 18:13:09 -0700 (PDT)
Date:   Wed, 29 Jul 2020 22:12:46 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com> <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked in jvmti_agent.c
To:     Ian Rogers <irogers@google.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     cj.chengjian@huawei.com, Li Bin <huawei.libin@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <F549EBCC-2BC0-43D4-B470-A53E9DF37A29@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 29, 2020 8:47:36 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> w=
rote:
>On Fri, Jul 24, 2020 at 3:07 AM Wang ShaoBo
><bobo=2Eshaobowang@huawei=2Ecom> wrote:
>>
>> Function jvmti_write_code called by compiled_method_load_cb may
>return
>> error in using fwrite_unlocked, this failure should be captured and
>> warned=2E
>>
>> Signed-off-by: Wang ShaoBo <bobo=2Eshaobowang@huawei=2Ecom>
>> ---
>>  tools/perf/jvmti/jvmti_agent=2Ec | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/jvmti/jvmti_agent=2Ec
>b/tools/perf/jvmti/jvmti_agent=2Ec
>> index 88108598d6e9=2E=2Ea1fe6aa16b6d 100644
>> --- a/tools/perf/jvmti/jvmti_agent=2Ec
>> +++ b/tools/perf/jvmti/jvmti_agent=2Ec
>> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>>         struct jr_code_load rec;
>>         size_t sym_len;
>>         FILE *fp =3D agent;
>> -       int ret =3D -1;
>> +       int ret;
>>
>>         /* don't care about 0 length function, no samples */
>>         if (size =3D=3D 0)
>> @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
>>         rec=2Ecode_index =3D code_generation++;
>>
>>         ret =3D fwrite_unlocked(&rec, sizeof(rec), 1, fp);
>> -       fwrite_unlocked(sym, sym_len, 1, fp);
>> +       if (ret)
>> +               goto error;
>
>Sorry, it seems I lost a reply to this=2E Won't ret here be the number
>of items written and not an error code? Consequently all writes will
>immediately goto error?

Good thing this is in tmp=2Eperf/core, you're right, the test has to be (r=
et < 0)=2E=2E=2E I'll fix, thanks!

Also we need some 'perf test' for this :-/

- Arnaldo
>
>Thanks,
>Ian
>
>> +       ret =3D fwrite_unlocked(sym, sym_len, 1, fp);
>> +       if (ret)
>> +               goto error;
>>
>> -       if (code)
>> -               fwrite_unlocked(code, size, 1, fp);
>> +       if (code) {
>> +               ret =3D fwrite_unlocked(code, size, 1, fp);
>> +               if (ret)
>> +                       goto error;
>> +       }
>>
>>         funlockfile(fp);
>> -
>> -       ret =3D 0;
>> -
>> -       return ret;
>> +       return 0;
>> +error:
>> +       funlockfile(fp);
>> +       return -1;
>>  }
>>
>>  int
>> --
>> 2=2E17=2E1
>>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
