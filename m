Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830FC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BDB24676
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9cMirXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBLTkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:40:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38397 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:40:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so3732103ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqEPluF1YjWMHllKIvFCE3R/reccWsSyy085Om1UZM8=;
        b=T9cMirXct8SOHRkNT8nUDSpJX8PptpdoGUyxFMSJMVKDNnhk0Q4yntq40cZnRq6zwg
         ZO9fhgWEfD/Yqo6UFGnxgg6At25kWkovMNafMQ8qUi+WOlA6cy77H4Xovl/VF7qXugK/
         zOxYW3bRpefvV3Xg+Qj6kAeRC4QjlVfcKrudKVWx/8/T7LO+2NNe/oX/iyHfAoabzo9S
         xlJaI9zeP7EdWIrsm5ticTjUqt5nM0YI28q1ylXV95l1HtkionzsEUZySJLCF50iWQDl
         BLl/eoydSMhSuWx3GBNF4TDklolk+Q7waokZlZc7NV8dzRJZj17JVT528Zhcd0upUjzW
         2M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqEPluF1YjWMHllKIvFCE3R/reccWsSyy085Om1UZM8=;
        b=IQbDp0E1ijV0i6/lmTBsnqFbQGTHdMjiJKQbAl6MM/doVpcxbkjMPW88ZiCnc7lCj6
         LOWAxAh6t5/EkEzW9gdv3q3I2ZBHjXBPznp4UDR4On9JhKSb0GBVIhENBGYvyCzmL/WK
         GjRUyyOFTKXpqLW/9gR9sV6CQiqh1JLmiilRZxKA7gJAQflH0JsJIkQMLj1gG/5deL9K
         m5CVuZQcwTNCGm8a0bFYkKLrldrkygcMBAzNAC6h/y3PshccK9K6aWwr/i5T91Cb9aEO
         Uup7IX7stIZvxvsubYF8nCVNbVoIyQ1LoeCn3T1iYB4wWKDnyYzTTAq/BshaugC1PVbO
         ioEA==
X-Gm-Message-State: APjAAAXnDFXR7HHTEvjalmm1ORBlDt6Wtj95zs/v012vU0exeAaYBI2Z
        8V1n6S2GBqJuC4xOeIzWg7K2hKDg8Iurz92HqUfM
X-Google-Smtp-Source: APXvYqwvXyxnKZV4j7eT5ZvUPLXdR7r6x3tGLHB9G48Hlyw2Jzy0zQ6Am+wzZDHyn84jUT52FIP2y+d4DWWDX04EgOg=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr8402668ljl.56.1581536429803;
 Wed, 12 Feb 2020 11:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20200211011631.7619-1-zzyiwei@google.com> <20200210211951.1633c7d0@rorschach.local.home>
 <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com>
 <20200210221521.59928416@rorschach.local.home> <CAKT=dDk+CiMQ_-f6Daa_ea2FOW=De6PKmcyiGrm4KEkVbH2fDQ@mail.gmail.com>
 <20200212143751.0114fe78@gandalf.local.home>
In-Reply-To: <20200212143751.0114fe78@gandalf.local.home>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Wed, 12 Feb 2020 11:40:18 -0800
Message-ID: <CAKT=dDnnSrkGx1KN8t0-c7cqXCCE=xj=usUT9COfmTDbirx5WQ@mail.gmail.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info! I'll update the patch accordingly.

Best regards,
Yiwei

On Wed, Feb 12, 2020 at 11:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 12 Feb 2020 11:26:08 -0800
> Yiwei Zhang <zzyiwei@google.com> wrote:
>
> > Hi Steven,
> >
> > I can move the stuff out from the kernel/trace. Then can we still
> > leave include/trace/events/gpu_mem.h where it is right now? Or do we
> > have to move that out as well? Because we would need a non-drm common
> > header place for the tracepoint so that downstream drivers can find
> > the tracepoint definition.
> >
>
> You can leave the header there. The include/trace/events/ is the place
> to put trace event headers for common code.
>
> It just did not belong in kernel/trace/
>
> Thanks!
>
> -- Steve
