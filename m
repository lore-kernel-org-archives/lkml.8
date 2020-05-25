Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86EAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D59207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmvjUZvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgEYV4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 17:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgEYV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 17:56:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C402C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 14:56:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d10so9109263pgn.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=T2aenYMHPjIozWAhlXxvV0j5BTbT+LaW6xXK9KoCbx4=;
        b=BmvjUZvTycJ5ngBuV543/G03kyFu16PCvm9nSW1wpNo0dXs40pFozLvgJB3LCqkSg/
         t7DxNu27uEy6XBNCC1F+MZipWLtoy7U74Y9uvYgO49vY1CJHQEIInWS8Gx8cQZhq6rJ5
         FXm69yvF4aY1LTU3zeusx9tkt1knPPseu7Fkllp/Q24T8zT2ecNaLoqsC2YiBY/ruu3O
         SWd+y9ZYxOYBgu0JVFdghTh0f4A7rgu96ih0SCsjpA8K91qoiNC9ffvOgehR7/18K0mD
         RFkmXRZfIrubATOnPXRPUbwTmaW85PdpJqsOXwtpRbkmmzmompAHrS4Tl96SeDxoDG0p
         zRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=T2aenYMHPjIozWAhlXxvV0j5BTbT+LaW6xXK9KoCbx4=;
        b=HOgclqLG1pr61QFP6CG8ZnxG5IAjh9HFHx36RnmSX2M3JWggOCrXxgb6B32TxSdyXN
         Xxj6zb1QS4gXkXYa0/21EG7+9YA1mzGe6ajbZ7TM7znWXlNcuZSNXcCH63KgNalOgjtB
         dfI40n2e+vk+DvMAAuuuwhnvIL+87RXsotfPYse80sbkPOzYGN9xj6fo8aV8f9RRkEtZ
         JhZ1TRmeLEZY2xaZEVIN/Mttcw4W2hkj9s/1O4HFRfsiWcXZXlfCROavRPx3ynL2BX92
         rX72BGTAnhTbLZT9eYSzOtafMe7OF8JanlS99xVdMm1flQLzEEVDEbjzcvl9kmqw4HJh
         jHzw==
X-Gm-Message-State: AOAM5311rJi5e1dZp+ax8dIRL8OKkRG2l91lMaXeCAUf3C7I+Kt5rqjQ
        AvpagBu2qWGLwCDb/sNVHPA=
X-Google-Smtp-Source: ABdhPJxopYIfstECzfLreNiZM9RiyzlqCIY2+g+lcwWL2Dbd5AgURK8hMAuWertyfNu74fGsQ+DKSQ==
X-Received: by 2002:aa7:973b:: with SMTP id k27mr18335721pfg.219.1590443801519;
        Mon, 25 May 2020 14:56:41 -0700 (PDT)
Received: from [10.0.0.21] (64-71-7-166.static.wiline.com. [64.71.7.166])
        by smtp.gmail.com with ESMTPSA id 202sm6172010pfv.155.2020.05.25.14.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 14:56:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Date:   Mon, 25 May 2020 14:56:39 -0700
Message-Id: <1E7D7170-7F5D-4A9F-951B-CA53EBF6F674@gmail.com>
References: <CAFLxGvxeg6+DY1LMTzvJe3=iW=zLyUj4xTRda99DurKdS6TDWw@mail.gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
In-Reply-To: <CAFLxGvxeg6+DY1LMTzvJe3=iW=zLyUj4xTRda99DurKdS6TDWw@mail.gmail.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
X-Mailer: iPhone Mail (17F75)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

      pr_warn("** If you see this message and you are not debugging    **\n"=
);
>        pr_warn("** the kernel, report this immediately to your vendor!  **=
\n");
>        pr_warn("**                                                      **=
\n");
>        pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **=
\n");
>        pr_warn("**********************************************************=
\n");
>=20
> Maybe we can add something like this for taints too? :-)
>=20

For TAINT_ROOTHOLE the severity should be =E2=80=9Cpr_emerg=E2=80=9D.  The m=
essage should repeat every five minutes.

-Tony=
