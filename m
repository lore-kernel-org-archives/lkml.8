Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D2EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8492C24248
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592679577;
	bh=v3y2Jwbm9NDjc+CMMmji9B9hWxSgStsie/FBB/cInPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lhn4Ym+x76xpYCQTVBMdOVlFLofcm+hazpaaqhJQuamMvLmELrg5SiaD2nhVC+r++
	 NywGzDvIZo1Ebl0yTscPrgG1weevt/tEV8ivyd0zSzZ0wkt+2wBe4qdNrx/JUB8QdA
	 S7KliL8mJv/HI8cMKxS/LJhlAPFJhsCiy4eCeN9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgFTS7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:59:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35150 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgFTS7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:59:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so15119109lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x63u2CH0kTOvK+Ylduvsgf843OJltI0Oa4WMxfgSi60=;
        b=YuZaZD+2V4T+V8YzzYJGa35OmsoetmgSGhdcjtcJee15mPLl0DDVPEosSzP/PWnHJj
         jgy4hPWH8VVmt2iYgXdkWir0ONer/cxkREFlgZ2wBjYY2Yu9ilgncolQOzb9kfd/gH8a
         5vaDuE8OvsPxmEYbptqvWO0a+mYBuV8TbyVfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x63u2CH0kTOvK+Ylduvsgf843OJltI0Oa4WMxfgSi60=;
        b=k94WywO6a78BTvn3u3U7QSml1i9PQZexWEY1j2gvBK01TPY3S+i7ETwSzMEnihF2qX
         Qs9F3mJmFWxIG3AubBlZN5QLn0G/2WoAV3DTO3/NCx+8H2asR1fLhT14qhisfQSF8C8j
         3Dc1TOx32QUG9peAmQv8XPb5vplEyilo5/kzlTa8TJyZC47HDI/Ms6fZsRryGYdknYM7
         fNYrxQDcVjaKNWIlGVHzQLzagiSmvjNmlv4KFuz35rotMbx+8reRYqi/ky2LBu1NhYo/
         Ud6T7z8nS56b9W5Xvex1ES8Bdt39chqu6dnhqVxg1Aazks3OGJT4/Or5M4cyv3+5+30g
         2PFQ==
X-Gm-Message-State: AOAM5310s+aOMXLvZhi0iChKYKw6IjCuSpePXSQ96jDxXT4RYqm/iW1R
        iuCkbOXjcJi5a7ekPnbCE+vqag9VOuQ=
X-Google-Smtp-Source: ABdhPJwXPnsZidRrGNwnDSdT0IlQI36p1eke2diw8stORBLblW/20107Gua2b3m37DFPrIHVp8Uw/w==
X-Received: by 2002:a2e:8e94:: with SMTP id z20mr4268356ljk.21.1592679511871;
        Sat, 20 Jun 2020 11:58:31 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n23sm2226207lfq.76.2020.06.20.11.58.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:58:30 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id i27so15046435ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:58:30 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr4590362ljj.102.1592679509716;
 Sat, 20 Jun 2020 11:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org> <87k1026h4x.fsf@x220.int.ebiederm.org>
In-Reply-To: <87k1026h4x.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 11:58:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
Message-ID: <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:36 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Instead test SIGNAL_GROUP_COREDUMP in signal_group_exit().

You say "instead", but the patch itself doesn't agree:

>  static inline int signal_group_exit(const struct signal_struct *sig)
>  {
> -       return  (sig->flags & SIGNAL_GROUP_EXIT) ||
> +       return  (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
>                 (sig->group_exit_task != NULL);
>  }

it does it _in_addition_to_.

I think the whole test for "sig->group_exit_task != NULL" should be
removed for this commit to make sense.

               Linus
