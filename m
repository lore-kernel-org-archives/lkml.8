Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAC8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450C8208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUMZJ6tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHaHtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:49:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:49:46 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w14so4535706eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akEiOdpS0Gg/fXyATJX/L6/L6imxqJBwCo+dknusM4c=;
        b=PUMZJ6tLcuQckS1up2hcmWmvYFTTItBVxCwxZOzgkclNgkfW2zxDrbOeyvIbA8smGM
         6Rmio8WjZDwImOBaI39ZcQV0yCpysOK8gDN3IeHoXbVhuSPnCsCE0V8mdGAlY3+Dt8QW
         OvsN9JbyoxW9KPB7jwWkSCoA+NjH5x1ym2rLnPEp2cYP6LPYFc2k8FjYHShH++l/o078
         QOsadrQjUk18bJjE1ALasXMIb+ot42DsTLa/3zwM8V4L31YzOLhP6fDewecqTQT+oLxH
         CYUxl28tayNt2u/MJLEZKuiClb8uqRzWch6m0AiGRiaXG/eP2O1jAvKcWYvPdMxx1Qvi
         5Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akEiOdpS0Gg/fXyATJX/L6/L6imxqJBwCo+dknusM4c=;
        b=ZRPqEOJ+wWdfcg3AtK8DiqQZkrX6rj/lHY4WoHa+ezg0TbyWDaq8Kd8BM286vdC2zI
         NCUcLnzds53LOho7GGW1xcHJDlsUXX7yc37jmN1VlbG6nnnR8MBEUwP5N7KcLD+XttLT
         S43cB1F0RPB6w49TN/HOa08SkTGHtXNCJ7r+rEba+rrXCpIoZ9peTIj6ENF5GluA2mpq
         Qajr5ahZ47iS6D3Og9YW6/kLeDyUEgAhPN0EO3xmtuPAICHujsgJn+1+dTORDJSwHXn+
         TyJkBkU7Lwnd4op99d+YPuBD99Uo+pJbgHRd9rx8HZ9s0tDUqZcTSc8EuO3hJMHmZgkA
         f68A==
X-Gm-Message-State: AOAM531r1oUAYYV2sBocalFjc5qPTxipPrT10Yd/UvZEzHkroy2L3lgn
        EETgDPZmC4uat+JBy6jliWuEs6OeHyj5ABUChSM=
X-Google-Smtp-Source: ABdhPJywkdtbMb0DPS7FRH3KSjaBMgwx1BxD4mdOzvbs+JVIYp7rXFFxjiYVe5KcgD3G7V74Z63uwbYevV5+/VOOvbg=
X-Received: by 2002:a50:8d4b:: with SMTP id t11mr57219edt.5.1598860182770;
 Mon, 31 Aug 2020 00:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598859038.git.zong.li@sifive.com>
In-Reply-To: <cover.1598859038.git.zong.li@sifive.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Mon, 31 Aug 2020 10:49:26 +0300
Message-ID: <CAOJsxLEHer5c-BPYnH6i_TW1iEJ+t4iF_8ZU49=Wvd2wSJ9+Gg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Get cache information from userland
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the series:

Reviewed-by: Pekka Enberg <penberg@kernel.org>

- Pekka
