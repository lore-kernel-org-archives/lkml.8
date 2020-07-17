Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33F0C433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F7422D2A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGQOH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:07:57 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGQOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:52 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mbiak-1kZMLb3fzy-00dFCu for <linux-kernel@vger.kernel.org>; Fri, 17 Jul
 2020 16:07:50 +0200
Received: by mail-qk1-f170.google.com with SMTP id b4so8808454qkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:07:49 -0700 (PDT)
X-Gm-Message-State: AOAM530sDwi8daHIHfRTEV11GOVGIn3vCDv5m632C1v1gg62NFZuuTof
        m4r5lsxo8fI4oNV/OZ9CYhnE3HhG/EfjqwVUEOs=
X-Google-Smtp-Source: ABdhPJwXFbLL8bewhD78mAte99R3/cO1757O1a+iHJWyX5YrwgzzCXRmHIkiOof65wN7r0/W/HCByNL66FBwuEo+RA8=
X-Received: by 2002:a37:9004:: with SMTP id s4mr671834qkd.286.1594994868740;
 Fri, 17 Jul 2020 07:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200717140405.17905-1-sudeep.holla@arm.com>
In-Reply-To: <20200717140405.17905-1-sudeep.holla@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 16:07:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2dpjx5MJLurjFC3UCTmOA8VPx0XBVtg+YRz09xxztNLw@mail.gmail.com>
Message-ID: <CAK8P3a2dpjx5MJLurjFC3UCTmOA8VPx0XBVtg+YRz09xxztNLw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Use NULL instead of integer 0 for
 rate pointer
To:     Sudeep Holla <sudeep.holla@arm.com>
List-Id: <soc.lore.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:U2gfMsPxtEsUB7duxwCqNup3eRdfb+sEbHD2bg0dKlv/ITV1W5t
 cp7KayNBwyCMqNCfWU38XU9nj0GmyOTxVllW+5QI9+Wihy1LMtwNNg/HiLrMAQa25ANLd2z
 g6qbhHyBLTqfgVrcZ0Ul8OzPx7XveCr66L2u3J3RTvEDdYp+v2qB/ExFcqhzzch9StWgONM
 ADph4K5bHK83bgaMIxgjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QxIQXya9pQA=:pCjwDEaef+Uliw1bvJfL/y
 4W8Qng/ENRPmsa0C0lLc7T4UR09mNyfTnWWhkVKtUvnkSY6KbA3IJ04JmR2O/p1XOtVSi5z3m
 Za9oaQd5QQkK0gE0/PXxgYQ50DtVciTj9bLABqKsPpPocOyOlfbm0GZGk3gWY9+ttBmzeWX+s
 lms8JYg/26KBBLefF9wPn0I1Pm7BK3kJDG9Cav4xHJD5EZJ2jc58RE1pXOtw1KAZ4ANOEnSE+
 RQP/9rq79eQ1SG1KSrEh+JUEORlxkcHwGxeb788fdWFb0M712xWIeO6KSuMsjmjz48CJGNiut
 ZLEcjzMr2XUt4pCJ5RsmAQ2hIA+qpOpHe+rP4Y16NKsL14Ka/9Idy3SfZhAH8p+M5XpkrHSdi
 tGSlatoF7/k8GavcdXIEIV122J/neCrNo6N3T7NmsqXkph9vAEVzPjfR9IQNkg6n7x/+RxuaG
 dOW/nnuj3xrqRFKahISCy/uTrK0VZkBJgtJugtr/jA+RBanLX5mVBwjjc/OxCtj4SnNNSwtXe
 oFij7Jw92VJjjNQeRBBbCW2VwIt4zOHQLVfLKFKYOj0IXydo/X710+M49arDbmRurP13xPkKS
 39xc4QXmS11ql3oTbXrWqNY2/Lxb0igB7hBz1voVSkbiA24dHXZLNQjvuBeaAC0fvlD9LESym
 dZ0syyMjfLW7vlIZkq622APQW+Z5wY7F617SrRb1XcgrfW1S09/0e1RcpPF2abJ0iBzE2H7yk
 paeOmFvAm8QoG+AxP05qCp8dnqnxvnW6BeXMrEcz3oL2VRvVi3CkNKvHux2fJPLvkG1ct0+8d
 MnP1jqpEuphNSQKHdEOcF+6icVMpfwVGj3MJGgUdYNJIiXIgiTcb0VWLkCtgNkbbMW/lgq45Z
 +Kz5bh+hS2jEWtNMMooDNS6myN9EIoDcGjykuXr7hrmanxrEsYOOb9MDuWu/jjUIjDat6+Ik+
 ZcFNPFSj8cF6+Obx9yx/htU1nF6feCY7vG6EqkLMxXv/LsRzbAnRZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 4:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Kbuild test robot reports the following sparse warning:
>
> drivers/firmware/arm_scmi/clock.c:142:21:
>         sparse: Using plain integer as NULL pointer
>
> Use NULL pointer instead of integer 0 for rate pointer and fix the
> warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi Arnd,
>
> Kbuild test robot reported this warning from the soc tree. Can you apply
> this directly or do you prefer pull request. Let me know.

Applied, thanks!

      Arnd
