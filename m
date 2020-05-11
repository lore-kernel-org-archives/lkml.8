Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C3FC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63972206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSJaUPfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgEKStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEKStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:49:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C60C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:49:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q7so10925274qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=869wQTgLjaV8+gbWESIyNteYJ1JdP4aekxmYMx3lK78=;
        b=YSJaUPfa2sskwaRRZFFHA6F0NbT/FyKkAAySTqfeu326f5CxoVkKcM6dPvebK+T2Iy
         Qsxu8jLhlB7XeBG3x6e6VNr58jY2ksrao2Uw5uxsd9yWS+UULWb/pZyoumd1v7eXL2mi
         THl89RwQNVhLLGoj1X178iq2Z0ui5/keeVyaoVGbzVcnwMUnki7yD996Su6bw0bvXost
         bjJfgllRTuJXqqiUMfBdAgX0pXNT67evETstQWpewQNtFEIxwtJWz6kUf+IojTg669y8
         IZS/p/+eGM0WrCWE2c0AHanYkanldBDWN50DNgiKLVET3/V9K/oNw34bYBeC3yD1IwVs
         RYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=869wQTgLjaV8+gbWESIyNteYJ1JdP4aekxmYMx3lK78=;
        b=moYQjfO/URcXXZhVJ8eDLduk5hL2FaIxC5aVgJUfoN6s6i3o/B4D2FQUo6wbHIqlkj
         QWsWlJDS5skTGU5czoPfilxiDipUhk5S7gfKgR7mzPuvibpVNScyVgMKTXxQsS5TWFRk
         //D5svyB65htpRGqIBnna0cHKc26xZTq5hP59RSWVK74e4OYECIoM+x22yXjr70vlcUm
         q4z3RNl/67EFeUd+MUsfk8XFdy28fOSkI/UPDYMFiThOEgJcGSkqF19UdY40K1eAYJhi
         iUGWuWSnD/MbakOdp7DwocvzhSzXV6TRHOvm2O1BDhwjjvkcG5Eu2lkuPWClF+9GBNAe
         /AKQ==
X-Gm-Message-State: AGi0Pub0mQudeNyeq8km0ADkXK92N35zmGWcgrbT/GHywNxbO2B1Gz6R
        JI5QT1zhRPxqmabxUHRH5xQ=
X-Google-Smtp-Source: APiQypLUY1xddghqh8nA9yW/MMbpaX3mzi7QQerLV3mrGd9ts9D7D+is2ifxlAiJ7QankFvSUUoUFw==
X-Received: by 2002:a37:9b47:: with SMTP id d68mr16624724qke.88.1589222951806;
        Mon, 11 May 2020 11:49:11 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q54sm9186295qtj.38.2020.05.11.11.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 11:49:11 -0700 (PDT)
Date:   Mon, 11 May 2020 15:48:55 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200511172620.GA14618@embeddedor>
References: <20200507190615.GA15677@embeddedor> <20200511154812.GD5377@kernel.org> <20200511172620.GA14618@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf script: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <AA4613D1-106B-4B4D-9470-EBEA2A527DC7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 11, 2020 2:26:20 PM GMT-03:00, "Gustavo A=2E R=2E Silva" <gustavoar=
s@kernel=2Eorg> wrote:
>On Mon, May 11, 2020 at 12:48:12PM -0300, Arnaldo Carvalho de Melo
>wrote:
>> Em Thu, May 07, 2020 at 02:06:15PM -0500, Gustavo A=2E R=2E Silva
>escreveu:
>> > The current codebase makes use of the zero-length array language
>> > extension to the C90 standard, but the preferred mechanism to
>declare
>> > variable-length types such as these ones is a flexible array
>member[1][2],
>> > introduced in C99:
>> >=20
>> > struct foo {
>> >         int stuff;
>> >         struct boo array[];
>> > };
>>=20
>> Can you split this into a kernel part and tools/ one? Also this is
>not
>> really just for "perf script", so please adjust the subject line too
>:-)
>>=20
>
>Sure thing=2E :)
>
>Is that OK if I use "perf: " for the tools part and "perf/x86: " for
>the
>kernel part?

perf tools: Summary

Since it touches multiple perf tools,=20

perf script: If it was only about 'perf script'
>
>Thanks
>--
>Gustavo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
