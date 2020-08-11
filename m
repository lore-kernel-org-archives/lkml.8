Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BE9206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="B25Mf+ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHKDpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgHKDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:45:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06671C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:45:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l64so10528209qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KsYcC1sTF0CP31Y7ynD10WX2opG39mAbhbFTvmtFPX8=;
        b=B25Mf+jaWbQB2obnBJ5QWy+IuHDZyo+nFnYpmBkgQFJ9BU+aFaB2FESqdCXpszGMHb
         MXGMlRdMZKkXa1ajDaIQpzdP3cxgTsb1hcp+Uace7gUiIkkdUJ1reRVmZ7a4lAa8rmNa
         5kOLirkaWTwofNklGm38RfQ7ibDC565ZrGbqa4qBzHhEFSeQfXpmP1s1vcQ9FHkV5HgE
         pjSwwpzczRbsEDYlBl7O7xkgpo3ZbO0KOr1UA/RAvA+cAfvyvGdg4XFpN531qXrIBnVR
         WDa0FPg2Pj4PLl+ePs/tqy4jxsA5R6EBNwBkzlE84ayQOWt9nZhQc3EjHTvBp8EGtWxN
         3zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KsYcC1sTF0CP31Y7ynD10WX2opG39mAbhbFTvmtFPX8=;
        b=YF5k57IOlTkluj0CTFwzjqorTM/eosBtweUwoFo7HHMnj8JJwdmWp634NiH1Ylbnms
         AdQcimQtxDwbUUKLBsN49TaOuXUwlEZjn09jCOtJxpQcyMUgqJxL0wFWXGjR/TrrXMAk
         85XlQeQYKZUHEBdbMJwqmf4vRC/+EazwXGtpdpVZ9Qw/t/0uxub4/DYseLQbHrjRgFmy
         3LfeN1Rmk1otOhCrghXtsFzWp+gXpB9sn60ga6f9BCS4ExEQrI0qglkA0Tio1OZJ+asU
         psSjoKmh9wXBpEFujGGDT5YNli/Fbl9PkSIBIrJU4FptRwrXlTdGphWC9svJKSJNqKI/
         sg3Q==
X-Gm-Message-State: AOAM530n/4J68MoJNJ36GCebQkqK8wDZ9tT8aBHfEgxbUCTodSiJQ9En
        E3j/zVGaQl8SskdglSYOHTzxtdm4J4wtEQ==
X-Google-Smtp-Source: ABdhPJxz93cpfbotqKOVtFtvGY+HzMJrDQ5lPU0GCD+2Ul342esFzUNHi2ta8+8tjpG5wkzcP59TYA==
X-Received: by 2002:a37:e508:: with SMTP id e8mr28692563qkg.380.1597117538231;
        Mon, 10 Aug 2020 20:45:38 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y46sm15495940qth.78.2020.08.10.20.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 20:45:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 00/12] HWPOISON: soft offline rework
Date:   Mon, 10 Aug 2020 23:45:36 -0400
Message-Id: <6214D3DD-7EB1-4598-8DA2-344430EC7858@lca.pw>
References: <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
Cc:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
In-Reply-To: <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
To:     =?utf-8?Q?
         "HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
        =?utf-8?Q?=E4=B9=9F=29" ?= <naoya.horiguchi@nec.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 10, 2020, at 11:11 PM, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=E7=
=9B=B4=E4=B9=9F) <naoya.horiguchi@nec.com> wrote:
>=20
> I'm still not sure why the test succeeded by reverting these because
> current mainline kernel provides similar mechanism to prevent reuse of
> soft offlined page. So this success seems to me something suspicious.

Even if we call munmap() on the range, it still can=E2=80=99t be be reused? I=
f so, how to recover those memory then?

>=20
> To investigate more, I want to have additional info about the page states
> of the relevant pages after soft offlining.  Could you collect it by the
> following steps?

Do you want to collect those from the failed or succeed kernel?=
