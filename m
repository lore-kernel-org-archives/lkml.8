Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA31B2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591756433;
	bh=nTjH+tdbs+yAKbTwA1OOrmTxHfSLcvvhAAg+lSjYA/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dJsjPUGX7FEJQ14D+WiTLmWYlfnmH+ooizgg+iGiRQ+J8Kp1dQRKb0ul1ncpH3T0/
	 heN0GIpxB8I6EZ2BPQKNL4uxjZujzJPxvBvmsEoi9/n7KoFdhk3bJNc+RBy04h5jMA
	 /DKxF7UM2HXsQ6N39lnV4G2wK1AAzZOp4RsQuLaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFJCdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgFJCdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:33:50 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C90E20774;
        Wed, 10 Jun 2020 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591756430;
        bh=nTjH+tdbs+yAKbTwA1OOrmTxHfSLcvvhAAg+lSjYA/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vPC03ns92LIQ+rLBTLuZAiZrArPks5URUOgmitlx9TLwhwbfNqSfqwdl0rpAEYP6S
         sV05gJqHwrG/8RdrRdvjVqc6uCGGEI0gytiieSgBNRq0qEazRLpwm7XMGDtAQIpB9u
         /S6OGKQ5tJDZ2JOoa0zKoDxV/Mhv73Vvswsfevms=
Received: by mail-ua1-f45.google.com with SMTP id v25so338706uau.4;
        Tue, 09 Jun 2020 19:33:50 -0700 (PDT)
X-Gm-Message-State: AOAM530ghc4Xi+9/CD1cDHrLPMHwmhsFbb4jeFjUZJDJDmpoAL2rU2cg
        aRanay6k8vEKeEyAssdUWC/qxtVkC+iIzjK+8T8=
X-Google-Smtp-Source: ABdhPJzrdQrTOlvQWKAfqf6y57d0RDb8cSLbmuHAMZqD9eEGwgxWOWugMp4a4gueTOO0ONCtgFvGNt3Ru0wnEG51bPw=
X-Received: by 2002:a9f:326a:: with SMTP id y39mr906811uad.93.1591756429682;
 Tue, 09 Jun 2020 19:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
 <9b50d2b1-2fb4-10a1-5966-5458507a9b05@loongson.cn> <20200511182814.GS11244@42.do-not-panic.com>
In-Reply-To: <20200511182814.GS11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 9 Jun 2020 20:33:37 -0600
X-Gmail-Original-Message-ID: <CAB=NE6VZyG1Q9kFYKXKg=EePUY7tY99LLEq95vuMPLZxufAdUg@mail.gmail.com>
Message-ID: <CAB=NE6VZyG1Q9kFYKXKg=EePUY7tY99LLEq95vuMPLZxufAdUg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Fix some issues about kmod
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, May 11, 2020 at 08:59:37PM +0800, Tiezhu Yang wrote:
> > Hi,
> >
> > Could you please apply the following three patches?
> >
> > [v4,1/4] selftests: kmod: Use variable NAME in kmod_test_0001()
> > https://lore.kernel.org/patchwork/patch/1227980/
> >
> > [v4,2/4] kmod: Remove redundant "be an" in the comment
> > https://lore.kernel.org/patchwork/patch/1227982/
> >
> > [v4,4/4] test_kmod: Avoid potential double free in trigger_config_run_type()
> > https://lore.kernel.org/patchwork/patch/1227978/
>
> Andrew,
>
> These 3 patches should be fine.
>
> I am re-working a replacement proper fix for patch #3, that requires a
> change to the umh. I'll try to iron this out today.

I'll pick these up, and run tests now that I have a finalized solution
in place for the patch replacement I mentioned which was needed. Sorry
this took so long, but I am glad I took my time. I'll post soon after
I test the new fix.

  Luis
