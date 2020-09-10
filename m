Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A76C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD02214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfR+kaqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgIJKwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgIJKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:50:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726C6C061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:50:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j11so8069006ejk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl+Puul4vVPh8oSiqSBQlazGVFYUlaK2t3JkMD3S8VU=;
        b=MfR+kaqr9Ijvrx9g8wnfe7FFqLLww8qX3LZ9b84v4pCfAz/g6fGA42sPm0CJpfWGGE
         qYE7rUatAHQDiitWJVs+uVxotoSAZqt3zr7GoxqZGh1X3QFe7FU352wH11BltiJNbHql
         5AEqFDggtRG3ieScrHb1PF00WL7dA2G8E61ESpi3lxr5RGIVR5IxhnyQQ0zgnrTAX3WJ
         VCZedtySvxPz/rXfJbYgpG31Vva3nJGgcQW74ksuK5HiDq8OoQimF9YEDA7bng/B1Prl
         fHM3laMutRyVCPg1OtxDzcu3uQx4vqauE5jF35lEQWUua+8X9EvtaD00ZrmplRoQ5jGi
         HkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl+Puul4vVPh8oSiqSBQlazGVFYUlaK2t3JkMD3S8VU=;
        b=EpWgb15H+tZz7xFrLnzyMS9lONxk+ISNnUuQ9QreOl/O2gxNWvES53ayFKmjxaL0yn
         t6A7bG8DEDZviPOBnfh/9XIjh1AWzAH9Qb3GXEQzT2A0MlMvr2nhbMoOV8jzXj6y0OLT
         4S4Jhk/WrBMpjy2xZjS7FNwq1ypnEEYcxua+7Vzm1HCe37A9xc3VS2nmqD9nq8pvpMzT
         n9XVV8xYO01rm5FcFbT/wbPUHu4DfENKZBrxkfr3wZZ5VJSNE8Cyl/SWDYRfAHrbV5nm
         G974/4q7uHMZ27lX+LfmeFf7nTh6HZiQo2QBxIrsMzm2Oo2SGBTNBu4KndtQ+jDb3j1q
         BJ1A==
X-Gm-Message-State: AOAM531NeEP+PjYeZWkefZ7m1aWurXYTr1IfJd5JptEjhlNrZ2QJMpWt
        r/+/sKACpAMSHF+h6AQ5Yf5pTmAxriuNVeVa8ix3qg==
X-Google-Smtp-Source: ABdhPJz2QEjAlqXQ/OoQNuvXwR82jdCqI8EOUurylTRWYYiFSskudC59oTiUg29MEX2zzBztMwvKMOU5vvzGeJ0jq6k=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr8438636ejc.114.1599735004965;
 Thu, 10 Sep 2020 03:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 12:49:38 +0200
Message-ID: <CAG48ez1jLVcj=BAAsSA5i-k+gCtRNn+OhfwAWAxFJSKLwZKQ=A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 01/11] usb: early: convert to readl_poll_timeout_atomic()
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        linux-usb@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:24 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> Use readl_poll_timeout_atomic() to simplify code
>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Jann Horn <jannh@google.com>
