Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779A6207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FKh4uRFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOTbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgEOTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:31:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A16C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:31:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g16so3178522eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vErvnQoqbf5Meaqtse3zpzTQXTThCj+PlNibNhhv2Uo=;
        b=FKh4uRFuzk6LWrSXDP88E2gJbQI+bBtvd2Vrw7lgHu5eyGOb+HDjTj2KDYFJxLUWzB
         PeZd/YkHHi25f64qU7/fLCFVGlERXsCjnxhlPRoAPpUYPCS+rmfQlU95K29FzuDaYRU1
         DB5aTnj3yrcjckhA/nS5y/+P1iauWWrbkRD5BHYJlSy71m6X61xPbEfO0sKbRrA75lmQ
         0SV5LPanC51ygC4iYuKyA1gPRqiKOWdHrmIvWhdmUpTWlJnEH8lXicDlYcgQ98lpSm5+
         cRmYG4HbwPlg1LKXAdiwuFNu/WuRc8kWB33kOw6rB15rTCvWOEmMSbQwGdErqx0Gd1vf
         3/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vErvnQoqbf5Meaqtse3zpzTQXTThCj+PlNibNhhv2Uo=;
        b=KWaya2CLQx9MXTvAAtq8Bsduc2HUrfMbzTClo7BzM4TpYnPJDlPk2R6rozdm34ABKS
         sa3iWYFlSVMWrunZDaHs6UhoczDkpnYZDx32ufYIsAWx1wZCtTOtFDC6qfOjE0GjyEFj
         UxA6XtlQvtHDYx2QDoOhhYSwla7xRWYRHtWK9qMWN4c7lLVmVGLgcJZln/V0eh8jwkNN
         p374KRfUiP+Yf0vt+SNmII2VdOTh+I/cCUBZvwQiTwx1AcJgDruK6H8qV0bkM6UFruAT
         ptjotDBbIh/lrvqANJg6SzsgwzHxsKuUAw+hzvuduglS3q7zdUApSdHvybD6R/kSCf42
         evbA==
X-Gm-Message-State: AOAM531Iew4et4lJ1M2WhfGR1IZauRhbT64yjzKBiNbjdSc6tUrqhNwx
        YCKPwg3+CfwCcAlnlcd3FMUyf3D4mlrIOzNtKabGYA==
X-Google-Smtp-Source: ABdhPJxVNhuoHXSVLn9PLNKxdspcJcNGGfAsekctXnv0fKnHI35D8TQO83ALfAlxb/fVSimNFlN5uGf+30lkrJL6Cxw=
X-Received: by 2002:aa7:da04:: with SMTP id r4mr4302843eds.346.1589571063296;
 Fri, 15 May 2020 12:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200515184434.8470-1-keescook@chromium.org> <20200515184434.8470-6-keescook@chromium.org>
In-Reply-To: <20200515184434.8470-6-keescook@chromium.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 15 May 2020 15:30:27 -0400
Message-ID: <CA+CK2bAvTo1=oLH32-Wdz07F3OP=T+gA6GgzkBH1Q9W8upHkNg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] pstore/ram: Introduce max_reason and convert dump_oops
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define parse_u32(name, field, default_value) {                                \
>                 ret = ramoops_parse_dt_u32(pdev, name, default_value,   \

The series seems to be missing the patch where ramoops_parse_dt_size
-> ramoops_parse_dt_u32 get renamed, and updated to handle default
value.
