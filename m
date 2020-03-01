Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F49BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453FB24649
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTqwlu9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCAAx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:53:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34527 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgCAAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:53:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id w27so5057408lfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 16:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dpJe4Mf6LX0NrQj7yUohcYZEvawc+wKB+azjehKaqA=;
        b=VTqwlu9yhhH2qXRUpJcfB/cMCFBXe3gl/fPRS2SlZbeiJQHElM1P/XE0RbevL0Rr4l
         SbcnvhJuczcZ0uIS/i9hNaS7/9g0FiHiYcgPKTcZL5EyIT/DA5AQNblDZkXYLQBfA/HP
         z2cLzoxkYxywAj9HE1VOm88evNedEmU6mF8dJ82Cy5tBp+IIB2nMThpJptdcTExbc7IG
         JUbwcQmm8YfBYAg6M5+e7ymMzXHsVozM4cL0+v8bMd95XeT06N2cnJ//xpz2xaCnEzZ9
         wLJUx2HcwZfwQ/FcdeUF3jomWWi239AbgX3GOKbeBJKbaGFZAEzeWIzD9aaa0VjJQq+t
         Ij2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dpJe4Mf6LX0NrQj7yUohcYZEvawc+wKB+azjehKaqA=;
        b=CgwuCLlfgfMzAz1laiptZc+rRgrLxVhQZyZMd+HGq1f+3cDMxCwB+YfakvngjMImwc
         CRFa/xMNQS3m78/0vMQkg1ePm1sVOasbHxQOesUyXDGzhc4+nn6vjDTLDFWyLWEMElQT
         3u1LBRKB0jqoNzy/RxwTBBn+GO/I0MHg09Lfkzt30kqp4CCay3fziGHJZPFRqMj9LrRu
         0hVWk4Uy6rB+7oBhdI/fMNFvKBy/ibWw2aiM2xfB6Ems9tUoSssgxk+SJTxSnSPY/I3Q
         iMwv0PgylX/guL3jzGGIWTQpudzZ9aOFvltT7sCBBRUaQlT3y4obO4vlbROHwqjekd1s
         5aFQ==
X-Gm-Message-State: ANhLgQ22gXA2/9RLd56SCFrzMPUzb1tv08qTANZsL6U8NRgRF8DxnFrZ
        uj0JfUyKZ+VgLRtYq6So8H4Jy4rqeo92dyHEijcU
X-Google-Smtp-Source: ADFU+vuyaDKwasGF4529bz/E0ATFDkNZPPHOsf1wAOCRsmrXQTGi8kdM7IQ7UEcgZQ25bxsDk4ILGp4Munwws2rf7Rw=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr1007163lfb.69.1583024035644;
 Sat, 29 Feb 2020 16:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20200212222922.5dfa9f36@oasis.local.home> <20200213042331.157606-1-zzyiwei@google.com>
 <20200213090308.223f3f20@gandalf.local.home> <CAKT=dDmB=TX++VeL=-NihDv5L4iBn_48=i7Lsnrkd+4e13QQsQ@mail.gmail.com>
 <CAKT=dDnt174adfWzSiNfheA5EVL32AG_2RQa0861V2Mjh-f51w@mail.gmail.com> <20200224113805.134f8b95@gandalf.local.home>
In-Reply-To: <20200224113805.134f8b95@gandalf.local.home>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Sat, 29 Feb 2020 16:53:44 -0800
Message-ID: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
Subject: Re: [PATCH v3] gpu/trace: add gpu memory tracepoints
To:     Greg KH <gregkh@linuxfoundation.org>,
        yamada.masahiro@socionext.com, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 8:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 23 Feb 2020 22:31:11 -0800
> Yiwei Zhang <zzyiwei@google.com> wrote:
>
> > Dear gpu and tracing owners,
> >
> > It's been a while and this is just a gentle and friendly re-ping for
> > review of this small patch.
>
> I guess the question is what tree should this go through. I usually
> only take tracing infrastructure changes and leave topic specific
> tracing for those that maintain the topics.
>
> I'm fine with taking this through my tree if I get a bunch of
> acked/reviewed by from other maintainers.
>
> -- Steve
>

Hi GPU directory owners/maintainers,

Given Steve's reply, could you guys help review and ack this tiny
patch? This is a friendly re-ping since it's been more than 2 weeks
without any response from gpu directory folks. The patchset v2 was
ack'ed by Greg(gregkh@), and this v3 patch only has format updates.
Please take another look. Many many thanks!

Best regards,
Yiwei
