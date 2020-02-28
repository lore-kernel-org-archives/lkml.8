Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF586C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C89A24699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PARcesVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgB1PBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:01:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39235 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgB1PBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:01:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id p34so2202462qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Clp+dXMAk/3s118zZhvs9Tjw+57UrzDN6Ah8uK4j4jM=;
        b=PARcesVsNYLJHoptI1jCN79pKBB6CjZlK5c8zEZMGfBCRE4JfvKXlXwc7kijpY67oy
         JGMzQDPhp2QAkJcaimTwV9y7rryPaBet8J43itCaySuNreCAiUp1GzddUnNYMKLQh5Vn
         0tn+q9qmyssvSMWnx8RtwLMTxw3AAn4uibZPOM7AQjGLNLwqU9FS326aKjPZIN8j4gc7
         VVLrBHgalqP83r+GgwsnW1w1+gxFGlGwmeQkohqN44EMiVMsLkk7OnzNvmf/Pj998QUJ
         8pjGK1+HNaBqwoMCYFRZoMEsZStoMsJ5Mr6mP1mu4cH4xakOt2WVuAIzRKPN4rOdz7ok
         pd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Clp+dXMAk/3s118zZhvs9Tjw+57UrzDN6Ah8uK4j4jM=;
        b=hhJWNCCLJaZ+Ik1sXjMgyJhF784Yuu+moIZSU8E2kQeGVSqtH9CeY6zazbW7ydFMlT
         /AjG985KrvLzbmRdhXFJPj2yNcl5zQpHyZI2ko7CNVi0iN4o9gAzgiPF1gIhcqF6jAdx
         0QnuTVDUf74qne9xqGsYvB5CFST+A5Ijc4y5GUNau3FlN4eafNIOhvv/kOjGxGqfl/Co
         JWN03S3UQ3asNr62gY6FZzCTzXOdWvuBTb7SKcs53rmi5B4u6gBI6UEOhFvdvaWhF+8i
         DGtzvS1VjIeqKWAhRd4Gl+3UI7LLR0jPqpy8MM5IlO1otyAGWWi3jntrAmEOQPJ3KeeD
         pyjA==
X-Gm-Message-State: APjAAAWW8sRlukg+qTuIYzcu+mdnXWY+rDGaEhwzNFdpwBmkZAKeNnWb
        BOpqUAyTMoXJjrGn1OGe3Jo=
X-Google-Smtp-Source: APXvYqw2r1YAkvtvtyajk+MuAfNUdr6EC19Jc/s0UV27xTDPWHe4WQ+NQ6PuRF/dMd2LpJs8DoguBQ==
X-Received: by 2002:ac8:1ae5:: with SMTP id h34mr4588421qtk.323.1582902075966;
        Fri, 28 Feb 2020 07:01:15 -0800 (PST)
Received: from [192.168.0.76] (177.206.220.193.dynamic.adsl.gvt.net.br. [177.206.220.193])
        by smtp.gmail.com with ESMTPSA id p19sm5247526qte.81.2020.02.28.07.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:01:15 -0800 (PST)
Date:   Fri, 28 Feb 2020 12:01:04 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <3fa6d985-1401-d767-a4bc-ce0efc420429@linux.ibm.com>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com> <20200206190412.GD1669706@krava> <20200227141110.GF10761@kernel.org> <3fa6d985-1401-d767-a4bc-ce0efc420429@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/6] perf annotate: Misc fixes / improvements
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
CC:     Jiri Olsa <jolsa@redhat.com>, namhyung@kernel.org,
        irogers@google.com, songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <6C84FDFE-B636-4D13-8D6E-EE0BDEB9F891@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 28, 2020 11:42:27 AM GMT-03:00, Ravi Bangoria <ravi=2Ebangoria=
@linux=2Eibm=2Ecom> wrote:
>
>
>On 2/27/20 7:41 PM, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Feb 06, 2020 at 08:04:12PM +0100, Jiri Olsa escreveu:
>>> On Tue, Feb 04, 2020 at 10:22:27AM +0530, Ravi Bangoria wrote:
>>>> Few fixes / improvements related to perf annotate=2E
>>>>
>>>> v2:
>https://lore=2Ekernel=2Eorg/r/20200124080432=2E8065-1-ravi=2Ebangoria@lin=
ux=2Eibm=2Ecom
>>>>
>>>> v2->v3:
>>>>   - [PATCH v3 2/6] New function annotation_line__exit() to clear
>>>>     annotation_line objects=2E
>>>
>>> Acked-by: Jiri Olsa <jolsa@redhat=2Ecom>
>>=20
>> Thanks applied the series to perf/urgent as it contains a fix=2E
>
>Thanks Arnaldo=2E I don't see patch #5 and #6 in perf/urgent=2E You misse=
d
>them?
>Or didn't consider for perf/urgent :) ?

Yeah, I have those in my perf/core branch=2E

- Arnaldo
>
>Ravi

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
