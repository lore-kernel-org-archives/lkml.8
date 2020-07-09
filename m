Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B24C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4552078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="z30mKjYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgGITJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGITJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:09:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD4FC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:09:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so2676805edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfCzYMi3aNHcdHPq4uJcYySKGoZRsLImzoMVPW+0WwU=;
        b=z30mKjYDHsKECZqXGPwVfeUpwmx0KVsIJEYam/LLKpJgaSS+zZ7368G8grmGsaaBqV
         fXZ6JEciUwBH48DjCti7A+KgHIs35CBxgGs2hgjRqyXuy7OZ3avpHbt0FCJG4uhCGHk1
         DAAfbYHFGjCq6wq30HwbPA+3MefVaxzYgFThCzHKNq0SLzjrZehaPh08juOv7gqS6FT/
         Led6Vie6mZl2txj0XNkIBjSlG1GQGXChXrh2Oge70rjkt/fY4UhYe3C+JXBvocWyJCa2
         zCMh/Pr/uMUZ067y+k73eEEYe26s7PqWvzuXLkvoF9wRi1FOdYOUs+SXfeGRfSDC/H7j
         SrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfCzYMi3aNHcdHPq4uJcYySKGoZRsLImzoMVPW+0WwU=;
        b=igvli5REAg7GgXqwnCuwOxTI3Y86cDr7G7VvgzjlqAX/O+bgNSaioF10kfdXlmIAwR
         m5t/gN259cKxqMq/9J7ed6yOJhf+You3BQbYMfIRzHPEXOw5VXs/I/QyjuoD0EbuV/2N
         Qdq0r3huo23eOgK0usNiTOLIooz5HAJOaHPc8Sm4qxmbPmC9NrRhgUpO+jCkVjsaaHXo
         TbfdNSBcIc5oVvBvQjtd7teF5dnn6t+vyMdBlgDOvllGuzy/2biqdgJPXQnIBP8LEVC9
         7u68npf9LZLjBP3k38to2CPujHjs7UJxl4vX4kNoim+OcNkN84H9+j4OYobmQyRrwI3o
         GO/A==
X-Gm-Message-State: AOAM532n0Ah9S/sZOuARu8naTWo+XTC6vmtyZpkD+PPeW5BnkkLw8Do4
        SXMD2qrG63Nc+oSQS4+iCOgeLy88tB8Leoe37xdV3g==
X-Google-Smtp-Source: ABdhPJwTYAZenqmgPEu0u5fZlCZXdTGUh5K//najny/f1OYXQHK89+GmctbhEmneY4bj5VNSlsqBCWdY8zLwDlGG1Qs=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr73091204edb.296.1594321741684;
 Thu, 09 Jul 2020 12:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKMK7uHuOD4v9ZU0d5THBhdD=97xO--N8bWd3+Na38vsHKO5Zg@mail.gmail.com>
In-Reply-To: <CAKMK7uHuOD4v9ZU0d5THBhdD=97xO--N8bWd3+Na38vsHKO5Zg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jul 2020 12:08:50 -0700
Message-ID: <CAPcyv4iht01M8t42JNSmfewKcZ7ztPuhdu01WrGzNFLPuqVNRw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 12:26 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Wed, Jul 8, 2020 at 8:30 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Linux maintains a coding-style and its own idiomatic set of terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
> >
> > Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Acked-by: SeongJae Park <sjpark@amazon.de>
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Chris Mason <clm@fb.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Replied to the old version, once more here so it's not lost.
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Got it, thanks Daniel.
