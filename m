Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C50C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C6B20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMOAgM9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDGSz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:55:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42789 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:55:29 -0400
Received: by mail-il1-f196.google.com with SMTP id f16so4283006ilj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/tslLXuxoyVjSOLI35ip3I2Cd88F7bzLCM3Xyu1bIgM=;
        b=WMOAgM9DrLI4UXG0tvW08mYqzl77Gk7Xb0oSU1n8sL1ius69d9XwTvx0OUV8qBYAqL
         SvUPKPH6SQ6mY9EXYJuX2zhxE9TOJ46+yakaNtEpBkwaxKsape35cHBAeLeS6z68+9mw
         TcPIsxqO9PEpOkEzb2/Ji/WtxrG93oiM9mpk5mmNxq8AHl0Kn7hQE7npRo8Q4o2zTdAn
         LHhh0XIZCRmBp2qtirzd99BwrSeFd8ZI9q+ID5u1gvnkjiUumiCIh42HS12eXoE+7NJU
         CB9hrzTlr1cHWYR2lHSSMIQOYhtoIazsjcDEIaX7/PseveInY1o3oWdd10ZaSakarfuq
         Hz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/tslLXuxoyVjSOLI35ip3I2Cd88F7bzLCM3Xyu1bIgM=;
        b=f1k8pkNvI/pdatnVZNPmHWxvFXH2UqdlAqR3RMepguNBqZQtyw8K33X2yDbQewE4+Z
         1P498jYPLXyFGRAnfuhRw0eLwZGkfpwvVf/2y2FY5CZk/l9rt1xo9ZZU7ZmqERY0y/Pd
         madc3ewqo920EVdsCQskyCRRlthJ0B7l4xLWC5Cl7lQ6IQi8uah4x1TXK5PbMylEeGr7
         Nc4fzyeN54PLCyJ/YPWPyJk9HW6Kg8o39PIcX57ikfqqV/KL+6iej/OFLguXQAlaKkoS
         9d61kt6hXA4dlPP5FtC17X9TQD61nSVLbeAbqme8UPivXvy6g0Q5IYeEOac5lWZ8+bOz
         R/AQ==
X-Gm-Message-State: AGi0PuaprF7WN79eS2y6gXHrw2+xO6gqKbJEBGT7T3OJopfyYB1Su6AP
        eGS/EmdhrsCyjNYGRPFW1Nc=
X-Google-Smtp-Source: APiQypKz3YCF7dQUKJtJtT0hWDaVgRVOTnWtQ71Ph3AWJXhZHfAJWm54lRtwbLGHWugt7DHibd/eVw==
X-Received: by 2002:a92:1581:: with SMTP id 1mr3983101ilv.144.1586285727755;
        Tue, 07 Apr 2020 11:55:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4700:9b2:1d50:a6a4:b3be:b3e4? ([2601:647:4700:9b2:1d50:a6a4:b3be:b3e4])
        by smtp.gmail.com with ESMTPSA id x10sm7509021ili.88.2020.04.07.11.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 11:55:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20200407111007.429362016@infradead.org>
Date:   Tue, 7 Apr 2020 11:55:21 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 7, 2020, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> Since we now have infrastructure to analyze module text, disallow
> modules that write to CRn and DRn registers.

Assuming the kernel is built without CONFIG_PARAVIRT, what is the right =
way
for out-of-tree modules to write to CRs? Let=E2=80=99s say CR2?

