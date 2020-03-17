Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BA6C5ACBF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F612073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8oTFxnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCQLp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:45:56 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:45780 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:45:55 -0400
Received: by mail-io1-f47.google.com with SMTP id w7so5223065ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUQX8mFk3gSlBbscD/fDRe/11PYGyXL/SKXh6MlIM2I=;
        b=t8oTFxnlKiNsNwIGO46DVvIsUdMcJk/CBjPchswlZgkJ+uCzem/a5y7p0j2X/O6zFN
         IH4qXVogDVQMS6CZy/Kc1B0gq9zQ/nNrkB6raK4JhJEyqqT/6qorhXtpj8KSnXgzyRRS
         hDIMroxkdnSjoousQu2w/GjfU0Hal+AG69C7L65s7NkTQuudHkfsqURN5Kx6ER7tZLGW
         1cn2duSBVpNQJG/SS11I7ydlzOK0lNYZofRJuzLoCwrcPSPzh0jkO1tofwXdSsn+P7yu
         eDML9HrSIH17ztLFQasZS9se+aod8L6bPEh5CURXWfha6l6uhZpEKzFAl0inBwlBjCYl
         VdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUQX8mFk3gSlBbscD/fDRe/11PYGyXL/SKXh6MlIM2I=;
        b=XZJK6Csrf+Bi1MX1bRxtRcpTSuyJOkIWrguuw5FbqeiulKrFVHxorZjTdcxOXRZQXL
         9iX/ft5SrF1P1Syw8SWAd8aAwYJZ/kiCkaWtYeGMOxMd+qTFBn+6tCnsbJmso6ee/G7g
         baAGSiiMzNIDBRMe5xT6QASQ6NEr2IiLe9/nwl2Asxk7MoeV5LRYa7h1Bv3FTs4PH7Nr
         /V47CeMO1Qrm+nydxgnfGXX/8JQaVQ6k/Did22AMSzGhbmx66g/qFceVObzsvWovhsfT
         kA7m4iDK4ulTQjo4zqc1M9dlW/3rQQrEU5AJ20Nwl3m4wFV72tJNmNWi0z8T9Uq2eBoC
         R1xQ==
X-Gm-Message-State: ANhLgQ2w+34JMH2ByYmcVRl5E650//RnaLmcwIRI5SdCXxDivDTH8doQ
        YYKqBlO7gOvv/3ntCIkscOgqoJf1KQd5OXS3cg==
X-Google-Smtp-Source: ADFU+vshpj0Df//ICe0Enba/8npBTFZ/FxObABwKeNow8CH/ZtRVvf+L6Zfy7C8OdR9BcmQFkFFts3XslqikzrFUNNQ=
X-Received: by 2002:a6b:c8d4:: with SMTP id y203mr3627684iof.111.1584445554704;
 Tue, 17 Mar 2020 04:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
 <1584333244-10480-3-git-send-email-kernelfans@gmail.com> <20200316085536.GB1831@infradead.org>
In-Reply-To: <20200316085536.GB1831@infradead.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 17 Mar 2020 19:45:42 +0800
Message-ID: <CAFgQCTuyZjLRBW1g7cMWhbqm48UMX+wCK4e6m2nGqnmM8ScLRQ@mail.gmail.com>
Subject: Re: [PATCHv6 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 4:55 PM Christoph Hellwig <hch@infradead.org> wrote:
>
[...]
>
> Wrong indentation.  We either align two tabs for continuation
> statements, or after the opening brace of the previous line.  With a
> likely or unlikely thrown in the former IMHO looks much better.  E.g.
>
>                 if (unlikely(flags & FOLL_LONGTERM) &&
>                                 is_migrate_cma_page(page))
>                         return NULL;
>
OK, thanks. I will send out V7 to fix it.

Regards,
Pingfan
