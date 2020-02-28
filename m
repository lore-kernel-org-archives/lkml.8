Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1B8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBDB2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWkmDDpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgB1PAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:00:09 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43770 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgB1PAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:00:09 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so1443000qvo.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=r5uJ0wc4GP6HMgk5dq1KYlyGtIduf4ShNQhhfVhz1nE=;
        b=gWkmDDpOSlkv9Ic9GMdNfELw4HMWqoAsExS08gBqTziNlHzRr5xfESyYkvcspSpEsH
         +WN/rsdiA/knyr+7z71BuvlUx9lQR39NtdirexnJZiQ723aAbeKIgpk8xBulOMe+rdJ0
         +y6X8saQMXHosfXCVxocBqKrlF+xj8gxUnZupqX2dIk0B0TMcWct/XBCEe/jBquZXBrP
         1sp9caUxOI2hETLUiLk/8KLThCmMfc4nyM3PppNrSWQW518xCpPdrIAyFYn8cePXR5AF
         uGUyo5/F0/RjiWGirZyPPSToUb3nUSm8RujndM9+nLH6r9i5UWFDzYpxCU2EC7VlHP0K
         jTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=r5uJ0wc4GP6HMgk5dq1KYlyGtIduf4ShNQhhfVhz1nE=;
        b=dZEGbeoZnJZVronyl8VLj+u5oaLB9l1/Qy2Od2hdgXIk85bYtJVA8PXgI0B+nvHrPk
         Z4XbnFNNRR2UHp9/s0xYt9KQg19kh1xb6oEaMqI5N20Dc4ppqRaLlT+pTDA1W3tp0Ki9
         EfJzXSd/3m9OM9KEsBdSb1zTg1GKqBeiB2NCuZ64+ElAaHY4fKNbLhrfJcyE+i2ddJpg
         e1H1Np40gVtmfLe4QjVdTCMx+38iONBb50IlOahBSyETdxOXEGUV9ecyE/tlkNHrFTQt
         INFSfZx/yIsOLa2JZZN9TrRwVmrKVKflf98a+JHDdjFBSqhupr8LcTMvChOWX+2oB7pR
         xr4g==
X-Gm-Message-State: APjAAAWQAU2z5E0ux2OvmlHlMyySP7gY8CHxWf9nDugOCNy7Gx1sVGcn
        euSXb1dXlvlVvQVrNHDQCzU=
X-Google-Smtp-Source: APXvYqyH2Xyw/iwda4WHtfv9SDFijySfjhvKt9+TST9YSBEW2aUTZNcPLrRfdAec9u6JTx1X0AfPyA==
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr4143382qvb.84.1582902006795;
        Fri, 28 Feb 2020 07:00:06 -0800 (PST)
Received: from [192.168.0.76] (177.206.220.193.dynamic.adsl.gvt.net.br. [177.206.220.193])
        by smtp.gmail.com with ESMTPSA id r37sm5109037qtj.44.2020.02.28.07.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:00:06 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:59:56 -0300
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
Message-ID: <11A3D3E8-133A-4235-856C-D8C3C1400264@gmail.com>
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
=20
Yep

>
>Ravi

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
