Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EA8C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F7F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="qhOQagm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438037AbgDNJ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437925AbgDNJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:56:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 02:56:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z12so11381031ilb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mTNRog1G9NWOtzic5n9BO42Qp3FLPijpt9pvlrD31Y=;
        b=qhOQagm3THBbvlxAE3Rn2heuILfmBp/l1AIRXXRKjGasf3aAUh7sEfVQcTOkl3HwA5
         AGOughY6DCPGc/MuRrrmAFSKnzurk90fqFyOlR50UlCDAoK4cl3BWzQAigY91SGhfMVm
         VCCh+QvAUgargxxeOpEtPmYiENOydD04UFelLdKRaXnUliSeaXDvANSzYewCSFyWSdaE
         OkUSvoda9SV5uw0f3O0Hb+9uV4KZ5Sbe5dThWCsE3Y0MVbKtj757hZ9+smGcLWmnFhIa
         YhTuXG1AOnrRllRakaOz0zBgCYvhr3hxDzKYy2JAz7DFNkmEQzLc4xHzQrMCTiW6HBOl
         1Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mTNRog1G9NWOtzic5n9BO42Qp3FLPijpt9pvlrD31Y=;
        b=LCvGmhvIPdRZzgYupazYoYY6azlTOiHao22fzj9JBC/bPVJdGc7FP8GJkHxHEzYGh8
         NAnTfzfDU0vPp6VwJby0AyrP9shyQc/Dmgt/9thwpPHiGEP/pomPxBmrtXXgaTS8qPGc
         4YKGPAvRfTEwf8qDxp0/0suP8YHwWfoaevjNxl365zDSKTHmDS1goxkrCsAwirFwELp9
         kqvJso+bWKCTkDNHd/c3ny12ajrZY0OiVWGYXknZ+srOaDp77vSEPI6DiEFhverdEHpS
         XMciYzdgz/zPNOcffhTYkgT9it2A1sDwcWxi1WXNg0qlD59WRO8i5H2ABkno3Wfa29Tc
         6RMw==
X-Gm-Message-State: AGi0Pub+5KvG9a//m07Z0HUnUTDb3mzH9O19ChFk5zuanhuoR35UGAei
        qjpXWaZGCny79eDzvj7CLI7lQ4Uxs8Q7VtMYp2AJ6A==
X-Google-Smtp-Source: APiQypLc7vO+U+uz9b8s/sGSMGpFqNHTJ9dIn0wIr4ttnCsma2EKuI05wVk56hvQwfQo+bBCeyWmIxzGlNztFQeLPM0=
X-Received: by 2002:a92:5f17:: with SMTP id t23mr7609747ilb.2.1586858198824;
 Tue, 14 Apr 2020 02:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200414075622.69822-1-songmuchun@bytedance.com> <ff540216-7f3e-9841-4896-81907540404d@web.de>
In-Reply-To: <ff540216-7f3e-9841-4896-81907540404d@web.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 17:56:02 +0800
Message-ID: <CAMZfGtVpMK38odpd3Ady_xW0hyMpN89Vwo_WNXBZz0yGaZzFQg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/ksm: Fix NULL pointer dereference
 when KSM zero page is enabled
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Xiongchun Duan <duanxiongchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:17 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > to crash when we access vma->vm_mm(its offset is 0x40) later in
>
> Will another fine-tuning become relevant also for this wording?
>

Sorry, I don't understand what this means because of my poor English.
Could you explain it again. Thanks.

>
> > following calltrace is captured in kernel 4.19 with KSM zero page
>
> Can the mentioned Linux version trigger any special software
> development concerns?
>
> Will any other tags become helpful in such a case?

How about changing
    "following calltrace is captured in kernel 4.19 with KSM zero page"
to
   "The following calltrace is captured with the following patch applied:
       e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with
colouring")
    "
?

-- 
Yours,
Muchun
