Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE093C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F822071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKO5iySR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAXWBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:01:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34352 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:01:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id f2so880571pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFmViv0LWpYCZmRZzBXX+e0FCAJTM0WkywcL3e5bisU=;
        b=VKO5iySR05BivpDQZf/VKaq5KXC/T0tXr1RXOxM2Cjjz+2DdsYlr12Q19jKOBereBA
         Nlu9+EGmJw2Ad+dKijIamnqzcecBWtEi2aukIVdIfiK8Fo9SXepfP1CpTyXrn24Ji8M0
         66gHlAJsRUvJpWz/ElEPqWt7DwmZ0aSAfW9AAxSmDzZDKF12hx/+yw/GM4I7nm6Qz5Sz
         o8LNez99DjtBAxQJmSHleGfzM3RFP9Op2Apahq7HW79aRQzo9BYNWyqVYv//HPuTxJVp
         rAF2oyYaLC9GroGIKw30bqpSIMbPq8G9oboKRKYFkVUd4jLdJod1ttB346M86rIfwZLz
         dJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFmViv0LWpYCZmRZzBXX+e0FCAJTM0WkywcL3e5bisU=;
        b=NVtVHQ9eaugSzo4fKYLuQlcaDo8VhFjw7IteYBYV1S1FbCrXrSUkQ8X/gNZs0z3wGA
         ubuNCdzX6cwU59zl+2y+Ywahk5tuT9DlA87WNwdn1yKHexiwmR6+SPaA1QffoFhxmina
         BSTtbFTlrp3Nk0LrinO4zyei8vcIEMTI0bu7KxX2Lm+d/88STcCw9IUSpBz/atNhpuk4
         3hOTSozMhqMEP1idhDkHbA8Q4ordgEUN/XUOWcQcfnLbwv6ADGtJ0d0+J9JmdVbOkgrq
         hctpp9jfJFLZGbvDoOrDZ0ipCD+FIISBa/zFkimevKelRZbhDNsUo2yfg41X4ZAvvyby
         l6iA==
X-Gm-Message-State: APjAAAUqyTQ9/wjawnDuyDr3ZqInT4aB6DBBfTCW/lsdc8WLb8GB1Any
        nwGFV2ij/+p1V8kdS/QFmBk0NA2UxuljxHlNhc7mDw==
X-Google-Smtp-Source: APXvYqzLJ4DMJP4xsUJ7yoV9hJv9V84tY3jtbZITHm4QWVVh8MDBcRDMqpXCXdzorK9BUvIJ/Al7pvb/nzCerCcaAMg=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr1511151pjt.131.1579903305086;
 Fri, 24 Jan 2020 14:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20200124194507.34121-1-davidgow@google.com>
In-Reply-To: <20200124194507.34121-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 24 Jan 2020 14:01:34 -0800
Message-ID: <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
Subject: Re: [PATCH] Fix linked-list KUnit test when run multiple times
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 11:46 AM David Gow <davidgow@google.com> wrote:
>
> A few of the lists used in the linked-list KUnit tests (the
> for_each_entry{,_reverse} tests) are declared 'static', and so are
> not-reinitialised if the test runs multiple times. This was not a
> problem when KUnit tests were run once on startup, but when tests are
> able to be run manually (e.g. from debugfs[1]), this is no longer the
> case.
>
> Making these lists no longer 'static' causes the lists to be
> reinitialised, and the test passes each time it is run. While there may
> be some value in testing that initialising static lists works, the
> for_each_entry_* tests are unlikely to be the right place for it.

Oh good, I am glad we are getting rid of those static variables. (I
thought we already dropped those - whoops.) I think this drops this
last of them, can you confirm David?

Regardless, this patch looks good to me.

> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for taking care of this!
