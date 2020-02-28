Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E56CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA26246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffqIO3tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgB1KEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:04:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33635 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1KEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:04:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so1618022qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a7+lcYU9pjgKIGJZWhmqaLl7BQiaMH92GolwR2dAbg8=;
        b=ffqIO3tpl78REQ8evZj33bAAf615GGOuXen7/dMMtlVM57ZCukIQFbicnpn4fDjzhN
         HakqnZ7no0rjRd5ZWeoiCnNL2+mpury+4qBvu0Xe0PkPP0Fz5hN/tXa8ZL4QQehlmGr9
         0e38cwDw5mQeNcq6/CIbwyELlxugMK4F6P1zIJcEMfmh4c5WIzFEz9WL4TA39GJjMb55
         Riwi2qrKqZa5fdGbpHmmsaHjrzyaMeuIvpYrrLyqfnB15Rl2rFqQt0vC4KtLEYbhjHHH
         R/yE8/fTbcaJO8b1Br1yzeKcx+Fd0F4C7mey16LyEXHnttErGlZGGKoROW9+kjwNis4T
         doKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a7+lcYU9pjgKIGJZWhmqaLl7BQiaMH92GolwR2dAbg8=;
        b=HtKQG0qZhGbAqpfua7/Yx5V01I8Fr3ZARRjq9Xw9QEBi5OUGWEI2iUsfmb68GxkSA5
         vVWo3Y/nfMaF6eneByXkiPIKWLcnlTOAtIWBEqHw72NoTQNw8yZWGj3TZOULKwqNY4vQ
         Lm3rACT0KiwjZq4WA4Nb77Q9+WTb3GMKQ2qezgRGHr0KAy1w0789MmNRyId6vqD/ssdr
         LblRsZh1Bt7ME8mnMRoN8nJuFgcFXs09B5Kw2w0nGYFieDo4oow4fyaFvZ0i56NvFRDB
         fe8dBN4ZiBuYwwHstHk9AJcvrcRyFD374Lsl0yprM9m9OS0Potfz6BF1TMFEoohPoRXE
         DbdQ==
X-Gm-Message-State: APjAAAXwameB6EDEBBIabKdjJlallwef//vnM6LgimQHUsl6H7QgRfyB
        yNyLivhslPvTJJLEJISKf6iYgXRc2jFbrnFsYcc=
X-Google-Smtp-Source: APXvYqzLy8PbPomb8ED2slWXoo8a+ELbzweki/7I99bejM1gBBLOOYC1yLUmx8A+4B5noUAQR/fG3ykITxc2mFi/0X0=
X-Received: by 2002:aed:31e2:: with SMTP id 89mr3568550qth.35.1582884249627;
 Fri, 28 Feb 2020 02:04:09 -0800 (PST)
MIME-Version: 1.0
References: <1581401993-20041-4-git-send-email-iamjoonsoo.kim@lge.com> <20200228074200.GL6548@shao2-debian>
In-Reply-To: <20200228074200.GL6548@shao2-debian>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 28 Feb 2020 19:03:58 +0900
Message-ID: <CAAmzW4NzT5G5ef9vFsU_=zV8+UyJHuRjfwKBbqij9kNd8wV8PQ@mail.gmail.com>
Subject: Re: [mm/workingset] 323c95f095: fio.read_bw_MBps 19.5% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 2=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:42, k=
ernel test robot <rong.a.chen@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Greeting,
>
> FYI, we noticed a 19.5% improvement of fio.read_bw_MBps due to commit:

Hello, all.

Please forget this improvement report.
My revision 1 patchset has a bug on this patch and it looks like it
causes some improvement. :)
I have fixed this bug at revision 2 patchset.

Thanks.
