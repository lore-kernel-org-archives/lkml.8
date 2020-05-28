Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F935C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A82215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUTCSEp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgE1MI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389674AbgE1MIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:08:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DBC05BD1E;
        Thu, 28 May 2020 05:08:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q8so28261885iow.7;
        Thu, 28 May 2020 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xg0QPxu1ZcXwi3FZlEd1nHSUYYcxk/H+be8VUas4WI=;
        b=DUTCSEp+0VouInoDHWVK37LO0AztXs67n/B34PE+3fFo0TvjRancJtR1Dmlw3Gj5/F
         Xm/xLkvkrtguVpxCr1h9I47Xagl+y0ZDzQWz6cd6EIimVdapLCyUBhHkYo9pOhZrJHK3
         gvckwiYbcKKqSQDiz+Et7z3mkEn4thxs7K1yiIppDEB7sODKNdfVxOwLilCjah2ecbxr
         9hmm4jFbeGAmonlPZT0dLYOtK2UC4G6k96cIRQgzTFPbBXxikI6ZgRqfzeqlEc/80rkZ
         X881udcPebn7/dOptUnbCMHEdpZiHmIwM0t0MmehFjfIzH7tdmZIAdXtuZiCndV6WLye
         d36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xg0QPxu1ZcXwi3FZlEd1nHSUYYcxk/H+be8VUas4WI=;
        b=ahhp18AQrYNveGhwDgPjNtrIrOhSfc3pOLsIAaq5naXpaICYdjR2e9Oc7iV9j92zte
         it3gNdBiCCUmpHxjD4dCrKqGqhYba1CW8984gT4rH2XHspHkSEBC6JcEta6LTppgMc1h
         Oiit4pkB9lSBywKCcGwEKOoS2mcafAaiy9rW/VRi8sb7B9EkyN6gR4EFfdzeuoRE+56o
         smdz6Kgi5U0Y8o5VrJ6s1NRynWxDZlA/FGMcZi2wf75jOg60q9mKVA1onAkLb4mzUV5R
         f0U0DN0TMduhuKlIp317SQkJKcWkDdcgzUYlNA8Xogh5FbslGtCDu+q0UGBuA1b0RxkF
         m19A==
X-Gm-Message-State: AOAM5316yDZgLqsu1XXAG8xKR23pgc6EChnl7AgZS8JnSp0YKIOJNSZu
        e/GdqPNK+Ke7c7i6YZDK/AZ6ofrS/WLfcvtqsw3utt4A
X-Google-Smtp-Source: ABdhPJzkKearcqBhw4Pr966FRVJJxc8ygvEkNMHoQhFIKcaLjSP3PyULF5sgdY1/EXULPKhc23v/kMvP/Xui/2T4ing=
X-Received: by 2002:a5d:8146:: with SMTP id f6mr2001054ioo.154.1590667697930;
 Thu, 28 May 2020 05:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de> <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
In-Reply-To: <20200528095703.GH30374@kadam>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 May 2020 20:08:06 +0800
Message-ID: <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY1XSB3b3JrcXVldWU6IFJlbW92ZSB1bm5lY2Vzc2FyeQ==?=
        =?UTF-8?B?IGtmcmVlKCkgY2FsbCBpbiByY3VfZnJlZV93cSgp?=
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Markus Elfring <markus.elfring@web.de>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 5:57 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Guys, the patch is wrong.  The kfree is harmless when this is called
> from destroy_workqueue() and required when it's called from
> pwq_unbound_release_workfn().  Lai Jiangshan already explained this
> already.  Why are we still discussing this?
>

I'm also confused why they have been debating about the changelog
after the patch was queued. My statement was about "the patch is
a correct cleanup, but the changelog is totally misleading".

destroy_workqueue(percpu_wq) -> rcu_free_wq()
or
destroy_workqueue(unbound_wq) -> put_pwq() ->
pwq_unbound_release_workfn() -> rcu_free_wq()

So the patch is correct to me. Only can destroy_workqueue()
lead to rcu_free_wq().

Still, the kfree(NULL) is harmless. But it is cleaner
to have the patch. But the changelog is wrong, even after
the lengthened debating, and English is not my mother tongue,
so I just looked on.
