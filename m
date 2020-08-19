Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA02BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4D32078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEYsVedF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHSWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSWJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:09:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD57C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:09:16 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a65so20327633otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2aZms47v6extSBzv//sF/AtrAyAelQrYrDctYBpr04=;
        b=KEYsVedFdZOQOSKvm37iFMygyWYKzyeKVhW7GTGsl2VQmKBUg/hkZq15rfVRQfC5eu
         dUtnTcGVi3clYiP8Mj5/69CXlvkgXFTYDkUlcWkoQ9qBcKDdXnK7v5CcO25kpXzKE5xS
         UoFKnLSkqfQ+sQDk6RybtzVcijHxCY5agHtf1D0MUFmQi8DMQy/bw26109HhW7KpI7KN
         F0tQYmHfj9dQhoyiwlrrYHPfIlB78enPqA7h59oq5DS6DdzqdUwcmXqOjNqtzotEtrrQ
         vgk5zbQjOqe3nwzXchl3hOB6/KvfHZuUlrSKoIgZyzXCwG73zgJnYCtd14yyyX7tvkYG
         /gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2aZms47v6extSBzv//sF/AtrAyAelQrYrDctYBpr04=;
        b=mMHEEbUK8+2ry4mxc4L/WRCmZ4H3i19O8akeK5Airwggim4TJj7DqRIOGO8JN3HKHA
         QiQvBRglZC/8cp5gjZUZLrVETYANBxTJd11V7vmzas9P+yYvuGXPckkR9tV2oFPUtoZo
         a/C8rP8L66iZue8SuWYR+eKKXfPYUhuxwDK6riEq2AaZZVTD709ByObZLjKXXtHfEdoo
         d2u3DUHQYNYB7yYiijPZP4/SykodA0E9uU4WfhpGHy3sf6ovvBQ49VQBMcZOLC9IEZca
         DUDq1pKBBjUbzsKvl7j+yqdragyTZVwQSIhHCmIbk936fJV5SSjRo1Dt9yisrL5CE+df
         prhQ==
X-Gm-Message-State: AOAM533ZXykl7IRIgsixgqZ7VgpsNgs4oFzcQfCfPqt22ybiwjjyQFJa
        ta/83bCroWhlSJF6z+Wj5oOauUCIxv+jus1b2YH/Kg==
X-Google-Smtp-Source: ABdhPJzt1m4Jk/Vfsw/369PYrT54BgnJK9X0NCnwn7bI4EEVd9vbywxvaU0LIHS+rgWiI+SfMc+IIrkD07Q745+LHBc=
X-Received: by 2002:a9d:ae9:: with SMTP id 96mr18674otq.241.1597874955900;
 Wed, 19 Aug 2020 15:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200803211423.29398-1-graf@amazon.com> <CALMp9eRHmhmKP21jmBr13n3DvttPg9OQEn5Zn0LxyiKiq2uTkA@mail.gmail.com>
 <B0FD5408-E2C1-444C-AFCE-7C622EA75F66@amazon.de>
In-Reply-To: <B0FD5408-E2C1-444C-AFCE-7C622EA75F66@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 19 Aug 2020 15:09:04 -0700
Message-ID: <CALMp9eS5+mV2SC-v4gusocrWtXpm-QzGoOTDGhFS9NEmuVNTDw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Allow user space to restrict and augment MSR emulation
To:     "Graf (AWS), Alexander" <graf@amazon.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raslan, KarimAllah" <karahmed@amazon.de>,
        Aaron Lewis <aaronlewis@google.com>,
        kvm list <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 2:46 PM Graf (AWS), Alexander <graf@amazon.de> wrote:

> Special MSRs like EFER also irritate me a bit. We can't really trap on them - most code paths just know they're handled in kernel. Maybe I'll add some sanity checks as well...

Why can't we intercept EFER?
