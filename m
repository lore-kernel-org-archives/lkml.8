Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD40C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FD42087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LcxRinM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBCPGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:06:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41109 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBCPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:06:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id u19so6816532qku.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Pqrua2aNFk7E/aM7DpxoCGO3yfSkT75o/9HVLjio40=;
        b=LcxRinM2Jd9ZtyI8A7OgwoRNBBwgVfxoTw6F2jIR/AQl8pk64TjhQ83Cgt88DEcwu8
         qF1fGj5ySzOctBIB6rYgyb4l17jteIrYZ7n09VpQXMmBaTX69+0hqWVfg2QbGGU4xiwZ
         4aUlfX7a+tZjA30Sgq7VZkPf/GVQGErTBzplWBIpRMuBw5btDuVxZ7asEfhy3WOBix8b
         veiN8k/FQZoqk5SPTvC86FgDgOaK0993N/Y3UZgGiao9dE6ck8n1p/KNvMqQo3fX/ZFi
         LOjzPOdSO3KUBdeFPvDLHMg3HQJHv7JIuUFL1vFRwzkoFo6yyNLCRVOXUo7HrKlcnDl4
         zRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Pqrua2aNFk7E/aM7DpxoCGO3yfSkT75o/9HVLjio40=;
        b=qLS+aV/1xsdKXaXe5ixuEoK9t7uGbrNQHFrS7ejPSHYzWEVZnoEauT6b/dJ0IRPrXY
         7dgM/ZuyDrIqe1OqomO6AxdX+pEchgSGdrR+LqM6qdobkGUNW8FwrbfQl2grTeO57mrc
         lAA28gm5uGo4622kvh0vyXOCUMmcE96F2aHaDFQdelIWxa9ObLTISxzxJOmjrsS/bZBe
         swJSg+oXmnh+ywCqa6kAH9kf13ShWfp1qJIwkAOgFDXETJXFBE+eQ47zR2NKBNg3i40C
         NKiaPLR2qJKzE9zlQHDemSCLgAiDlsxbS89P/EC/56kFBCju9BLUzfAYB99KnAxcGtvJ
         8bIQ==
X-Gm-Message-State: APjAAAX/NhOWjE13rjgd4FyDxAsDTQZ8AsZStPzt7Kq/56gH4RYlQ8dF
        4d/t5/z8xo1ElSEbIwD2SAvXYg==
X-Google-Smtp-Source: APXvYqyqItfjETcCSYHpKDhogrMUuY03DaFYMc/nGKpzOi93kS/qtSJ47mCv2S/o6vqvOPD4MEyUbw==
X-Received: by 2002:a37:9d44:: with SMTP id g65mr10795127qke.15.1580742374374;
        Mon, 03 Feb 2020 07:06:14 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i28sm10543162qtc.57.2020.02.03.07.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 07:06:13 -0800 (PST)
Message-ID: <1580742371.7365.1.camel@lca.pw>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
From:   Qian Cai <cai@lca.pw>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Grzegorz Halat <ghalat@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ssaner@redhat.com, atomlin@redhat.com,
        oleksandr@redhat.com, vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date:   Mon, 03 Feb 2020 10:06:11 -0500
In-Reply-To: <34467005-1742-47a0-cd2b-05567584b91e@de.ibm.com>
References: <20200129180851.551109-1-ghalat@redhat.com>
         <84C253EB-B348-4B62-B863-F192FBA8C202@lca.pw>
         <34467005-1742-47a0-cd2b-05567584b91e@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-03 at 15:08 +0100, Christian Borntraeger wrote:
> 
> On 29.01.20 19:39, Qian Cai wrote:
> > 
> > 
> > > On Jan 29, 2020, at 1:08 PM, Grzegorz Halat <ghalat@redhat.com> wrote:
> > > 
> > > Memory management subsystem performs various checks at runtime,
> > > if an inconsistency is detected then such event is being logged and kernel
> > > continues to run. While debugging such problems it is helpful to collect
> > > memory dump as early as possible. Currently, there is no easy way to panic
> > > kernel when such error is detected.
> > > 
> > > It was proposed[1] to panic the kernel if panic_on_oops is set but this
> > > approach was not accepted. One of alternative proposals was introduction of
> > > a new sysctl.
> > > 
> > > Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then the
> > > kernel will be crashed when an inconsistency is detected by memory
> > > management. This currently means panic when bad page or bad PTE
> > > is detected(this may be extended to other places in MM).
> > > 
> > > Another use case of this sysctl may be in security-wise environments,
> > > it may be more desired to crash machine than continue to run with
> > > potentially damaged data structures.
> > 
> > It is annoying that I have to repeat my feedback, but I don’t know why
> > admins want to enable this by allowing normal users to crash the systems
> > more easily through recoverable MM bugs where I am sure we have plenty.
> > How does that improve the security?
> 
> There are cases where data corruption is a no-go, while "one node going down" 
> is acceptable.
> And then there is also the case for payed service providers that often need
> a dump at the time of the problem to understand rare issues.
> 
> So I DO see value in such a thing. We should just piggy-back on panic_on_warn
> I guess.
> 

Indeed, so change pr_alert() to pr_warn() there then?
