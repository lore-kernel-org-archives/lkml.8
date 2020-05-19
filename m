Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C87C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 04:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9859F2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 04:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Z2TQfIZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgESERK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 00:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgESERK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 00:17:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1892BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 21:17:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id p12so10069350qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=f35quzRTsPSsXcJMV+Q1OnEk4JEQ9yMytf7fZJAZYAM=;
        b=Z2TQfIZL9NbNzNvNKecDOF2sZC6+uM75u5B8T3tjnT2qxjksiZ4nf22dJVGFfNvpRH
         YsW728leEpAw2LtHjhrKLvsi1oIOoT2j3PLmApLPOYeRPz5r/xx49lLN5FaG47LyCaE5
         kA0H0/BzVYzlEMRNyjb8BQNrGS0d6KqDWKGPOsUOyq4GnkaUCpYV0Br9YAClyzN1hbmB
         N4k7lHi6vgiLgTtzWxatpoKTzXejDtAz2Sx1Nu6xJQRDSHgcjMN1CItquZ+HJ11qHcmD
         oORc9pauzyd6+2D/Mt1lPySnOpRz6MQdeZHcPA2Pup0BJuW3dd2pdzpyKUbkWIunxSGD
         NpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=f35quzRTsPSsXcJMV+Q1OnEk4JEQ9yMytf7fZJAZYAM=;
        b=KbNXB22GFAcPUutKoRQihmfGqsXp5cSwHaCutC3DGTdZseh+QNwVqoptN/4xlH+CGG
         OolBkOkV1muiXnTM4G8l8ePVfmHBWc5eEXKx8XUk+Y4YTzE8jRmRTKs8wv/A3e3nCouo
         OhHxej2xkCF3gejfHQzB3QFZcAGQOuhPWxW3+3WpsNNULjFE1bA84qAZ0AEdXobD38w0
         MtY7mbsgWOce5GZfxUhNawCfW5Uj/das/bDqaFTIljER075rYDUecBuG8PozePu3LDd6
         lIunGtSEuzNPzAWC2Un14hqnT5HCBMmt19OWwjTuLYY3qHtAmKwr/JN9gD61xyDypnwY
         lUXg==
X-Gm-Message-State: AOAM531nJnNqIpjhBFguT6EuGGpRz2ePU4dW6l8nO1tBjsFkCWgwO6Ru
        FBmmWkpqvLTHs3CEno/QNPq0F0uyQK5qOw==
X-Google-Smtp-Source: ABdhPJwpIyb/nh5fY7rAFENRuBra4D8OY1t7WiU2n5+pWVxtKyVO2uDEjGoCqueT0Au5EjRO4+zNhw==
X-Received: by 2002:ac8:c09:: with SMTP id k9mr6448359qti.264.1589861829049;
        Mon, 18 May 2020 21:17:09 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k3sm9948855qkb.112.2020.05.18.21.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 21:17:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: memory offline infinite loop after soft offline
Date:   Tue, 19 May 2020 00:17:07 -0400
Message-Id: <19C82531-5DDB-4474-8FF6-67513BB53784@lca.pw>
References: <20200515034809.GA27576@hori.linux.bs1.fc.nec.co.jp>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20200515034809.GA27576@hori.linux.bs1.fc.nec.co.jp>
To:     =?utf-8?Q?
         "HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
        =?utf-8?Q?=E4=B9=9F=29" ?= <naoya.horiguchi@nec.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 11:48 PM, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=E7=
=9B=B4=E4=B9=9F) <naoya.horiguchi@nec.com> wrote:
>=20
> I'm very sorry to be quiet for long, but I think that I agree with
> this patchset and try to see what happend if merged into mmtom,
> although we need rebaseing to latest mmotm and some basic testing.

Looks like Oscar have been busy those days. Would you have time to take it o=
ver and rebase it?=
