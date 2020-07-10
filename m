Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28753206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BHwRYb78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGJVsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:48:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F61BC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:48:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so5713190edy.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUIt310w+rKIAAlks2WRt+7uT8NARjs7Y0eCqqZJf2U=;
        b=BHwRYb78vowORyVP/n4chHoNe7CPo7i/RG9zILzfXiNvGgfgK88kGYQrCbjF+qN7ms
         PU8cAeDYvJPQ3NOIOsR7F50xSpNDF/kQU8KKfd6cCzdNw9Ynsnf8ViAiO9poo9le0mpI
         C21BfAQRvQsFhOW8j/uqlBDuqO1mRKsJe1NiN17k0rIjOgUCof1w1QPQH1pbkaiMCWHt
         GV4z0E0gG9uV37pmtqshOduDAnwA06bU2RI2/wT3grOfZ6h9YYtTisHqCDfnJSRApb73
         CZFYi2bmMOn3dj5jr0hjO8hLk8Ff56tR0Bf38ksycHvQgFHvghRnTETBTSPLLImHcWVN
         cZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUIt310w+rKIAAlks2WRt+7uT8NARjs7Y0eCqqZJf2U=;
        b=cUwGAN1iQul9OsuvV+Q3+kuVpoNKaUqzGQA8m982kVw1y94tItkCo5XbBNRVDtjIkN
         m3mCUuMuNY4qNmvSdMc0ZCFaQZRNxZC2deoEyADCDdpo7JaIQGVXcHi//OiyoOHGzl3+
         jujvrKRC6zfSj+9mcVO1IqEy5N5hMebYhMvj3eRDYWCsFAtrSYMrKk2cncCmH+2LtJeh
         tjCIQnYLn5NOb217xSpvfSrSST/gXeV4cq8lT+rER7aMrVz0/kS5IzsLhHomoeWG+ALY
         lNMEJhKoGbw30o98COlnsMTK6vHdtOLvNv/rlSLzsQCh0TF2fAP49ogxSu6CPUxSzcAQ
         V/Ag==
X-Gm-Message-State: AOAM532ArCcz3GQ2vpF8liTg7mEj5RsndI1hbskSDV4bkiXdxRRW3/M0
        odXOyPaImH0ZMcDsOj/G+3iJG/PNxqi+fqIEPn1ejw==
X-Google-Smtp-Source: ABdhPJwWWnbhpZs3ka1RooYvoRDcsQuQWgeCkvZ6c9xxca909Gu1Z/nB6d4LnB2raQ02AMoXB9+2GYTltV6dLu2ajQU=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr76240842edj.93.1594417709895;
 Fri, 10 Jul 2020 14:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
 <97c24e99-9f49-f094-acfb-705c2da12a76@labbott.name>
In-Reply-To: <97c24e99-9f49-f094-acfb-705c2da12a76@labbott.name>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 14:48:18 -0700
Message-ID: <CAPcyv4hpBN=KA54YY96MG2tuKKH7=hyX+rA1t3CUFLL76aNTtg@mail.gmail.com>
Subject: Re: [PATCH v3] CodingStyle: Inclusive Terminology
To:     Laura Abbott <laura@labbott.name>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        SeongJae Park <sjpark@amazon.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mark Brown <broonie@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 2:13 PM Laura Abbott <laura@labbott.name> wrote:
>
> On 7/8/20 2:14 PM, Dan Williams wrote:
> > Linux maintains a coding-style and its own idiomatic set of terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
> >
[..]
> Acked-by: Laura Abbott <laura@labbott.name>

Thanks, Laura.
