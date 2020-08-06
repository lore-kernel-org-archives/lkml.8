Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DB420855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739525;
	bh=Ckyqd8uriffVbvsxY0duO4M2MNVEawyPbHYj4ZdlU6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZXY9AIubeBOjMOJPxH3SDLuF1lfuHV1j1N2VL7+2e9IaUlrZcLW63wNYqfpdZnzex
	 K2Ltn0iKvqiGbDs1BzDh2KNWs4WOBmr/EfHp+HRotV8fAIh8XWTS2RV6H71wN9Rxwv
	 Uwfc+2Y4ShTvaW2znJHxMBO5HHz2jEdsNMjatIEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHFSpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgHFSpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:45:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C5120855;
        Thu,  6 Aug 2020 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596737753;
        bh=Ckyqd8uriffVbvsxY0duO4M2MNVEawyPbHYj4ZdlU6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eq6odyjISBUL9c/lZ7YjVbnud9jyjpOCtWNKrz/UkGhp5jBa7SP3YRZrZZcoa/ZrV
         Z8ZvLzJ+wT3Hwaef7DyHM3CzUt6xY+Z3oNlzC1Qqki/ZLsInLJXWfPr9i2zVuA5wd0
         6Qe8HkX5GAyrLnqXAWifad8jz9ZCOeTFTBHBwVOY=
Date:   Thu, 6 Aug 2020 11:15:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, oss-drivers@netronome.com,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Elder <elder@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v2 0/2 net] bitfield.h cleanups
Message-ID: <20200806111550.7a010fb3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200806111358.2b23887c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200708230402.1644819-1-ndesaulniers@google.com>
        <CAKwvOdmXtFo8YoNd7pgBnTQEwTZw0nGx-LypDiFKRR_HzZm9aA@mail.gmail.com>
        <CAKwvOdkGmgdh6-4VRUGkd1KRC-PgFcGwP5vKJvO9Oj3cB_Qh6Q@mail.gmail.com>
        <20200720.163458.475401930020484350.davem@davemloft.net>
        <CAKwvOdmU+Eh0BF+o4yqSBFRXkokLOzvy-Qni27DcXOSKv5KOtQ@mail.gmail.com>
        <CAKwvOd=YBL_igN-Z1V9bePdt9+GOqkKq-H4Wg8GBZvBsdOHeOw@mail.gmail.com>
        <20200806111358.2b23887c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 11:13:58 -0700 Jakub Kicinski wrote:
> please repost the first patch only

To be clear the second patch may need to wait for net-next since it's
refactoring. That's why I suggest only posting patch 1 now, i.e. the
fix.
