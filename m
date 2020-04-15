Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD5CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987FE2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt4KqbBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636853AbgDOOsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392410AbgDOOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:47:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD6C061A0C;
        Wed, 15 Apr 2020 07:47:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b62so17453548qkf.6;
        Wed, 15 Apr 2020 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ4iMxtLmyt1fidTbl+NFGEvP3aHTCvbYm4rWcaVlyA=;
        b=Yt4KqbBYzrcQoQQlbdCqsuee3b+HaiUsutQD8Qbx5syhE1/i1Cw+VMzbLyCKcYaRYi
         WAa0/Tvi6yhSrD3vkuaptsmzvS5iqXwB8vfcW40nQ8iC7S6SHHv6vSE/1fblaHpM7xPd
         INyYDeTWPradXrWH0Te8CMeemJUNXr1N6tnq7e7HIaeDgeTLK0uYENrtc6B181jOAytd
         kENWGTYOc074TwDs0ADlLkl7NssWed71MbxwMz5AIQpugB4nBUdrlFmViwh/4LDbffo7
         j2sYfHlFC4fGGkxGRMrmkcXPAUWvDANSAxFpooShlv547O6GeNpnSRrpzBY7T1nDdaiP
         qQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ4iMxtLmyt1fidTbl+NFGEvP3aHTCvbYm4rWcaVlyA=;
        b=QR+kqWnUg6Iu1UgZNwSXDYrSvleYfh5Q9tpoY3SPRijHw+5ISY31N9lGNnsb6Es5p7
         wTnrx59a6k9bi6074raDnHPopx3NYoutDzG4RNrKGnVD3An4kA/MyJDtHndMQyBsQU/I
         imyiKX8RudygS2bkcYcS1WtKx3652GxWdaGhtImkWzWwLO3XduXwJ8kkmjSOuk01vzYG
         hHYC/K7ylLUImK6AQW9UYkt5szTfKiW+h9Li7XtM5zVrYoVn4NO/fpkADuUv/O3FlZhK
         r1TUL9SY1gUmxWu7xZPo575L4jia3no9TLdWuFXXn91uIda0fL9mIFRiNsetp0rwXOdl
         iKpw==
X-Gm-Message-State: AGi0PuYMyJqRu0xkA7vGQ9G+w8sxByzaj3nsSK6p7aI7z0TjuGfc7SsC
        OvQcrUBAIrsYeQ0ptNzJ02z5qM9P2OoCdR1FY5WUfUdX
X-Google-Smtp-Source: APiQypJUfL/gNlmbIS5arKSbG7lka+aMpwLuCQIZtSnNdCJg0n76Xjm5HPKezGAW0zBKEBD4gJjv8CJLffCHkEBpaoM=
X-Received: by 2002:a37:a7cd:: with SMTP id q196mr2235781qke.160.1586962066994;
 Wed, 15 Apr 2020 07:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <CALUj-gsRgkEyRe3vubEeWx8ENwEyE+Fzv4bKKDZ+iq3urRG0BA@mail.gmail.com>
 <20200415163851.2e5f96f8@coco.lan>
In-Reply-To: <20200415163851.2e5f96f8@coco.lan>
From:   rishi gupta <gupt21@gmail.com>
Date:   Wed, 15 Apr 2020 20:17:35 +0530
Message-ID: <CALUj-gvYeXFv8TwypuyPygypW-izmgTcRY1mOGHyMGb-RGt2tw@mail.gmail.com>
Subject: Re: Correct place to put the new doc for "How to use this driver"
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mauro. I will put doc in admin-guide folder.

On Wed, Apr 15, 2020 at 8:08 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Wed, 15 Apr 2020 09:25:02 +0530
> rishi gupta <gupt21@gmail.com> escreveu:
>
> > Hi Team,
> >
> > I need to add a documentation file to let users know "how to use this driver".
> > Specifically this one (tty-ttyvs.rst): https://lkml.org/lkml/2020/2/15/153
> >
> > (1) I am unable to find any directory where it will fit. This driver
> > belongs to Virtual TTY device category.
> > Any suggestions where to put it?
>
> Docs focused on driver usage belongs to the admin-guide.
>
> >
> > (2) After putting it is it mandatory to link it to
> > Documentation/index.rst as suggested here
> > https://www.kernel.org/doc/html/latest/doc-guide/index.html
>
> You should actually add it to Documentation/admin-guide/index.rst.
>
> >
> > Regards,
> > Rishi
>
>
>
> Thanks,
> Mauro
